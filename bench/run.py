#!/usr/bin/env python3
"""Messpunkt 1 (S1h): runs every program in every VM round-robin and records the wall time of
the whole process (start to end) and its CPU time (user + sys, from the children's rusage).

    python3 run.py --script <lyric-script> --lyrvm <lyrvm> --dir <copy of bench/ with bc/> \
        --runs 7 --out results/run.json

A warm-up round (not recorded) comes first; every run's output is compared with the oracle,
and a mismatch marks the pair INVALID.
"""
import argparse
import json
import math
import os
import platform
import resource
import statistics
import subprocess
import time

# The closed-form results: fib(32); the loop, computed in Python; 50 * sum(0..99999); sum(0..99999).
ORACLE = {"empty": "0", "fib": "2178309", "loop": "990548", "objects": "249997500000",
          "objects1": "4999950000"}
PROGRAMS = ["empty", "fib", "loop", "objects", "objects1"]


def commands(args):
    d = args.dir
    return {
        "script": lambda p: [args.script, "asm", f"{d}/{p}.lyrsasm"],
        "v46-release": lambda p: [args.lyrvm, "run", f"{d}/bc/{p}.release.lyrbc"],
        "v46-debug": lambda p: [args.lyrvm, "run", f"{d}/bc/{p}.debug.lyrbc"],
    }


def run_once(cmd):
    before = resource.getrusage(resource.RUSAGE_CHILDREN)
    t0 = time.perf_counter()
    done = subprocess.run(cmd, capture_output=True, text=True)
    wall = time.perf_counter() - t0
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    cpu = (after.ru_utime - before.ru_utime) + (after.ru_stime - before.ru_stime)
    return wall, cpu, done.returncode, done.stdout.strip(), done.stderr.strip()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--script", required=True)
    ap.add_argument("--lyrvm", required=True)
    ap.add_argument("--dir", required=True)
    ap.add_argument("--runs", type=int, default=7)
    ap.add_argument("--out", required=True)
    args = ap.parse_args()

    vms = commands(args)
    names = list(vms)
    samples = {vm: {p: [] for p in PROGRAMS} for vm in names}
    invalid = []
    rounds = []

    for r in range(args.runs + 1):
        warm = r == 0
        load = os.getloadavg()
        order = names[r % len(names):] + names[:r % len(names)]
        for p in PROGRAMS:
            for vm in order:
                wall, cpu, code, out, err = run_once(vms[vm](p))
                ok = code == 0 and out == ORACLE[p]
                if not ok:
                    invalid.append({"round": r, "vm": vm, "program": p, "exit": code,
                                    "stdout": out, "stderr": err[:500]})
                if not warm:
                    samples[vm][p].append({"wall": wall, "cpu": cpu, "ok": ok})
        rounds.append({"round": r, "warmup": warm, "loadavg_before": load})
        print(f"round {r}{' (warm-up)' if warm else ''}: loadavg {load[0]:.2f}", flush=True)

    summary = {}
    for vm in names:
        summary[vm] = {}
        for p in PROGRAMS:
            walls = [s["wall"] for s in samples[vm][p]]
            cpus = [s["cpu"] for s in samples[vm][p]]
            summary[vm][p] = {
                "median_wall": statistics.median(walls),
                "min_wall": min(walls),
                "max_wall": max(walls),
                "median_cpu": statistics.median(cpus),
                "valid": all(s["ok"] for s in samples[vm][p]),
            }

    def net(vm, p):
        return summary[vm][p]["median_wall"] - summary[vm]["empty"]["median_wall"]

    ratios = {}
    for ref in ["v46-release", "v46-debug"]:
        ratios[ref] = {}
        for p in ["fib", "loop", "objects"]:
            ratios[ref][p] = {
                "gross": summary[ref][p]["median_wall"] / summary["script"][p]["median_wall"],
                "net": net(ref, p) / net("script", p),
                "cpu": summary[ref][p]["median_cpu"] / summary["script"][p]["median_cpu"],
            }
        for kind in ["gross", "net", "cpu"]:
            values = [ratios[ref][p][kind] for p in ["fib", "loop", "objects"]]
            ratios[ref][f"geomean_{kind}"] = math.exp(sum(map(math.log, values)) / len(values))

    result = {
        "host": platform.uname()._asdict(),
        "runs": args.runs,
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
            s = summary[vm][p]
            print(f"| {p} | {vm} | {s['median_wall']:.3f} | {s['min_wall']:.3f} | "
                  f"{s['max_wall']:.3f} | {s['median_cpu']:.3f} | {'ok' if s['valid'] else 'INVALID'} |")
    print()
    for ref in ratios:
        print(f"{ref} / script: " + ", ".join(
            f"{p} gross {ratios[ref][p]['gross']:.2f} net {ratios[ref][p]['net']:.2f} "
            f"cpu {ratios[ref][p]['cpu']:.2f}" for p in ["fib", "loop", "objects"]))
        print(f"  geomean gross {ratios[ref]['geomean_gross']:.2f} "
              f"net {ratios[ref]['geomean_net']:.2f} cpu {ratios[ref]['geomean_cpu']:.2f}")
    print(f"invalid runs: {len(invalid)}")


if __name__ == "__main__":
    main()
