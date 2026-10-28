n = 100000000, 5 runs each, round-robin; oracle acc = 663007437317834240
| variant | what | median s | min–max s | start s | executed | ns/instr | ns/instr net | ns/iter net | check |
|---|---|---:|---:|---:|---:|---:|---:|---:|---|
| P0 | plain C loop, no VM (oracle) | 0.255 | 0.224–0.345 | 0.0049 | 800000006 | 0.32 | 0.31 | 2.50 | ok |
| P1 | Lyric 5 register VM, hot first | 3.638 | 3.211–3.885 | 0.0039 | 800000006 | 4.55 | 4.54 | 36.34 | ok |
| P1-lto | P1 built with --lto | 3.767 | 2.711–4.022 | 0.0034 | 800000006 | 4.71 | 4.70 | 37.63 | ok |
| P2 | Lyric 5 register VM, hot last | 3.793 | 3.429–4.155 | 0.0070 | 800000006 | 4.74 | 4.73 | 37.86 | ok |
| P3 | Lyric 5 register VM, Ptr in unsafe | 11.702 | 11.324–13.838 | 0.0022 | 800000006 | 14.63 | 14.62 | 117.00 | ok |
| P3-lto | P3 built with --lto | 4.867 | 4.444–5.733 | 0.0020 | 800000006 | 6.08 | 6.08 | 48.65 | ok |
| P4 | Lyric 5 stack VM, hot first | 10.419 | 9.847–10.721 | 0.0046 | 2100000011 | 4.96 | 4.96 | 104.14 | ok |
| P5 | C register VM, switch | 2.354 | 1.749–3.289 | 0.0041 | 800000006 | 2.94 | 2.94 | 23.50 | ok |
| P5b | C register VM, computed goto | 3.294 | 2.318–4.074 | 0.0036 | 800000006 | 4.12 | 4.11 | 32.90 | ok |
| P4c | C stack VM, switch | 9.853 | 8.140–11.335 | 0.0022 | 2100000011 | 4.69 | 4.69 | 98.50 | ok |
