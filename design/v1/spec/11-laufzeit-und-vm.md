# 11 — Laufzeit und VM

Entschieden 2026-10-28 (Maintainer, im Fragedialog). Die VM und der Compiler von Lyric-Script
werden in Lyric 5 geschrieben (00 Z2). Grundlage: die Sprache aus 02–09, die Host-Regeln aus 01,
die Dispatch-Probe (`design/v1/probes/dispatch/`) und die Werte-Probe (`design/v1/probes/werte/`).
**Die Werte-Probe (2026-10-28) bestätigt V2 und Gen; V3 wurde nach ihr neu entschieden** (A').

## Vorgaben aus der Sprache

| Vorgabe | Quelle |
|---|---|
| Skalare nur `int`, `float`, `bool`, `char` — alle 64 Bit | 02 T1 |
| Structs unveränderlich und geteilt (auch rekursiv), Klassen veränderlich; Gleichheit/Hash synthetisiert | 02 T7, 03 |
| `?T` mit `??T`; ein wachsender Sequenztyp; Strings sind Lyric-5-Strings | 03 |
| jeder Aufruf darf werfen | 05 |
| Typargumente zur Laufzeit erhalten (Reflexion) | 09 |
| ein Scheduler je Instanz; `call` und `start`/`step`; Abbruch auch wartender Tasks | 01, 07 |
| Fuel und Deadline an Rückwärtssprüngen und Aufrufen; Anhalten = Rückkehr aus der Dispatch-Schleife; Allokationszähler; Eigentum je Instanz; Umbau am Ort beim Reload | 01 |
| Quelle ist das Format; Bytecode ist Cache oder `loadTrusted` | 01 S10 |

## Gemessen (Dispatch-Probe, 2026-10-28)

| Befund | Zahl |
|---|---|
| clang `-O2` faltet Lyric 5s `if`-Kette zu einer Sprungtabelle (A2a nicht nötig) | heiß zuerst 1,30 / zuletzt 1,20 ns je Instruktion |
| Indexprüfungen | 24 % der Dispatch-Zeit (1,26 → 0,96 ns); `Ptr` ist kein Ausweg |
| Register gegen Stack | 8 gegen 21 Instruktionen je Iteration bei gleichen ns/Instruktion → **2,7×** |
| Lyric 5 gegen 4.6 | 19–25× je Iteration (verschiedene Befehlssätze) |

## Entscheidungen

| # | Frage | Entscheidung |
|---|---|---|
| V1 | Maschinenform | **Registermaschine** (gemessen 2,7× je Iteration). Drei Operanden, feste Breite (8 Byte, inline im Array), Registervergabe in einem Durchlauf (Lua). |
| V2 | Wertdarstellung | **Getrennte Dateien**: `scalars: uint64[]` (eine Datei für alle Skalare, alle 64 Bit) und `refs: HeapRef[]`, in Frames und Objekten; der Compiler ordnet jeden Slot statisch zu; `?int` = zwei Skalar-Slots (Wert, Präsenz), `??int` = drei. *Werte-Probe:* gleich schnell wie Zwei-Wort-Slots (1–5 %) und gleich groß — entscheidend ist, dass getrennte Dateien die gemessene Falle ausschließen: ein Zwei-Wort-Slot, der ganz geschrieben wird, ist 4× langsamer (Barriere bei jeder Skalarschreibung). |
| V3 | Referenzform | **Interface `HeapRef`**, jede Art eine Klasse (`ScriptObject`, `ScriptArray`, `Closure`, `HostHandle`, …); **Strings in einer Hülle `ScriptString :: HeapRef { s: string }`** (eine Allokation beim Erzeugen, danach kostenlos umwandelbar). *Neu entschieden 2026-10-28 nach der Werte-Probe (A'):* `extend string :: HeapRef` boxt bei **jeder** Umwandlung (16 B); das Speichern eines Interface-Werts kostet +2,4 ns, weil Lyric 5s `LYR_WRITE_BARRIER_VALUE` die allgemeine Kartenschleife nimmt — **Anforderung A4** an Lyric 5 ([lyric#610](https://github.com/lyriclang/lyric/issues/610)). **Messpunkt 1 (S1) entscheidet**: ist A4 nicht behoben und dominieren Referenz-Moves, Umstellung auf eine einzige Klasse `Obj` (8-Byte-Referenzen) — eine Änderung nur im Inneren der VM. |
| Gen | Generics | **Hybrid wie .NET**: eine geteilte Kopie für alle Referenztypen, je eine für `int`, `float`, `bool`, `char` (≤ 5 je Typparameter); das Typargument als versteckter Deskriptor (Reflexion, `is`, Synthese); Constraint-Aufrufe auf Referenztypen über eine Witness-Tabelle. `List<int>` ungeboxt, `List<MeinTyp>` kompiliert nichts neu. *Werte-Probe:* ein Map-Lookup über die Witness-Tabelle kostet im Cache +11–13 % (~2,3 ns je Aufruf); bei großen Tabellen dominiert die zusätzliche Indirektion, nicht der Aufruf — **die native `Map` (12 Src) hält Lyric-5-Strings als Schlüssel direkt, ohne Hülle**. |
| Co | Koroutinen und Tasks | **VM-eigene Frames** (4.6, Lua): ein Task ist eine Frame-Liste auf dem Heap mit Zustand `Ready`/`Waiting(op)`/`Suspended`/`Done`; Warten und Budget sichern den Zustand und kehren aus der Dispatch-Schleife zurück; I/O startet eine Lyric-5-Operation als Lyric-5-Task, der Skript-Task parkt. *Standalone* wartet die Hauptschleife auf Abschlüsse, `step()` blockiert nie. Grenze: ein Skript-Callback, den ein Native aufruft, darf nicht warten (Fehler; selten, weil die std nach 00 Z6 in Script ist). Braucht A2b nicht. |
| Thr | Threads | **Eine Instanz darf den Thread wechseln, wenn sie ruht** (kein Aufruf aktiv, kein Task wartet auf I/O); **mehrere Instanzen laufen parallel**; kompilierter Code ist unveränderlich und geteilt, die Typtabellen der VM sind lesesicher. Bereitet die Worker-Instanzen (07, Tür) vor. |
| Fmt | Bytecode | **Internes Format ohne Versprechen**: Kopf mit Magic, Compiler-Version, Quell-Hash; Cache-Schlüssel Hash(Quelle + Compiler-Version); `loadTrusted` nimmt nur Bytecode der eigenen Toolchain-Version; keine Spec, kein Verifier als Grenze (01 S10); die std liegt vorkompiliert im Binary, `pack` macht dasselbe für Apps. |
| Perf | Ziele (Ratchets) | `hello.lyrs` warm (Cache) **≤ 10 ms**, kalt **≤ 50 ms**; eingebettet VM + kleine Instanz **≤ 5 ms**; Durchsatz der Bench-Suite **≥ 5×** 4.6 Release auf derselben Maschine; leere Instanz **≤ 100 KiB**. **Verfehlt die erste Messung ein Ziel um mehr als 2×, wird der Plan neu geschnitten** (CONTRIBUTING, Scope-Check) — das Ziel wird nicht still verschoben. |
| Emb | Einbettungsflächen 1.0 | **(a) Lyric-5-API** (Paket `lyric_script`: `Vm`, `Instance`, `call`, `start`/`step`, Rechte, Budget — gleiches Runtime, gleicher GC) und **(b) C-ABI** (`liblyricscript` `.a`/`.so`/`.dll` + Header über Lyric 5s `@Export`, 11 W5 — für C, C++, Rust, Zig, C# über P/Invoke, Python über ctypes). .NET-Paket und weitere Bindings sind Türen. |
| Hst | Host-API-Beschreibung | **Ein Format: ein `.lyrs`-Modul mit Deklarationen ohne Rumpf** (Typen, Handle-Klassen, `@Requires`-Tags nach 01 S2), Implementierungen nach Namen registriert; die VM prüft beim Laden, dass jede Deklaration eine Implementierung hat; die Datei dient zugleich dem Editor der Skriptautoren. **Lyric-5-Hosts erzeugen Datei und Registrierung mit einem Makro `@ScriptApi`** (Lyric 5 M9b). |

## Folgen für die Umsetzung (Liste bestätigt)

| Thema | Regel |
|---|---|
| Instruktionen | Registerform, drei Operanden, 8 Byte, getypte Opcodes (`i`, `f`, `b`, `c`, `r`); Superinstruktionen nur mit Messung |
| Dispatch | `match` über den Opcode (Sprungtabelle durch clang); Indexprüfung bleibt zunächst — verfehlt das Durchsatz-Ratchet, wird **A2d** an Lyric 5 gestellt (ungeprüfter, inline gehender Zugriff) |
| Objekte | Kopf (TypeDesc, besitzende Instanz, Typversion, Generation) → Skalar- und Ref-Array (Umbau am Ort, 01 S7a); Structs geteilt; `ScriptArray` hält Elemente je Elementtyp in Skalar- oder Ref-Speicher |
| Paniken | **Skript-Paniken erkennt die VM selbst** (Überlauf über `checked*`, Index vor dem Zugriff) und wickelt nur VM-Frames ab; eine **Lyric-5-Panik** (Bug in VM oder Native) wird je `call`/`step` an einer Task-Grenze gefangen → `.Panic(intern)`, die VM bleibt nutzbar (wie Lyric 5 11 H3) |
| Fehler | VM-Ausnahmen wickeln VM-Frames ab; `defer` läuft auf VM-Ebene |
| Budget | Fuel je Grundblock an Rückwärtssprüngen und Aufrufen, Deadline-Flag, Allokationszähler in VM-Allokationspfaden und Natives (01 S5, S6) |
| Scheduler | einer je Instanz; I/O über Lyric-5-Tasks; *standalone* wartet auf Abschlüsse, `step()` blockiert nie |
| Rechte | Rechtetabelle je Modul und Host-Tags in der VM; Natives-Tabelle je Instanz als Funktionszeiger |
| std | vorkompiliert (trusted Bytecode) im Binary; die Lyric-5-Natives sind in die VM gelinkt; native Module (00 Z5) statisch in ein eigenes Binary gelinkt oder dynamisch geladen (A1) |
| Debugger | Zeilentabellen je Funktion, Breakpoints, Schrittmodi; DAP in Bereich 13 |
| JIT | **keiner in 1.0** (Tür); Inline-Caches für Interface-Aufrufe nur mit Messung |

## Anforderungen an Lyric 5 (Stand nach Bereich 11)

| # | Anforderung | Stand |
|---|---|---|
| A1 | mehrere Lyric-5-Bibliotheken in einem Prozess (geteiltes Runtime) | nur für dynamisch geladene native Module; Alternative statisches Linken |
| A2a | Switch-/Sprungtabellen-Senkung | **nicht nötig** (gemessen) |
| A2b | Anhalten aus verschachtelten Aufrufen | **nicht nötig** dank Co = A |
| A2c | exakter Toolchain-Pin | nötig zum Umsetzungsbeginn (bis M15: Lyric 5 aus festem Commit bauen) |
| A2d | ungeprüfter Elementzugriff im heißen Pfad | erst, wenn das Durchsatz-Ratchet verfehlt wird (24 % gemessen) |
| A4 | Schreibbarriere für 16-Byte-Werte mit einer Kartenmarkierung statt der allgemeinen Schleife | gestellt: [lyric#610](https://github.com/lyriclang/lyric/issues/610); entscheidet V3 bei Messpunkt 1 |
| A3 | Instanz-Zuordnung im GC | Tür (Live-Speichergrenze je Instanz) |

## Begründung

**Register und getrennte Dateien (V1, V2).** Die Probe hat die Maschinenform entschieden. Die
getrennten Dateien nutzen, was die Sprache garantiert: der Compiler weiß von jedem Slot, ob dort
ein Skalar oder eine Referenz liegt, und weil T1 die Skalare auf vier 64-Bit-Typen reduziert hat,
reicht eine Skalar-Datei.

**Hybride Generics (Gen).** Typargumente müssen zur Laufzeit bekannt sein (Reflexion), die
Standardbibliothek ist in Script geschrieben — Monomorphisierung hätte jeden Skript-Compile mit
der Neuübersetzung von `List`/`Map` belastet, ein einziger geteilter Rumpf hätte `List<int>`
geboxt. Mit nur vier Skalartypen ist der .NET-Weg billig.

**Eigene Frames (Co).** Frames auf dem Heap machen Anhalten, Abbrechen, Backtraces, Debugger und
den Reload-Umbau zu Datenoperationen der VM, hängen nicht an A2b und halten Tasks billig; die eine
Grenze (Native-Callback darf nicht warten) trifft im Python-Modell der std selten.

**Parallele Instanzen (Thr).** Eigentum je Instanz (01 S9) macht Instanzen unabhängig; ein Host
mit Job-System bekommt Parallelität ohne Threads in der Sprache.

**Kein Format-Versprechen (Fmt).** Weil fremder Bytecode nie geladen wird (01 S10), gibt es
niemanden, dem ein stabiles Format nützte; die VM bleibt frei optimierbar.

**Ehrgeizige Ziele mit Regel (Perf).** Ein natives Lyric-5-Binary startet in 1,8 ms und die
Dispatch-Schleife ist 19–25× schneller als 4.6; die Ziele liegen in der Klasse von Python beim
Start und deutlich über 4.6 beim Durchsatz. Die Scope-Check-Regel verhindert, dass ein verfehltes
Ziel still wandert.

**Ein Format für die Host-API (Hst).** Statische Typen verlangen eine Beschreibung zur
Übersetzungszeit, Skriptautoren brauchen sie im Editor; Lyric 5s Makros machen sie für
Lyric-5-Hosts zu einem Nebenprodukt der Implementierung.

## Verworfene Alternativen

| Option | Warum nicht |
|---|---|
| Stack-Maschine (V1) | 2,7× langsamer je Iteration (gemessen). |
| Zwei-Wort-Werte (V2 A), alles geboxt (V2 C) | Speicher je Slot und GC-Scan aller Slots bzw. Allokation je Ergebnis. |
| Eine Klasse `Obj` (V3 B) | Verschnitt, Indirektion; Rückfall, falls die Probe A widerlegt. |
| Enum-Referenz (V3 C) | Heute konservativ gescannt. |
| Monomorphisierung (Gen A), geteilt mit Box (Gen B) | Neuübersetzung der std je Skript bzw. geboxte Skalare in Containern. |
| Lyric-5-Koroutine je Task (Co B), Hybrid (Co C) | A2b, Speicher je Task, Stacktiefe, Debugger bzw. zwei Mechanismen. |
| Instanz an Thread gebunden (Thr A), threadsicher (Thr C) | Keine Job-Systeme bzw. Locks und Widerspruch zu 07. |
| Stabiles Format (Fmt B) | Niemand nutzt es; bindet die VM. |
| Moderate Ziele (Perf B), erst messen (Perf C) | Zu weit unter dem Möglichen bzw. ohne Ratchet. |
| Programmatische Host-API (Hst B) | Braucht trotzdem eine Beschreibung für den Editor. |
| .NET-Paket, weitere Bindings in 1.0 (Emb c/d) | Türen; über die C-ABI jederzeit nachreichbar. |

## Offen

- Bereich 13 (in 12 aufgegangen): DAP, LSP, `pack`, Cache-Ort; Kostenregeln der schweren Natives
  (01 S5c).
- V3 bei Messpunkt 1 (S1): A4 behoben oder Umstellung auf `Obj`.
