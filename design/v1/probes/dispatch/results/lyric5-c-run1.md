n = 100000000, 5 runs each, round-robin; oracle acc = 663007437317834240; loadavg before 0.89 8.14 11.92, after 1.07 6.22 10.86
| variant | what | median s | min–max s | CPU s (median) | start s | executed | ns/instr | ns/instr net | ns/iter net | check |
|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| P0 | plain C loop, no VM (oracle) | 0.084 | 0.073–0.117 | 0.078 | 0.0009 | 800000006 | 0.10 | 0.10 | 0.83 | ok |
| P1 | Lyric 5 register VM, hot first | 1.237 | 1.096–1.574 | 1.236 | 0.0011 | 800000006 | 1.55 | 1.54 | 12.35 | ok |
| P1-lto | P1 built with --lto | 1.276 | 1.058–1.431 | 1.276 | 0.0012 | 800000006 | 1.59 | 1.59 | 12.75 | ok |
| P2 | Lyric 5 register VM, hot last | 1.346 | 1.135–1.530 | 1.346 | 0.0011 | 800000006 | 1.68 | 1.68 | 13.45 | ok |
| P3 | Lyric 5 register VM, Ptr in unsafe | 4.261 | 3.538–4.666 | 4.259 | 0.0017 | 800000006 | 5.33 | 5.32 | 42.59 | ok |
| P3-lto | P3 built with --lto | 1.819 | 1.510–2.076 | 1.812 | 0.0011 | 800000006 | 2.27 | 2.27 | 18.18 | ok |
| P4 | Lyric 5 stack VM, hot first | 3.706 | 3.300–4.247 | 3.706 | 0.0012 | 2100000011 | 1.76 | 1.76 | 37.05 | ok |
| P5 | C register VM, switch | 1.015 | 0.866–1.115 | 1.014 | 0.0009 | 800000006 | 1.27 | 1.27 | 10.14 | ok |
| P5b | C register VM, computed goto | 0.930 | 0.848–1.084 | 0.930 | 0.0009 | 800000006 | 1.16 | 1.16 | 9.29 | ok |
| P4c | C stack VM, switch | 3.390 | 3.357–4.138 | 3.390 | 0.0008 | 2100000011 | 1.61 | 1.61 | 33.89 | ok |
