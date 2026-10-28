part w3, 9 runs each, round-robin; loadavg before 1.02 2.34 7.30, after 1.00 1.92 6.59
| config | what | median ms | min–max ms | ns/lookup | allocs | bytes | gcs | check |
|---|---|---:|---:|---:|---:|---:|---:|---|
| small-mono | hash/eq on string, direct (monomorphized) | 427.6 | 408.9–598.3 | 42.76 | 0 | – | – | ok |
| small-iface | hash/eq through the key's interface table (KeyRef) | 504.1 | 478.2–655.3 | 50.41 | 0 | – | – | ok |
| small-wit | hash/eq through a witness object over HeapRef keys | 497.3 | 483.9–550.1 | 49.73 | 0 | – | – | ok |
| big-mono | hash/eq on string, direct (monomorphized) | 1982.7 | 1905.9–2140.0 | 198.27 | 0 | – | – | ok |
| big-iface | hash/eq through the key's interface table (KeyRef) | 2985.2 | 2798.2–3400.9 | 298.52 | 0 | – | – | ok |
| big-wit | hash/eq through a witness object over HeapRef keys | 3147.8 | 2940.2–3433.2 | 314.78 | 0 | – | – | ok |
