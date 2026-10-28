part w3, 9 runs each, round-robin; loadavg before 1.03 1.11 4.31, after 1.02 1.08 3.84
| config | what | median ms | min–max ms | ns/lookup | allocs | bytes | gcs | check |
|---|---|---:|---:|---:|---:|---:|---:|---|
| small-mono | hash/eq on string, direct (monomorphized) | 520.0 | 499.3–542.2 | 52.00 | 0 | – | – | ok |
| small-iface | hash/eq through the key's interface table (KeyRef) | 600.8 | 571.4–647.1 | 60.08 | 0 | – | – | ok |
| small-wit | hash/eq through a witness object over HeapRef keys | 617.1 | 594.0–667.7 | 61.71 | 0 | – | – | ok |
| small-hash | hashStr(query) alone, no table | 176.0 | 164.9–191.3 | 17.60 | 0 | – | – | ok |
| big-mono | hash/eq on string, direct (monomorphized) | 2263.4 | 2190.7–2317.5 | 226.34 | 0 | – | – | ok |
| big-iface | hash/eq through the key's interface table (KeyRef) | 3919.9 | 3831.8–4118.7 | 391.99 | 0 | – | – | ok |
| big-wit | hash/eq through a witness object over HeapRef keys | 4261.9 | 4134.0–4392.0 | 426.19 | 0 | – | – | ok |
| big-hash | hashStr(query) alone, no table | 197.6 | 178.5–203.1 | 19.76 | 0 | – | – | ok |
