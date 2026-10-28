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
