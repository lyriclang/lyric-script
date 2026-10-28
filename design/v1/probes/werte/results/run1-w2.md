part w2, 9 runs each, round-robin; loadavg before 0.63 6.92 11.23, after 1.04 3.06 8.25
oracle acc = 670165716117834240
| variant | what | median ms | min–max ms | ns/instr | ns/iter | frame bytes (allocs) | check |
|---|---|---:|---:|---:|---:|---:|---|
| P0 | plain C loop, no VM (oracle) | 152.6 | 135.4–181.1 | – | 1.53 | 0 (0) | ok |
| W2-a | split: scalars uint64[] + refs HeapRef[] | 2945.4 | 2761.4–3269.0 | 2.27 | 29.45 | 480 (4) | ok |
| W2-b | Value{bits, ref: HeapRef}, nil object, scalar write .bits | 3089.3 | 2786.8–3234.9 | 2.38 | 30.89 | 448 (2) | ok |
| W2-bc | Value{bits, ref: HeapRef}, nil object, scalar write whole slot | 11787.5 | 11179.6–13672.3 | 9.07 | 117.88 | 448 (2) | ok |
| W2-o | Value{bits, ref: ?HeapRef}, scalar write .bits | 3581.1 | 3401.5–3899.0 | 2.75 | 35.81 | 576 (2) | ok |
| W2-oc | Value{bits, ref: ?HeapRef}, scalar write whole slot | 12278.2 | 11640.2–13375.0 | 9.44 | 122.78 | 576 (2) | ok |
| P1 (dispatch probe) | scalar-only register VM, 8 instr/iter | 1595.2 | 1419.0–1777.0 | 1.99 | 15.95 | – (–) | ok |
