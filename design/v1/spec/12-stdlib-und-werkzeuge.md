# 12 — Standardbibliothek und Werkzeuge

Entschieden 2026-10-28 (Maintainer, im Fragedialog). Die Bereiche 12 (Standardbibliothek) und
13 (Werkzeuge) sind auf Wunsch des Maintainers **zusammengelegt**. Abweichungsrunde gegen Lyric 5
`design/v5/spec/10-stdlib.md` (B1–B13) und `11-werkzeuge-interop.md` (W1–W9).

## Ausgangslage

| | 4.6 | Lyric 5 (`stdlib5/std`, `origin/main`) |
|---|---|---|
| Umfang | 25 Dateien, 8,4k Zeilen Lyric | 34 Module, rund 40k Zeilen |
| darunter | Grundausstattung | `regex` (RE2), `compress`, `toml`, `http` (Client und Server), `json`, `codec`, `time` (TZif), `crypto`, `uri`, `term` … |
| API | 4.x-Formen (`OrThrow`-Zwillinge, verschachtelte `io.*`) | Namensgesetz N1–N13, eine werfende Funktion je Operation |

Die VM ist ein Lyric-5-Programm und kann Lyric 5s Standardbibliothek direkt rufen — Lyric 5 ist
die natürliche „C-Schicht" des Python-Modells (00 Z6).

## Entscheidungen

| # | Frage | Entscheidung |
|---|---|---|
| Um | Umfang | **Regel D und Trägerklausel wie Lyric 5** (10 U1/U2) — die Lyric-5-Module ohne `sync`, `thread`, `ffi`, `meta`, `syntax`, `build`, dazu `reflect` (09), `BigInt`/`Bytes` (02 T1), `json` mit dem `Json`-Enum (02 K4) — **plus eine feste Liste von Skript-Batterien**, je mit **einer** entschiedenen API: **`cli`** (Argumente, Flags, Optionen, `--help`), **`csv`** (RFC 4180), **`log`**, **`fs.glob`**. |
| Src | Quelle von API und Implementierung | **Die API folgt Lyric 5s std** (Namen, Formen, Namensgesetz), angepasst an Script-Typen (`string` statt `StringView`, `T[]` statt `Slice`, `int` statt Breiten, keine `throws`-Klauseln). **Kerntypen nativ in der VM** (wie CPython `list`/`dict`): `T[]`, `Map`, `Set` (eigene Implementierung, Einfügereihenfolge), String-Operationen, `BigInt`, `Bytes`. **Schwere Teile als dünne native Adapter über Lyric 5s std**: `regex`, `compress`, `toml`, `json`-Parser, `http`, `net`, `fs`, `process`, `time`, `crypto`, `encoding`. **Logik in Script**: `iter`-Adapter, `fmt`-Hilfen, `cli`, `csv`, `log`, `test`, Pfadlogik. Die 4.6-std ist **keine** Vorlage mehr (Korrektur zu 00 Z2). |
| Repl | REPL | **Inkrementell**: jede Eingabe setzt dieselbe Instanz fort; eine Neudefinition nutzt die Reload-Übernahme nach Name und Typ (01 S7a); Ausdrücke werden mit Typ ausgegeben (`{x:?}`); Importe lösen die Rechte-Abfrage aus (01 S4). Notebook-Kernel (Jupyter) ist Tür. |
| Ed | Editoren | **Eine Erweiterung je Editor** (`vscode-lyric`, `jetbrains-lyric`) für `.lyr` und `.lyrs`, **zwei Sprachserver nach Endung** (`lyric lsp`, `lyric-script lsp`; Skizze aus Lyric 5 11 H9). Der Script-Sprachserver ist in Lyric 5 geschrieben und nutzt die Compiler-Bibliothek von Script. |
| Pk | Ausliefern als Programm | **`pack` hängt Bytecode an eine vorgebaute Runtime je Ziel** (4.6 `lyrstub`, `deno compile`): eine Datei, keine C-Toolchain beim Nutzer; Runtimes je Tier-1-Ziel im Toolchain-Archiv; der Bytecode gilt als vertrauenswürdig (01 S10). **Mit nativen Modulen** (00 Z5) baut `pack --native` eine eigene Runtime über die Lyric-5-Toolchain. |

## Standardbibliothek — Einzelheiten (Liste bestätigt)

| Thema | Regel |
|---|---|
| Module (~33) | `core`, `iter`, `collections` (`Map`/`Set` nativ, Einfügereihenfolge, `Deque`, `Heap`), `string`, `fmt`, `math` (+ `BigInt`), `encoding`, `codec` (`Codable`), `json` (`Json`-Enum), `toml`, **`csv`**, `regex`, `compress`, `hash`, `crypto`, `random`, `time`, `io` (`print`-Familie, `readLine`, `Reader`/`Writer`), `fs` (+ **`glob`**), `path`, `net`, `uri`, `http`, `process`, `os` (Umgebung, Signale), `term`, `task` (`Channel`, `select`, `sleep`, `Timer`, `Semaphore`), `test`, **`reflect`**, **`cli`**, **`log`** |
| Namen | Lyric 5s Namensgesetz N1–N13 (keine Antwortform im Namen, `length()` mit Klammern, `sort()`/`sorted()` …); ohne `mut fn` (03) |
| Antwortformen | eine werfende Funktion je Operation, `?T` für Abwesenheit, Panik „aus Daten nie" (Lyric 5 10 B3) |
| Zahlen | `int`, `float`, `BigInt`; Typkonstanten am Typ (`int.max`, `float.epsilon`), Weltkonstanten in `math` (`math.pi`) |
| Container | `T[]` wachsend; `+` und `xs * n` (Lyric 5 10 B7); `Map`, `Set`, `Deque`, `Heap` |
| I/O | Go-Form `Reader`/`Writer` über `Bytes`, ein `IoError { kind }`, `Command`-Struct für Prozesse |
| Strings | wie Lyric 5 (Länge in Bytes, `s[i]`, `Pattern`-Interface, Regex in linearer Zeit) |
| Natives | je schwerem Native eine **Kostenregel** mit Test (01 S5c); je Native mit Callback die Kennzeichnung „Callback darf nicht warten" (11 Co) |
| Rechte | jedes Modul gehört zu einer Rechteklasse: `file` (`fs`, Datei-Teile von `io`), `net` (`net`, `http`), `process`, `os` (Umgebung, Signale, **Uhr** und **ungeseedeter Zufall** — Determinismus aus den Rechten, 01 S8), `native`; die genaue Tabelle legt der Plan fest |
| Test | `assert`/`assertEq`/`assertThrows`, `@Test`, Subtests, `@Bench` |

## Werkzeuge — Einzelheiten (Liste bestätigt)

| Thema | Regel |
|---|---|
| CLI | **ein Binary `lyric-script` mit Verben** (Lyric 5 11 W1; 4.6 hatte elf Binaries): `run` (Vorgabe für `lyric-script datei.lyrs`), `test`, `fmt`, `check`, `lock`, `fix` (`--from-lyric5`, `--from-4`), `doc`, `api`, `pack`, `repl`, `lsp`, `dap`, `new`, `init`, `explain`, `clean`, `toolchain`, `version`, `help`, `completions` |
| Optionen | streng; Präzedenz CLI > `LYRIC_SCRIPT_*` > Manifest > Benutzerkonfiguration > Vorgabe; Exit-Codes 0/1/2/101, Programm-Exit durchgereicht; `--json` als NDJSON; Rechte über `--allow` und `-A` (01 S4); `run --watch` mit Reload-Bericht (01 S7) |
| Diagnosen | Modell von Lyric 5 11 W6 (Record mit beschrifteten Spans, Notizen, Fixes; Ausgabe wie rustc; NDJSON; `explain`; Katalog `diagnostics.toml`; jede Warnung mit rotem und grünem Fall); **eigenes Präfix `LYS-`** (`LYS-SEM0001`), die 4.6-Codes werden umbenannt |
| Lints | Gruppen aus Lyric 5 11 W7 plus Script-eigene (`unmarked-throw`, `explicit-api`, Operator am Zeilenanfang, Anweisungen in einem nur importierten Modul, …); `[lints]`, `--deny-warnings` |
| Editor | LSP und DAP in Lyric 5 über die Compiler-Bibliothek; eine Erweiterung (Ed); **eigene Tree-sitter-Grammatik `tree-sitter-lyric-script`** (andere Zeilenende-Regeln), nach dem Muster der von Lyric 5 |
| Formatter, Doku | eine Form (09 Y10); `lyric-script doc` aus `///`, Doc-Tests |
| Distribution | Modell von Lyric 5 11 W9: ein Archiv je Tier-1-Ziel mit den Runtimes für `pack`, Kanäle stable und `dev`, minisign, `toolchain` wechselt auf die Manifest-Version; eigener Versionszähler ab 1.0.0 |
| Cache | im Cache-Verzeichnis des Benutzers (Bytecode, Abhängigkeiten aus dem Frontmatter); `clean` |

## Abweichungen von Lyric 5 (Nachtrag zur Tabelle in 09)

| Gebiet | Lyric 5 | Lyric-Script | Quelle |
|---|---|---|---|
| Batterien | `cli`, `log` als Ring-Pakete, CSV Tür (10 B1) | `cli`, `log`, `csv`, `fs.glob` in `std` | Um |
| `BigInt` | Tür (10 B1) | in `std` | 02 T1 |
| Module | `sync`, `thread`, `ffi`, `meta`, `syntax`, `build` | entfallen; `reflect` neu | 02 W, 09 |
| REPL | keine in 5.0 (11 W8 E6) | inkrementell | Repl |
| Binary | `lyric` | `lyric-script` | 00 |
| Diagnosecodes | `LYR-…` | `LYS-…` | Werkzeuge |
| Artefakt | native Binary über `zig cc` | Bytecode an vorgebaute Runtime | Pk |

## Begründung

**Batterien mit einer API (Um).** Eine Skriptsprache wird nach dem bewertet, was ohne Paket geht —
Pythons Argument. Ohne Registry in 1.0 wöge der Verzicht doppelt. Lyric 5s Einwand gegen
API-Geschmack in `std` bleibt ernst genommen: jede Batterie bekommt genau eine entschiedene API,
keine zweite daneben (Pythons drei Argument-Parser als Warnung).

**Lyric 5 als C-Schicht (Src).** Gleiche Namen und Formen in der Familie sind Z3 auf Ebene der
Bibliothek; die schweren Teile (Regex, Kompression, TOML, HTTP, Zeitzonen) sind in Lyric 5 fertig
und getestet, und die VM ruft sie ohne Fremdgrenze. Die 4.6-std hätte die API zurückgebracht,
die Lyric 5 in Bereich 10 bewusst verlassen hat.

**Inkrementelle REPL (Repl).** Die Reload-Mechanik aus 01 macht eine REPL fast geschenkt: eine
Eingabe ist ein kleiner Reload derselben Instanz. 4.6s Replay wiederholte Seiteneffekte.

**Eine Erweiterung (Ed).** Eine Familie, eine Installation; die Trennung liegt bei den
Sprachservern, wo sie hingehört.

**Bytecode an Runtime (Pk).** „Schick mir das Programm" ohne Toolchain beim Empfänger; der seltene
Fall mit nativen Modulen nimmt den längeren Weg.

## Verworfene Alternativen

| Option | Warum nicht |
|---|---|
| Regel D streng (Um A), kleiner Kern (Um C) | Alltagsaufgaben bräuchten Git-Pakete; zu karg ohne Registry. |
| 4.6-std über `fix --from-4` (Src B) | 4.x-API, die Lyric 5 verlassen hat — zwei std-Welten. |
| Eigener std-Entwurf (Src C) | Hauptarbeit ohne Gewinn. |
| Replay-REPL (Repl B), keine REPL (Repl C) | Wiederholte Seiteneffekte bzw. Loch in einer Skriptsprache. |
| Eigene Script-Erweiterungen (Ed B) | Doppelte Pflege und Releases. |
| Nur Quelltext (Pk B), immer neu bauen (Pk C) | Kein Programm zum Weitergeben bzw. Lyric-5-Toolchain für jedes `pack`. |

## Folgen

- **00 Z2/Z6 korrigiert**: der Lyric-Quelltext von 4.6 ist Vorlage für Beispiele und Testfälle,
  nicht mehr für die std; die native Schicht des Python-Modells ist Lyric 5s std.
- **14 Migration**: `fix --from-4` (4.6-Code → Script) und `fix --from-lyric5` (09 Cmp).
- **15 Plan**: Reihenfolge der std-Module nach Abhängigkeit von VM-Kerntypen und Adaptern;
  Rechtetabelle je Modul; Kostenregeln der Natives.
