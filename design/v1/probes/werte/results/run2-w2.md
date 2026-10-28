part w2, 9 runs each, round-robin; loadavg before 0.33 1.27 5.64, after 1.03 1.11 4.31
oracle acc = 670165716117834240
| variant | what | median ms | min–max ms | ns/instr | ns/iter | frame bytes (allocs) | check |
|---|---|---:|---:|---:|---:|---:|---|
| P0 | plain C loop, no VM (oracle) | 153.0 | 137.7–179.0 | – | 1.53 | 0 (0) | ok |
| W2-a | split: scalars uint64[] + refs HeapRef[] | 2983.1 | 2791.5–3163.0 | 2.29 | 29.83 | 480 (4) | ok |
| W2-b | Value{bits, ref: HeapRef}, nil object, scalar write .bits | 3008.5 | 2933.8–3275.4 | 2.31 | 30.08 | 448 (2) | ok |
| W2-bc | Value{bits, ref: HeapRef}, nil object, scalar write whole slot | 11474.0 | 11215.7–12226.1 | 8.83 | 114.74 | 448 (2) | ok |
| W2-o | Value{bits, ref: ?HeapRef}, scalar write .bits | 3631.1 | 3449.2–3918.0 | 2.79 | 36.31 | 576 (2) | ok |
| W2-oc | Value{bits, ref: ?HeapRef}, scalar write whole slot | 11890.6 | 11677.9–12920.6 | 9.15 | 118.91 | 576 (2) | ok |
| P1 (dispatch probe) | scalar-only register VM, 8 instr/iter | 1485.7 | 1401.4–1543.0 | 1.86 | 14.86 | – (–) | ok |
