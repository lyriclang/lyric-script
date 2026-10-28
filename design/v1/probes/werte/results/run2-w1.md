part w1, 9 runs each, round-robin; loadavg before 0.27 1.27 5.67, after 0.33 1.27 5.64
| config | what | median ms | min–max ms | ns/iteration | allocs | bytes | gcs | check |
|---|---|---:|---:|---:|---:|---:|---:|---|
| base | class instance -> ScriptObject[] (no interface) | 11.6 | 10.5–14.2 | 1.16 | 0 | 0 | 0 | ok |
| class | class instance -> HeapRef[] | 35.6 | 31.3–37.5 | 3.56 | 0 | 0 | 0 | ok |
| string | string -> HeapRef[] | 114.0 | 105.1–137.0 | 11.40 | 10000000 | 160000000 | 37 | ok |
| struct | Small { a, b } -> HeapRef[] | 124.8 | 115.6–143.2 | 12.48 | 10000000 | 320000000 | 75 | ok |
| int | int -> HeapRef[] | 111.0 | 95.8–147.6 | 11.10 | 10000000 | 160000000 | 37 | ok |
| move | ready HeapRef (a string) -> HeapRef[] | 34.6 | 30.5–37.3 | 3.46 | 0 | 0 | 0 | ok |
