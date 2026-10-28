part w3, 9 runs each, round-robin; loadavg before 1.02 1.00 2.81, after 1.01 1.00 2.53
| config | what | median ms | min–max ms | ns/lookup | allocs | bytes | gcs | check |
|---|---|---:|---:|---:|---:|---:|---:|---|
| small-mono | hash/eq on string, direct (monomorphized) | 441.8 | 424.9–451.2 | 44.18 | 0 | – | – | ok |
| small-mbox | as mono, every key behind a StrBox object (the box, no dispatch) | 450.7 | 430.3–478.0 | 45.07 | 0 | – | – | ok |
| small-iface | hash/eq through the key's interface table (KeyRef) | 491.7 | 476.9–533.5 | 49.17 | 0 | – | – | ok |
| small-wit | hash/eq through a witness object over HeapRef keys | 510.8 | 489.5–523.8 | 51.08 | 0 | – | – | ok |
| small-hash | hashStr(query) alone, no table | 144.4 | 138.5–167.2 | 14.44 | 0 | – | – | ok |
| big-mono | hash/eq on string, direct (monomorphized) | 2025.8 | 1981.9–2063.6 | 202.58 | 0 | – | – | ok |
| big-mbox | as mono, every key behind a StrBox object (the box, no dispatch) | 2721.2 | 2600.1–2868.3 | 272.12 | 0 | – | – | ok |
| big-iface | hash/eq through the key's interface table (KeyRef) | 3063.0 | 2953.2–3104.9 | 306.30 | 0 | – | – | ok |
| big-wit | hash/eq through a witness object over HeapRef keys | 3128.9 | 3072.2–3395.4 | 312.89 | 0 | – | – | ok |
| big-hash | hashStr(query) alone, no table | 200.3 | 176.8–220.6 | 20.03 | 0 | – | – | ok |
