part w3, 9 runs each, round-robin; loadavg before 1.04 3.06 8.25, after 1.02 2.34 7.30
| config | what | median ms | min–max ms | ns/lookup | allocs | bytes | gcs | check |
|---|---|---:|---:|---:|---:|---:|---:|---|
| small-mono | hash/eq on string, direct (monomorphized) | 504.5 | 489.0–527.8 | 50.45 | 0 | – | – | ok |
| small-iface | hash/eq through the key's interface table (KeyRef) | 583.3 | 548.2–610.3 | 58.33 | 0 | – | – | ok |
| small-wit | hash/eq through a witness object over HeapRef keys | 600.3 | 565.5–640.7 | 60.03 | 0 | – | – | ok |
| big-mono | hash/eq on string, direct (monomorphized) | 2218.8 | 2066.3–2568.1 | 221.88 | 0 | – | – | ok |
| big-iface | hash/eq through the key's interface table (KeyRef) | 3691.8 | 3474.8–3951.7 | 369.18 | 0 | – | – | ok |
| big-wit | hash/eq through a witness object over HeapRef keys | 4287.4 | 4113.6–4497.6 | 428.74 | 0 | – | – | ok |
