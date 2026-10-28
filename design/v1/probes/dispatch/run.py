#!/usr/bin/env python3
"""Times the dispatch-probe binaries built by build.sh.

    python3 run.py <bindir> [--n 100000000] [--runs 5] [--json out.json]

Runs every variant `runs` times at n, round-robin (so a slow phase of the machine hits every
variant alike), and once more per round at n = 1 for the constant start-up cost. Checks that
every variant prints the same acc and the executed count its VM must reach (8n + 6 for the
register VM, 21n + 11 for the stack VM); a variant that differs is reported INVALID.
"""
import argparse, json, os, statistics, subprocess, sys, time, pathlib

VARIANTS = [
    ('P0', 'p0_native', None, 'plain C loop, no VM (oracle)'),
    ('P1', 'p1_reg', 'reg', 'Lyric 5 register VM, hot first'),
    ('P1-lto', 'p1_reg_lto', 'reg', 'P1 built with --lto'),
    ('P1-man', 'p1_man', 'reg', 'P1 C rebuilt by hand, unchanged (control)'),
    ('P1-noidx', 'p1_noidx', 'reg', 'P1 C, index checks removed'),
    ('P1-bare', 'p1_bare', 'reg', 'P1 C, index+overflow checks and poll removed'),
    ('P2', 'p2_reg_hotlast', 'reg', 'Lyric 5 register VM, hot last'),
    ('P3', 'p3_reg_ptr', 'reg', 'Lyric 5 register VM, Ptr in unsafe'),
    ('P3-lto', 'p3_reg_ptr_lto', 'reg', 'P3 built with --lto'),
    ('P4', 'p4_stack', 'stack', 'Lyric 5 stack VM, hot first'),
    ('P5', 'p5_switch', 'reg', 'C register VM, switch'),
    ('P5b', 'p5b_goto', 'reg', 'C register VM, computed goto'),
    ('P4c', 'p4c_stack', 'stack', 'C stack VM, switch'),
]

def run(exe, n):
    """Wall time and CPU time (user + sys, from wait4) of one run, and what it printed."""
    t0 = time.perf_counter()
    p = subprocess.Popen([exe, str(n)], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    out, err = p.stdout.read(), p.stderr.read()
    _, status, ru = os.wait4(p.pid, 0)
    t = time.perf_counter() - t0
    p.returncode = os.waitstatus_to_exitcode(status)
    if p.returncode != 0:
        sys.exit(f'{exe} {n} exited {p.returncode}: {err}')
    fields = dict(kv.split('=') for kv in out.split())
    return t, ru.ru_utime + ru.ru_stime, int(fields['acc']), int(fields['executed'])

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('bindir')
    ap.add_argument('--n', type=int, default=100_000_000)
    ap.add_argument('--runs', type=int, default=5)
    ap.add_argument('--json')
    args = ap.parse_args()
    bindir = pathlib.Path(args.bindir)
    n = args.n
    expect = {'reg': 8 * n + 6, 'stack': 21 * n + 11, None: 8 * n + 6}
    per_iter = {'reg': 8, 'stack': 21, None: 8}
    times = {v[0]: [] for v in VARIANTS}
    cpus = {v[0]: [] for v in VARIANTS}
    starts = {v[0]: [] for v in VARIANTS}
    seen = {}
    load_before = pathlib.Path('/proc/loadavg').read_text().split()[:3]
    for rnd in range(args.runs):
        for name, exe, kind, _ in VARIANTS:
            t, cpu, acc, ex = run(str(bindir / exe), n)
            times[name].append(t)
            cpus[name].append(cpu)
            seen.setdefault(name, set()).add((acc, ex))
            starts[name].append(run(str(bindir / exe), 1)[0])
        print(f'round {rnd + 1}/{args.runs} done', file=sys.stderr)
    load_after = pathlib.Path('/proc/loadavg').read_text().split()[:3]
    oracle_acc = next(iter(seen['P0']))[0]
    rows = []
    for name, exe, kind, what in VARIANTS:
        results = seen[name]
        acc, ex = next(iter(results))
        valid = len(results) == 1 and acc == oracle_acc and ex == expect[kind]
        med = statistics.median(times[name])
        cpu = statistics.median(cpus[name])
        start = statistics.median(starts[name])
        rows.append(dict(variant=name, binary=exe, what=what, median_s=med,
                         min_s=min(times[name]), max_s=max(times[name]), runs=times[name],
                         cpu_median_s=cpu, cpu_runs=cpus[name],
                         startup_s=start, executed=ex, acc=acc, valid=valid,
                         ns_per_instr=med * 1e9 / ex,
                         ns_per_instr_net=(med - start) * 1e9 / ex,
                         instr_per_iter=per_iter[kind],
                         ns_per_iter=(med - start) * 1e9 / n))
    print(f'n = {n}, {args.runs} runs each, round-robin; oracle acc = {oracle_acc}; '
          f'loadavg before {" ".join(load_before)}, after {" ".join(load_after)}')
    print('| variant | what | median s | min–max s | CPU s (median) | start s | executed | ns/instr | ns/instr net | ns/iter net | check |')
    print('|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|')
    for r in rows:
        print(f"| {r['variant']} | {r['what']} | {r['median_s']:.3f} | {r['min_s']:.3f}–{r['max_s']:.3f} | "
              f"{r['cpu_median_s']:.3f} | {r['startup_s']:.4f} | {r['executed']} | {r['ns_per_instr']:.2f} | "
              f"{r['ns_per_instr_net']:.2f} | {r['ns_per_iter']:.2f} | {'ok' if r['valid'] else 'INVALID'} |")
    if args.json:
        pathlib.Path(args.json).write_text(json.dumps(dict(n=n, runs=args.runs, oracle_acc=oracle_acc,
                                                           load_before=load_before, load_after=load_after,
                                                           rows=rows), indent=2))

if __name__ == '__main__':
    main()
