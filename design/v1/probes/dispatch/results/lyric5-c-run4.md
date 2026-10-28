n = 100000000, 9 runs each, round-robin; oracle acc = 663007437317834240; loadavg before 0.26 1.59 6.60, after 1.77 2.28 6.05
| variant | what | median s | min–max s | CPU s (median) | start s | executed | ns/instr | ns/instr net | ns/iter net | check |
|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| P0 | plain C loop, no VM (oracle) | 0.067 | 0.061–0.185 | 0.067 | 0.0006 | 800000006 | 0.08 | 0.08 | 0.67 | ok |
| P1 | Lyric 5 register VM, hot first | 1.042 | 0.964–2.909 | 1.042 | 0.0008 | 800000006 | 1.30 | 1.30 | 10.41 | ok |
| P1-lto | P1 built with --lto | 0.968 | 0.928–3.493 | 0.968 | 0.0010 | 800000006 | 1.21 | 1.21 | 9.67 | ok |
| P1-man | P1 C rebuilt by hand, unchanged (control) | 1.009 | 0.966–2.565 | 1.008 | 0.0008 | 800000006 | 1.26 | 1.26 | 10.08 | ok |
| P1-noidx | P1 C, index checks removed | 0.766 | 0.732–1.257 | 0.766 | 0.0008 | 800000006 | 0.96 | 0.96 | 7.65 | ok |
| P1-bare | P1 C, index+overflow checks and poll removed | 0.736 | 0.711–1.170 | 0.736 | 0.0008 | 800000006 | 0.92 | 0.92 | 7.36 | ok |
| P2 | Lyric 5 register VM, hot last | 0.964 | 0.942–1.526 | 0.962 | 0.0008 | 800000006 | 1.20 | 1.20 | 9.63 | ok |
| P3 | Lyric 5 register VM, Ptr in unsafe | 3.091 | 2.964–7.095 | 3.087 | 0.0010 | 800000006 | 3.86 | 3.86 | 30.90 | ok |
| P3-lto | P3 built with --lto | 1.321 | 1.255–3.233 | 1.321 | 0.0010 | 800000006 | 1.65 | 1.65 | 13.20 | ok |
| P4 | Lyric 5 stack VM, hot first | 2.815 | 2.659–5.999 | 2.811 | 0.0009 | 2100000011 | 1.34 | 1.34 | 28.14 | ok |
| P5 | C register VM, switch | 0.760 | 0.699–1.203 | 0.760 | 0.0008 | 800000006 | 0.95 | 0.95 | 7.59 | ok |
| P5b | C register VM, computed goto | 0.728 | 0.678–1.403 | 0.728 | 0.0007 | 800000006 | 0.91 | 0.91 | 7.27 | ok |
| P4c | C stack VM, switch | 2.930 | 2.790–5.114 | 2.930 | 0.0008 | 2100000011 | 1.40 | 1.39 | 29.29 | ok |
