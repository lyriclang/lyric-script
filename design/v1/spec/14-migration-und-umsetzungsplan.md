# 14 — Migration und Umsetzungsplan

Entschieden 2026-10-28 (Maintainer, im Fragedialog). Die Bereiche 14 (Migration) und 15
(Umsetzungsplan) sind auf Wunsch des Maintainers **zusammengelegt**. Das Ergebnis der Runde: der
Plan von hier bis `lyric-script 1.0.0`. Grundlage: alle Entscheidungen in 00–12.

## Teil 1 — Migration

Es gibt keine 4.x-Linie und keine Nutzer, die zu schützen wären (00). Zu übertragen ist:

| Korpus | Umfang | Wohin |
|---|---|---|
| 4.6-Beispiele (`examples/`, `stdlib-tests/`) | ~5k Zeilen Lyric | Beispiele und Abnahmetests für Script |
| 4.6-Tests (C#) | 62,7k Zeilen | **Verhaltensorakel**: wo die Sprache gleich bleibt, prüfen Tests gegen 4.6, gebaut aus dem Tag |
| 4.x-Konformanzsuite (`lyric-spec` Branch `script`, 158 Fälle) | | Quelle für Testideen; die Script-Suite entsteht neu |
| 4.6-Standardbibliothek | 8,4k Zeilen | **keine Vorlage** (12 Src: API und native Schicht aus Lyric 5) |
| Lyric-5-Code | | `lyric-script fix --from-lyric5` (09 Cmp) |

| # | Frage | Entscheidung |
|---|---|---|
| Fx | 4.6-Code nach Script | **Kette über Lyric 5**: `lyric fix --from-4` (Lyric 5 M16, gegen Grammatik und Guide geprüfter Regelkatalog) und dann `lyric-script fix --from-lyric5`; `lyric-script fix --from-4` ist eine dünne Hülle, die die Kette ruft, wenn `lyric` installiert ist. Kein zweiter 4.x-Parser. |
| Repo | `lyriclang/lyric-script` | **Schnitt im selben Repo**: Tag `v4.6-final` (nie veröffentlicht; der C#-Baum bleibt daraus baubar, als Orakel), Branch `archive/4.x`, `docs/archive/4.x/` (Grammar, Guide, Bytecode.md); `main` = Lyric-Script 1.0 in Lyric 5 (`design/v1/`, Pakete, `std/`, `tests/`). Wie Lyric 5 M0. |
| Spec | Spezifikation | **Delta zu Lyric 5.0**: je Kapitel „Es gilt Lyric 5.0 §n mit folgenden Abweichungen" (die Tabelle aus 09 und 12), gepinnt auf die 5.0-Spec auf `lyric-spec` Branch `script` (ersetzt den 4.x-Text); **eigene Konformanzsuite** (`since: 1.0.0`) mit rotem und grünem Fall je Abweichung. Eine spätere Lyric-5-Edition übernimmt Script nur durch bewusste Entscheidung. |

Verworfen: eigenes `--from-4` mit eigenem Parser (zweiter Regelkatalog), kein Werkzeug (privater
4.x-Code ohne Weg); neues Repo (gespaltene Geschichte), C#-Baum bis 1.0 im Baum (zwei Toolchains,
C#-CI); vollständige eigene Spec (zweites Werk für eine weitgehend gleiche Sprache), keine formale
Spec (Widersprüche zwischen Spec und Compiler bleiben unsichtbar).

## Teil 2 — Umsetzungsplan

### Regeln

- **Rule 3** (CONTRIBUTING): jeder Meilenstein liefert ein laufendes Artefakt.
- **Vertikale Schnitte**: `lyric-script run hello.lyrs` kommt vor jeder Breite.
- **Spec-first als Delta**: jeder Meilenstein schreibt sein Delta-Kapitel und die Konformanzfälle
  (rot und grün je Abweichung) mit, nicht am Ende.
- **Messpunkte sind Ratchets** (11 Perf): warm ≤ 10 ms, kalt ≤ 50 ms, eingebettet ≤ 5 ms, leere
  Instanz ≤ 100 KiB, Bench-Suite ≥ 5× 4.6. **Verfehlt ein Messpunkt sein Ziel um mehr als 2×,
  wird der Plan neu geschnitten** — das Ziel wandert nicht still.
- **4.6 ist Orakel** (aus `v4.6-final` gebaut), wo die Sprache gleich bleibt.
- **Befunde in Lyric 5** gehen als Issues an `lyriclang/lyric`, nicht als Umgehungen in Script.
- **Größen** wie Lyric 5: S (Tage), M (1–2 Wochen), L (3–4 Wochen), XL (> 4 Wochen) an Sessions;
  > 100 % über der Größe → neu schneiden.
- **Arbeitsmodus** (Maintainer, 2026-10-28): **autonom wie Lyric 5** — Claude plant je Slice und
  implementiert, Commit und Push je Slice, PR je Meilenstein, CI selbst prüfen; der Maintainer
  reviewt und gibt an Meilensteingrenzen frei. Beobachtet wird, ob das Verständnis des Codes mit
  seiner Größe mithält (CLAUDE.md).
- **Start sofort** (Maintainer, 2026-10-28; 00 Z2 Strategie B), mit Vorsichtsregeln: eigener
  Clone/Worktree für Script und für den gepinnten Lyric-5-Bau, nie gleichzeitig mit
  Lyric-5-Testläufen (geteilte `/tmp`-Caches in WSL), Lyric-5-Befunde als Issues.

### Meilensteine

#### Phase 0 — Vorbereitung

| M | Inhalt | Artefakt | Größe |
|---|---|---|---|
| **S0 Schnitt und Gerüst** | Repo-Schnitt (Repo); `design/v1` auf `main`; CI baut Lyric 5 aus einem festen Commit (A2c-Behelf bis Lyric 5 M15); Lyric-5-Pakete `lyric_script` (Compiler und VM als Bibliothek), `lyric-script` (CLI), `liblyricscript` (C-ABI, leer); `diagnostics.toml` mit Präfix `LYS-`; Delta-Skelett der Spec auf `lyric-spec` Branch `script` (Kapitelliste, Pin auf die Lyric-5.0-Spec); **Werte-Probe ausgewertet** (11 V2/V3/Gen bestätigt oder zurück in den Dialog) | `lyric-script --version` in der CI auf allen Tier-1-Zielen | M |

#### Phase 1 — Kern

| M | Inhalt | Artefakt | Größe |
|---|---|---|---|
| **S1 VM-Kern** | Registerform, Instruktionsformat (8 Byte), Text-Assembler/Disassembler für Tests, getrennte Skalar-/Ref-Dateien, `HeapRef`-Objekte mit Kopf, Aufrufe, Operationen für `int`/`float`/`bool`/`char`, Skript-Paniken in der VM, Isolation von Lyric-5-Paniken, Fuel-Gerüst (11) | handgeschriebener Bytecode (fib, Schleifen, Objekte) läuft; **Messpunkt 1**: Mikro-Bench gegen 4.6 | L |
| **S2 Frontend-Kern** | Lexer mit Zeilenende-Regeln (09 NL), Parser (Script + angenommene Lyric-5-Formen, 09 Cmp), Resolver, Typprüfung für den Kern, Kotlin-Rückgaberegel, `int`→`float`, Registervergabe, Emitter, Top-Level-Code als `main` (07 Top), Bytecode-Cache | `lyric-script run hello.lyrs`; erste Zielprogramme; **Messpunkt 2**: Start warm/kalt | XL |
| **S3 Typsystem vollständig** | hybride Generics (Deskriptoren, Witness-Tabellen), Interfaces (`by`, `sealed`, Objektsicherheit), `??T`, Literal-Protokolle, Leer-Inferenz, Synthese (Compiler-Liste), `with`, Tupel, Patterns, Laufzeit-Deskriptoren für die Reflexion (03, 05, 09) | generischer Code und Interfaces in Skripten; Konformanzfälle | L |
| **S4 Fehler und Kontrolle** | VM-Ausnahmen, erschlossene Fehlermengen, geprüftes `throws`, `try?`/`try!`/`try … catch`, `catch (e in […])`, `defer`/`using`, `loop`/`break value`, `never` (05) | Fehlerbeispiele; Exit 1/101 | M |

#### Phase 2 — Programme

| M | Inhalt | Artefakt | Größe |
|---|---|---|---|
| **S5 Module und Pakete** | Datei = Modul, Importe, Globale, Pfadregel, Prelude, `lyric-script.toml`, Lock, Git und Pfad, Frontmatter-Abhängigkeiten, Rechteklassen aus Importen (07) | Skriptprojekt aus mehreren Dateien mit Git-Abhängigkeit; Einzelskript mit Frontmatter | M |
| **S6 Koroutinen und Tasks** | Tasks auf VM-Frames, Scheduler je Instanz, Generatoren, `spawn`/`await`/`TaskScope` (Top-Level), Channels, `select`, `sleep`, `Timer`, `Semaphore`, Abbruch, `withTimeout`, I/O über Lyric-5-Tasks (07, 11) | nebenläufiges Beispiel | L |
| **S7 std-Kern** | native Kerntypen (`T[]`, `Map`/`Set` in Einfügereihenfolge, `string`, `BigInt`, `Bytes`); `core`, `iter`, `collections`, `string`, `fmt`, `math`, `io`, `fs` + `glob`, `path`, `process`, `os`, `time`, `random`, `test`, `cli`, `log`, `csv`; Rechtetabelle; Kostenregeln (12) | Zielprogramme Terminal-Werkzeug und Automatisierung (02) laufen; **Messpunkt 3**: Bench-Suite ≥ 5× 4.6 | XL |

#### Phase 3 — Die Rolle

| M | Inhalt | Artefakt | Größe |
|---|---|---|---|
| **S8 Sicherheit und Einbettung** | Rechte grob + fein, Abfrage, `--allow`/`-A`; Budget (Fuel, Deadline, Anhalten, `abort`); Allokationsbudget; Determinismus; Eigentum je Instanz, tiefe Kopie; `call`/`start`/`step`; Lyric-5-API `lyric_script`; C-ABI; Host-API `.lyrs` + `@ScriptApi`; Threadwechsel im Ruhezustand (01, 11) | Beispiel-Hosts in C und Lyric 5 mit einem Mod unter Budget; **Messpunkt 4**: eingebettet ≤ 5 ms, ≤ 100 KiB | L |
| **S9 Hot-Reload** | Typvergleich, Übernahmeplan, Umbau am Ort, `@Migrate`, Abbruch der Koroutinen, `Stale`, `var`/`let`/Anweisungs-Regel, Bericht, `run --watch` (01 S7) | Mod lädt neu und behält Zustand; Reload-Testsuite | L |
| **S10 std-Rest** | Adapter `regex`, `compress`, `toml`, `json` (`Json`-Enum), `codec`/`Codable`, `http`, `net`, `uri`, `encoding`, `hash`, `crypto`, `term`; `reflect`-API (12, 09) | Zielprogramm „Daten" (JSON über HTTP) läuft | L |

#### Phase 4 — Werkzeuge

| M | Inhalt | Artefakt | Größe |
|---|---|---|---|
| **S11 Werkzeuge I** | `fmt`, `check`, `test` mit Doc-Tests, Diagnosekatalog + `explain` + NDJSON, Lints, `fix --from-lyric5`, `fix --from-4` (Kette), `doc`, `api` (12, 14) | Werkzeuge in der CI; Katalog geprüft | L |
| **S12 Werkzeuge II** | LSP, DAP, REPL (inkrementell), Editor-Erweiterungen mit zwei Sprachservern, `tree-sitter-lyric-script` (12) | Editor mit Diagnosen, Hover, Debugger; REPL | XL |
| **S13 Distribution** | `pack` mit vorgebauten Runtimes, `pack --native`, Archive je Tier-1, Kanäle stable/`dev`, minisign, `toolchain` (12) | `dev`-Build zum Herunterladen; `pack`-Binary auf allen Tier-1-Zielen | M |

#### Phase 5 — Release

| M | Inhalt | Artefakt | Größe |
|---|---|---|---|
| **S14 Migration, Spec, Guide** | 4.6-Beispiele über die Kette migriert (Abnahme), Delta-Spec 1.0 vollständig mit Suite, Guide, CHANGELOG (14) | Suite grün; Guide | L |
| **S15 Release 1.0.0** | alle Ratchets grün, Release-Checkliste, **gebaut gegen das veröffentlichte Lyric 5.0.0** | Tag `v1.0.0` | M |

### Abhängigkeiten

```
S0 → S1 → S2 → S3 → S4 → S5 → S6 → S7 ─┬→ S8 → S9 ─┐
                                        └→ S10 ──────┴→ S11 → S12 → S13 → S14 → S15
```

| Außerhalb | Wofür | Stand |
|---|---|---|
| Lyric 5 aus festem Commit (A2c-Behelf) | S0 ff. | bis Lyric 5 M15 (`toolchain install`) |
| Lyric 5 Makros (M9b) | S8 `@ScriptApi` | fertig |
| Lyric 5 `fix --from-4` (M16) | S11/S14 Kette | offen |
| Lyric 5 5.0.0 veröffentlicht | S15 | offen |
| A1 / A2d / A3 an Lyric 5 | nur bei dynamischen nativen Modulen / verfehltem Durchsatz / Speichergrenze je Instanz | Türen |

### Größenordnung

Compiler ~25–35k Zeilen (das 4.6-Frontend: 33k C#), VM ~8–12k, Kerntypen und Adapter der std
~8–10k, std in Script ~10–15k, Werkzeuge ~10k — **zusammen 60–80k Zeilen Lyric 5 und Script**,
etwa so viel wie Lyric 5 selbst. Sechzehn Meilensteine, keine Termine.

### Türen ohne Meilenstein

Hot-Reload Stufe 3 (Funktionstausch am Ort); Live-Speichergrenze je Instanz (A3);
plattformübergreifender Determinismus (fdlibm); Vertrauensliste im Terminal; `dynamic`;
Unionen; optionale Parametertypen; `eval`; dynamischer Import; `reflect.construct`; Decorators;
Worker-Instanzen; Sichten (`Slice`); JIT; .NET-Paket und weitere Bindings; Notebook-Kernel;
Registry.

## S0 — Slices (Plan, 2026-10-28)

| Slice | Inhalt | Prüfung |
|---|---|---|
| **S0a** | dieser Plan | — |
| **S0b Schnitt** | Tag `v4.6-final` und Branch `archive/4.x` auf `33339164` (der letzte reine 4.6-Baum); auf `main`: die C#-Toolchain, ihre Tests, Werkzeuge und Build-Dateien entfernt; `docs/archive/4.x/` nimmt Grammatik, Guide, Bytecode-Format, Pack-Format, die 4.x-Designnotizen, `STATUS.md`, `CHANGELOG.md` und die `examples/` (Eingabe von S14) auf; neue `README.md`, `STATUS.md`, `CHANGELOG.md`, `CONTRIBUTING.md` für die Script-Linie | der Baum enthält keinen C#-Code mehr; `v4.6-final` baut wie zuvor |
| **S0c Gerüst** | Lyric-5-Paket `lyric_script` (`lyric.toml`): Bibliotheksmodule `lyric_script.vm`, `lyric_script.compiler` (Platzhalter mit einem Test), Binary `lyric-script` (`--version`, `help`, Exit-Codes nach 12), C-ABI-Stub `lyrs_version()` über `@Export`; Version `1.0.0-dev`; `diagnostics.toml` mit Präfix `LYS-` (Format wie Lyric 5) | lokal unter WSL gegen den gepinnten Lyric-5-Bau: `lyric5 build`, `lyric5 test`, `lyric-script --version` |
| **S0d CI** | `lyric5.pin` (Commit von `lyriclang/lyric`); Workflow: Lyric 5 aus dem Pin auschecken, `lyric5` per NativeAOT bauen (Cache je Pin und Ziel), zig aus dessen `tooling/zig-version`; `lyric-script` bauen, testen und `--version` prüfen auf linux-x64, linux-arm64, win-x64, osx-arm64; die 4.x-Workflows fallen weg | PR-Lauf grün auf allen Tier-1-Zielen |
| **S0e Spec-Skelett** | `lyric-spec` Branch `script`: der 4.x-Text als Tag `script-4.x-final`, dann das Delta-Skelett (Kapitelliste nach Lyric 5.0, je Kapitel „Es gilt Lyric 5.0 §n mit folgenden Abweichungen", leere Suite mit `since: 1.0.0`); `spec.pin` hier | Skelett gemergt, Pin zeigt darauf |
| **S0f Werte-Probe** | Ergebnis der Probe (`design/v1/probes/werte/`) einchecken und in 11 eintragen: V2/V3/Gen bestätigt — oder die widerlegte Frage zurück in den Dialog | Probe-Bericht mit Kontrollen |
| **Abschluss** | `STATUS.md`: S0 erledigt mit Artefakt; PR, CI grün, Merge | `lyric-script --version` in der CI auf allen Tier-1-Zielen |

**Vorsichtsregeln** (14 Start): der gepinnte Lyric-5-Bau liegt in einem eigenen Worktree unter
WSL (`~/dev/projects/lyric-worktrees/script-pin`), nie im Checkout der Lyric-5-Session; keine
Lyric-5-Testläufe; Builds nicht, während eine Messprobe läuft.

## S1 — Slices (Plan, 2026-10-28)

Ziel aus der Meilensteintabelle: die VM als Lyric-5-Bibliothek, mit handgeschriebenem Bytecode
lauffähig, und **Messpunkt 1** gegen 4.6. S1 hat keine Sprachoberfläche (Bytecode ist intern,
11 Fmt) — kein Delta-Kapitel der Spec; die Laufzeitpanik-Codes (`LYS-RT…`) kommen in den
Diagnosekatalog.

| Slice | Inhalt | Prüfung |
|---|---|---|
| **S1a Instruktionen** | `Instr` (8 Byte, inline im Array: Opcode, drei 16-Bit-Operanden; Sprung- und Konstantenziele als Operand oder Folgewort), die Opcode-Tabelle des Kerns: Moves (Skalar, Ref), Konstanten (`int`, `float`, Konstantenpool), `int`- und `float`-Arithmetik, Vergleiche, `int`↔`float` (`as`, sättigend), `bool`-Logik, Sprünge (unbedingt, bedingt, fusionierter Vergleich+Sprung), `call`/`ret`, `panic` | Tabellentest: jeder Opcode hat Name, Operandenarten, Länge |
| **S1b Module und Funktionen** | `Function` (Name, Zahl der Skalar- und Ref-Register, Code, Konstanten, Zeilentabelle), `Module`, `TypeDesc` (Name, Skalar- und Ref-Felder mit Namen) — die Laufzeitform, die der Compiler in S2 erzeugt | Konstruktion und Prüfung der Grenzen (Registerindizes, Sprungziele) beim Laden eigener Module |
| **S1c Text-Assembler** | eine Textform für Tests (`.lyrsasm`): Funktionen mit Registerzahlen, Labels, Konstanten, Typen; Assembler und Disassembler | Rundreise Text → Modul → Text; Fehler mit Zeile |
| **S1d Interpreter** | Frames mit `scalars: uint64[]` und `refs: HeapRef[]` (V2), VM-eigener Frame-Stack (Co = A), Dispatch über `match` (Sprungtabelle, A2a), `call`/`ret` mit Argumenten in beiden Dateien; **Skript-Paniken erkennt die VM** (Überlauf über `checked*`, Division durch 0, Index) mit Backtrace aus den VM-Frames und Zeilen; ein Aufruf in die VM läuft an einer Lyric-5-Task-Grenze, eine Lyric-5-Panik wird `.Panic(intern)` (11) | fib, Schleifen, Überlauf, Division durch 0, Rekursionstiefe; Backtrace-Form |
| **S1e Objekte** | `interface HeapRef`, `ScriptObject` (Kopf: TypeDesc, besitzende Instanz, Typversion, Generation — die letzten drei als Felder ohne Verhalten bis S8/S9), `ScriptString` (V3 A'); Opcodes `new`, Feld lesen/schreiben (Skalar, Ref), Identitätsvergleich | Objektprogramme (verkettete Liste, Zähler in Objekten); Werte überleben eine GC-Sammlung (`lyr_gc_collect` erzwungen) |
| **S1f Fuel-Gerüst** | Zähler je Grundblock an Rückwärtssprüngen und Aufrufen; Erschöpfung hält an und meldet `.Suspended` (Fortsetzen in S8) | Endlosschleife mit Budget hält an der erwarteten Stelle an (deterministisch) |
| **S1g Kommandozeile** | `lyric-script asm <datei.lyrsasm>` — führt Bytecode-Text aus; in `help` als vorläufig markiert, entfällt mit `run` in S2 | Ende-zu-Ende in der CI |
| **S1h Messpunkt 1** | Mikro-Bench (fib, Schleifen, Felder in Objekten) in `bench/`, dieselben Programme für 4.6 (aus `v4.6-final`), dieselbe Maschine, Netzbetrieb; Ratchet ≥ 5×; **Entscheidung V3** (A4 = lyric#610 behoben? sonst Referenz-Moves messen, ggf. `Obj`) | Bericht `bench/README.md` mit Erwartung vorab und Kontrolle |
| **Abschluss** | STATUS, PR, CI grün, Merge, Tag `s1-complete` | handgeschriebener Bytecode läuft in der CI auf allen Tier-1-Zielen |

**Ergebnis Messpunkt 1 (2026-10-28, `bench/README.md`):** 4,3× im geometrischen Mittel (fib
3,2–3,5×, loop 6,0×, objects 4,0–4,2×) — Ziel ≥ 5× verfehlt, nicht um mehr als 2×, also kein
Neuzuschnitt; V3 bleibt A' (11). **Folge für den Plan:** S7 bekommt vor Messpunkt 3 einen Slice
„Aufrufpfad der VM" (Frames ohne `List`, aufgelöste Funktionstabelle, eine Wachstumsprüfung je
Aufruf, Fuel an Rücksprüngen statt je Aufruf), gemessen mit diesem Bench.

## S2 — Slices (Plan, Entwurf 2026-10-28)

Ziel aus der Meilensteintabelle: `lyric-script run hello.lyrs` — der Compiler für den Kern der
Sprache, vom Text bis zum Bytecode der VM aus S1, und **Messpunkt 2** (Start warm/kalt).
Spec-first: S2 schreibt die Delta-Kapitel 01 (lexikalisch) und 02 (Grammatik) für den Kern und
bringt den Läufer der Konformanzsuite.

| Slice | Inhalt | Prüfung |
|---|---|---|
| **S2a Spec und Suite** | Delta 01/02 für den Kern (Zeilenende-Regel 09 NL, Frontmatter, angenommene Lyric-5-Formen 09 Cmp); Kopfformat der Konformanzfälle (`since`, erwartete Ausgabe, Exit-Code oder Diagnose-Code) und ein Läufer, den die CI gegen `spec.pin` fährt | Läufer mit einem roten und einem grünen Fall |
| **S2b Lexer** | Token von Lyric 5 (39 reservierte Wörter, kontextuelle, Literale: Ganzzahlen mit `_`/Hex/Bin/Okt, Floats, `char`, Strings, `r"…"`, `"""…"""`, `f"…"`, `b"…"`), Kommentare (`//`, verschachteltes `/* */`, `///`, `//!`), Frontmatter, `#!`; **Zeilenende als Token mit den Fortsetzungsregeln** (09 NL), `+`/`-` am Zeilenanfang mit Warnung | Token-Goldtests; jede Fortsetzungsregel rot und grün |
| **S2c Parser** | AST des Kerns: Module mit Top-Level-Anweisungen, `fn` (Kotlin-Rückgaberegel), `struct`/`class`/`enum` ohne Payload, `let`/`var`, Zuweisung, `if`/`else` (auch als Ausdruck), `while`, `loop`/`break value`, `for` über Ranges, `return`, Ausdrücke mit der Präzedenztabelle von Lyric 5 (nicht-assoziative Vergleiche), Aufrufe mit benannten Argumenten, Feldzugriff, Struct-Initializer, `Point(1, 2)`; angenommene Lyric-5-Formen; Fehlerbehandlung je Anweisung | Parser-Goldtests; Fehler mit Position |
| **S2d Namen und Typen (Kern)** | Resolver (Scopes, eine Datei); Typprüfung für `int`, `float`, `bool`, `char`, `string`, Structs (unveränderlich), Klassen (`var`-Felder), Funktionen mit Parametertypen, `int`→`float` an `float`-Stellen und in gemischter Arithmetik (03 Mix), Prelude `print`/`println` | Typfehler mit Codes `LYS-SEM…`; Konformanzfälle |
| **S2e Codegen** | direkt vom getypten AST zu Bytecode, Register in einem Durchlauf (Lua): Locals fest, Temporäre stapelartig je Datei, Argumente oben auf den lebenden Registern (11, S1d-Aufrufkonvention); Top-Level-Anweisungen als `main` des Einstiegsmoduls (07 Top); `println` über einen **nativen Aufruf** (neuer Opcode `callnative`, Natives-Tabelle der VM) | die Zielprogramme ohne `std`-Breite; Bytecode-Goldtests über den Disassembler |
| **S2f Diagnosen** | Darstellung wie rustc (Lyric 5 W6): Code, Position, Ausschnitt, `help:`; NDJSON mit `--json`; Katalogeinträge `LYS-LEX…`, `LYS-PAR…`, `LYS-SEM…` | Text- und JSON-Goldtests |
| **S2g `run`** | `lyric-script run datei.lyrs` und `lyric-script datei.lyrs`; Bytecode-Cache (11 Fmt: Schlüssel Hash(Quelle + Compiler-Version)); Exit-Codes nach 12 | Ende-zu-Ende in der CI |
| **S2h Messpunkt 2** | Start `hello.lyrs` warm (Cache) und kalt, Ratchets ≤ 10 ms / ≤ 50 ms (11 Perf) | Bericht mit Erwartung vorab |
| **Abschluss** | STATUS, PR, CI, Merge, Tag `s2-complete` | `lyric-script run hello.lyrs` in der CI auf allen Tier-1-Zielen |

Offen für S3 und später: Generics, Interfaces, Optionals, Patterns, Fehler, Module.

*Nachtrag S2b (2026-10-28):* `check` wächst mit dem Compiler — erst der Lexer, dann Parser und
Typen —, damit die Konformanzsuite ab S2b läuft; die lexikalischen Codes spiegeln Lyric 5
(dieselbe Bedeutung wie die gleiche Nummer von `LYR-LEX`; Script-eigen zuerst ab 0100, seit S3b
ab 0900 — Lyric 5 belegt `SEM` bis 0232, und seine `SEM0101`/`SEM0102` braucht Script mit den
Labels selbst).

**Ergebnis S2 (2026-10-28):** `lyric-script run hello.lyrs` läuft in der CI auf allen
Tier-1-Zielen, dazu `fib` und `tally`; 97 Tests, 33 Konformanzfälle (Kapitel 01, 02 Kern, 03, 07,
08, 12, 14, 16 der Spec). Messpunkt 2: warm 1,36 ms, kalt 1,66 ms — beide Ratchets halten.
`run` kam schon mit S2e (der Ende-zu-Ende-Test brauchte es), S2g brachte den Cache. Entscheidungen,
die das Design präzisieren, stehen als offene Punkte in STATUS (P2–P5).

## S3 — Slices (Plan, Entwurf 2026-10-28)

Ziel aus der Meilensteintabelle: das Typsystem vollständig — generischer Code und Interfaces in
Skripten, mit Konformanzfällen. Spec-first wie S2: jedes Delta-Kapitel (03, 05, 09) bekommt seine
Regeln mit dem Slice, der sie baut. Was S2 als `LYS-NYI0001` meldet und zu S3 gehört, verschwindet
hier (Optionals, Tupel, Funktionswerte, Synthese, Definite Assignment).

| Slice | Inhalt | Prüfung |
|---|---|---|
| **S3a Optionals** | `?T`, `null`, `??`, `!`, `?.` (flacht ab), `??=`, Eingrenzung über `!= null` und `if (let x = …)`, `?T`-Felder Default `null`; in der VM nach 11 V2: `?T` über einem Referenztyp ist die Referenz mit `nil`, sonst die Slots von `T` und ein Präsenz-Slot (`?int` zwei Skalar-Slots, `??int` drei) — dafür bekommt jeder Wert eine **Slot-Form** (Skalare, Referenzen) in Registern, Feldern, Globalen, Argumenten und Rückgaben (Rückgaben mit mehreren Slots in der VM) | Konformanzfälle rot/grün je Form; Panik `LYS-RT0004` bei `!` auf `null` |
| **S3b Definite Assignment, leere Literale** | `var x: int` ohne Wert mit Definite Assignment (03 T8); „Leer": die erste festlegende Verwendung bestimmt den Typ (03 Leer) | Fehler mit Vorschlag an der Deklaration |
| **S3c Tupel** | Tupeltypen, benannte Tupel (Etiketten), `t.0`, Destrukturierung in `let` und `for` | Konformanzfälle |
| **S3d Enums mit Werten, `match`, Patterns** | Varianten mit Nutzlast, `match` als Anweisung und Ausdruck, Patterns (Y6: Namen binden, `.Red`, Typ-Patterns, `=` als Feldtest, Bereiche, Oder), Erschöpfung, `is` mit Eingrenzung | Erschöpfungsfehler mit fehlenden Fällen |
| **S3e Funktionswerte** | Lambdas in drei Formen, nachlaufende Blöcke, `it`, Captures (Schleifenbindung je Durchlauf frisch, 02 C1), Funktionstypen, Methoden als Werte, lokale `fn` (Y11); VM: Closures (`Closure :: HeapRef`), indirekter Aufruf | Closure-Programme; Capture-Fälle |
| **S3f Interfaces** | Deklaration, Konformanzlisten, Default-Rümpfe, `by`, `sealed`, Objektsicherheit, `Any`; Interface-Werte und Aufrufe über Witness-Tabellen (11 Gen) | Konformanzfälle; Fehler der Objektsicherheit |
| **S3g Generics** | generische Funktionen, Structs, Klassen, Enums; Constraints; hybride Instanziierung (eine geteilte Kopie für Referenztypen, je eine für `int`/`float`/`bool`/`char`, 11 Gen) mit Typ-Deskriptoren | generische Programme; Bytecode-Goldtests der Kopien |
| **S3h Synthese, `with`, Literal-Protokolle** | `Equatable`/`Hashable`/`Debug` für Structs, Enums, Tupel (03 Eq), `{x}` über `Debug`, `Display`; `with` (W1–W8); `From…Literal` an Stellen mit Zieltyp (03 Lit) | `==` auf Structs; Druckform; `with`-Fälle |
| **S3i Laufzeit-Deskriptoren** | Typ-Deskriptoren zur Laufzeit für `is` und die Reflexion (09 Rf: `typeOf`), Typargumente bleiben erhalten | `typeOf([1, 2])` sagt `int[]` (sobald S7 die Listen bringt: der Deskriptor ist da) |
| **Abschluss** | STATUS, PR, CI, Merge, Tag `s3-complete` | generischer Code und Interfaces in Skripten in der CI |

Reihenfolge: a–e vor f–g (Interfaces und Generics bauen auf Optionals, Tupeln und Funktionswerten
auf), h nach f (Synthese braucht die Interfaces), i zuletzt.

**S3a, Ergebnis.** Optionals wie Lyric 5 §3.1–3.3 mit dessen Codes; Slot-Formen nach 11 V2,
Rückgaben mit mehreren Slots. Eingrenzung endet an einer Zuweisung, eine Schleife, die die Bindung
schreibt, grenzt in keinem Durchlauf ein; ein zweiter Test grenzt erneut ein. Nachgezogen in S3b
(Abgleich mit §3.2): Eingrenzung auch hinter einem Zweig, der mit `break` oder `continue` endet,
im mehrzeiligen Wert-`if`, und `==` auf `?T` (Regel 7: beide leer oder beide gleich; ein `T` auf
einer Seite wird zu `?T`).

**S3b, präzisiert.**

- *Definite Assignment* wie Lyric 5 §7.1 Regel 5 (`LYS-SEM0018`), im Checker in Quellreihenfolge
  mitgeführt: die Menge der Bindungen ohne Wert, die noch nicht auf jedem Weg zugewiesen sind.
  Zweige vereinigen ihre Mengen, ein Zweig, der nicht herauskommt (`return`, `break`, `continue`,
  `never`), trägt nichts bei; `while` und `for` hinterlassen den Stand vor dem Rumpf, `loop` den
  seiner `break`s; die rechte Seite von `&&`, `||`, `??`, `??=` und die Argumente hinter `?.`
  zählen nicht. Später zuweisen lässt sich nur ein `var`; ein `let` ohne Wert ist wie in Lyric 5
  nie schreibbar (`LYS-SEM0019`).
- Eine *globale* Bindung des Skripts braucht ihren Wert an der Deklaration (`LYS-SEM0903`):
  Funktionen lesen sie zu jeder Zeit, auch bevor der Skriptcode sie zuweist (offener Punkt P8).
- *Leer* für `var x = null` (in einer Funktion und im Skriptcode): die Funktion wird in zwei
  Läufen geprüft. Der erste schweigt und sucht die erste festlegende Verwendung in
  Quellreihenfolge — eine Zuweisung, `??=`, der Wert an einer Stelle mit Zieltyp (Argument,
  Rückgabe, getypte Bindung, Feld); der zweite prüft mit dem gefundenen Typ `?T`. Findet sich
  keine, meldet der zweite `LYS-SEM0010` an der Deklaration mit dem Vorschlag `var x: ?T = null`.
  Funktionen, deren Ergebnistyp erst ihr Rumpf festlegt, prüft der stille Lauf nicht mit. Ein
  `let x = null` bleibt `LYS-SEM0010` (ein `let` bekommt nie einen zweiten Wert).
- Leere Sammlungsliterale `[]` und `[:]` gehen mit den Literalen in S7 denselben Weg.

**S3b, Ergebnis.** Wie präzisiert; die Definite-Assignment-Menge wird nie an Ort verändert
(jeder gespeicherte Stand bleibt gültig), ein Lauf über die Kinder einer Anweisung (`stmtAny`)
ersetzt den Schreib-Lauf von S3a. 115 Tests, 55 Konformanzfälle.

**S3c, Ergebnis.** Tupel nach Lyric 5 §6 Regeln 1–5. In der VM ist ein Tupel die Slots seiner
Elemente hintereinander, inline wie ein Optional (11 V2) — kein Objekt, `t.k` liest an seinem
Platz. Etiketten fahren im Typ mit, zählen aber nicht zu seiner Gleichheit (Lyric 5 §6 Regel 3).
Gleichheit, Hash und Druckform (Regel 6) kommen mit der Synthese in S3h, `for ((a, b) in …)` mit
den Sammlungen in S7. 119 Tests, 61 Konformanzfälle.

**S3d, Ergebnis.** Enums mit Nutzlast, `match` und die Muster nach Lyric 5 §4 und §9, in vier
Teilen (d1 Deklaration und Bau, d2 `match` und Muster, d3 Abdeckung, d4 Muster in `if let`,
`while let`, `let … else`). Darstellung: ein Enum ohne Nutzlast ist ein `int`; eines mit Nutzlast
eine Referenz auf ein unveränderliches Objekt, ein VM-Typ je Variante mit dem Tag als erstem
Skalar — wie ein Struct, also rekursiv ohne `Box` (Abweichung von Lyric 5 §4.1 Regeln 3–4, Folge
aus 03). Ein `match` senkt zu verschachtelten `if`s über einen einmal gehaltenen Wert; ein
Wächter bindet in seiner Bedingung und im Arm, ein Oder-Muster bindet je Name den Wert der
passenden Alternative. Abdeckung nach Maranget über einen vereinfachten Musterraum, der Zeuge
als Muster geschrieben; unerreichbare Arme nach Lyric 5s enger Regel. Typ-Muster kommen mit S3f
(Interface-Werte), Array-Muster mit S7. 129 Tests, 71 Konformanzfälle.

**S3e, präzisiert (Entwurf).** Funktionswerte nach Lyric 5 03 §8 ohne `inline fn` und vorerst ohne
`throws` (S4).

- *Darstellung.* Ein Funktionswert ist ein Objekt eines VM-Typs je Lambda: Skalarfeld 0 ist der
  Funktionsindex, danach die Captures. Eine Lambda-Funktion nimmt das Objekt als ersten
  Referenzparameter (Lokale 0); `call.v` (neu, Basen wie `call`) liest den Index aus dem
  Objekt an der Ref-Basis. Freie und statische Funktionen und gebundene Methoden als Werte
  bekommen je eine Thunk-Funktion mit diesem ersten Parameter (gecacht je Ziel).
- *Captures* (§8.3): ein `let` (und ein Parameter, `this`) als Kopie beim Bau; ein `var` in einer
  Zelle (VM-Typ je Slot-Form), die Funktion und Lambda teilen. Der Checker markiert die
  eingefangene Lokale als `boxed`; der Codegen legt die Zelle bei der Deklaration an
  (`SetLocal`, neu `DeclareLocal` für `var x: T` ohne Wert) — eine Bindung im Schleifenrumpf
  bekommt so je Durchlauf eine frische Zelle (02 C1). Verschachtelte Lambdas fangen über die
  Captures der äußeren.
- *Lambdas* (§8.2): `(n: int): int => n + 1`, `x => x * 3`, nachlaufender Block mit `it` oder
  benannten Parametern; Parametertypen geschrieben oder aus dem erwarteten Funktionstyp, sonst
  `LYS-SEM0045`; Ergebnis geschrieben, erwartet oder aus dem Wert des Rumpfs (ein `return` in
  einem Lambda ohne bekanntes Ergebnis verlangt den Typ). Lokale `fn` (§8.6): ihr Name ist in
  ihrem Rumpf das Objekt selbst (Lokale 0) — so ruft sie sich.
- *Aufruf* über einen Wert: `f(a)` auf einer Bindung, einem Feld, jedem Ausdruck vom
  Funktionstyp. Funktionswerte werden nicht verglichen (`LYS-SEM0059`).

**S3e, Ergebnis.** Wie präzisiert, in zwei Teilen (Lambdas, Captures, lokale `fn`, Aufruf über
Werte; dann nachlaufende Blöcke, gebundene Methoden, statische Funktionen und Felder als
Funktionswerte). Der erste stille Lauf von 03 Leer macht keine Funktion bleibend: was er an
Lambdas und Thunks anlegt, nimmt er zurück. Ein S2-Pin, der `run { 7 }` als Fehler festhielt,
fiel mit seiner Regel. 134 Tests, 75 Konformanzfälle.

**S3f, präzisiert (Entwurf).** Interfaces nach Lyric 5 05 §1–§6, §9–§11, soweit sie keine
Generics brauchen (`Self`, statische Member, assoziierte Typen, generische Member und `extend`,
Objektsicherheit mit S3g; Operator-Interfaces und Synthese mit S3h).

- *Darstellung.* Ein Interface-Wert ist eine Referenz auf ein Objekt: Structs, Klassen und Enums
  mit Nutzlast sind es schon (geteilt, nicht kopiert — Abweichung 05 aus 03); ein Skalar, ein
  `string`, ein Enum ohne Nutzlast wird beim Übergang in ein Box-Objekt eines VM-Typs je
  eingebautem Typ gelegt. Ein Kind-Wert ist so ohne Umbau ein Wert seiner Eltern (§11).
- *Dispatch.* Jede Interface-Methode des Programms bekommt eine Slot-Nummer; jede `TypeDesc`
  trägt eine Tabelle Slot → Funktion (−1: nicht konform) und die Programmtyp-Nummer für `is`.
  `call.i` (neu: Slot, Basen) liest den Empfänger an der Ref-Basis und ruft die Funktion seiner
  Tabelle. Ein Default wird einmal übersetzt, mit `this` als Interface-Wert (§2 Regel 3: ein
  Aufruf auf `this` dispatcht erneut); für eine Box ruft ein Thunk die Methode mit dem
  ausgepackten Wert. Das Bytecode-Format bekommt die Tabellen (Formatversion steigt).
- *Konformanz* in der Liste von Struct, Klasse, Enum und in `extend T :: [I] { … }`; `extend T`
  auch auf eingebauten Typen (Methoden auf `int`, `string`). Jedes abstrakte Member der Kette
  mit exakter Signatur (`LYS-SEM0020`, `LYS-SEM0042`); Eltern, Defaults, ein eigenes Member
  gewinnt; zwei Defaults eines Namens entscheidet der Typ (`LYS-SEM0043`).
- *`Any`, `is`, Typ-Muster, `sealed`* (§9–§10): `x is T` vergleicht die Programmtyp-Nummer bzw.
  sucht in der Tabelle, mit Eingrenzung (Auspacken bei Boxen); Typ-Muster `c: Circle` im
  `match`; ein `sealed interface` macht die Abdeckung über seine Konformer geschlossen.
- *Delegation* `by` (§5): Weiterleitungsfunktionen je nicht selbst geschriebenem Member.

**S3f, Ergebnis.** Wie präzisiert, in vier Stufen (Interfaces und `call.i`; Boxen und `extend`
auf eingebauten Typen; `Any`, `is`, Typ-Muster, `sealed`; `by`). Eine Kontrolle der Boxen blieb
zuerst grün, weil der richtige Wert zufällig im Skalarregister an der Basis lag; der Test ruft
jetzt gespeicherte Interface-Werte nach anderer Arbeit. 142 Tests, 82 Konformanzfälle.

**S3g, präzisiert (Entwurf).** Generics nach Lyric 5 03 §9 und 11 Gen.

- *Prüfung einmal* (§9.1 Regel 1): ein generischer Rumpf wird an der Deklaration geprüft, `T`
  undurchsichtig (`Ty.Param`), seine Member nur aus den Constraints; der getypte Baum trägt
  `Ty.Param` und Constraint-Aufrufe als eigene Knoten.
- *Instanzen* (11 Gen): je Funktion bzw. Typ eine Kopie je **Form** der Typargumente — eine
  geteilte für alle Referenztypen (Strings eingeschlossen), je eine für `int`, `float`, `bool`,
  `char` (und je Enum ohne Nutzlast, Tupel- und Optional-Form, deren Slots sich unterscheiden).
  Eine Kopie entsteht durch Ersetzen im getypten Baum (ein Lauf über alle Knoten).
- *Deskriptor* (11 Gen): die geteilte Kopie nimmt je Typparameter einen versteckten
  Referenzparameter, den Deskriptor des Typarguments (eine `TypeDesc`-Referenz: Familie,
  Tabelle). `load.t` lädt ihn, `call.d` (neu: Slot, Basen) ruft über seine Tabelle — so auch auf
  einem `string`, der selbst keine Tabelle trägt. In einer skalaren Kopie ist der Typ bekannt,
  der Constraint-Aufruf ein direkter `call`.
- *Inferenz am Aufruf* (§9.2): Argumente binden, dann der erwartete Typ; geschriebene
  Typargumente zuerst; was offen bleibt, `LYS-SEM0060`; Anzahl `LYS-SEM0026`, Constraint
  `LYS-SEM0028`; Kette unendlicher Instanzen `LYS-SEM0197`.
- *Generische Typen*: `struct Pair<A, B>`, `class Box<T>`, `enum Opt<T>` mit Layout je Form;
  `Self` und statische Member in Interfaces, Objektsicherheit (§7) mit ihnen.
- Teile: g1 generische Funktionen (Inferenz, Constraints, Kopien, Deskriptoren); g2 generische
  Typen; g3 `Self`, Statics, Objektsicherheit; Bytecode-Goldtests der Kopien.

*S3g, g1 Ergebnis:* generische Funktionen wie präzisiert, noch ohne Deskriptor (die geteilte
Kopie ruft Constraint-Member über die Tabelle des Werts — alle geteilten Typen sind
VM-Objekte); ein `string` bekommt eine eigene Kopie wie die Skalare (sein Wert trägt keine
Tabelle; Abweichung von 11 Gen, bis der Deskriptor kommt). Eine generische Funktion als Wert
und geschriebene Typargumente am Aufruf kommen mit g2/g3.

*g2, Entwurf:* ein generischer Typ ist eine Schablone, deren Eintrag zugleich die Instanz mit
den eigenen Parametern ist; `Pair<int, string>` legt einen Eintrag je Argumentliste an (Felder,
Varianten ersetzt; Instanz und Schablone merken sich Schablone und Argumente). Methoden sind
Schablonen mit den Parametern des Typs; ein Aufruf auf einer Instanz ist ein `CallGeneric`,
die Tabelle einer Instanz entsteht in der Kopierphase. Der Ersatz kennt Instanzen: in
`Named(Instanz mit Parametern)` werden die Argumente ersetzt. Ein Initialisierer ohne
Typargumente bindet sie aus den Feldwerten, `.None` aus dem erwarteten Typ.

**S3g, Ergebnis.** g1 generische Funktionen, g2 generische Typen, g3 geschriebene Typargumente am
Aufruf (`f<int>(x)`, C#s Regel gegen die Mehrdeutigkeit mit `<`). *Neu zugeschnitten:* `Self`,
statische Member über einen Typparameter (`T.make()`), assoziierte Typen, Objektsicherheit und
eine generische Funktion als Wert brauchen den Deskriptor — in der geteilten Kopie steht kein
Empfänger, der die Tabelle trägt — und gehen mit ihm in **S3i**. 148 Tests, 85 Konformanzfälle.

**S3h, präzisiert (Entwurf).** Die Literal-Protokolle (`From…Literal`) brauchen statische
Member und gehen mit dem Deskriptor nach **S3i**; S3h nimmt:

- *h1 Gleichheit* (03 Eq, Lyric 5 05 §14 Regeln 2–3): `==`/`!=` auf Structs, Enums (Variante,
  dann Nutzlast), Tupeln und Optionals, wenn jeder Teil vergleichbar ist — ohne Liste; je Typ
  eine synthetische Funktion (rekursive Typen rufen sie wieder). Klassen nur mit `:: Identity`
  (Referenzgleichheit, `same`); sonst `LYS-SEM0059` mit dem Teil, der nicht vergleichbar ist.
  `Identity` ist wie `Any` ein Name des Prelude. `Hashable` mit den Sammlungen (S7).
- *h2 Druckform* (Lyric 5 05 §14 Regel 2): `Debug` ungefragt — `P { x = 1, y = "a" }`,
  `E.B(3)`, `E.R { w = 4 }`, `E.A`, `(1, "a")`, ein Optional als sein Wert oder `null`, ein
  String in Anführungszeichen, ein `char` in einfachen —; `{x}` und `println(x)` nehmen sie für
  alles außer den Skalaren und Strings (Display mit den Prelude-Interfaces, S7).
- *h3 `with`* (Lyric 5 03 §2.5): Kopie eines Structs mit ersetzten Feldern, alte Werte rechts,
  Pfade `with { to.x = 9 }`; auf Klassen und Tupeln `LYS-SEM0116`.

**S3h, Ergebnis.** h1–h3 wie präzisiert. Ein Struct ist in Script geteilt und unveränderlich,
`with` baut deshalb jeden Struct neu, den ein Pfad berührt (ein Objekt je Struct, nicht je
Feld); ein Pfad nach dem Ersetzen seines ganzen Feldes ändert den neuen Wert, wie Lyric 5s
Speicherungen in die Kopie. Ziel zuerst, dann die Werte in Schreibreihenfolge. Die Druckform
eines Interface-Werts (`<I>`) und eines Funktionswerts (`<fn>`) ist ein Platzhalter bis zum
Deskriptor (**S3i**). Der Bytecode-Cache verdeckte eine Kontrolle (gleiche Version, anderer
Compiler) — offener Punkt P11. 158 Tests, 92 Konformanzfälle.

**S3i, präzisiert (Entwurf).** Erst der Deskriptor nach 11 Gen (der .NET-Weg), dann was auf ihn
gewartet hat:

- *i1 Deskriptoren als Werte.* Ein `TypeDesc` trägt seine Typargumente als Deskriptoren
  (`args`); ein Deskriptor ist ein Wert der VM. `load.t` legt den eines Programmtyps in ein
  Referenzregister. Eine geteilte Kopie einer generischen Funktion bekommt je Typparameter einen
  versteckten Referenzparameter, den der Aufrufer statisch füllt oder aus seinem eigenen
  weiterreicht. Eine Methode eines generischen Typs liest die Argumente vom Deskriptor ihres
  Empfängers (`desc.of`), denn über `call.i` kennt der Aufrufer sie nicht — wie .NET, das sie
  über die MethodTable des `this` findet. Ein Objekt, das eine geteilte Kopie baut
  (`Pair<T> { … }`), bekommt seinen genauen Typ: `inst.t` interniert `Pair<Foo>` zur Laufzeit
  (Schablone und Argumente, Layout und Tabelle der geteilten Form), `new` nimmt den Deskriptor
  dann aus einem Register. Funktions-, Tupel- und Optionaltypen haben Deskriptoren nach Art und
  Bestandteilen (Arrays mit S7). `x is T` in einer Kopie prüft gegen den Deskriptor. Die
  Druckform eines Interface-Werts und eines Werts vom Typ `T` ist die seines Werts: die
  Druckfunktion steht in jeder Tabelle an einem festen Slot.
- *i2 `Self` und statische Member* (Lyric 5 05 §7): `Self` in Interfaces und Typen; statische
  Member eines Interfaces, `static fn parse(s: string): Self`, `static let zero: Self`, erreicht
  über einen Typparameter, `T.parse(s)`. Eine eigene Kopie ruft direkt, eine geteilte über die
  statische Tabelle des Deskriptors. Statische Defaults. Ein Interface mit `Self` über den
  Empfänger hinaus, mit statischem oder generischem Member, ist nur Constraint (`LYS-SEM0126`).
- *i3 assoziierte Typen* (§8 Regeln 1–7): `type Item;`, `Self.Item`, die Antwort im Typ oder im
  Block, der Pfad `T.Item`, die Fixierung `Iterator<Item = int>`, die Wertform.
- *i4 eine generische Funktion als Wert*: eine eigene Kopie direkt, eine geteilte als Closure,
  die die Deskriptoren hält.
- *i5 Literal-Protokolle* (03 Lit): `FromIntLiteral`, `FromFloatLiteral`, `FromStringLiteral`,
  `FromBoolLiteral`, `FromNullLiteral` als Prelude-Interfaces mit
  `static fn from…Literal(v): Self`; ein Literal an einer Stelle, deren Typ konformiert, ruft sie,
  eine Variable nie. `FromArrayLiteral` und `FromMapLiteral` mit S7.
- *i6 generische Extend-Blöcke* (§13 Regeln 1–5): bedingte Konformanz, Kohärenz. Die Blöcke auf
  eingebauten Konstruktoren und die Blanket-Blöcke (Regeln 6–9) mit S7, wo die std sie braucht.

Je Teil Konformanzfälle in 03 und 05; `typeOf` selbst kommt mit `reflect` (S10), sein Prüfstein
`typeOf([1, 2])` mit S7 — S3i liefert die Deskriptoren, die beide lesen.

**S3i i1, Ergebnis.** Die Probe vorher: `mk(Foo { }) is Pair<Foo>` war `false` — die geteilte
Kopie baute `Pair<Any>`, ein Fehler seit S3g. Jetzt hat jeder Typ einen Deskriptor (ein
Interface und ein Enum mit Nutzlast eigene, das Enum mit seinen Varianten verknüpft; Funktions-,
Tupel- und Optionaltypen nach Bedarf); sieben Ops, Bytecode-Format 3. Eine Kopie, deren Lambda
`T` braucht, kennt den Deskriptor noch nicht (die Closure müsste ihn halten) — mit i4. 164
Tests, 93 Konformanzfälle.

**S3i, Ergebnis.** i1 Deskriptoren, i1b Druckform über einen festen Slot (`instantiate` bis
zum Fixpunkt), i2 `Self` und statische Member samt `static let` (eifrig vor den Anweisungen des
Skripts, Lyric 5 04 §1 Regel 2), i3 assoziierte Typen (Antworten, Defaults, Schranken, Pfade,
Fixierungen, Wertform; ein von ihnen eingeschränkter Parameter bekommt je Typ eine eigene Kopie,
da die Slots einer Antwort je Typ verschieden sind), i4 generische Funktion als Wert und Lambdas
geteilter Kopien mit deren Deskriptoren, i5 Literal-Protokolle als Prelude in Lyric-Script
(Member nach Art benannt), i6 generische Extend-Blöcke mit bedingter Konformanz und Kohärenz.
Drei Fehler seit S3g behoben (geteilte Kopie baute `Pair<Any>`; weitergereichtes eingeschränktes
`T` gab SEM0028; Lambda einer geteilten Kopie löschte `T`). Mit S7: Konstanten generischer
Typen, Blöcke auf einer Instanz, auf eingebauten Konstruktoren und Blanket-Blöcke, ein Name je
Interface getrennt implementiert (05 §3 Regel 4). Beim Abgleich der Bereichsdokumente gegen den Code
fehlte 05 D2/D3 eine Uhr: zwei Defaults eines Namens nahmen still den ersten — jetzt
`LYS-SEM0043`, dazu der qualifizierte Aufruf `I.m(x)`. 191 Tests, 115 Konformanzfälle.

## S4 — Slices (Plan, Entwurf 2026-10-29)

Ziel aus der Meilensteintabelle: Fehler und Kontrolle — VM-Ausnahmen, erschlossene Fehlermengen,
geprüftes `throws`, `try?`/`try!`/`try … catch`, `catch (e in […])`, `defer`/`using`,
`loop`/`break value`, `never` (05). Grundlage Lyric 5 06 (gepinnt 38ea610e) mit Scripts
Abweichungen 05 Th, K, K7 (erschlossene statt deklarierte Mengen, `try` wirkungslos). Der Parser
kennt `throw`/`try`/`defer`/`catch` noch nicht; S4 ist ganz neu. Spec-first in den Kapiteln 06
und 07 des Deltas.

| Slice | Inhalt | Prüfung |
|---|---|---|
| **S4a Werfen und Fehlerpfad** | `throw e` (Anweisung und Ausdruck vom Typ `never`); in der VM verlässt ein Fehler jeden Rahmen wie eine Rückkehr ohne Wert (06 §5 R1), Handler-Tabelle je Funktion; der `try`-Block mit Klauseln als Typtests über den Deskriptor (`is.t`/`is.i`/`is.d`, 06 §4 R7); ungefangen aus `main`: `error:` mit `caused by:`/`suppressed:`, Exit 1 (§5 R3); Paniken bleiben 101 und unfangbar | Fehlerbeispiele; Exit 1/101 |
| **S4b Der Datensatz eines Fehlers** | wo er zuerst geworfen wurde, `e.backtrace()` an der Bindung einer Klausel (06 §4 R4, Lyric 5 M5-3); `throw e` der eigenen Bindung in ihrer Klausel ist derselbe Fehler und behält ihn, jeder andere Wurf beginnt einen neuen. `Error` und `Exception` kamen schon mit S4a; `e.suppressed()` ist ein `Error[]` und kommt mit den Arrays (S7), das Anhängen mit S4e | Konformanzfälle |
| **S4c Fehlermengen** | je Funktion erschlossen (Fixpunkt über den Aufrufgraphen); geschriebenes `throws [A, B]` als geprüfter Vertrag; Teilmengenregel nur bei deklariertem Interface-Member; Funktionswerte, Host und native Module werfen `Error` (05 K); Lint `unmarked-throw` | Fehler am Vertrag |
| **S4d Ausdrucksformen und Klauselregeln** | `try?` (nicht abgeflacht), `try!` (Panik `RT0010`), `try e catch (x: A) v` (06 §6); `catch (e in [A, B])`, Regeln E9 (kein Typ doppelt, unerreichbare Klausel, Catch-all zuletzt), `catch (e)` trägt die Menge (K7), präzises Weiterwerfen | Konformanzfälle |
| **S4e `defer` und `using`** | `defer` statisch auf jeden Ausgang gelegt, auf dem Fehlerpfad als Catch-all-Bereich, LIFO; wirft er unterwegs, gewinnt der erste Fehler, der zweite hängt als unterdrückt an (§5 R4–R5); `using let` für `Closeable` (§7) | Reihenfolge-Fälle |
| **S4f Kontrolle und `never`** | `loop`/`break value` und Labels prüfen (Codes 0101/0102), `do-while`; `never` passt überall und endet nur seinen Pfad, nur als Rückgabetyp schreibbar (§9, `LYS-SEM0145`); `panic`, `assert { }`, `unreachable`, `todo` im Prelude | Konformanzfälle |
| **Abschluss** | STATUS, PR, CI, Merge, Tag `s4-complete` | Fehlerbeispiele in der CI |

Reihenfolge: a vor b (das Werfen braucht noch keine Hierarchie, die Klauseln testen Typen), b vor
c–d, e nach a, f unabhängig.

**S4a, Ergebnis (2026-10-29).** `throw e` als Anweisung und als Ausdruck vom Typ `never`; `never`
passt jetzt in `fit` zu jedem Typ, also auch rechts von `??` und als Rumpf eines Lambdas. Der
`try`-Block mit getypten Klauseln und der Klausel ohne Typ; eine Klausel testet wie ein
Typmuster (`typeTest`, `heldAs`) und bindet den Fehler als ihren Typ. In der VM die Op `throw`
und eine Bereichstabelle je Funktion, innerste zuerst (Bytecode-Format 4; im Text-Assembler die
Zeile `catch @von, @bis, @handler, rN`); ein Fehler verlässt Rahmen um Rahmen bis zum ersten
Bereich, der ihn abdeckt — beim Aufrufer am Aufruf. Ungefangen fragt die VM im selben Lauf
`message()` und `cause()` (die Kette bis 64, ein Zyklus endet dort; wirft `message()`, nennt
der Typ den Fehler) und endet mit `Outcome.Error`; die CLI druckt `error:`, `  caused by:` und
die Rahmen, Exit 1. `Error` und `Exception` stehen als Lyric-Script-Quelle im Prelude (aus S4b
vorgezogen), dazu `LYS-SEM0030` und `LYS-SEM0036` (ein Block ohne Klausel, wie Lyric 5). Die
Zuweisungsanalyse: eine Klausel kennt nur, was vor dem `try` zugewiesen war. Der Runner kann
Lyric 5s `stderr:`. Nebenbei behoben: eine Kopie an einem Skalar gab ihn einem
Interface-Parameter als Referenz weiter (seit S3g, `f<T :: [Show]>(x: T) = describe(x)` mit
`int`: fehlerhafter Bytecode) — jetzt eine Box wie bei `fit`. 208 Tests, 123 Konformanzfälle.

**S4b, Ergebnis (2026-10-29).** Ein Fehler trägt seinen Datensatz: die Rahmen seines ersten
Wurfs als Funktionen und Instruktionen (`ErrorRecord`, ein Wert der VM), gemacht bei jedem
`throw`, als Text erst auf Nachfrage (Native `error.trace`). Ein Bereich bekommt ein zweites
Register für ihn; die neue Op `rethrow` wirft mit dem Datensatz weiter — `throw e` der eigenen
Bindung in ihrer Klausel und der Weiterwurf, wenn keine Klausel nimmt; jeder andere Wurf
beginnt einen neuen. `e.backtrace()` an der Bindung gibt ein `?Backtrace` des Prelude (`show()`
die Rahmen in der Spurform `    at <function> (line <n>)`), nur an der Bindung selbst
(`LYS-SEM0012` sonst), ein eigenes Member des Typs geht vor. Der Bericht zeigt die Rahmen des
Datensatzes, also den ersten Wurfort. Bytecode-Format 5. `e.suppressed()` kommt mit den Arrays
(S7), das Anhängen mit S4e. 214 Tests, 126 Konformanzfälle.

**S4c, Ergebnis (2026-10-29).** Die Mengen werden nach dem Prüfen der Rümpfe in einem eigenen
Lauf über den getypten Baum erschlossen (`throws.lyr`): je Funktion die Typen ihrer `throw`s und
die Mengen ihrer Aufrufe, weniger was die Klauseln nehmen, in Runden bis kein Satz mehr wächst
(Rekursion). Ein Funktionswert wirft alles (02 K2); ein Interface-Member wirft, was es schreibt,
sonst die Vereinigung der Mengen seiner Implementierungen im Skript (entschieden beim Bau: 05 K
nennt nur Funktionswerte, Host und native Module `Error`; mit „alles“ bräche schon
`e.message()` jeden Vertrag — offener Punkt P14). Der Weiterwurf der Bindung trägt, was die
Klausel erreichte (K7, präzises Weiterwerfen); eine generische Menge steht in den Begriffen des
Aufrufs. Ein geschriebenes `throws` ist Vertrag (`LYS-SEM0034` am `throws`, mit Typ und Zeile
jedes Verstoßes), die Teilmengenregel für Implementierungen eines Members mit `throws`
(`LYS-SEM0042`), `LYS-SEM0137`, `LYS-PAR0049`. Die Marke `try e` wird geparst und ändert nichts;
der Lint `unmarked-throw` kommt mit den Lints (S11). Neu in `typed.lyr`: Kinder-Läufe über den
getypten Baum (`exprsIn`, `stmtsIn`, …). 222 Tests, 133 Konformanzfälle.

**S4d, Ergebnis (2026-10-29).** Die Ausdrucksformen ohne neue VM-Mechanik: `try?`, `try!` und
`try e catch (x: A) v` werden zum Block mit Ergebnis-Lokaler um das vorhandene `TStmt.Try`
gesenkt. `try?` ist nicht abgeflacht (`??int`), über `void` nur als Anweisung (`LYS-SEM0140`);
`try!` panisch mit `LYS-RT0010` und der Meldung des Fehlers (neue Op `panic.c` mit Code,
Format 6 — S4f braucht sie für `panic`/`assert`/…); die Teile der Ausdrucksform vereinigen sich
wie die Arme eines `match`; eine Klausel gehört zum nächsten `try` links. Die Regeln zwischen
Klauseln (`LYS-SEM0035`, `LYS-SEM0141`, `LYS-SEM0142`) teilen Block- und Ausdrucksform über
einen gemeinsamen Klauselkopf; die Mengenklausel `catch (e in [A, B])`. K7: ein `match (e)` über
die Bindung einer Mengen- oder typlosen Klausel deckt die erreichende Menge — die Prüfung wartet
bis nach der Inferenz (`LYS-SEM0050` nennt den fehlenden Typ). Abweichung, entschieden beim
Bau: die Bindung bleibt ein `Error`, auch wo nur ein Typ ankommt (Lyric 5 M5-6), da die Mengen
erst nach den Rümpfen feststehen. `LYS-PAR0050`/`PAR0051` im Parser. 229 Tests, 145
Konformanzfälle.

**S4e, Ergebnis (2026-10-29).** `defer` und `using let` werden im Checker zu `TStmt.Finally`
gesenkt: der Rest des Gültigkeitsbereichs ist die Region des `defer`, auch in Wertblöcken. Der
Codegen legt den `defer` auf jeden Ausgang: am Ende, auf dem Fehlerpfad im Handler (unter einer
eigenen Region, deren Fehler mit der neuen Op `suppress` an den Datensatz des ersten gehen; dann
`rethrow`), und bei `return`/`break`/`continue` als Kopie — die Region bekommt dort eine Lücke,
damit die Kopie unter den äußeren Regionen läuft, nicht unter der eigenen (06 §5 R4); der Wert
eines `return` liegt vorher in eigenen Registern. Der Bericht nennt `  suppressed:` (Format 7).
`using` bindet ein `Closeable` des Prelude (`LYS-SEM0143`, `LYS-PAR0052`); ein fallengelassenes
`Closeable` warnt (`LYS-SEM0144`, die `let`-Hälfte mit den Lints S11). Ein Sprung aus einem
`defer`-Rumpf (`return`, `break`/`continue` nach außen) ist abgelehnt (`LYS-SEM0904`, eigener
Code; Lyric 5 sagt nichts — offener Punkt P15). 238 Tests, 153 Konformanzfälle.

**S4f, Ergebnis (2026-10-29).** Labels werden jetzt geparst — vor `loop`, `while`, `do` und
`for`, vor einem `loop` auch mitten im Ausdruck; der Parser führt die Labels der umgebenden
Schleifen, damit nach `break` ein Name das Label ist, wo eine Schleife es trägt, sonst der
Anfang des Werts. `TStmt.Break`/`Continue` tragen, wie viele Schleifen nach außen ihr Ziel steht;
`LYS-SEM0101`, `LYS-SEM0102`, `LYS-SEM0103` (Warnung). `do { … } while (c)` mit eigenem
`TStmt.DoWhile` (`continue` zum Test). `never` nur als Rückgabetyp (`LYS-SEM0145`, auch im
Funktionstyp das Ergebnis), eine `never`-Funktion kehrt nicht zurück (`LYS-SEM0146`,
`LYS-SEM0017`); ein `return` dessen, was nicht zurückkehrt, erzeugt kein `ret` (vorher
fehlerhafter Bytecode bei `fn f(): int = todo()`). `panic`, `assert { }`, `unreachable`, `todo`
als Built-ins auf `TExpr.Panic` (RT0008/0011/0012/0013); `assert` steht an der Stelle, zitiert
die Bedingung aus dem Quelltext (den der Parser jetzt im Modul hält) und baut die Meldung nur
beim Fehlschlag. Der Fall aus Lyric 5s Beispiel (`ok || fail("why")` ist ein `bool`) fand eine Lücke: `never` als Operand — rechts von `&&`/`||` bestimmt die linke Seite den Typ, unter jedem anderen Operator ergibt das Ganze `never`; `println` eines `never` ebenso. 245 Tests, 165 Konformanzfälle.

**S4, Abschluss (2026-10-29).** Abgleich der Bereichszeilen 05 E3–E12, K, K7, Th, Pn gegen den
Code: gebaut, oder mit Uhr — Task-Ergebnisse tragen den Fehler mit S6 (E10); `e.suppressed()`
(ein `Error[]`), `Result<T, E>` als Bibliothekstyp, Iteratoren ohne Fehlertyp und das Schließen
eines `Closeable`-Iterators durch `for` (E7) mit S7; `.Error` an der Host-Grenze mit S8 (E6,
01 S11); der Lint `unmarked-throw` und die `let`-Hälfte von `LYS-SEM0144` mit den Lints (S11).
Abweichungen gegenüber Lyric 5, im Delta-Kapitel 06 geführt: erschlossene Mengen samt
Interface-Member ohne `throws` (P14), die Bindung einer typlosen Klausel bleibt `Error` (M5-6),
der Sprung aus einem `defer` ist abgelehnt (P15), Rahmen immer im Bericht. Je Slice
Mutantenkontrollen mit vorher geschriebener Vorhersage. Verfehlt nur in S4a: die Vorsuche
`caught` und die Abwicklung rechnen beide `back.pc - 1`, ein Mutant auf der einen traf den Test
der anderen nicht (2 statt 3, dann 3 statt 2). Vor den Läufen geschärft, weil sie den Mutanten
sonst nicht gesehen hätten: je ein Test in S4b (Aufrufer-Rahmen), S4c (Fixpunkt) und S4e
(Wertblock).

## S5 — Slices (Plan, Entwurf 2026-10-29)

Ziel aus der Meilensteintabelle: Module und Pakete — Datei = Modul, Importe, Globale, Pfadregel,
Prelude, `lyric-script.toml`, Lock, Git und Pfad, Frontmatter-Abhängigkeiten, Rechteklassen aus
Importen (07). Grundlage: Lyric 5 04 und 15 (gepinnt 38ea610e), Scripts Abweichungen 07 Top, Path,
Dep, Man, V1–V7, 02 V und 01 S1–S4. Bisher ist ein Skript eine Datei; S5 ist Lader,
Namensauflösung über Dateien, Projekt und Abhängigkeiten.

| Slice | Inhalt | Prüfung |
|---|---|---|
| **S5a Module einer Wurzel** | Datei = Modul, Name aus dem Pfad unter dem Ordner des Einstiegs ohne Präfix (Path); Importe selektiv/qualifiziert/Alias, `pub import`, kein Glob (V3); `private` an Funktionen, `pub`/`internal` angenommen (02 V); Modul-`let`/`var` vor dem Code des Einstiegs in Abhängigkeitsreihenfolge, Zyklus Fehler (V5); nur der Einstieg führt Anweisungen aus, die anderen ein Lint (Top); `RES0001/0003/0004/0005/0009`, ungenutzter Import (`SEM0072`); ein Bytecode-Modul fürs ganze Programm, Cache-Schlüssel über alle Quellen | Mehrdatei-Fälle (Runner: Verzeichnisfälle) |
| **S5a2 Typen über Module, Namensräume, Einstieg** | aus S5a geteilt (2026-10-29): ein Typ über sein Modul im Initialisierer (`util.Point { … }`) und generisch (`util.Box<int>`); `private` an Typen und Mitgliedern (Lyric 5 §3 R6–R7); `RES0011`, `RES0012`, Verdecken des Prelude (`SEM0153`); `fn main` als Einstieg eines Moduls ohne Anweisungen, beides „zwei Einstiege“ (Top); der Pfad nennt seine Datei genau, Groß-/Kleinschreibung auch auf Windows (Lyric 5 §2 R4); die Spurform mit der Datei (06 R3) | Mehrdatei-Fälle |
| **S5b Manifest** | `lyric-script.toml` (`[package]` `name`, `version`, `edition`, `toolchain`; `[dependencies]` mit `path`); mit Manifest Lyric 5s Pfadregel (Paketname vorn, `src/`, `src/lib.lyr` Wurzelmodul, `src/main.lyr` Einstieg); nur Deklariertes importierbar (`RES0014`); `PKG`-Codes | Paketfälle mit Pfad-Abhängigkeit |
| **S5c Git und Lock** | Git-Abhängigkeiten (`tag`/`branch`/`rev`), normalisierte URL, Nutzer-Cache, MVS über Versionslinien, `[override]`, Zyklus `PKG0010`; `lyric-script.lock` mit Commit und Inhalts-Hash, `--locked`, `--offline`, `lyric-script update` | Fälle mit lokalen Repositories (`repos/<name>/<version>`), nie Netz |
| **S5d Frontmatter-Abhängigkeiten** | der `---`-Kopf eines Einzelskripts mit der Abhängigkeits-Teilmenge des Manifests, beim ersten Lauf aufgelöst, nach dem Hash des Kopfs gecacht; `lyric-script lock tool.lyrs` → `tool.lyrs.lock` | Einzelskript mit Kopf |
| **S5e Rechteklassen aus Importen** | Rechte je Modul aus den Importen abgeleitet, im Bytecode vermerkt, beim Laden geprüft (`CAP0001`, alle auf einmal mit Zeile); `--allow`/`-A`, einmalige Abfrage vor dem Start am Terminal (01 S1, S4); `std` kommt mit S7 — die Mechanik jetzt, eine Testtabelle steht für `std` | Rechte-Fälle |
| **Abschluss** | STATUS, PR, CI, Merge, Tag `s5-complete`; Bereichszeilen gegen den Code | Beispielprojekt in der CI |

Reihenfolge: a vor a2 vor b vor c; d nach c (teilt den Auflöser); e nach a2.

**S5a, Ergebnis (2026-10-29).** Spans und Diagnosen tragen ihre Datei (0 der Einstieg, −1 das
Prelude). Der Prüfer registriert die Deklarationen eines importierten Moduls unter
`<pfad>::<name>` und schlägt jeden Namen über die Sicht des aktuellen Moduls nach, so dass ein
importiertes Modul die Namen des Einstiegs nicht sieht (`SEM0002`). Die drei Importformen und
`pub import`; `private` an Funktionen, beim Import und beim Aufruf über das Modul (`RES0009`);
ein Name zweimal gebunden (`RES0001`, die Deklaration behält ihn); ein Name, den das Modul nicht
hat (`RES0004`); der ungenutzte Import (`SEM0072`) in Schreibreihenfolge, ein schon abgelehnter
nicht noch einmal. Nur der Einstieg führt Anweisungen aus: die `let`/`var` importierter Module
sind Globale, vor dem Code des Einstiegs in Abhängigkeitsreihenfolge gefüllt, andere Anweisungen
warnen (`SEM0905`, Tops Lint). Die CLI liest den Einstieg und alle erreichbaren Module (`a.b` →
`a/b.lyrs` unter dem Ordner des Einstiegs, `RES0003`), ordnet sie in Tiefensuche (`RES0005` mit
dem Kreis), meldet je Datei und schlüsselt den Cache über Namen und Texte aller Dateien; ein
Skript ohne `import` behält den Schlüssel seines Textes und wird vor dem Cache nicht geparst.
`checkModule(entry, imported = [])` und `parse(source, file = 0)` sind der eine Eingang für
Tests und CLI. Gefunden: drei Schleifen über `Map.keys()` — `SEM0042` aus S4c, die Self-Kopien
und die Zeugen der Instanzen —; Lyric 5s Map liefert bis etwa acht Einträge die
Einfügereihenfolge, darüber eine je Prozess neue, also waren Meldungen und Bytecode bei großen
Typen je Lauf anders geordnet; jetzt nach Slot. Spec 04 Regeln 1–9 mit 14 Ordnerfällen (der
Runner nimmt einen Ordner mit `main.lyrs` als einen Fall), alle rot gegen S4 und grün gegen
S5a; Tests 245 → 256, Fälle 165 → 179. Mutanten mit vorher geschriebener Vorhersage: im ersten
Lauf trafen 3 von 4 — die Reihenfolge der ungenutzten Importe sah ein Test mit vier Einträgen
nicht; auf ein Dutzend geschärft, dann trafen beide Reihenfolge-Mutanten, der alte
`keys()`-Weg von `SEM0042` eingeschlossen; die übrigen fünf wie vorhergesagt.

**S5a2, Ergebnis (2026-10-29).** Der Einstieg ist ein Modul wie jedes: seine Deklarationen unter
`::<name>`, nur das Prelude bar; so verdeckt ein Name eines Moduls den des Prelude mit Warnung
(`SEM0153`), statt mit ihm zu kollidieren, und ein eingebauter Typname ist keiner Deklaration
(`RES0011`, jetzt auch für Funktionen und Bindungen). Ein Typ über sein Modul — `util.Point { … }`,
`util.Box<int>`, `util.Shape.Rect { … }`, `util.Shape.Dot`, `util.Counter.start()` —; `private`
an Typen, Feldern und Methoden: ein Typ merkt sich sein Modul und die Namen seiner privaten
Mitglieder, jede Zugriffsstelle fragt `mayName`, Initialisierer und `with` fragen `mayBuild`
(Lyric 5 §3 R6–R7). Mitglieder ohne Wort sind jetzt öffentlich wie Deklarationen (vorher las
der Parser nur `pub`). Der Lader prüft jeden Pfadteil gegen das Verzeichnis (exakte Schreibung
auch auf Windows/macOS, `RES0003`) und gibt jedem Modul seine Untermodule mit (`RES0012`).
`fn main` ist der Einstieg eines Skripts ohne Anweisungen, sein `int` der Exit-Code; beides ist
„zwei Einstiege“ (`SEM0906`), eine andere Form `SEM0021`. Ein Rahmen eines importierten Moduls
nennt seine Datei, `at f (util/deep.lyrs:2)`; die Bytecode-Funktion trägt sie (Format 8), die
Rahmen des Einstiegs bleiben `(line n)` (P16). Gefunden: ein Lambda mit Ausdrucksrumpf ohne
Wert führte seinen Rumpf nie aus (`() => say()` rief `say` nicht), seit S3e — der Rumpf wurde
für ein `return` ohne Wert verworfen; dazu der Fall in 03. Spec 04 Regeln 10–15 und Regel 1
(exakte Namen), 06 Regel 3 (die Datei), 14 Regel 3 (Schlüssel über alle Dateien); 12 Fälle,
alle rot gegen S4. Tests 256 → 263, Fälle 179 → 192. Zwei Testerwartungen waren falsch, nicht
der Code: Importe werden vor den Funktionen gebunden (ihre Warnung steht vorn), und
`import x { y }` bindet `y`, nicht `x`. Mutanten (8, in zwei Läufen) alle wie vorhergesagt.

**S5b, Ergebnis (2026-10-29).** `lyric-script.toml` über `std.toml` gelesen (`src/package.lyr`):
`[package]` mit `name`, `version`, `edition` (`"1"`), `toolchain`, den beschreibenden Feldern;
`[dependencies]` mit `path`; Floats und Datumsangaben (`PKG0001`), fehlende oder falsche Felder
(`PKG0002`), Unbekanntes und die Registerform (`PKG0003`) an ihrer Zeile im Manifest; Git,
`[override]`, `include`/`exclude` (S5c) und `[lints]` (S11) als `NYI0001`. Der Lader zieht aus
der CLI nach `src/loader.lyr`: das nächste Manifest über einem Einstieg unter dessen `src/`
macht das Programm zu einem Paket, dann gilt Lyric 5s Pfadregel (`app.a.b` → `src/a/b.lyrs`,
`app` → `src/lib.lyrs`, kein `app.lib`); die Pakete über Pfad-Abhängigkeiten je einmal gelesen
(`PKG0004` für einen Ordner ohne das genannte Paket, `PKG0005` für zwei gleichen Namens), ein
Import nur aus dem eigenen und den deklarierten Paketen (`RES0014`); eine Toolchain unter der
verlangten endet mit 2 (`PKG0009`). `run`/`check` ohne Datei im Paketordner nehmen
`src/main.lyrs` (`CLI0005` ohne). `internal` hält eine Deklaration oder ein Mitglied im Paket
(07 V2), ohne Manifest öffentlich. Spec 15 Regeln 1–5 und zehn Paketfälle (der Runner baut sie
aus dem Ordner ohne Datei, `exit:` neben `error:` für Umgebungsfehler); gegen S4 alle rot, aber
nur weil ein Aufruf ohne Datei dort scheitert — die semantische Kontrolle sind die Mutanten,
erstmals mit Konformanzlauf, weil der Lader nur dort getestet ist: sechs auf einmal, alle sechs
wie vorhergesagt (Unit 265/267, Konformanz 196/202). Tests 263 → 267, Fälle 192 → 202.
Vorhersage verfehlt: in einer Probe meldete ein Programm mit `RES0014` nicht auch den
`internal`-Verstoß der zweiten Zeile — Ladefehler beenden vor dem Prüfer.

**S5c, geteilt (2026-10-29).** S5c ist der größte Slice von S5; er wird in drei Teile geschnitten,
je mit eigenem Ergebnis: **S5c1** Git-Abhängigkeiten (Revisionen, Normalform der URL, Nutzer-Cache,
`--offline`), **S5c2** die Lockdatei (Commit und Inhalts-Hash, `--locked`, `lyric-script update`),
**S5c3** Versionslinien und MVS, `[override]`, Paketzyklen (`PKG0010`), `include`/`exclude`.

**S5c1, Ergebnis (2026-10-29).** Eine Git-Abhängigkeit liest eine Revision: Tag, Branch, Commit
(`rev`, 7–64 Hex-Ziffern) oder den Branch, den `HEAD` nennt; die URL in ihrer Normalform
verglichen, gecacht und geklont. Der Lader klont ein Repository einmal bare in den Nutzer-Cache
(`<cache>/git/<schlüssel>`), holt nach, wo ein Branch verlangt ist oder die Revision fehlt, und
checkt jeden Commit einmal aus (`<cache>/src/<schlüssel>/<commit>`) — über `git` als Prozess
(`std.process`). Fehlende Revision, fehlendes Paket, ein Versions-Tag über einem anderen Manifest:
`PKG0006`; unerreichbar oder `--offline` ohne Cache: `PKG0007`, Exit 2; ein Paket aus Git nennt
seine Abhängigkeiten per Git (`PKG0004`). Ein Import einer Abhängigkeit, die nicht gelesen wurde,
schweigt (der Fehler steht am Manifest). Der Runner baut `repos/<name>/<version>/` zu
Git-Repositories (fester Autor, feste Zeit), ersetzt `{repos}` und gibt jedem Paketfall eine Kopie
und einen eigenen Cache; `option:` reicht Optionen durch. Spec 15 Regeln 6–7, acht Fälle, alle rot
gegen S5b. Ein Fall war vor den Mutanten zu weich (der Pfad zeigte ins Leere, PKG0004 auch ohne
die Regel) und wurde geschärft; danach trafen alle vier Mutanten wie vorhergesagt. Tests 267 →
269, Fälle 202 → 210.

**S5c2, Ergebnis (2026-10-29).** `lyric-script.lock` (`src/lock.lyr`): je gelesener Git-Revision
Name, Version, Repository, Revision wie verlangt, Commit und Inhalts-Hash (`h1:` + Base64 von
SHA-256 über die sortierten Zeilen `sha256  pfad` von Manifest, `src/**`, `README*`, `LICENSE*`;
Base64 selbst geschrieben, weil `std.encoding` berechnete Modulbindungen hat). Ein gelockter
Eintrag wird am gelockten Commit gelesen und sein Inhalt geprüft (`PKG0008`), ein kaputter Lock
abgelehnt (`PKG0001`), der Lock nur bei Änderung geschrieben, ohne Git gelöscht; `--locked`
verweigert jede Abweichung, ein fehlender Eintrag vor jedem Fetch (`PKG0011`); `update
[paket…]` liest neu (`CLI0006` für einen Namen ohne Git-Paket). Gefunden: `run` nahm den
Bytecode aus dem Cache, bevor die Fehler des Laders gemeldet waren (seit S5a) — ein Programm mit
Ladefehler lief; ebenso nahm die Abkürzung für Skripte ohne `import` auch in einem Paket mit
kaputtem Manifest den Cache. Beide geschlossen. Der Hash stimmte beim ersten Lauf mit einem
Python-Orakel; die Commits der Runner-Repositories sind durch festen Autor und feste Zeit
bestimmt — der Runner schaltet `core.fileMode` ab, sonst hängen sie am Dateisystem des Checkouts
(lokal `/mnt/c`: jede Datei ausführbar). Spec 15 Regeln 8–9, sieben Fälle (Runner: `update`).
Mutanten: im ersten Lauf überlebte die `--locked`-Frühprüfung — der Fall ohne Lock wird auch
von der Schlussprüfung gefangen; ein geschärfter Fall (Lock hält `geo`, das Manifest liest auch
`units`) misst sie jetzt, der Mutant fiel. Tests 269 → 271, Fälle 210 → 217.

**S5c3, Ergebnis (2026-10-29).** Der Lader liest jetzt zweiphasig: erst jede Quelle, die das
Programm verlangt — auch Versionen auf dem Weg —, jede Anfrage gemerkt; dann je Name eine
(`choose`): ein Override, sonst die größte Version einer Linie eines Repositories (MVS), sonst
`PKG0005`; die Anfragen erreichen danach das gewählte Paket, und eine Tiefensuche über die
gewählten meldet Zyklen mit ihrem Pfad (`PKG0010`). `[override] name = { path }` des
Wurzelmanifests ersetzt jede Anfrage des Namens, bevor etwas gelesen oder geholt wird.
`include`/`exclude` bestimmen den Inhalt eines Git-Pakets (Muster mit `*`, `?`, `**`, Ordner);
der Hash wird jetzt nach dem Lesen des Manifests gebildet, und ein Modul außerhalb des Inhalts
gibt es nicht (`RES0003`). `update` hebt einen Versions-Tag des Wurzelmanifests auf den neuesten
seiner Linie und schreibt ihn in seine Zeile. Spec 15 Regeln 10–12, sechs Fälle; sechs Mutanten in
einem Lauf, alle wie vorhergesagt. Eine Testerwartung war falsch (eine Override-Zeile um eins
verzählt). Tests 271 → 275, Fälle 217 → 223.

**S5d, Ergebnis (2026-10-29).** Der `---`-Kopf eines Einzelskripts ist die Teilmenge des
Manifests, die ein Skript nimmt — `[dependencies]`, `[override]`, `toolchain` in `[package]`, kein
Paketname (`PKG0003`) —, gelesen mit `readManifest(text, frontmatter = true)`; seine Fehler stehen
an den Zeilen des Skripts. Das Skript wird zur Wurzel eines Paketgraphen ohne eigenen Namen: seine
eigenen Module bleiben bei der Pfadregel, ein Import mit dem Namen einer Abhängigkeit vorn geht in
deren Paket. Aufgelöst beim ersten Lauf, gemerkt als Lock im Nutzer-Cache unter dem Hash des Kopfs
(`<cache>/scripts/<hash>.lock`), so dass ein bewegter Branch den nächsten Lauf nicht ändert;
`lyric-script lock tool.lyrs` schreibt `tool.lyrs.lock` daneben, das zuerst gelesen wird. Der
Runner baut auch einen Programmordner mit `repos/` aus einer Kopie. Spec 15 Regel 13, drei Fälle,
alle rot gegen S5c3; Mutanten wie vorhergesagt, nachdem ein eigener Mutant falsch gebaut war (die
Vorrangregel machte jeden Import pfadbasiert — kein Befund über die Tests). Fälle 223 → 226.
