#!/usr/bin/env python3
# Messpunkt 1: derived numbers from run JSONs (per call / iteration / node, per VM instruction).
#   python3 bench/derive.py bench/results/run1.json bench/results/run2.json
import json, sys, statistics

FIB_CALLS = 7049155           # 2*fib(33) - 1
FIB_NONLEAF = 3524577         # fib(33) - 1
FIB_LEAF = 3524578            # fib(33)
LOOP_N = 10_000_000
NODES = 100_000
# executed VM instructions per unit (static count from the bytecode)
INSTR = {
    "script": {"fib_nonleaf": 8, "fib_leaf": 3, "loop": 5, "walk": 5, "build": 6},
    "v46-release": {"fib_nonleaf": 11, "fib_leaf": 3, "loop": 16, "walk": 18, "build": 23},
    "v46-debug": {"fib_nonleaf": 11, "fib_leaf": 3, "loop": 11, "walk": 18, "build": 18},
}

for path in sys.argv[1:]:
    r = json.load(open(path))
    s = r["summary"]
    print("==", path)
    for vm in s:
        e = s[vm]["empty"]["median_wall"]
        fib = s[vm]["fib"]["median_wall"] - e
        loop = s[vm]["loop"]["median_wall"] - e
        obj = s[vm]["objects"]["median_wall"] - e
        k = INSTR[vm]
        fib_instr = FIB_NONLEAF * k["fib_nonleaf"] + FIB_LEAF * k["fib_leaf"]
        line = (f"{vm:12s} empty {e*1000:6.1f} ms | fib {fib*1e9/FIB_CALLS:6.1f} ns/call "
                f"{fib*1e9/fib_instr:5.2f} ns/instr | loop {loop*1e9/LOOP_N:6.1f} ns/iter "
                f"{loop*1e9/LOOP_N/k['loop']:5.2f} ns/instr | objects {obj*1e9/(50*NODES):6.1f} ns/visit(all)")
        if "objects1" in s[vm]:
            o1 = s[vm]["objects1"]["median_wall"] - e
            walk = (obj - o1) / 49          # one walk over all nodes
            build = o1 - walk
            line += (f" | walk {walk*1e9/NODES:6.1f} ns/node {walk*1e9/NODES/k['walk']:5.2f} ns/instr"
                     f" | build {build*1000:6.1f} ms = {build*1e9/NODES:6.1f} ns/node")
        print(line)
    for ref in r["ratios"]:
        q = r["ratios"][ref]
        print(f"{ref}/script: " + "  ".join(
            f"{p} {q[p]['gross']:.2f}/{q[p]['net']:.2f}" for p in ["fib", "loop", "objects"])
            + f"  geomean {q['geomean_gross']:.2f}/{q['geomean_net']:.2f} (gross/net)")
    if "objects1" in s["script"]:
        for ref in ["v46-release", "v46-debug"]:
            e_s = s["script"]["empty"]["median_wall"]; e_r = s[ref]["empty"]["median_wall"]
            ws = (s["script"]["objects"]["median_wall"] - s["script"]["objects1"]["median_wall"])
            wr = (s[ref]["objects"]["median_wall"] - s[ref]["objects1"]["median_wall"])
            bs = s["script"]["objects1"]["median_wall"] - e_s - ws / 49
            br = s[ref]["objects1"]["median_wall"] - e_r - wr / 49
            print(f"{ref}/script B3 split: walk {wr/ws:.2f}, build {br/bs:.2f}")
    # spread: max/min of the 7 walls per cell
    for vm in s:
        print(vm, " ".join(f"{p}:{s[vm][p]['max_wall']/s[vm][p]['min_wall']:.2f}" for p in s[vm]))
