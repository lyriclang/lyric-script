part w3, 9 runs each, round-robin; loadavg before 0.80 0.95 3.18, after 1.02 1.00 2.81
| config | what | median ms | min–max ms | ns/lookup | allocs | bytes | gcs | check |
|---|---|---:|---:|---:|---:|---:|---:|---|
| small-mono | hash/eq on string, direct (monomorphized) | 517.7 | 504.1–560.6 | 51.77 | 0 | – | – | ok |
| small-mbox | as mono, every key behind a StrBox object (the box, no dispatch) | 544.3 | 520.0–573.4 | 54.43 | 0 | – | – | ok |
| small-iface | hash/eq through the key's interface table (KeyRef) | 583.8 | 567.8–624.6 | 58.38 | 0 | – | – | ok |
| small-wit | hash/eq through a witness object over HeapRef keys | 584.0 | 560.0–627.1 | 58.40 | 0 | – | – | ok |
| small-hash | hashStr(query) alone, no table | 175.9 | 164.8–209.1 | 17.59 | 0 | – | – | ok |
| big-mono | hash/eq on string, direct (monomorphized) | 2199.4 | 2063.9–2331.8 | 219.94 | 0 | – | – | ok |
| big-mbox | as mono, every key behind a StrBox object (the box, no dispatch) | 3037.8 | 2888.1–3128.8 | 303.78 | 0 | – | – | ok |
| big-iface | hash/eq through the key's interface table (KeyRef) | 3835.0 | 3677.5–4121.1 | 383.50 | 0 | – | – | ok |
| big-wit | hash/eq through a witness object over HeapRef keys | 4193.4 | 4127.8–4690.7 | 419.34 | 0 | – | – | ok |
| big-hash | hashStr(query) alone, no table | 197.2 | 182.2–210.9 | 19.72 | 0 | – | – | ok |
