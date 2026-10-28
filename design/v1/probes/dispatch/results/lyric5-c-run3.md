n = 100000000, 9 runs each, round-robin; oracle acc = 663007437317834240; loadavg before 0.99 4.08 9.31, after 1.12 3.02 8.20
| variant | what | median s | min–max s | CPU s (median) | start s | executed | ns/instr | ns/instr net | ns/iter net | check |
|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| P0 | plain C loop, no VM (oracle) | 0.063 | 0.055–0.077 | 0.062 | 0.0007 | 800000006 | 0.08 | 0.08 | 0.62 | ok |
| P1 | Lyric 5 register VM, hot first | 1.030 | 0.999–1.083 | 1.030 | 0.0009 | 800000006 | 1.29 | 1.29 | 10.29 | ok |
| P1-lto | P1 built with --lto | 0.965 | 0.919–0.997 | 0.965 | 0.0008 | 800000006 | 1.21 | 1.21 | 9.64 | ok |
| P2 | Lyric 5 register VM, hot last | 0.975 | 0.933–1.040 | 0.974 | 0.0008 | 800000006 | 1.22 | 1.22 | 9.74 | ok |
| P3 | Lyric 5 register VM, Ptr in unsafe | 3.118 | 3.025–3.262 | 3.116 | 0.0009 | 800000006 | 3.90 | 3.90 | 31.17 | ok |
| P3-lto | P3 built with --lto | 1.328 | 1.257–1.364 | 1.327 | 0.0009 | 800000006 | 1.66 | 1.66 | 13.27 | ok |
| P4 | Lyric 5 stack VM, hot first | 2.791 | 2.656–2.897 | 2.791 | 0.0009 | 2100000011 | 1.33 | 1.33 | 27.90 | ok |
| P5 | C register VM, switch | 0.741 | 0.705–0.881 | 0.741 | 0.0007 | 800000006 | 0.93 | 0.93 | 7.41 | ok |
| P5b | C register VM, computed goto | 0.728 | 0.702–0.828 | 0.728 | 0.0006 | 800000006 | 0.91 | 0.91 | 7.27 | ok |
| P4c | C stack VM, switch | 2.881 | 2.837–2.998 | 2.880 | 0.0007 | 2100000011 | 1.37 | 1.37 | 28.80 | ok |
