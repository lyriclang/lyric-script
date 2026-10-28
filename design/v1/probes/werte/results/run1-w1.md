part w1, 9 runs each, round-robin; loadavg before 0.60 7.02 11.29, after 0.63 6.92 11.23
| config | what | median ms | min–max ms | ns/iteration | allocs | bytes | gcs | check |
|---|---|---:|---:|---:|---:|---:|---:|---|
| base | class instance -> ScriptObject[] (no interface) | 10.6 | 8.9–14.2 | 1.06 | 0 | 0 | 0 | ok |
| class | class instance -> HeapRef[] | 30.7 | 28.9–39.4 | 3.07 | 0 | 0 | 0 | ok |
| string | string -> HeapRef[] | 108.9 | 98.9–136.9 | 10.89 | 10000000 | 160000000 | 37 | ok |
| struct | Small { a, b } -> HeapRef[] | 115.4 | 108.7–134.8 | 11.54 | 10000000 | 320000000 | 75 | ok |
| int | int -> HeapRef[] | 105.8 | 95.0–140.3 | 10.58 | 10000000 | 160000000 | 37 | ok |
| move | ready HeapRef (a string) -> HeapRef[] | 31.0 | 27.3–36.1 | 3.10 | 0 | 0 | 0 | ok |
