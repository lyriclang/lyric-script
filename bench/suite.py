#!/usr/bin/env python3
"""Messpunkt 3 (S7k): the bench suite. Every program runs in every VM, round-robin, and the wall
time of the whole process (start to end) and its CPU time (children's rusage) are recorded.

    python3 suite.py --script <lyric-script> --lyrvm <lyrvm> --dir <copy of bench/ with bc/> \
        --runs 9 --out results/suite1.json

VMs: `script` runs the source (src/*.lyrs) with a warm cache — the warm-up round fills it, as
4.6 runs bytecode `lyrc` made beforehand; `script-asm` runs the hand-written bytecode of
Messpunkt 1 where there is one; `v46` runs `lyrvm` on the release-profile bytecode.
Before each round the script waits (at most --idle-wait seconds) for the 1-minute load average
to fall below --idle-load and records it. Every run's output is compared with the oracle
(oracle.py, computed independently); a mismatch marks the run INVALID and keeps it out of the
medians.

`--prefill <lyric-script>` compiles every source once with another binary of the same commit
before the warm-up round (the cache key is source, version and format, not the profile): while
lyric#667 lets a release-profile compiler corrupt its own compile, a debug binary fills the cache
and the release binary only runs the bytecode — which is what the suite measures.
"""
import argparse
import json
import math
import os
import platform
import resource
import statistics
import subprocess
import sys
import tempfile
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from oracle import ORACLE  # noqa: E402

PROGRAMS = ["empty", "fib", "loop", "objects", "words", "sort", "sortby", "map", "strings"]
ASM = {"empty", "fib", "loop", "objects"}
# The ratchet's mean runs over every program but `empty`; the second mean only over those whose
# work stays in the VM in both languages (no native sort, map or string building on one side).
SUITE = [p for p in PROGRAMS if p != "empty"]
VM_ONLY = ["fib", "loop", "objects", "sortby"]


def commands(args, cache):
    d = args.dir
    return {
        "script": lambda p: [args.script, "run", f"{d}/src/{p}.lyrs"],
        "script-asm": lambda p: [args.script, "asm", f"{d}/{p}.lyrsasm"] if p in ASM else None,
        "v46": lambda p: [args.lyrvm, "run", f"{d}/bc/{p}.release.lyrbc"],
    }


def run_once(cmd, env):
    before = resource.getrusage(resource.RUSAGE_CHILDREN)
    t0 = time.perf_counter()
    done = subprocess.run(cmd, capture_output=True, text=True, env=env)
    wall = time.perf_counter() - t0
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    cpu = (after.ru_utime - before.ru_utime) + (after.ru_stime - before.ru_stime)
    return wall, cpu, done.returncode, done.stdout.strip(), done.stderr.strip()


def wait_idle(limit, seconds):
    t0 = time.time()
    while os.getloadavg()[0] >= limit and time.time() - t0 < seconds:
        time.sleep(15)
    return os.getloadavg(), time.time() - t0


def geomean(values):
    return math.exp(sum(map(math.log, values)) / len(values))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--script", required=True)
    ap.add_argument("--lyrvm", required=True)
    ap.add_argument("--dir", required=True)
    ap.add_argument("--runs", type=int, default=9)
    ap.add_argument("--out", required=True)
    ap.add_argument("--idle-load", type=float, default=1.0)
    ap.add_argument("--idle-wait", type=int, default=600)
    ap.add_argument("--prefill")
    args = ap.parse_args()

    oracle = {p: ORACLE[p]() for p in PROGRAMS}
    cache = tempfile.mkdtemp(prefix="s7k-cache-")
    env = dict(os.environ, LYRIC_SCRIPT_CACHE=cache)
    vms = commands(args, cache)
    names = list(vms)
    samples = {vm: {p: [] for p in PROGRAMS} for vm in names}
    invalid = []
    rounds = []

    prefilled = []
    if args.prefill:
        for p in PROGRAMS:
            done = subprocess.run([args.prefill, "run", f"{args.dir}/src/{p}.lyrs"],
                                  capture_output=True, text=True, env=env)
            ok = done.returncode == 0 and done.stdout.strip() == oracle[p]
            prefilled.append({"program": p, "ok": ok})
            if not ok:
                invalid.append({"round": "prefill", "vm": "prefill", "program": p,
                                "exit": done.returncode, "stdout": done.stdout.strip()[:200],
                                "stderr": done.stderr.strip()[:500]})
        print(f"prefill with {args.prefill}: {sum(x['ok'] for x in prefilled)}/{len(PROGRAMS)}",
              flush=True)

    for r in range(args.runs + 1):
        warm = r == 0
        load, waited = wait_idle(args.idle_load, args.idle_wait)
        order = names[r % len(names):] + names[:r % len(names)]
        for p in PROGRAMS:
            for vm in order:
                cmd = vms[vm](p)
                if cmd is None:
                    continue
                wall, cpu, code, out, err = run_once(cmd, env)
                ok = code == 0 and out == oracle[p]
                if not ok:
                    invalid.append({"round": r, "vm": vm, "program": p, "exit": code,
                                    "stdout": out[:200], "stderr": err[:500]})
                if not warm:
                    samples[vm][p].append({"wall": wall, "cpu": cpu, "ok": ok})
        rounds.append({"round": r, "warmup": warm, "loadavg_before": load, "waited": waited})
        print(f"round {r}{' (warm-up)' if warm else ''}: loadavg {load[0]:.2f} "
              f"(waited {waited:.0f} s), invalid so far {len(invalid)}", flush=True)

    summary = {}
    for vm in names:
        summary[vm] = {}
        for p in PROGRAMS:
            good = [s for s in samples[vm][p] if s["ok"]]
            if not good:
                continue
            walls = [s["wall"] for s in good]
            summary[vm][p] = {
                "median_wall": statistics.median(walls),
                "min_wall": min(walls),
                "max_wall": max(walls),
                "median_cpu": statistics.median([s["cpu"] for s in good]),
                "valid": len(good),
                "of": len(samples[vm][p]),
            }

    def ratio(vm, p, kind):
        a, b = summary["v46"].get(p), summary[vm].get(p)
        if not a or not b:
            return None
        if kind == "gross":
            return a["median_wall"] / b["median_wall"]
        if kind == "cpu":
            return a["median_cpu"] / b["median_cpu"]
        net_a = a["median_wall"] - summary["v46"]["empty"]["median_wall"]
        net_b = b["median_wall"] - summary[vm]["empty"]["median_wall"]
        return net_a / net_b if net_b > 0 else None

    ratios = {}
    for vm in ["script", "script-asm"]:
        ratios[vm] = {p: {k: ratio(vm, p, k) for k in ["gross", "net", "cpu"]}
                      for p in SUITE if ratio(vm, p, "gross")}
        for group, members in [("suite", SUITE), ("vm_only", VM_ONLY)]:
            for k in ["gross", "net", "cpu"]:
                values = [ratios[vm][p][k] for p in members if p in ratios[vm] and ratios[vm][p][k]]
                if len(values) == len([p for p in members if p in ratios[vm]]) and values:
                    ratios[vm][f"geomean_{group}_{k}"] = geomean(values)

    result = {
        "host": platform.uname()._asdict(),
        "runs": args.runs,
        "prefill": args.prefill,
        "prefilled": prefilled,
        "rounds": rounds,
        "loadavg_after": os.getloadavg(),
        "samples": samples,
        "summary": summary,
        "ratios": ratios,
        "invalid": invalid,
    }
    with open(args.out, "w") as f:
        json.dump(result, f, indent=1)

    print()
    print("| program | VM | median wall s | min | max | median CPU s | valid |")
    print("|---|---|---:|---:|---:|---:|---|")
    for p in PROGRAMS:
        for vm in names:
            s = summary[vm].get(p)
            if s:
                print(f"| {p} | {vm} | {s['median_wall']:.4f} | {s['min_wall']:.4f} | "
                      f"{s['max_wall']:.4f} | {s['median_cpu']:.4f} | {s['valid']}/{s['of']} |")
    print()
    for vm in ratios:
        print(f"v46 / {vm}:")
        for p in SUITE:
            if p in ratios[vm]:
                q = ratios[vm][p]
                print(f"  {p:8} gross {q['gross']:6.2f}  net "
                      f"{q['net'] if q['net'] is None else round(q['net'], 2)}  cpu {q['cpu']:6.2f}")
        for k, v in ratios[vm].items():
            if k.startswith("geomean"):
                print(f"  {k} {v:.2f}")
    print(f"invalid runs: {len(invalid)}")
    for i in invalid[:20]:
        print("  INVALID", i)


if __name__ == "__main__":
    main()
