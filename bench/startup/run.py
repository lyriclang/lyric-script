#!/usr/bin/env python3
"""Messpunkt 2: the start of `lyric-script run hello.lyrs`, warm (bytecode in the cache) and cold
(compiled, the cache written). See README.md for the expectations and the control."""

import argparse
import json
import os
import pathlib
import shutil
import statistics
import subprocess
import tempfile
import time


def one(binary, script, cache):
    env = dict(os.environ, LYRIC_SCRIPT_CACHE=str(cache))
    t0 = time.perf_counter()
    done = subprocess.run([binary, "run", script], capture_output=True, text=True, env=env)
    elapsed = time.perf_counter() - t0
    files = list((cache / "bytecode").glob("*.lyrsc")) if (cache / "bytecode").exists() else []
    ok = done.returncode == 0 and done.stdout == "Hello, world!\n" and len(files) == 1
    return elapsed, ok


def measure(binary, script, runs):
    root = pathlib.Path(tempfile.mkdtemp(prefix="lys-startup-"))
    warm_cache = root / "warm"
    one(binary, script, warm_cache)  # fills the warm cache, and warms the file system
    warm, cold, invalid = [], [], 0
    for k in range(runs + 1):
        cold_cache = root / f"cold-{k}"
        t, ok = one(binary, script, cold_cache)
        if k > 0:
            cold.append(t)
            invalid += 0 if ok else 1
        shutil.rmtree(cold_cache, ignore_errors=True)
        t, ok = one(binary, script, warm_cache)
        if k > 0:
            warm.append(t)
            invalid += 0 if ok else 1
    shutil.rmtree(root, ignore_errors=True)
    return warm, cold, invalid


def summary(xs):
    xs = sorted(xs)
    return {
        "median_ms": round(statistics.median(xs) * 1000, 2),
        "min_ms": round(xs[0] * 1000, 2),
        "p90_ms": round(xs[int(len(xs) * 0.9) - 1] * 1000, 2),
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--binary", action="append", required=True, help="profile=path")
    ap.add_argument("--script", required=True)
    ap.add_argument("--runs", type=int, default=30)
    ap.add_argument("--out", required=True)
    args = ap.parse_args()
    results = {"loadavg": os.getloadavg(), "runs": args.runs, "profiles": {}}
    for spec in args.binary:
        profile, path = spec.split("=", 1)
        warm, cold, invalid = measure(path, args.script, args.runs)
        results["profiles"][profile] = {
            "warm": summary(warm),
            "cold": summary(cold),
            "invalid": invalid,
            "warm_all_ms": [round(t * 1000, 3) for t in warm],
            "cold_all_ms": [round(t * 1000, 3) for t in cold],
        }
        print(profile, "warm", summary(warm), "cold", summary(cold), "invalid", invalid)
    results["loadavg_end"] = os.getloadavg()
    pathlib.Path(args.out).write_text(json.dumps(results, indent=2) + "\n")


if __name__ == "__main__":
    main()
