#!/usr/bin/env python3
"""Times the value-probe binaries built by build.sh.

    python3 run.py <bindir> <w1|w2|w3> [--runs 9] [--json out.json] [--dispatch <dispatch-probe bindir>]

Runs every configuration of the chosen part `runs` times, round-robin (a slow phase of the
machine hits every configuration alike). The time is what the program measured in-process
around its loop (`ns=`); where a program prints none (the C oracle, the dispatch probe's P1), it
is the wall time minus the median wall time of a run at n = 1. Every configuration is checked
against what it must print; one that differs is reported INVALID.
"""
import argparse, json, os, statistics, subprocess, sys, time, pathlib

def w1_configs(n):
    def expect(mode):
        check = {'base': 56, 'class': 56, 'string': 72, 'move': 72,
                 'int': 16 * n - 136, 'struct': 32 * n - 272}[mode]
        allocs = n if mode in ('string', 'int', 'struct') else 0
        nbytes = {'string': 16 * n, 'int': 16 * n, 'struct': 32 * n}.get(mode, 0)
        return dict(check=check, allocs=allocs, bytes=nbytes)
    what = {'base': 'class instance -> ScriptObject[] (no interface)',
            'class': 'class instance -> HeapRef[]',
            'string': 'string -> HeapRef[]',
            'struct': 'Small { a, b } -> HeapRef[]',
            'int': 'int -> HeapRef[]',
            'move': 'ready HeapRef (a string) -> HeapRef[]'}
    return [dict(name=m, exe='w1_coerce', args=[m, str(n)], expect=expect(m), per=n, unit='iteration',
                 what=what[m]) for m in ('base', 'class', 'string', 'struct', 'int', 'move')]

def w2_configs(n, bindir, dispatch, oracle_acc):
    rows = [dict(name='P0', exe='w2_p0', args=[str(n)], wall=True, per=n, unit='iteration',
                 what='plain C loop, no VM (oracle)', expect=dict(executed=13 * n + 8))]
    what = {'a': 'split: scalars uint64[] + refs HeapRef[]',
            'b': 'Value{bits, ref: HeapRef}, nil object, scalar write .bits',
            'bc': 'Value{bits, ref: HeapRef}, nil object, scalar write whole slot',
            'o': 'Value{bits, ref: ?HeapRef}, scalar write .bits',
            'oc': 'Value{bits, ref: ?HeapRef}, scalar write whole slot'}
    for L in ('a', 'b', 'bc', 'o', 'oc'):
        rows.append(dict(name=f'W2-{L}', exe=f'w2_{L}', args=[str(n)], per=n, unit='iteration', what=what[L],
                         expect=dict(executed=13 * n + 8), instr=True))
    if dispatch:
        rows.append(dict(name='P1 (dispatch probe)', exe=str(pathlib.Path(dispatch) / 'p1_reg'), args=[str(n)],
                         wall=True, per=n, unit='iteration', what='scalar-only register VM, 8 instr/iter',
                         expect=dict(executed=8 * n + 6), instr=True, own_acc=True))
    return rows

def w3_expect(n, q, lookups):
    vals = [-1 if (j & 3) == 3 else (j * 7919) % n for j in range(q)]
    cycles, rem = divmod(lookups, q)
    s_all = sum(v for v in vals if v >= 0)
    h_all = sum(1 for v in vals if v >= 0)
    s_rem = sum(v for v in vals[:rem] if v >= 0)
    h_rem = sum(1 for v in vals[:rem] if v >= 0)
    total, hits = cycles * s_all + s_rem, cycles * h_all + h_rem
    return total + hits * 4294967296

def w3_configs(lookups, exe):
    rows = []
    for size, n, q in (('small', 4000, 4096), ('big', 1000000, 1048576)):
        check = w3_expect(n, q, lookups)
        for mode, what in (('mono', 'hash/eq on string, direct (monomorphized)'),
                           ('mbox', 'as mono, every key behind a StrBox object (the box, no dispatch)'),
                           ('iface', 'hash/eq through the key\'s interface table (KeyRef)'),
                           ('wit', 'hash/eq through a witness object over HeapRef keys')):
            rows.append(dict(name=f'{size}-{mode}', exe=exe, args=[mode, str(n), str(q), str(lookups)],
                             per=lookups, unit='lookup', what=what, expect=dict(check=check, allocs=0)))
        # the hash alone: its check depends on the hash function, so only checked for being the same
        # in every run (and, by hand, between w3_map and w3_map_lto)
        rows.append(dict(name=f'{size}-hash', exe=exe, args=['hash', str(n), str(q), str(lookups)],
                         per=lookups, unit='lookup', what='hashStr(query) alone, no table', expect=dict(allocs=0)))
    return rows

def run(exe, args):
    t0 = time.perf_counter()
    p = subprocess.Popen([exe] + args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    out, err = p.stdout.read(), p.stderr.read()
    _, status, ru = os.wait4(p.pid, 0)
    wall = time.perf_counter() - t0
    code = os.waitstatus_to_exitcode(status)
    if code != 0:
        sys.exit(f'{exe} {args} exited {code}: {err}')
    fields = dict(kv.split('=', 1) for kv in out.split() if '=' in kv)
    return wall, ru.ru_utime + ru.ru_stime, fields

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('bindir')
    ap.add_argument('part', choices=['w1', 'w2', 'w3'])
    ap.add_argument('--runs', type=int, default=9)
    ap.add_argument('--n', type=int)
    ap.add_argument('--lookups', type=int, default=10_000_000)
    ap.add_argument('--dispatch')
    ap.add_argument('--exe', default='w3_map', help='W3 binary (w3_map or w3_map_lto)')
    ap.add_argument('--json')
    args = ap.parse_args()
    bindir = pathlib.Path(args.bindir)
    if args.part == 'w1':
        configs = w1_configs(args.n or 10_000_000)
    elif args.part == 'w2':
        configs = w2_configs(args.n or 100_000_000, bindir, args.dispatch, None)
    else:
        configs = w3_configs(args.lookups, args.exe)
    for c in configs:
        c['path'] = c['exe'] if os.path.isabs(c['exe']) else str(bindir / c['exe'])
        c['ns'], c['walls'], c['cpus'], c['starts'], c['seen'] = [], [], [], [], []
    load_before = pathlib.Path('/proc/loadavg').read_text().split()[:3]
    for rnd in range(args.runs):
        for c in configs:
            wall, cpu, f = run(c['path'], c['args'])
            c['walls'].append(wall)
            c['cpus'].append(cpu)
            c['seen'].append(f)
            if c.get('wall'):
                start_args = c['args'][:-1] + ['1']
                c['starts'].append(run(c['path'], start_args)[0])
            else:
                c['ns'].append(int(f['ns']))
        print(f'round {rnd + 1}/{args.runs} done, loadavg {pathlib.Path("/proc/loadavg").read_text().split()[0]}',
              file=sys.stderr)
    load_after = pathlib.Path('/proc/loadavg').read_text().split()[:3]
    # W2: every VM's acc must be the oracle's (P0); P1 has its own oracle from the dispatch probe
    oracle_acc = None
    if args.part == 'w2':
        oracle_acc = configs[0]['seen'][0]['acc']
    rows = []
    for c in configs:
        problems = []
        first = c['seen'][0]
        for f in c['seen']:
            for k, v in c['expect'].items():
                if int(f.get(k, -1)) != v:
                    problems.append(f'{k}={f.get(k)} expected {v}')
            for k in ('acc', 'check'):
                if k in first and f.get(k) != first[k]:
                    problems.append(f'{k} differs between runs')
        if oracle_acc is not None and not c.get('own_acc') and first.get('acc') != oracle_acc:
            problems.append(f"acc={first.get('acc')} expected {oracle_acc}")
        if c.get('own_acc') and first.get('acc') != '663007437317834240' and c['args'][0] == '100000000':
            problems.append(f"acc={first.get('acc')} expected the dispatch probe's 663007437317834240")
        if c.get('wall'):
            start = statistics.median(c['starts'])
            times = [(w - start) * 1e9 for w in c['walls']]
        else:
            start = None
            times = c['ns']
        med = statistics.median(times)
        row = dict(name=c['name'], what=c['what'], args=c['args'], valid=not problems, problems=sorted(set(problems)),
                   median_ns=med, min_ns=min(times), max_ns=max(times), runs_ns=times,
                   wall_median_s=statistics.median(c['walls']), cpu_median_s=statistics.median(c['cpus']),
                   startup_s=start, ns_per_unit=med / c['per'], unit=c['unit'], output=first)
        if c.get('instr'):
            row['ns_per_instr'] = med / int(first['executed'])
        rows.append(row)
    print(f'part {args.part}, {args.runs} runs each, round-robin; loadavg before {" ".join(load_before)}, '
          f'after {" ".join(load_after)}')
    if args.part == 'w2':
        print(f'oracle acc = {oracle_acc}')
        print('| variant | what | median ms | min–max ms | ns/instr | ns/iter | frame bytes (allocs) | check |')
        print('|---|---|---:|---:|---:|---:|---:|---|')
        for r in rows:
            o = r['output']
            fb = f"{o.get('frame_bytes', '–')} ({o.get('frame_allocs', '–')})"
            npi = f"{r['ns_per_instr']:.2f}" if 'ns_per_instr' in r else '–'
            print(f"| {r['name']} | {r['what']} | {r['median_ns'] / 1e6:.1f} | {r['min_ns'] / 1e6:.1f}–{r['max_ns'] / 1e6:.1f} | "
                  f"{npi} | {r['ns_per_unit']:.2f} | {fb} | {'ok' if r['valid'] else 'INVALID ' + '; '.join(r['problems'])} |")
    else:
        print(f'| config | what | median ms | min–max ms | ns/{rows[0]["unit"]} | allocs | bytes | gcs | check |')
        print('|---|---|---:|---:|---:|---:|---:|---:|---|')
        for r in rows:
            o = r['output']
            print(f"| {r['name']} | {r['what']} | {r['median_ns'] / 1e6:.1f} | {r['min_ns'] / 1e6:.1f}–{r['max_ns'] / 1e6:.1f} | "
                  f"{r['ns_per_unit']:.2f} | {o.get('allocs', '–')} | {o.get('bytes', '–')} | {o.get('gcs', '–')} | "
                  f"{'ok' if r['valid'] else 'INVALID ' + '; '.join(r['problems'])} |")
    if args.json:
        pathlib.Path(args.json).write_text(json.dumps(dict(part=args.part, runs=args.runs, load_before=load_before,
                                                           load_after=load_after, oracle_acc=oracle_acc, rows=rows),
                                                      indent=2))

if __name__ == '__main__':
    main()
