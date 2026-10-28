n = 100000000, 9 runs each, round-robin; oracle acc = 663007437317834240; loadavg before 1.06 6.05 10.76, after 1.08 4.20 9.40
| variant | what | median s | min–max s | CPU s (median) | start s | executed | ns/instr | ns/instr net | ns/iter net | check |
|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| P0 | plain C loop, no VM (oracle) | 0.068 | 0.058–0.092 | 0.068 | 0.0007 | 800000006 | 0.08 | 0.08 | 0.67 | ok |
| P1 | Lyric 5 register VM, hot first | 1.055 | 0.969–1.481 | 1.034 | 0.0010 | 800000006 | 1.32 | 1.32 | 10.54 | ok |
| P1-lto | P1 built with --lto | 1.032 | 0.923–1.374 | 1.031 | 0.0010 | 800000006 | 1.29 | 1.29 | 10.31 | ok |
| P2 | Lyric 5 register VM, hot last | 1.006 | 0.922–1.367 | 1.004 | 0.0010 | 800000006 | 1.26 | 1.26 | 10.05 | ok |
| P3 | Lyric 5 register VM, Ptr in unsafe | 3.141 | 2.957–4.895 | 3.141 | 0.0012 | 800000006 | 3.93 | 3.93 | 31.40 | ok |
| P3-lto | P3 built with --lto | 1.364 | 1.239–1.994 | 1.364 | 0.0009 | 800000006 | 1.71 | 1.70 | 13.63 | ok |
| P4 | Lyric 5 stack VM, hot first | 2.806 | 2.670–4.017 | 2.806 | 0.0009 | 2100000011 | 1.34 | 1.34 | 28.05 | ok |
| P5 | C register VM, switch | 0.751 | 0.707–1.122 | 0.751 | 0.0007 | 800000006 | 0.94 | 0.94 | 7.51 | ok |
| P5b | C register VM, computed goto | 0.731 | 0.683–1.028 | 0.730 | 0.0007 | 800000006 | 0.91 | 0.91 | 7.30 | ok |
| P4c | C stack VM, switch | 2.954 | 2.789–4.263 | 2.952 | 0.0008 | 2100000011 | 1.41 | 1.41 | 29.53 | ok |
