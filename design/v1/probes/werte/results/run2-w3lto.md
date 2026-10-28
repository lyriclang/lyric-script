part w3, 9 runs each, round-robin; loadavg before 1.02 1.08 3.84, after 1.05 1.08 3.52
| config | what | median ms | min–max ms | ns/lookup | allocs | bytes | gcs | check |
|---|---|---:|---:|---:|---:|---:|---:|---|
| small-mono | hash/eq on string, direct (monomorphized) | 433.6 | 409.5–443.6 | 43.36 | 0 | – | – | ok |
| small-iface | hash/eq through the key's interface table (KeyRef) | 490.6 | 467.2–514.6 | 49.06 | 0 | – | – | ok |
| small-wit | hash/eq through a witness object over HeapRef keys | 500.1 | 467.8–532.4 | 50.01 | 0 | – | – | ok |
| small-hash | hashStr(query) alone, no table | 155.2 | 130.7–179.0 | 15.52 | 0 | – | – | ok |
| big-mono | hash/eq on string, direct (monomorphized) | 1979.2 | 1906.5–2023.6 | 197.92 | 0 | – | – | ok |
| big-iface | hash/eq through the key's interface table (KeyRef) | 3027.6 | 2811.5–3082.9 | 302.76 | 0 | – | – | ok |
| big-wit | hash/eq through a witness object over HeapRef keys | 3175.8 | 3052.9–3319.0 | 317.58 | 0 | – | – | ok |
| big-hash | hashStr(query) alone, no table | 202.2 | 186.4–211.5 | 20.22 | 0 | – | – | ok |
