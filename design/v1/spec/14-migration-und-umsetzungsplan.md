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

**S5e, Ergebnis (2026-10-29).** Rechte aus Importen (`src/rights.lyr`): die Klassen `file`, `net`,
`process`, `os`, `native`; der Lader vermerkt je Import eines Moduls einer Klasse das Recht mit
Pfad und Zeile, das Bytecode-Modul trägt sie (`Module.rights`, Format 9), so dass
ein Lauf aus dem Cache sie ebenso verlangt. Vor dem Start prüft `run`: `--allow file,net` (auch
`--allow=…`, wiederholbar) und `-A` geben; was fehlt, wird am Terminal einmal mit Herkunft
erfragt, sonst alles auf einmal als `CAP0001` gemeldet, Exit 2; `CLI0007` für ein Wort, das
keine Klasse ist. Die Tabelle für `std` steht vorläufig im Code (`std.fs` → `file`, `std.net`/
`std.http` → `net`, `std.process` → `process`, `std.os`/`std.time`/`std.random` → `os`); S7
legt sie mit `std` fest. Weil `std` bis dahin nicht importierbar ist, steht `LYRIC_SCRIPT_RIGHTS`
als Testtabelle für sie (kann Rechte nur verlangen, nie geben). Gefunden: ein Lyric-5-ICE bei
`(try? f()) ?? null` (lyriclang/lyric#624, umgangen); `eprint` ohne Zeilenende erschien am
Terminal erst nach der Antwort — die Frage steht jetzt auf eigener Zeile (über ein
Pseudo-Terminal geprüft). Spec 17 Regel 1, vier Fälle (Runner: `env:`, `stderr-has:`), alle rot
gegen S5d. Mutanten: ein eigener Mutant baute nicht; eine Vorhersage verfehlt, weil zwei
Mutanten im selben Lauf sich maskierten (ohne gesammelte Rechte ist `-A` gleichgültig) — allein
fiel der zweite wie vorhergesagt. Tests 275 → 278, Fälle 226 → 230.

**S5, Abschluss (2026-10-29).** Abgleich der Bereichszeilen 07 Top, Path, Dep, Man, V1–V7 und
02 V gegen den Code: gebaut sind Datei = Modul mit exakten Namen und Laden je Datei einmal (V1),
die drei Importformen, `pub import`, die Nichtnutzungswarnung (V3), Sichtbarkeit mit `private`
je Datei und `internal` je Paket (V2, 02 V), Modul-`let`/`var` in Abhängigkeitsreihenfolge (V5),
Namensräume mit `RES0001/0011/0012` (V6), Pakete mit Pfad und Git, Lock, MVS über Versionslinien
und `[override]` (V7, Man), Frontmatter-Abhängigkeiten (Dep), nur der Einstieg führt Anweisungen
aus und `fn main` als Einstieg (Top). Mit Uhr woanders: die Prelude-Zusätze `eprintln`,
`readLine`, `args`, `exit` (V3 I8) mit dem std-Kern (**S7**), dort auch die feste Rechtetabelle;
die Note, dass ein lokaler Name ein Modul verdeckt (V6), und `@Test`/`lyric-script test` (V4)
mit **S11**; Bereiche auf Rechten (`--allow file=./data`) und die Rechte von Host-Modulen mit
**S8** (01 S1–S2); `[lints]` mit **S11**. Das Austrittskriterium — ein Skriptprojekt aus
mehreren Dateien mit Git-Abhängigkeit, ein Einzelskript mit Frontmatter — erfüllen die
Paketfälle der Suite, die die CI auf allen vier Plattformen fährt (Git-Repositories baut der
Runner), dazu `examples/project` (Paket mit Pfad-Abhängigkeit) und `examples/scripts/square.lyrs`
(Kopf) als Schritte der CI. Gefunden über den Meilenstein: drei Schleifen über `Map.keys()`, ein
Lambda ohne Wert lief nie (S3e), `run` nahm Bytecode aus dem Cache vor den Ladefehlern (S5a), ein
Lyric-5-ICE (lyriclang/lyric#624). Je Slice Mutanten mit vorher geschriebener Vorhersage;
verfehlt: ein Reihenfolgetest mit zu wenigen Einträgen (S5a), eine `--locked`-Prüfung, die eine
andere verdeckte (S5c2), zwei sich maskierende Mutanten (S5e); jeweils geschärft oder getrennt
nachgeprüft. Neue Werkzeugfalle: Lyric 5s Map ist bis etwa acht Einträge geordnet. 278 Tests,
230 Fälle; Bytecode-Format 9.

## S6 — Slices (Plan, Entwurf 2026-10-29)

Ziel aus der Meilensteintabelle: Koroutinen und Tasks — Tasks auf VM-Frames, Scheduler je Instanz,
Generatoren, `spawn`/`await`/`TaskScope` (Top-Level), Channels, `select`, `sleep`, `Timer`,
`Semaphore`, Abbruch, `withTimeout`, I/O über Lyric-5-Tasks (07 End, Wait, N2–N9; 11 Co; Lyric 5
10 §1–§7). N1, N7, N10 entfallen (eine Instanz, ein Thread).

| Slice | Inhalt | Prüfung |
|---|---|---|
| **S6a Tasks in der VM** | die Frames des Interpreters je Task, eine Warteschlange je Instanz; `spawn { }` → `Task<T>`, `await()`, `status()` (`Running`/`Done`/`Failed`/`Panicked`/`Cancelled`), `yieldNow()`; kooperativ (N8); der Top-Level-Code ist ein `TaskScope` (End): Kinder am Ende abgewartet, der Fehler eines Kindes bricht die Geschwister ab und endet mit Exit 1 | Konformanzfälle |
| **S6b Koroutinen** | `Coroutine<Y, R>`: `next(): ?Y`, `result()`, `isDone()`, `close()` (wirft drinnen `Cancelled`); Generator-Lambdas, `sequence { yield }`; `Coroutine :: Iterator`, `for` darüber; Warten im Generator parkt dessen Task (N3) | Konformanzfälle |
| **S6c Abbruch und Scopes** | `task.cancel()` → `Cancelled` am nächsten Wartepunkt (N9), fangbar; `TaskScope { }`, `scope.cancel()`, `spawnDetached`, `withTimeout(d) { }`; Panik im Task → `Panicked`, `await()` paniert erneut (N4); `TaskStatus<T>` mit Wert, Fehler und `PanicInfo`, `isDone()` (Lyric 5 10 §2 Regeln 10–11; aus S6a) | Konformanzfälle |
| **S6d Channels, select, Zeit** | `Channel<T>` gepuffert und ungepuffert, senden/empfangen/schließen; `select` als Builder; `sleep`, `Timer.after`; `Semaphore` (kein Mutex, N5); die Hauptschleife *standalone* wartet auf Zeitgeber; `withTimeout(d) { }` (aus S6c) | Konformanzfälle |
| **S6e I/O über Lyric-5-Tasks** | ein wartendes Native startet einen Lyric-5-Task und parkt den Skript-Task (N6, 11 Co); die ersten Natives, die das brauchen (`readLine` von stdin, `sleep` auf der Uhr); ein Callback aus einem Native darf nicht warten (Fehler) | Konformanzfälle |
| **Abschluss** | STATUS, PR, CI, Merge, Tag `s6-complete`; Bereichszeilen gegen den Code | nebenläufiges Beispiel in der CI |

Reihenfolge: a vor b vor c vor d vor e. Austrittskriterium: ein nebenläufiges Beispiel in der CI.

**S6a, Ergebnis (2026-10-29).** Der Interpreter läuft je Task: `TaskState` hält Register, Rahmen
und Stelle, `RunShared` Modul, Globale, Deskriptoren, Budget und Warteschlange; `run` ist der
Scheduler (FIFO, kooperativ: ein Task läuft, bis er endet, wartet oder weicht), `runTask` lässt
einen laufen. Neue Ops `spawn`, `await`, `yield`, `task.st`, `join` (Format 10). Ein Fehler, der
einen Kind-Task verlässt, wird mit Datensatz gehalten statt gemeldet; `await` wirft ihn erneut,
eine Panik paniert den Wartenden erneut. Sprache: `spawn { … }` → `Task<T>` (Prelude: `class
Task<T>`, `enum TaskStatus`), `await()` und `status()` als Methoden, `yieldNow()`; für die
geworfenen Mengen wirft `await` jedes `Error` (N4: `Task<T>` ohne `throws`). Das Ende des
Top-Levels — nach `fn main`, wo es Einstieg ist — ist ein `join`, nur wo das Programm `spawn`
enthält: es wartet alle Tasks ab, dann entscheidet das erste Scheitern nach End-Reihenfolge,
Fehler und Panik gleich (Exit 1 bzw. 101), auch wo es erwartet und gefangen wurde (Lyric 5 10
§4 Regel 2, §5 Regel 3; wie `TaskScope.ended` in Lyric 5s `std.task`). Eine Verklemmung paniert
den Lauf (`RT0018`, Lyric 5s Code); Lyric 5 §2 Regel 12 lässt den ältesten wartenden Task panieren — da eine
Panik nicht fangbar ist, kommt beides zum selben Ende. Vorgezogen aus S6c: `Panicked` und das
erneute Panieren in `await()`, die der Scope braucht. Mit Uhr **S6c**: das Abbrechen der
Geschwister beim ersten Scheitern, bis dahin laufen sie zu Ende; `TaskStatus<T>` mit Wert, Fehler
und `PanicInfo` (Lyric 5 §2 Regel 11 — N4 nennt nur die Zustände, eine Abweichung ist nicht
entschieden, also gilt Lyric 5) und `isDone()` (Regel 10). Gefunden: `join` nahm den ersten
*gestarteten* gescheiterten Task und ließ eine Panik immer gewinnen — gegen Lyric 5s Scope, zwei
VM-Tests rot gegen den alten Stand; `spawn(42)` lief ohne Diagnose durch; `SEM0023` stand in
keinem Katalog (der Katalog-Check fing es) → `SEM0014`, ein Block mit Parametern `SEM0001` statt
`SEM0045`, beim Lambda nicht mehr doppelt gemeldet; die Verklemmung trug einen eigenen Code
`RT0900`, obwohl Lyric 5 sie als `RT0018` kennt (Spec 16 Regel 1) — umbenannt. Spec 10 Regeln 1–3, elf Fälle; die neun
ersten rot gegen S5 geprüft, die End-Reihenfolge nageln die VM-Tests fest. Sieben Mutanten in drei
Läufen (`join` ohne Scheitern, `Failed` als `Done`, `spawn(42)` still, `await` ohne Menge; `yield`
ohne Wechsel, kein `join`; `await` ohne erneutes Werfen), alle wie vorher aufgeschrieben gefangen.
Tests 278 → 292, Fälle 230 → 241.

**S6b, Schnitt (2026-10-29).** Zwei Teile, je mit eigenem Ergebnis. **S6b1**: Koroutinen in der VM
— eigene Kontexte im ziehenden Task, Ops `co.new`, `co.next`, `yield.v`, `co.res`, `co.done`,
Format 11 — und Koroutinen-Funktionen mit `yield`, Ergebnis über `return`, `next()`, `result()`,
`isDone()` (Lyric 5 10 §1 Regeln 1–6). **S6b2**: Generator-Lambdas und `sequence { }` (Regeln
11–12), `for` über eine Koroutine. **S6b3** (nach S6b1 abgespalten, weil S6b2 sonst zu groß würde):
`close()` mit `Cancelled` am `yield`, `using let` (Regeln 9–10), ein `yield` in einer gerufenen
Funktion (Regel 13), Identität (Regel 14). `Coroutine :: Iterator`
kommt mit dem Iterator-`for` in **S7**; bis dahin kennt `for` nur Ranges und, ab S6b2, Koroutinen.

**S6b1, Ergebnis (2026-10-29).** Eine Koroutine läuft auf eigenen Registern und Rahmen im Task,
der sie zieht: der Task hält den laufenden Kontext und einen Stapel der ziehenden (`Pull`), so
dass ein Warten in der Koroutine — `yieldNow()`, `await` — den ganzen Task samt Kette parkt (N3,
Lyric 5 §2 Regel 6). Ops `co.new` (die Slots von `Y` als Immediate, die von `R` aus der
Rumpffunktion), `co.next` (Antwort in der Form von `?Y`: erst der Wert, dann das Flag — dieselbe
Belegung wie jedes Optional, so dass der Code sie unverändert übernimmt), `yield.v`, `co.res`,
`co.done`; Format 11. Ein Fehler, den der Rumpf nicht fängt, geht an den `co.next`, der ihn traf,
und wird dort erneut geworfen; eine Panik geht an den Task. Ziehen einer laufenden Koroutine und
ein `yield` ohne Koroutine paniken (`RT0014`). Im Checker: `Coroutine<Y, R>` in der Prelude,
`Coroutine<Y>` = `Coroutine<Y, void>`; eine Funktion mit diesem Ergebnis und eigenem `yield`
(außerhalb ihrer Lambdas — die AST-Läufe bekamen dafür `deep`) oder ohne Rückgabewert ist eine
Koroutinen-Funktion: ihr Rumpf wird ein parameterloses Lambda, das Parameter und Empfänger
einfängt, die Funktion gibt `co.new` davon zurück. `yield` (`SEM0038`), `return` (`SEM0039`,
`SEM0017`), `next()` als `?Y`/`bool`/`??T`, `result()` (`SEM0012` ohne `R`), `isDone()`; ein Pull
wirft für die Mengen jedes `Error` (03, wie `Task<T>`). Ein `yield` außerhalb des eigenen Rumpfs
ist bis S6b2 `NYI`. Spec 10 Regeln 4–6, 13 Fälle, alle rot gegen S6a; acht Mutanten in drei
Läufen (Flag des Yields, Referenzen am Ende, Fehler ans Ziehen, kein Ergebnis; `SEM0038`,
`SEM0039`, `deep`, kein erneutes Werfen), alle wie vorher aufgeschrieben. Der Katalog-Check fing
`RT0014` vor dem ersten Lauf. Tests 292 → 306, Fälle 241 → 254.

**S6b2, Ergebnis (2026-10-29).** Ein Lambda, dessen Block ein eigenes `yield` hat, ist ein
Generator: sein Rumpf wird zum internen Aufruf `<generator>(Block)`, den der Checker mit dem
erwarteten Typ prüft — der geschriebene Ergebnistyp oder der des Orts gibt `Y` und `R`, sonst
vereinheitlichen sich Yields und Returns zu ihnen (`unify`, `SEM0016`). Dafür ein stiller erster
Durchgang (wie bei 03 Leer: Fehler schweigen, erzeugte Funktionen werden zurückgenommen) und ein
zweiter gegen die gefundenen Typen, damit ein `yield 1` vor einem `yield 2.5` umgewandelt wird
statt als Float-Bits gelesen. `SEM0046` für einen Pfad ohne Ergebnis. `sequence { … }` erkennt der
Checker wie `spawn` und gibt den Generator des Blocks direkt (`R` = `void`). `for (x in c)` über
eine Koroutine senkt der Checker zu `while (let x = c.next())` über eine verborgene Lokale, die
die Koroutine einmal hält; `Coroutine<void>` → `SEM0007`. Gefunden: die Vorausschau auf ein Lambda
zählte nur runde Klammern, `(x: int): Pair<int, int> => x` war kein Lambda (Parser-Fehler seit S3,
jetzt `<`/`>` als Tiefe). Spec 10 Regeln 7–8, zehn Fälle, alle rot gegen S6b1; sechs Mutanten in
zwei Läufen, zwei Vorhersagen verfehlt: `>>` ohne eigene Zählung ist äquivalent (die Tiefe wird nur
zu hoch, ein Komma beendet die Vorausschau nie zu früh — der `>>`-Test ist ein Pin des Verhaltens,
kein roter Fall), und zwei Mutanten im selben Lauf (Ort ignoriert, Returns ohne Ableitung) gaben
zusammen `R` = `void` und so einen zweiten Fall rot; jeder hat seinen eigenen Fänger. Tests 306 →
312, Fälle 254 → 264.

**S6b3, Ergebnis (2026-10-29).** `close()` (Op `co.close`, der Code baut das `Cancelled`): eine nie
gezogene oder fertige Koroutine endet; eine geparkte läuft an ihrem `yield` weiter, das dort das
`Cancelled` wirft — die VM schleust es als synthetisches `throw` am Kopf der Interpreter-Schleife
ein (ein Flag, ein Register über dem Rahmen), so dass Handler und `defer` der Stelle greifen. Endet
der Rumpf mit genau diesem `Cancelled`, ist der `close` fertig; was ein `defer` dabei warf, wirft
er, das erste, der Rest hineinunterdrückt; ein anderer Fehler kommt heraus; ein `yield` danach und
ein `close` der laufenden paniken (`RT0014`). `Coroutine :: [Identity, Closeable]` in der Prelude,
`Cancelled` dazu (P17: Prelude oder `std.task`); `using let` schließt, eine fallengelassene
Koroutine warnt nicht. Ein `yield` außerhalb des eigenen Rumpfs (Regel 13) wird `yield.d` mit dem
Typschlüssel seines Werts (Debug-Text des Typs, je Programm nummeriert), `co.key` gibt der
Koroutine den ihres `Y`; jede `yield` wirft für die Mengen `Cancelled` (eine Funktion mit
geschriebenem `throws` deckt es, `SEM0034`). Format 12. Gefunden: `eq.r` verglich über `sameRef`,
das nur `ScriptObject`, `ScriptString` und `Nil` kennt — zwei Verweise auf eine Koroutine (und
einen Task) waren nie gleich (Probe vorher `false`); und ein Task war seit S6a in `Any`
umwandelbar, obwohl die VM ihn ohne Deskriptor hält — Tasks und Koroutinen sind bis S7 keine
Interfacewerte (Abweichung in Spec 10). Spec 10 Regeln 9–10, 13 Fälle, zwölf rot gegen S6b2 (der
dreizehnte, kein Interfacewert, ist ein Pin: unter S6b2 war die Koroutine gar nicht `Closeable`).
Sechs Mutanten in zwei Läufen, alle gefangen; eine Vorhersage vor dem Lauf korrigiert (ohne
Einschleusen läuft das `yield` erneut und paniert sofort), und `a_yield_after_the_close_panics`
bleibt unter diesem Mutanten aus dem falschen Grund grün — ein Panikfall vergleicht nur den Code;
die Unit-Tests fangen ihn. Tests 312 → 319, Fälle 264 → 277.

**S6c, Schnitt (2026-10-29).** Drei Teile. **S6c1** Abbruch: `task.cancel()` markiert, jedes
Warten im Task (`await`, `yieldNow`, das Ende des Top-Levels) wirft `Cancelled` — das, in dem er
steht, sofort, jedes spätere vor dem Warten (Lyric 5 10 §3 Regeln 1–3); ein Task, der mit
`Cancelled` endet, ist `Cancelled` und kein Scheitern; das erste Scheitern im Top-Level bricht die
Geschwister ab (07 End, §4 Regel 2); `spawnDetached { }`, auf den niemand wartet und der nur
`Cancelled` werfen darf (§2 Regel 3). **S6c2** `TaskScope`: `TaskScope.new()`, `scope.spawn`,
`close()` wartet, erstes Scheitern bricht ab, `scope.cancel()`, ein geschlossener Scope nimmt keinen
Task (§4). **S6c3** `TaskStatus<T>` mit Wert, Fehler und `PanicInfo`, `isDone()` (§2 Regeln 10–11,
§5). `withTimeout(d) { }` braucht die Uhr und wandert zu **S6d** (Zeit).

**S6c1, Ergebnis (2026-10-29).** `t.cancel()` (Op `task.cancel`) markiert den Task und nimmt ihn aus
dem Warten, in dem er steht (`waitingOn`: aus der Warteliste des anderen Tasks, zurück in die
Schlange). `await`, `yieldNow` und `join` prüfen am Anfang, ob ihr Task abgebrochen ist, und werfen
dann ein `Cancelled`, das die VM baut — das Modul nennt den Prelude-Typ (Format 13) —, über das
synthetische `throw` aus S6b3 an der Stelle des Wartens; ein `yield` kehrt dafür zum `yield` selbst
zurück (`yielded`). Ein Task, der mit `Cancelled` endet, ist `Cancelled` und kein Scheitern; das
erste Scheitern, Fehler oder Panik, bricht die übrigen Tasks des Top-Levels ab (07 End, endlich
gebaut). `spawnDetached { }` (Op `spawn.d`): nicht im `join`, sein Block bekommt die Klausel
`throws Cancelled` (`SEM0034` über den vorhandenen Abgleich), seine Panik beendet den Lauf. Für die
Mengen wirft `yieldNow()` `Cancelled`. Gefunden: der Konformanz-Runner kannte kein Zeitlimit — ein
Abbruch, der nie wirkt, hätte die Suite angehalten statt rot gemacht (die Gegenprobe gegen S6b3
hätte gehangen); jetzt 60 s je Aufruf, und ein Fall endet dann rot. Mutanten, die den Abbruch
ganz abschalten, würden aus demselben Grund hängen und blieben aus; sechs endliche in zwei Läufen,
alle wie vorher aufgeschrieben. Ein S6a-Test nahm ausgerechnet `cancel()` als Methode, die ein Task
nicht hat — Vorhersage verfehlt, Test auf `stop()`. Spec 10 Regeln 11–12, neun Fälle, alle rot gegen
S6b3. Tests 319 → 324, Fälle 277 → 286.

**S6c2, Ergebnis (2026-10-29).** `TaskScope.new()` (Op `scope.new`; der Checker fängt den statischen
Aufruf ab), `scope.spawn { }` (`spawn.s`, der Task gehört dem Scope statt dem Top-Level), `close()`
(`scope.close`: wartet wie `join` über die Tasks des Scopes, dann wirft er das erste Scheitern oder
paniert erneut; ein abgebrochener Task, der hier wartet, bricht die Tasks des Scopes ab und wartet
weiter, Regel 4), `scope.cancel()`; ein geschlossener Scope nimmt keinen Task (`RT0008`, Lyric 5s
Code der Panik). Das erste Scheitern eines Scope-Tasks bricht dessen Geschwister ab, nicht die des
Top-Levels. `TaskScope :: Closeable` in der Prelude, `using let` schließt ihn; kein Interfacewert
(wie Task und Koroutine). Format 14. Spec 10 Regel 13, acht Fälle, alle rot gegen S6c1; sechs
Mutanten in drei Läufen, alle wie vorher aufgeschrieben — drei davon (kein Abbruch der Geschwister,
keiner beim Warten in `close`, `scope.cancel` ohne Wirkung) hängen einen Fall auf und fallen über das
Zeitlimit des Runners, das S6c1 brachte. Tests 324 → 328, Fälle 286 → 294.

**S6c3, Ergebnis (2026-10-29).** `t.status()` ist `TaskStatus<T>` wie in Lyric 5 — `Running`,
`Done(value)`, `Failed(error)`, `Cancelled`, `Panicked(info)` mit `PanicInfo { code, message,
trace }` —, `t.isDone()` dazu. Der Checker baut den Wert aus der Zustandsnummer der VM als Kette
von `MakeVariant` über drei neue Ops, die einen beendeten Task ohne Warten und ohne
Abbruchprüfung lesen (`task.val`, `task.err`, `task.pinfo`); Format 15. `TaskStatus<T>` ist kein
`Equatable` (Lyric 5s auch nicht): die S6a/S6c1-Fälle und -Tests, die einen Status mit `==`
verglichen, matchen ihn jetzt. Spec 10 Regel 1 neu, vier Fälle dazu, zwei umgeschrieben; fünf
rot gegen S6c2, der sechste (`match` auf `.Cancelled`) ein Pin. Vier Mutanten in zwei Läufen; einer
blieb zweimal grün — erst lag der Wert noch vom `await` im Register, dann stand dort die Konstante
1, mit der die Kette `Done` erkennt, und der Task gab ebenfalls 1 —, der Fall nimmt jetzt 7. Eine
Probe-Vorhersage verfehlt: `TaskStatus.Running == …` meldet zuerst `SEM0060` (die generische
Variante braucht den Typ vom Ort), der Fall vergleicht zwei Status. Tests 328 → 330, Fälle 294 →
298.

**S6d, Schnitt (2026-10-29).** Drei Teile. **S6d1** `Channel<T>` und `Semaphore` in der VM.
**S6d2** `select`: `Select`/`Selection` als Prelude-Quelltext in Script (wie Lyric 5s `std.task`
sie in Lyric schreibt; source-first), über drei VM-Intrinsics — ein Kanal ist bereit, ein Task
beobachtet einen Kanal, ein Task parkt bis zur Regung eines beobachteten. **S6d3** Zeit:
`Duration`, `sleep`, `Timer.after`, `.timeout(d)` im Select, `withTimeout` (Prelude-Quelltext mit
eigenem `TaskScope`, damit ein scheiternder Arbeits-Task nicht den Lauf scheitern lässt) und der
Scheduler, der auf den frühesten Zeitgeber wartet.

**S6d1, Ergebnis (2026-10-29).** `Channel<T>.new(capacity)` (ungepuffert bei 0), `send`, `recv(): ?T`,
`close()`, `ChannelClosed` in der Prelude; `Semaphore.new(n)` mit `acquire`, `tryAcquire`,
`release`, `available`. Ein Kanal hält Puffer, wartende Empfänger und wartende Sender samt Wert;
`recv` antwortet in der Form von `?T` wie ein Pull. Ein schon übergebener Wert oder eine übergebene
Erlaubnis gehört dem Task, auch wenn ihn danach ein Abbruch weckt — der wirkt am nächsten Warten
(sonst ginge der Wert verloren). Ein Abbruch nimmt den Task auch aus den Wartelisten von Kanal und
Semaphor. Dazu ein statischer Aufruf auf einer Typinstanz, `Channel<int>.new(1)`, den es bisher
nicht gab. Format 16. Spec 10 Regeln 14–15, zehn Fälle, alle rot gegen S6c3; sechs Mutanten in zwei
Läufen, alle wie vorher aufgeschrieben (ohne Hänger: jede Verklemmung paniert mit `RT0018`). Ein
Fall kam beim Entwerfen der Mutanten hinzu: die Regel, dass der Wert eines wartenden Senders auf den
frei gewordenen Pufferplatz rückt, hatte keine Probe. Tests 330 → 336, Fälle 298 → 308.

**S6d2, Ergebnis (2026-10-29).** `Select.on(c) { v => … }.on(…) { … }.run()` ist Prelude-Quelltext in
Script: eine Kette von Fällen hinter dem Interface `SelectCase` (`ChannelCase<T>`: bereit?, beobachten,
feuern = `body(channel.recv())`), `Selection.on<T>` als generische Methode, `run()` feuert den ersten
bereiten Fall, sonst beobachtet es alle Kanäle und parkt. Die VM gibt dafür drei Intrinsics, die nur
Quelltext der Prelude rufen kann (`__chanReady`, `__chanWatch`, `__parkWatched`; Benutzercode sieht
die Namen nicht, `SEM0002`): `chan.ready`, `chan.watch`, `park.w`. Ein gepufferter Wert, ein Sender,
der zu warten beginnt, und ein `close` wecken die Beobachter eines Kanals; ein Abbruch nimmt den Task
von allen Beobachtungen. Format 17. Spec 10 Regel 16, sieben Fälle (einer kam beim Entwerfen der
Mutanten hinzu: ein Kanal, der schließt, während der Select wartet), alle rot gegen S6d1; fünf
Mutanten in zwei Läufen, alle wie vorher aufgeschrieben; „das Weck-Flag wird übergangen“ blieb als
äquivalent aus (nach dem Wecken ist die Beobachtungsliste leer, `park.w` läuft ohnehin weiter).
Tests 336 → 340, Fälle 308 → 315.

**S6d3, Ergebnis (2026-10-29).** Der Lauf hält seine Zeitgeber auf einer eigenen monotonen Uhr
(Lyric 5s `Monotonic`): vor jedem Schritt wecken die fälligen ihre Schläfer hinter den bereiten Tasks
— in der Reihenfolge ihrer Fristen — oder schließen den Kanal ihres `Timer`; ist kein Task bereit,
schläft der Lauf (Lyric-5-`sleep`) bis zum frühesten, erst ohne Zeitgeber ist es eine Verklemmung.
Ops `sleep`, `timer.after`; Format 18. `Duration` (privates Feld, `of…`-Funktionen), `sleep`,
`Timer.after`, `TimedOut`, `.timeout(d)` im Select und `withTimeout` sind Prelude-Quelltext;
`withTimeout` startet seinen Block in einem eigenen Scope, damit dessen Scheitern nur aus
`withTimeout` kommt und nicht den Lauf scheitern lässt (Script-Besonderheit: das Top-Level ist ein
Scope). Gefunden: `execute` fragte den VM-Task mit `yieldNow()` ab und hätte geschlafen; nach einem
erfolglosen Nachgeben schläft es jetzt eine Millisekunde. Und das Flag „das Programm startet Tasks“
setzte jedes `scope.spawn`, über die Prelude also jedes Programm — es endete mit einem `join`; das
fing der S6a-Test „nur ein Programm, das Tasks startet, endet mit `join`“, das Flag gehört jetzt
dem einfachen `spawn` allein (der erste Fix griff nicht: der Wächter des Patch-Skripts übersprang eine
Löschung, deren neuer Text im alten steckte). Spec 10 Regel 17, elf Fälle, alle rot gegen S6d2;
drei Mutanten in zwei Läufen, alle wie vorher aufgeschrieben; drei naheliegende blieben aus (bei
einem fälligen Zeitgeber ist die Reihenfolge gleich, ein Lauf ohne Schlafen kreist nur, ein beim
Abbruch stehengebliebener Zeitgeber ließe einen beendeten Task wieder anlaufen). Tests 340 → 343,
Fälle 315 → 326.

**S6e, Ergebnis (2026-10-29).** Ein wartendes Native startet einen abgekoppelten Lyric-5-Task und
parkt den Skript-Task (Op `read.line`, Format 19); der Lyric-5-Task legt ihn zurück in die Schlange
und meldet sich über einen Lyric-5-Kanal, auf den der Lauf wartet, wenn nichts bereit ist — mit dem
frühesten Zeitgeber als Timeout. Solange ein Native aussteht, gibt der Lauf bei jedem Schritt an
Lyric 5 ab, sonst verhungerte der Leser hinter einem Task, der nur `yieldNow()` ruft. Der erste
Nutzer ist `readLine()` der Prelude (07 V3 I8; aus der S7-Liste vorgezogen, wie die S6e-Zeile ihn
nennt): die nächste Zeile ohne Zeilenende, `null` am Ende; ein Lesefehler beendet die Eingabe bis
`std.io` `IoError` bringt (**S7**). Ein Abbruch beendet das Warten, eine danach gelesene Zeile fällt
weg. `sleep` „auf der Uhr“ kam anders als die Zeile sagt schon mit S6d3 (Zeitgeber-Schlange, im
Leerlauf Lyric-5-`sleep`); „ein Callback aus einem Native darf nicht warten“ setzt Callbacks voraus,
die erst die Host-API bringt (**S8**). Der Konformanz-Runner kann `stdin:`. Spec 10 Regel 18, fünf
Fälle, alle rot gegen S6d3; zwei Mutanten in zwei Läufen, beide gefangen — kein Abgeben an Lyric 5
über das Zeitlimit; ein Leser, der den Task nicht zurücklegt, dreimal über die Verklemmungspanik
(er senkt den Zähler offener Natives, der Lauf sieht also zu Recht eine Verklemmung) und nur einmal
über das Zeitlimit, anders als vorher aufgeschrieben; den Abbruch eines *wartenden* Lesens prüft
kein Fall — bei leerer Eingabe kommt das Dateiende zuvor, der Fall prüft den Abbruch vor dem Warten.
Tests 343 → 344, Fälle 326 → 331.

**S6, Abschluss (2026-10-29).** Abgleich der Bereichszeilen 07 End, Wait, N2–N9 und 11 Co gegen den
Code: gebaut sind N2 (Koroutinen, `next`/`result`/`isDone`/`close`, Generator-Lambdas, `sequence`),
N3 (Warten parkt den Task, auch im Generator), N4 (`spawn`, `Task<T>`, `await`, `status` mit Werten,
`Panicked`, `TaskScope`, `spawnDetached`), N5 (`Channel`, `select`, `sleep`, `Timer.after`,
`Semaphore`), N6 (ein Scheduler je Instanz; *standalone* pumpt die Laufzeit und wartet auf Zeitgeber
und Natives), N8 (kooperativ, `yieldNow`), N9 (`cancel`, `scope.cancel`, `withTimeout`, `Cancelled`
fangbar), End (Top-Level als Scope, das erste Scheitern bricht ab, `spawnDetached` nicht abgewartet)
und 11 Co (VM-Rahmen je Task, Natives über Lyric-5-Tasks). Mit Uhr woanders: `Coroutine :: Iterator`
und `for` über jedes Iterable, `os.signals` als Kanal mit dem Recht `os` (N5, Lyric 5 §12), `IoError`
für `readLine` und Tasks/Koroutinen/Kanäle als Interfacewerte (mit Deskriptoren) in **S7**; Wait
(eingebettet `call`/`start`/`step`), das Anhalten der Instanz samt Tasks über das Budget (N8, 01 S5b)
und Callbacks aus Natives in **S8**; P17 (Ort der Prelude-Namen) beim Maintainer. Entfallen wie
entschieden: N1, N7, N10, mit ihnen Lyric 5 §8 (Atomics), §9 (Threads), §10 `Mutex`/`RwLock`/`Once`
und §11 (Pools) — `Semaphore` schützt Abschnitte über Wartepunkte (02 W). Das Austrittskriterium,
ein nebenläufiges Beispiel, erfüllt `examples/concurrent/pipeline.lyrs` (Generator, Kanäle, drei
Arbeiter, Semaphor, `select` mit Timeout) als Schritt der CI auf allen vier Plattformen. Gefunden über
den Meilenstein: `join` nahm den ersten *gestarteten* scheiternden Task; `spawn(42)` ohne Diagnose;
zwei Codes außerhalb des Katalogs bzw. gegen Lyric 5s Nummer; `eq.r` hielt zwei Verweise auf eine
Koroutine nie für gleich; ein Task war in `Any` umwandelbar; die Lambda-Vorausschau kannte `<…>`
nicht (seit S3); der Runner hatte kein Zeitlimit; `execute` hätte im Leerlauf gekreist; jedes
`scope.spawn` markierte das Programm als Task-startend. Lehren: Wächter in Patch-Skripten (Löschung
gegen Einfügung), Testwerte, die keine Konstante der Nachbarschaft sind, Mutanten vor der Vorhersage
auf Beobachtbarkeit prüfen. 344 Tests, 331 Fälle; Bytecode-Format 19.

## S7 — Slices (Plan, Entwurf 2026-10-29)

Ziel aus der Meilensteintabelle: der std-Kern — die nativen Kerntypen und die Module, die die
Zielprogramme „Terminal-Werkzeug“ und „Automatisierung“ (02) brauchen, die feste Rechtetabelle,
die Kostenregeln der schweren Natives (01 S5c), dazu der Slice „Aufrufpfad der VM“ aus dem
Ergebnis von Messpunkt 1 und **Messpunkt 3**. Quellen: 12 Um, Src und die Einzelheiten; 03 S,
Str, Eq, Leer, Lit, Index; 05 Iteratoren und E7; 07 V3 I8; 01 S5c, S8; 11 V3, Gen, std. Die API
folgt Lyric 5s `std` (Namensgesetz N1–N13), angepasst an Script-Typen; was Lyric 5 nicht hat
(`BigInt`, `cli`, `csv`, `log`, `fs.glob`), entscheidet der Slice, der es bringt, nach 12. Mit
Uhr aus früheren Meilensteinen hierher: Array-Muster und `Hashable` (S3), `typeOf([1, 2])`
(S3i), Display mit den Prelude-Interfaces (S3), `e.suppressed()` (S4b), die Prelude-Zusätze
`eprintln`, `args`, `exit` und die feste Rechtetabelle (S5), `Coroutine :: Iterator`, `for` über
jedes Iterable, Tasks/Koroutinen/Kanäle als Interfacewerte, `IoError` für `readLine` und
`os.signals` (S6).

| Slice | Inhalt | Prüfung |
|---|---|---|
| **S7a std als Script-Module** | `import std.<m>` löst auf Quelltexte im Binary auf (`std/*.lyrs`, eingebettet mit Lyric 5s `comptime embed`): Logik in Script (12 Src), übersetzt wie ein Paket und mit dem Programm im Bytecode-Cache; *vorkompiliert* ins Binary (11 std) kommt mit `pack` (S13), das dieselbe Mechanik braucht — bis dahin übersetzt der erste Lauf nach einem Update die importierten std-Module mit. Natives der std als `__name(…)`-Intrinsics, nur in std-Dateien erkannt (wie die der Prelude seit S6), mit Signaturen aus einer Tabelle, die Checker und VM teilen. Die Rechtetabelle je Modul fest (12 Rechte) statt der vorläufigen aus S5e; die Testtabelle `LYRIC_SCRIPT_RIGHTS` retiriert mit ihr, ihre Fälle importieren echte Module | ein std-Modul importiert und gerufen; Rechte-Fälle gegen echte Importe |
| **S7b Listen** | `T[]` nativ in der VM (`ScriptArray`, getrennt für Skalare und Referenzen — `List<int>` ungeboxt, 11 Gen), `List<T>` als Alias; Literale, `[]` mit Leer-Inferenz (03 Leer), `FromArrayLiteral` (03 Lit); `xs[i]`, `xs[^n]`, `xs[i] = v` mit Bereichsprüfung, `xs[a..b]` kopiert (03 S); die Methoden von Lyric 5s `List` ohne die Sichten (`length()`, `push`, `pop`, `insert`, `remove…`, `contains` …), `+` und `xs * n` (12 Container), `in`/`!in`, `==` über `Equatable`-Elemente; `Index<K>`/`IndexSet<K>` für eigene Typen (03 Index); Array-Muster; `typeOf([1, 2])` sagt `int[]`; `e.suppressed()`; der Text einer Liste in der Debug-Form | Konformanzfälle; Kostenregeln für `+` und `xs * n` |
| **S7c Iteratoren** | generische Interfaces (`interface I<T>`, Lyric 5 §5 — seit S3 ohne Uhr, gefunden in S7b2b); `FromArrayLiteral<T>`; eine Liste als Interfacewert mit Deskriptor (`typeOf([1, 2])`); `Iterator { type Item; fn next(): ?Item }` ohne Fehlertyp (05), `Iterable`, `FromIterator`; `for` über jedes Iterable, auch eigene Typen, und `for` schließt `Closeable`-Iteratoren (05 E7); `Coroutine :: Iterator`; Tasks, Koroutinen und Kanäle als Interfacewerte mit Deskriptoren; `std.iter` in Script mit den Adaptern von Lyric 5s `iter` und den Listen-Methoden darüber (`map`, `filter`, `sortedBy`, `retain` …); `sort` nativ | Konformanzfälle; Kostenregel für `sort` |
| **S7d Map und Set** | `Map<K, V>` und `Set<T>` nativ, eine eigene Hash-Tabelle in Einfügereihenfolge (12 Src; 01 S8: keine Adress-Hashes), `string`-Schlüssel ohne Hülle (11 Gen); **Synthese** von `Equatable` und `Hashable` für Structs, Enums und Tupel, deren Felder es sind (03 Eq; `float` nicht `Hashable`), Klassen über `Identity` mit einer Objektnummer statt der Adresse; Map-Literal, `[:]` (`FromMapLiteral`), `m[k]` → `?V`, `m[k] = v`, `in`, die Methoden von Lyric 5s `Map`/`Set`; `Deque` und `Heap` in Script (12 Container) | Konformanzfälle; Reihenfolge mit mehr als einem Dutzend Einträgen |
| **S7e Strings und Formate** | die String-Methoden von Lyric 5s `core`/`string` an `string` (03 Str: `length()` in Bytes, `s[i]` das Zeichen ab Byte `i`, `s[a..b]` neu, `chars()`, `lines()`, `split`, `trim…`, `lower`/`upper`, `replace`, `repeat`, `Pattern` …), Zahlen aus Text; `Display` und `Debug` als Prelude-Interfaces, jeder Wert druckbar — `{x}` fällt auf `Debug` zurück (03 Eq); `std.fmt` mit Formatangaben in f-Strings (`{n:>6}`, `{x:.2}`, `{x:?}`); `print`/`println` für jeden Wert | Konformanzfälle; Kostenregeln für `repeat`, `replace`, `split` |
| **S7f Zahlen, `BigInt`, `Bytes`** | Konversion über `From`/`Into` (05 D6, P19) mit 05 §13 Regel 9; Typkonstanten am Typ (`int.max`, `float.epsilon`), `std.math` (Weltkonstanten, die Funktionen von Lyric 5s `math`), `checked*`/`saturating*`/`wrapping*` und `+% -% *%` (03 Überlauf); `BigInt` nativ (Lyric 5 hat keins: eine eigene Implementierung in der VM, 02 T1) mit Literalen über `FromIntLiteral`; `Bytes` mit `b"…"`, Index, kopierenden Slices, UTF-8 hin und zurück; `std.random` — geseedet ohne Recht, ungeseedet mit `os` (01 S8) | Konformanzfälle; Kostenregeln für `BigInt`-Multiplikation, -Division und -Text |
| **S7g I/O und Dateien** | `std.io`: `Reader`/`Writer` über `Bytes` (Go-Form), `IoError { kind }`, stdin/stdout/stderr, die `print`-Familie, `readLine()` wirft `IoError`; `eprintln` in der Prelude (07 V3 I8); `std.fs` als Adapter über Lyric 5s `fs` (wartende Natives über Lyric-5-Tasks wie seit S6e), `fs.glob` und `std.path` in Script | Konformanzfälle mit Dateien im Fallordner |
| **S7h Prozesse, Umgebung, Zeit** | `std.process` (`Command`-Struct, Lauf mit Ausgabe und Exit-Code), `std.os` (Umgebung; `signals` als Kanal mit dem Recht `os`), `args` und `exit` in der Prelude; `std.time` als Adapter über Lyric 5s `time` | Konformanzfälle |
| **S7i Batterien** | in Script, je eine API (12 Um): `std.test` (`assert…` nach Lyric 5s `test`; `@Test`, Subtests, `@Bench` und `lyric-script test` mit S11), `std.cli` (Argumente, Flags, Optionen, `--help`), `std.log`, `std.csv` (RFC 4180) | Konformanzfälle |
| **S7j Aufrufpfad der VM** | aus Messpunkt 1: Frames ohne `List`, aufgelöste Funktionstabelle, eine Wachstumsprüfung je Aufruf, Fuel an Rücksprüngen statt je Aufruf | Bench von S1 vorher/nachher, Erwartung vorab |
| **S7k Messpunkt 3** | Bench-Suite: die Programme von Messpunkt 1 als Script-Quelltext, dazu Programme über die Kerntypen (Wörter zählen, Sortieren, Map-Last, Strings bauen), je auch als 4.x-Programm; dieselbe Maschine; Ratchet ≥ 5× | Bericht `bench/README.md` mit Erwartung vorab und Kontrolle |
| **Abschluss** | die Zielprogramme Terminal-Werkzeug und Automatisierung (02) in der Form der entschiedenen API als Beispiele in der CI; STATUS, PR, CI, Merge, Tag `s7-complete`; Bereichszeilen gegen den Code | Zielprogramme in der CI auf allen Tier-1-Zielen |

Reihenfolge: a bis i in dieser Folge — Listen vor Iteratoren (Adapter liefern Listen), beide vor
Map und Set (`keys()`, `entries()`), Listen vor Strings (`split`), `Bytes` vor I/O; j unabhängig,
aber vor k; k zuletzt, wenn alle Kerntypen stehen. Ein Slice, der zu groß wird, wird wie in S5
und S6 geteilt, bevor er gebaut wird. **Kostenregeln**: jedes schwere Native rechnet proportional
ab (`budget.charge(n)`, 01 S5c) und bekommt seinen Test im Slice, der es bringt; das Prüfen der
Deadline in langen Schleifen kommt mit dem Budget (S8). **Spec**: Kapitel 12 wächst je Slice um
Regeln und Fälle; die Sprachteile (Literale, Index, `for`, Synthese) gehen in 03, 07, 08 und 09.
Austrittskriterium: die Zielprogramme laufen in der CI; Messpunkt 3 ≥ 5×.

**S7a, Ergebnis (2026-10-29).** Die Script-Quellen der std liegen in `std/` neben `src/` und kommen
über Lyric 5s `comptime embed` ins Binary (`src/stdsrc.lyr`: Modulliste, Quelltext je Name, die
Prelude); auch die Prelude ist jetzt eine Datei statt eines Strings im Checker. `import std.<m>`
nimmt nie eine Datei des Programms oder ein Paket — ein Pfad mit `std` vorn geht in die Tabelle,
ein fehlendes Modul ist `RES0003`; die Module bilden ein eigenes Paket (`internal` bleibt ihres)
und werden mit dem Programm übersetzt, ihr Text geht also in den Cache-Schlüssel. Natives der
std: `__os_env(name)` im Rumpf einer std-Funktion ruft `os.env` der VM-Tabelle, der Typ ist die
Signatur der Funktion; der Codegenerator vergleicht die Slots mit der Tabelle. Erste Module:
`std.os` (`env`) und `std.fs` (`exists`), Format 20. Die Rechtetabelle ist fest (Spec 17 Regel 1):
`std.fs` → `file`, `std.net`/`std.http` → `net`, `std.process` → `process`, `std.os`, `std.time`
und `std.random` → `os` — `std.random` nur bis S7f, das den geseedeten Generator vom System
trennt —, jedes andere Modul nichts; `LYRIC_SCRIPT_RIGHTS` retiriert, die Rechte-Fälle
importieren echte Module. Gefunden: der Runner ignorierte `stderr-has:` in einem abgelehnten
Fall still (ein neuer Fall war darum gegen S6 grün) — er liest jetzt die Diagnosen. Spec 12
Regel 2, vier Fälle neu, drei Rechte-Fälle umgeschrieben und einer dazu; sieben rot gegen S6, der
achte (nur die std erreicht die Natives) hütet den Zugang. Mutanten in drei Läufen: alle
gefangen, einer zusätzlich von einem S6d2-Test, den die Vorhersage vergessen hatte; das Entfernen
der Slot-Prüfung ist heute unbeobachtbar (kein Native weicht ab). Tests 344 → 348, Fälle 331 → 336.

**S7b, geteilt (2026-10-29).** Zu groß für einen Slice; drei Teile. **S7b1** das Listen-Objekt der
VM, Literale mit dem Typ des Orts, Index lesen und schreiben, `length`/`push`/`pop`, `for` über
eine Liste, die Debug-Form. **S7b2** die übrigen Methoden von Lyric 5s `List` ohne Sichten, `^n`,
kopierende Slices, `+`, `xs * n` (Kostenregeln), `in`/`!in`, `==`, das leere Literal mit der
ersten Verwendung (03 Leer), `FromArrayLiteral`, eine Liste als Interfacewert mit Deskriptor,
`typeOf([1, 2])`, `e.suppressed()`. **S7b3** `Index<K>`/`IndexSet<K>` für eigene Typen und die
Array-Muster.

**S7b1, Ergebnis (2026-10-29).** `ScriptArray` hält die Skalar- und die Referenz-Slots seiner
Elemente getrennt, `ns` und `nr` je Element (`List<int>` ungeboxt, ein Tupel als seine Slots);
zehn Ops (`list.new`, `list.push`, `list.get.s/.r/.n`, `list.set.s/.r/.n`, `list.len`,
`list.pop`), die Ein-Slot-Formen am Ort, die mehrteiligen über Index und Liste an den Basen;
Format 21. Im Compiler ein `TExpr.ListOp` für alle Operationen und ein `Place.Item` für
`xs[i] = v` und `xs[i] op= v` (Liste und Index einmal ausgewertet). Ein Literal hat den Typ des
Orts, sonst den seiner Elemente — ein `int` unter `float`s wird `float` (03 Mix) —; `[]` braucht
den Ort bis S7b2. `for (x in xs)` ist eine Indexschleife über die einmal gehaltene Liste, die
Länge vor jedem Schritt gelesen, die Bindung je Element frisch. Die Debug-Form ist eine
Funktion je Listentyp; über einem Typparameter erst mit S7c. Ein Index außerhalb ist
`LYS-RT0003` (Lyric 5s Nummer). Was bis S7b2 fehlt — `==`, eine Liste als Interfacewert —, sagt
jetzt `NYI0001` statt eines Fehlers, der wie eine Regel klang; ein Pin auf „Listenliteral noch
nicht“ retirierte mit seiner Regel. Spec 03 Regeln 16–17, 07 Regel 6, 08 Regel 3, acht Fälle,
alle rot gegen S7a; drei VM-Tests in Assembler halten die Konvention der Basen fest. Vier
Mutanten in einem Lauf, alle wie vorhergesagt gefangen; ein fünfter (`pop` ohne die Kennung der
schlichten Referenz) ist äquivalent. Tests 348 → 351, Fälle 336 → 344.

**S7b2, geteilt (2026-10-29).** **S7b2a** `extend<T> T[]` (eine Sprachlücke: der Block meldete
`SEM0124`, obwohl 03 ihn entschieden hat), die Methoden in Script, Operatoren, Slices; **S7b2b**
`^n` und offene Bereiche, das leere Literal mit der ersten Verwendung (03 Leer),
`FromArrayLiteral`, eine Liste als Interfacewert mit Deskriptor, `typeOf([1, 2])`,
`e.suppressed()`.

**S7b2a, Ergebnis (2026-10-29).** Ein eingebauter Typeintrag `List` mit einem Typparameter trägt
die Methoden aller Listen; `extend<T> T[] { … }` (auch `List<T>`) fügt hinzu, `this` ist die
Liste, der Empfänger bindet das Element, und die Kopien bekommen ihre Deskriptoren als versteckte
Parameter, weil eine Liste keinen hält. Die Methoden, die nicht vergleichen, stehen in Script in
der Prelude (`isEmpty`, `get`, `first`, `last`, `pushAll`, `insert`, `removeAt`, `removeWhere`,
`clear`, `truncate`, `swap`, `reverse`, `reversed`, `fill`), ebenso die Helfer von `+`, `*` und
Slices; drei Intrinsics dazu (`__listTruncate`, `__listChanges`, `__listCheck`) und
`__boundsPanic` für `RT0003` aus Script. `__`-Namen nennt nur die Bibliothek. **Abweichung vom
Plan:** `Equatable` gibt es in Script noch nicht als Interface (S3h synthetisiert Gleichheit je
Typ), also schreibt der Checker `contains`, `indexOf`, `remove`, `dedup`, `==` und `in` je
konkretem Elementtyp; über einem Typparameter erst mit S7d. Kostenregeln für `+` und `xs * n`
entfallen: sie sind Bytecode, den das Fuel zählt, kein Native. **Korrektur an S7b1:** dessen `for`
besuchte nachgeschobene Elemente — eine Erfindung; Lyric 5s `List`-Iterator paniert nach einer
Längenänderung (`RT0016`), also zählt die Liste jetzt ihre Änderungen (`list.changes`,
`list.check`, Format 22) und jeder Schritt prüft. Typnamen klammern `(?int)[]` und
`(fn() -> int)[]`. Spec 03 Regel 16, 05 Regel 12, 07 Regel 6, 08 Regel 3; elf Fälle neu, einer
umgeschrieben; alle rot gegen S7b1 außer dem umgeschriebenen `for` (dessen andere Hälfte). Vier
Mutanten: einer überlebte wie vorhergesagt (Element an Index 0), einer gegen die Vorhersage (der
Deskriptor-Fall brauchte den Deskriptor gar nicht — der Text eines `T` geht über die Tabelle des
Werts); beide Fälle geschärft, beide Mutanten danach gefangen; ein Unit-Test fing einen dritten
mit, den die Vorhersage nur dem Fall zugeschrieben hatte. Tests 351 → 353, Fälle 344 → 355.

**S7b2b, Ergebnis (2026-10-29).** In den Klammern einer Liste zählt `^n` vom Ende — Lesen,
Schreiben, Bereichsenden; die Liste wird dafür einmal gehalten —, und ein Bereich darf seine
Enden auslassen (`xs[a..]` ist `xs[a..^0]`, `xs[..b]`, `xs[..]`); der Parser kennt `^` nur dort
(`Expr.FromEnd`). `var xs = []` und `let xs = []` nehmen den Typ der ersten festlegenden
Verwendung (03 Leer) über den zweiten Durchlauf, den `var x = null` schon hat: ein `push`, eine
Zuweisung, die Bindung an einer Stelle, die eine Liste nimmt; sonst `SEM0010` mit dem zu
schreibenden Typ. `e.suppressed()` an der Bindung einer Klausel ist ein `Error[]` (Op
`list.supp`, Format 23). **Gefunden:** der erste Durchlauf verwirft die Funktionen, die er
schreibt, aber die Caches synthetisierter Funktionen behielten deren Indizes — neben `var x =
null` auf oberster Ebene druckte `println(P { a = 1 })` eine leere Zeile (seit S3b/S3h);
`dropFunctionsFrom` räumt jetzt jeden Cache. **Lücke ohne Uhr gefunden:** generische Interfaces
(`interface I<T>`, Lyric 5 §5; 03 übernimmt Lyric 5s Generics) lehnt der Parser ab, und kein Plan
nennt sie — Uhr jetzt **S7c**, wo `FromIterator<T>` sie braucht; mit ihnen gehen
`FromArrayLiteral<T>` (Mitglied `fromArrayLiteral` nach der Namensregel von Spec 03 Regel 14)
und die Liste als Interfacewert mit Deskriptor samt `typeOf`-Prüfstein dorthin, die dieselbe
Tabellenmechanik brauchen (P18). Spec 03 Regel 8, 06 Regel 10, 08 Regel 3; sieben Fälle, alle rot
gegen S7b2a. Vier Mutanten in einem Lauf, alle wie vorhergesagt. Fälle 355 → 362.

**S7b3, Ergebnis (2026-10-30).** `Index<K>`/`IndexSet<K>` sind in Lyric 5 generische Interfaces
und gehen mit P18 nach S7c; S7b3 sind die Listenmuster (Lyric 5 §9s Array-Muster): `[p, q]`,
`[first, ..rest]`, `[a, .., z]`, ein `..` höchstens (`LYS-PAR0033`, gemeldet ohne Abbruch wie in
Lyric 5), vor dem `..` von vorn, danach vom Ende gezählt, `..name` eine Kopie (09 Y6), die Länge
vor jedem Element geprüft, durch ein Optional hindurch, in `match`, `let … else`, `if let`. Die
Abdeckung zählt Längen wie Rust: jede Länge bis zur ersten, die kein Muster ohne `..` erreicht
und jedes mit `..` deckt, diese für alle längeren (`Space.Seq`); der Zeuge zeigt `[_, _, ..]`.
Spec 09 Regel 5, acht Fälle, alle rot gegen S7b2b. Vier Mutanten in drei Läufen (drei hätten
denselben Fall getroffen), alle wie vorhergesagt; ein Lauf griff erst nicht, weil `fmt` eine
Zeile des Ankers umgebrochen hatte. **Gefunden in der eigenen Arbeit:** das Aufräumen aus S7b2b
löschte aus `instances` auch Typinstanzen (Schlüssel `type …`, Werte Typindizes), sobald ein
Typindex über der Funktionszahl lag — `Box<S299>` gab es dann zweimal (`SEM0001`); ein Test mit
300 Typen war rot, ist es nach dem Fix nicht mehr. Tests 353 → 354, Fälle 362 → 370.

**S7b, Abschluss (2026-10-30).** Listen sind gebaut: das native Objekt mit Slots je Element,
Literale, Index mit `^n`, Slices mit offenen Enden, die Methoden von Lyric 5s `List` (in Script
über `extend<T> T[]`, vergleichende je Elementtyp synthetisiert), `+`, `*`, `in`, `==`, `for` mit
Lyric 5s Änderungspanik, das leere Literal über die erste Verwendung, `e.suppressed()`, Muster.
Mit Uhr woanders: `Index<K>`/`IndexSet<K>`, `FromArrayLiteral<T>`, eine Liste als Interfacewert
und `typeOf([1, 2])` mit den generischen Interfaces (**S7c**, P18); die vergleichenden Methoden
über einem Typparameter mit `Equatable` als Interface (**S7d**); `sort` mit den Iteratoren
(**S7c**). Gefunden über den Teil-Meilenstein: der erfundene „nachgeschobenes Element wird
besucht“-Satz von S7b1 (Lyric 5 paniert), veraltete Funktionen nach dem ersten Durchlauf von 03
Leer (seit S3b/S3h), die fehlenden generischen Interfaces (seit S3), der Runner, der
`stderr-has:` in Ablehnungen überging. 354 Tests, 370 Fälle; Bytecode-Format 23.

**S7c, geteilt (2026-10-30).** S7c trägt jetzt die generischen Interfaces (P18) vor den Iteratoren;
fünf Teile, jeder braucht den vorigen.

| Slice | Inhalt | Prüfung |
|---|---|---|
| **S7c1 Generische Interfaces** | `interface I<T> { … }` (Lyric 5 §5): Typparameter am Interface, Instanzen `I<int>` als eigene Interfaces mit eigener Tabelle, Konformanz `:: [I<int>]` am Typ und im Extend-Block, Constraints `T :: [I<int>]`, `I<int>` als Wert (Interfacewert), Defaults über `T`; Objektsicherheit wie für `Self` | Konformanzfälle |
| **S7c2 Index und Literal** | `Index<K>`/`IndexSet<K>` in der Prelude: `x[k]`, `x[k] = v`, `x[k] op= v` auf eigenen Typen (03 Index), Objekt und Schlüssel einmal ausgewertet; `FromArrayLiteral<T>` mit `fromArrayLiteral` (Namensregel Spec 03 Regel 14) | Konformanzfälle |
| **S7c3 Werte ohne Deskriptor** | eine Liste als Interfacewert (Deskriptor `T[]`, Tabelle des `List`-Eintrags je Element, `is int[]`, Debug über `Any`), Konformanzen `extend<T> T[] :: [I]`; Tasks, Koroutinen, Kanäle als Interfacewerte (Uhr aus S6) | Konformanzfälle |
| **S7c4 Iteratoren** | (aus S7c3: Tasks, Koroutinen, Kanäle und Listen eines Typparameters als Interfacewerte) `Iterator { type Item; fn next(): ?Item }` ohne Fehlertyp (05), `Iterable`, `FromIterator<T>`, `collect()`; `for` über jedes Iterable, `Closeable`-Iteratoren geschlossen (05 E7); `T[] :: Iterable` mit der Änderungspanik; `Coroutine :: Iterator` | Konformanzfälle |
| **S7c5 Vergleiche und Operatoren** | (05 D6, ohne Uhr seit S3 — P19) `Equatable`, `Ordered` (`?Ordering`), `TotalOrder` als Prelude-Interfaces, synthetisiert für Structs, Enums und Tupel, deren Felder es sind (03 Eq; `float :: TotalOrder`), `==`/`<` … über sie, die vergleichenden Listen-Methoden über einen Typparameter; Operator-Interfaces `Add<Rhs = Self> { type Out = Self }` …, `Neg`, `Contains<T>` (`in`, `!in`), `+=` abgeleitet, `++`/`--` als Ausdrücke; gemischte Arithmetik über eingebaute Konformanzen (03 Mix) | Konformanzfälle |
| **S7c5d Mehrere Instanzen** | (aus S7c5c, 05 Regel 13) mehrere Instanzen eines generischen Interfaces an einem Typ (Lyric 5 05 §3 Regeln 4–5: Mitglieder je Block, `SEM0122`; nebeneinander je Instanz), Antworten je Konformanz-Instanz (§8 Regel 3), die eingebauten gemischten Konformanzen (`int :: Add<float>`, 03 Mix) | Konformanzfälle |
| **S7c6 `std.iter`** | `Range<T>` als Wert (`let r = 1..5`, `x in r`, `r.iter()` — die NYI-Uhr zeigte auf S3, gefunden in S7c5c3), die Adapter von Lyric 5s `iter` in Script, die Listen-Methoden darüber (`map`, `filter`, `sortedBy`, `retain` …), `sort` nativ über `TotalOrder` mit Kostenregel; der Platzhalter `_` unter Typargumenten (Lyric 5 §9.2 Regeln 4–5, §9.3 Regel 2) | Konformanzfälle; Kostenregel für `sort` |

**S7c1, geteilt (2026-10-30).** **S7c1a** generische Interfaces ohne `Self` und ohne Defaults;
**S7c1b** `Self` in einem generischen Interface (seine Mitglieder generisch über die Parameter
und `Self` zugleich) und Default-Mitglieder über `T` — beides brauchen `FromArrayLiteral<T>`
(statisch, gibt `Self`) und `Index<K>` (`Self.Output`).

**S7c1a, Ergebnis (2026-10-30).** `interface I<T, …>` deklariert Typparameter (mit Constraints
wie eine generische Funktion); seine Mitglieder sind generisch über sie wie die Methoden eines
generischen Typs. `I<int>` — in einer Konformanz, einem Constraint, als Elternteil oder als Typ
eines Werts — ist eine Instanz über `typeInstance`, ein Interface eigenen Rechts mit den Slots der
Vorlage; Eltern einer Instanz werden bei Bedarf an ihren Argumenten gebildet (`parentsOf`), weil
eine Instanz vor den Eltern der Vorlage entstehen kann. Eine Konformanz prüft die Signaturen an den
Argumenten der Instanz; ein Aufruf über einen `I<int>`-Wert oder ein `T :: [I<int>]` belegt die
Typparameter des Mitglieds mit den Argumenten der Instanz, die es deklariert (`memberBinds`).
Ein generischer Typ konformiert an seinen eigenen Parametern (`class Cell<T> :: Store<T>`), jede
Instanz an ihren Argumenten (`ifaceAt`). Gefunden beim Bauen: die Typparameter einer generischen
Funktion wurden an einer zweiten Stelle nur über den Namen aufgelöst; `Source<T>` in einer
generischen Funktion fällt über die Abkürzung „eigene Parameter“ auf die Vorlage zurück — die
Vorlage steht darum für sich selbst an ihren Parametern. Spec 05 Regel 15, fünf Fälle, alle rot
gegen S7b. Vier Mutanten in zwei Läufen, alle wie vorhergesagt. Fälle 370 → 375.

**S7c1b, Ergebnis (2026-10-30).** Ein Mitglied eines Interfaces, das über `Self` generisch ist,
nimmt `Self` zuerst und die Parameter des Interfaces danach (`selfFirst`) — so bleiben `Self =
Param(0)` und alle Stellen, die es so belegen, gültig; ein Aufruf belegt `[Self] ++ Argumente
der Instanz` (`bindsOf`), an allen acht Stellen, die vorher nur `[t]` kannten. Ein Default über
`T` wird je Konformer an den Argumenten seiner Instanz kopiert: `conform()` merkt sich je Slot
die Argumente (`slotArgs`), `tableSelf`/`tableInstance` kopieren damit (`selfCopyIn`), auch für
die Instanzen eines generischen Konformers; auf dem Konformer selbst liest eine Instanz die
Interfaces ihrer Vorlage an ihren Argumenten (`ifacesOf`). Der `Self`-Constraint eines Mitglieds
nennt die Vorlage: eine Instanz zählt als Konformanz zu ihr (`isOf`). Gefunden: ein Anker, dessen
Ersatz anderswo schon stand, hätte das Patch-Skript als erledigt übersprungen — der Trockenlauf
fing es. Spec 05 Regel 15 ergänzt, zwei Fälle, beide rot gegen S7c1a. Drei Mutanten in zwei
Läufen, alle wie vorhergesagt. Fälle 375 → 377. **S7c1 fertig** (P18 gebaut).

**S7c2, Ergebnis (2026-10-30).** Die Prelude deklariert `Index<K>` (`type Output`, `fn
index(k: K): Self.Output`), `IndexSet<K> :: Index<K>` (`fn setIndex(k: K, v: Self.Output)`) und
`FromArrayLiteral<T>` (`static fn fromArrayLiteral(items: T[]): Self`, das Mitglied nach der
Namensregel von Spec 03 Regel 14). `x[k]` auf einem eigenen Typ ist ein Methodenaufruf
`index` — damit gelten alle Wege: am Typ, über einen Constraint, über einen Interfacewert —,
`x[k] = v` ist `setIndex`, `x[k] op= v` hält `x` und `k` in verborgenen Lokalen; was kein
`Index` ist, `SEM0007` (Lyric 5s Nummer und Bedeutung, der Katalogeintrag erweitert), was kein
`IndexSet`, `SEM0019`. Ein Listenliteral an einer Stelle, deren Typ `FromArrayLiteral<T>`
ist, wird als Liste von `T` an dessen `fromArrayLiteral` gegeben; über einen Typparameter mit
der Instanz aus seinen Constraints (`instanceFor`). **Gefunden beim Bauen:** assoziierte Typen
in einem generischen Interface wurden an der Instanz gelesen (`assocNames`, Schranken,
Defaults, das Interface eines `Ty.Assoc`) — jetzt an der Vorlage; erst damit trägt `Index<K>`
sein `Output`. Spec 03 Regel 14, 08 Regel 4; vier Fälle, alle rot gegen S7c1b. Drei Mutanten
in einem Lauf, alle wie vorhergesagt. Fälle 377 → 381.

**S7c3, Ergebnis (2026-10-30).** Eine Liste ist ein Interfacewert in einer Box wie ein Skalar oder
ein String; der Typ der Box ist ein Eintrag je Elementtyp, eine Instanz des `List`-Eintrags
(`entryOf`), mit eigener Tabelle — `Any`, `x is int[]`, die Debug-Form über die Tabelle — und
`extend<T> T[] :: [I]` macht jede Liste zu einem `I`, als Wert und über einen Constraint.
**Gefunden beim Bauen:** die Box eines eingebauten Typs hatte nur für `string` einen
Referenzslot (die Box einer Liste brachte die VM zum Absturz); ein generischer Unboxer hielt
seinen Rumpf in `body` statt in `template` (seine Kopien waren leer); `memberCallOn` rief die
generische Methode einer Liste ohne Kopie; Extend-Blöcke auf `T[]` meldeten ihre Konformanzen
nie an. Eine Liste eines Typparameters als Interfacewert braucht ihren Deskriptor zur Laufzeit —
mit **S7c4**, wohin auch Tasks, Koroutinen und Kanäle als Interfacewerte gehen: `Coroutine ::
Iterator` zieht deren Methoden in die Prelude, erst dann tragen ihre Tabellen. Spec 03 Regel 16,
05 Regel 12; zwei Fälle, beide rot gegen S7c2. Vier Mutanten in drei Läufen, alle wie
vorhergesagt; ein fünfter (der Referenzslot der Box) zeigte sich beim Bauen. Fälle 381 → 383.

**S7c4, geteilt (2026-10-30).** **S7c4a** `Iterator`, `Iterable`, `for` über beide, `T[] ::
Iterable`; **S7c4b** `Coroutine :: Iterator` und Tasks, Koroutinen, Kanäle als Interfacewerte —
ihre Methoden wandern dafür als Funktionen über Intrinsics in die Prelude; **S7c4c**
`FromIterator<T>` mit `collect()` (ein generisches statisches Mitglied eines Interfaces, das
über `Self` generisch ist — seit S3i NYI), die Blanket-Blöcke (`extend<I :: [Iterator]> I ::
[Iterable<Iter = I>]`, 05 Regeln 6–9) und Listen eines Typparameters als Interfacewerte.

**S7c4a, Ergebnis (2026-10-30).** Die Prelude deklariert `Iterator` (`type Item`, `fn next():
?Self.Item`, ohne Fehlertyp — 05) und `Iterable` (`type Iter :: [Iterator]`, `fn iter():
Self.Iter`). `for (x in e)` über ein `Iterator` ist `while (let x = e.next())` über `e`, einmal
gehalten, über ein `Iterable` über dessen `iter()`; ist der Iterator ein `Closeable`, schließt
ihn ein `defer` an jedem Ausgang (05 E7); sonst `SEM0007`. Jede Liste ist ein `Iterable`
(`extend<T> T[] :: Iterable` mit `ListIter<T>`, das nach einer Längenänderung wie die Schleife
paniert). **Gefunden beim Bauen:** `classifyInterfaces` löste jeden Interfacenamen im Modul des
letzten Items auf — ein eigenes `Iterator` des Skripts bekam die Klassifizierung der Prelude, die
Prelude brach (seit S3i, latent, bis die Prelude ein Interface trug, das Skripte selbst
schreiben); ein generischer Extend-Block trug die Antworten seiner assoziierten Typen nie ein;
die Debug-Form eines `T[]`-Felds in einem generischen Typ war NYI — jetzt eine Schleife am Ort.
Spec 03 Regel 16, 07 Regel 7; fünf Fälle, alle rot gegen S7c3. Vier Mutanten in einem Lauf, alle
gefangen; einer traf drei Fälle mehr als vorhergesagt (die S3i-Fälle schreiben ihr eigenes
`Iterator`, wie die Unit-Tests). Fälle 383 → 388.

**S7c4b, Ergebnis (2026-10-30).** `Coroutine<Y, R> :: Iterator` mit `type Item = Y`; ihre Methoden,
die eine Tabelle erreicht, sind jetzt Funktionen der Prelude über Intrinsics (`__coNext`,
`__coClose`, `__scopeClose` — dieselben Ops wie der statische Aufruf). Tasks, Koroutinen,
Scopes, Kanäle und Semaphore sind Interfacewerte: die VM hält sie ohne Deskriptor, also trägt
ihn eine Box wie bei Listen (S7c3; Kennung `vmHeld`, Box mit Referenzslot); `x is Task<int>`,
die Debug-Form `<Task>`. Damit die Tabelle des rohen VM-Objekts nie gefragt wird, sind solche
Typen keine geteilte Form: jede Instanz bekommt ihre Kopie. Die Pins aus S6 („kein
Interfacewert“) retirieren mit ihrer Regel: zwei Unit-Zusicherungen erwarten jetzt keinen
Fehler, ein Konformanzfall entfällt. Spec 10 Regeln 8 und 19, die Abweichung zurückgezogen;
zwei Fälle, beide rot gegen S7c4a. Vier Mutanten in drei Läufen, alle wie vorhergesagt.
Fälle 388 → 389.

**S7c4c, geteilt (2026-10-30).** Vor `FromIterator<T>` (ein generisches statisches Mitglied) und
den Adaptern (`map<U>` …) fehlte die Grundlage: **S7c4c1** generische Methoden generischer
Besitzer; **S7c4c2** `FromIterator<T>`, `collect()`, die Blanket-Blöcke, Listen eines
Typparameters als Interfacewerte.

**S7c4c1, Ergebnis (2026-10-30).** **Lücke seit S3, ohne Uhr:** eine generische Methode eines
generischen Typs (`fn map<U>` in `Box<T>`) meldete „'T' names no type“ — die eigenen Parameter
ersetzten den Scope des Besitzers; generische Mitglieder eines Interfaces mit `Self` waren NYI
(S3i). Jetzt sind die Parameter des Besitzers zuerst — die eines generischen Typs, `Self` und die
eines Interfaces, die eines Extend-Blocks (`outerParams`) —, die eigenen danach; ein Aufruf belegt
die des Besitzers als Präfix, der Rest kommt aus den Argumenten. Die Deskriptoren einer Kopie
teilen sich auf (`fromThisAt`): die eines generischen Typs und `Self` vom Empfänger, die eigenen
und die eines generischen Interfaces als versteckte Parameter; eine Tabellenkopie ist darum
immer exakt (ein Aufruf über die Tabelle reicht keinen versteckten Deskriptor). Spec 03 Regel
12, 05 Regel 10; drei Fälle, alle rot gegen S7c4b. Drei Mutanten in drei Läufen, alle wie
vorhergesagt. Fälle 389 → 392.

**S7c4c2, neu geschnitten (2026-10-30).** `collect()` als Mitglied von `Iterator` hätte
`Iterator` zur reinen Constraint gemacht (ein generisches Mitglied, `SEM0126`), kein
`Iterator<Item = int>` mehr als Werttyp — Lyric 5 legt es darum in den Blanket-Block
`extend<I :: [Iterator]> I`. Die Blanket-Blöcke mit Mitgliedern (05 §13 Regel 7) gehen deshalb
in **S7c4c2**; ihre Konformanzen (Regeln 8–9), ihre statischen Mitglieder, ein Block auf einer
Instanz und Listen eines Typparameters als Interfacewerte in **S7c4c3**. Der Platzhalter `_`
unter Typargumenten (Lyric 5 §9.2 Regeln 4–5, §9.3 Regel 2) hat bisher keine Uhr: **S7c5**, wo
die Adapter viele Typargumente tragen.

**S7c4c2, Ergebnis (2026-10-30).** Die Prelude deklariert `FromIterator<T>` (`static fn
fromIter<I :: [Iterator<Item = T>]>(it: I): Self`), jede Liste ist eines ihres Elements, und
`collect<C :: [FromIterator<I.Item>]>()` steht im Blanket-Block über jedem Iterator. Dafür:
Lyric 5 §9.2 Regel 2 — der erwartete Typ bindet, was die Argumente offen lassen, ohne sie zu
überstimmen — und Regel 4 — Typargumente am Methodenaufruf, die eigenen nach denen des
Empfängers (`SEM0026` bei anderer Zahl); Blanket-Blöcke mit Mitgliedern, der Empfänger bindet
den Zielparameter, eine Fixierung die übrigen (`SEM0170` für einen, den nichts bindet,
`SEM0168` für ein vom Typ verdecktes Mitglied, `SEM0121` für zwei Blöcke eines Namens); ein
Interface-Mitglied mit eigenen Typparametern wird gegen das des Konformers geprüft (gleich
viele, gleich beschränkt, `SEM0042`) und über einen Typparameter für das Argument kopiert.
**Gefunden beim Bauen:** (1) **Lücke seit S3, ohne Uhr:** der Schlüssel der Instanzen und
Kopien war der angezeigte Name — jeder Typparameter hieß `T`, ein Typ nur bei seinem Namen:
`Pair<B, A>` und `Pair<A, A>` in einem Generic waren *eine* Instanz („expected B, found A“),
`Holder<a.Item>` und `Holder<b.Item>` aus zwei Modulen auch; jetzt `tyKey`, injektiv. (2) Die
Arität eines generischen Interfaces stand erst mit seiner Deklaration — zwei, die einander
nennen (`Iterator`, `FromIterator`), scheiterten; jetzt ein Vorlauf. (3) Eine generische
Konformanz der Listen (`T[] :: FromIterator<T>`) wurde nie am Element gelesen. (4) Ein
statisches Mitglied mit eigenen Typparametern lief in einer geteilten Kopie über die Tabelle,
deren Kopie das eigene `I` mit `Self` band (`Sum.build` gab 0, ein eigenes `fromIter` lief nie);
ein Constraint mit einem solchen Mitglied macht die Kopien jetzt exakt, wie assoziierte Typen.
(5) Die übrigen Methoden einer Koroutine erreichten ihre Prelude-Klasse nicht. Spec 03 Regeln
12, 16; 05 Regeln 12, 15; 07 Regel 7; zwölf Fälle, elf rot gegen S7c4c1 — der zwölfte hält das
`SEM0042` einer falschen Implementierung fest, das vorher für jede kam. Fünf Läufe mit sieben Mutanten: vier wie vorhergesagt; im fünften machte der alte Schlüssel auch `an_iterator_collects` rot — die Instanzen der Prelude selbst (`FromIterator` an verschiedenen Parametern) kollidierten, `collect` braucht den injektiven Schlüssel.
Fälle 392 → 404.

**S7c5/S7c6 und S7f, neu geschnitten (2026-10-30). Lücke seit S3, ohne Uhr (P19):** 05 D6
entscheidet die Operator-Interfaces (`Add<Rhs = Self> { type Out = Self }` …), `++`/`--` als
Ausdrücke, `+=` abgeleitet, `Equatable`, `Ordered`, `TotalOrder`, `Contains` und die Konversion
über `From`/`Into`; die S3f-Präzisierung schob die Operatoren „mit S3h“, S3h nahm sie nicht
auf, keine Zeile nannte sie. Da `sort` ein `TotalOrder` braucht und `Ordered :: [Equatable]`
ist, kommen die Vergleiche als Interfaces und die Operatoren als **S7c5** vor `std.iter`, das
**S7c6** wird; S7d behält Map, Set und `Hashable` (die Synthese von `Equatable` kommt mit S7c5).
`From`/`Into` gehen mit 05 §13 Regel 9 (ein Parameter, den nur die Konformanz nennt — ihr
einziger Nutzer, `extend<T, U :: [From<T>]> T :: [Into<U>]`) nach **S7f**, zu den Zahlen.

**S7c4c3, Zuschnitt (2026-10-30).** Blanket-Konformanzen (05 §13 Regel 8: der Block gibt `J`
jedem Typ, den seine Constraints zulassen — Constraints, Werte von `J` mit den Mitgliedern des
Blocks, Antworten aus der Fixierung der Konformanz, `extend<I :: [Iterator]> I ::
[Iterable<Iter = I>]` wie in Lyric 5; die Ausschlüsse `SEM0133`), statische Mitglieder eines
Blanket-Blocks, ein Block auf einer Instanz (`extend Box<int> { … }`, Regeln 1–2), Listen eines
Typparameters als Interfacewerte.

**S7c4c3, geteilt (2026-10-30).** **S7c4c3a** Blanket-Konformanzen und statische Mitglieder
eines Blanket-Blocks; **S7c4c3b** ein Block auf einer Instanz — die Instanzen teilen heute die
Methodentabelle der Vorlage, `extend Box<int> { … }` landet still auf jedem `Box<T>` —, Listen
eines Typparameters als Interfacewerte und die Werte eines Interfaces, das ein Blanket-Block
einer Liste, einem VM-gehaltenen generischen Typ oder einem nur bedingt erreichten gibt.

**S7c4c3a, Ergebnis (2026-10-30).** Ein Blanket-Block darf konformieren: er gibt das Interface
und seine Kette jedem Typ, den seine Constraints zulassen, die Signaturen am Ziel geprüft
(`SEM0042`, `SEM0020`), die assoziierten Typen im Rumpf oder per Fixierung in der Liste
beantwortet (`SEM0128`, `SEM0129`); `conformsTo` fragt die Blöcke, eine exakte Kopie ruft das
Mitglied des Blocks für den Typ, und jeder erreichte Typ bekommt das Interface, die Antworten und
die Mitglieder des Blocks in seine Tabelle — kopiert erst nach der Prüfung, in `tableSelf` bzw.
je Instanz in `tableInstance`. Ein Typ, der selbst zu einem Glied der Kette konformiert, und ein
zweiter Block für eine Kette sind `SEM0133`. Statische Mitglieder über den Typ und über einen
Typparameter. Die Prelude gibt jedem Iterator `Iterable<Iter = I>` wie Lyric 5. **Gefunden beim
Bauen:** (1) **seit S3i:** die Schranke einer Antwort wurde gefragt, bevor die übrigen
Konformanzen derselben Liste standen — `type Iter = Both` eines `Both :: [Iterator, Iterable]`
war `SEM0160`; (2) eine Tabellenkopie bei der Deklaration war leer (Rümpfe noch ungeprüft); (3)
ein VM-gehaltener generischer Typ ohne Tabelle hatte keine Antwort `Iter`, `C.Iter` blieb in
der Kopie offen, und der Codegenerator überging `TExpr.Unknown` still — die Schleife lief ewig;
jetzt bekommt jeder erreichte Typ die Antworten, und ein unaufgelöster Ausdruck paniert mit
`LYS-ICE0001`; (4) eine geteilte Kopie über einen nur bedingt erreichten Typ rief über eine
Tabelle ohne den Eintrag (ICE) — jetzt `NYI0001` mit Uhr S7c4c3b, wie ein solcher Wert. Spec 05
Regel 12, 07 Regel 7; fünf Fälle, alle rot gegen S7c4c2. Sechs Mutanten in drei Läufen: einer wie vorhergesagt; drei Fehlgriffe — ein Default lief über die Box-Tabelle des materialisierten Typs statt über die Blöcke; ein Ablehnungsfall prüft nur, dass seine Codes vorkommen, ein zusätzliches `SEM0160` bleibt dort unsichtbar; und die offene Antwort führte nicht zu `TExpr.Unknown`, sondern zur Kopie des **abstrakten** `next` — die Schleife hing weiter. Seitdem gibt `memberCallOn` für ein abstraktes Mitglied `TExpr.Unknown` (die laute Panik); die Wiederholung paniert wie vorhergesagt.
Fälle 404 → 409.

**S7c4c3b, Ergebnis (2026-10-30).** Ein Block auf einer Instanz (`extend Box<int> { … }`,
`extend int[] { … }`) gibt seine Mitglieder und Konformanzen dieser Instanz allein, am
Instanztyp geprüft (`ownMethods`, `instIfaces`; `SEM0012` anderswo, `SEM0133` neben einer
Konformanz der Vorlage). Eine Liste eines Typparameters ist ein Interfacewert: die Kopie legt
sie in die Box ihres Elements, eine geteilte Kopie macht den Deskriptor zur Laufzeit (`inst.t`
über `List<Any>`, `new.d`); `x is T[]` prüft gegen ihn. Ein Blanket-Block gibt seine
Konformanz mit Tabelle auch einer Liste, einem VM-gehaltenen generischen Typ und einem nur
bedingt erreichten (dort unter der Bedingung) — die NYI-Sperren von S7c4c3a sind weg.
**Gefunden beim Bauen:** (1) ein Block auf einer Instanz landete auf der Vorlage und wurde
gegen `T` geprüft (die Instanzen teilen die Methodentabelle); (2) **seit S3g:** ein generischer
Typ, mit Argumenten vor seiner Deklaration genannt, war `SEM0026` — ein Aritätsvorlauf wie für
Interfaces; (3) `fn f<T>(xs: T[]): Any = xs` kompilierte **still** zur Box des Vorlageneintrags
und stürzte zur Laufzeit ab — die NYI-Sperre in `coerce` war tot, `fit` boxte vorher; der
Deskriptor eines Listentyps war im Codegenerator immer `Any`; (4) ein Listeneintrag, den erst
eine Kopie machte, hatte keine Debug-Form; (5) **seit S3i:** der Laufzeit-Deskriptor einer
Instanz führte die bedingten Konformanzen der Vorlage ohne Bedingung — `Cond<int> is Named` war
`true`. Spec 03 Regeln 12, 16; 05 Regel 12; sechs Fälle, alle rot gegen S7c4c3a. Sieben Mutanten in vier Läufen, die Fälle alle wie vorhergesagt; bei einem (der Listendeskriptor wieder `Any`) stimmte der Mechanismus nicht — statt `false` paniert der Lauf, `inst.t` über einen Deskriptor ohne Argumente.
Fälle 409 → 415. Damit ist **S7c4** fertig.

**S7c5, geschnitten (2026-10-30).** Nach Lyric 5 05 §12 (Script 05 D6, 03 Mix): **S7c5a**
`Equatable` als Interface — `==` über einen Typparameter, das eigene `equals`, Klassen über
`:: Equatable` oder `:: Identity`, die vergleichenden Listen-Methoden über `T`; **S7c5b**
`Ordered`, `TotalOrder` und `Ordering` (`float :: TotalOrder`, Fl), `<` … über sie, die
Synthese; **S7c5c** die Operator-Interfaces (`Add<Rhs = Self> { type Out = Self }` …, `Neg`,
die Bit-Operatoren), die Auflösung am rechten Operanden, `+=` abgeleitet, `++`/`--` als
Ausdrücke, `Contains<T>` für `in`, die gemischte Arithmetik über eingebaute Konformanzen.

**S7c5a, Ergebnis (2026-10-30).** Die Prelude deklariert `Equatable { fn equals(o: Self): bool }`
(eine reine Constraint) und die vergleichenden Listen-Methoden als Script-Quelltext,
`extend<T :: [Equatable]> T[]` — die synthetisierten `#indexOf`/`#dedup` und der eigene Weg von
`in` sind weg, `x in xs` ist `xs.contains(x)`. Ein Struct, ein Enum, ein Tupel, eine Liste, ein
Optional sind `Equatable`, wenn ihre Teile es sind; eine Klasse über `:: Equatable` (ihr
`equals`, sonst feldweise) oder `:: Identity`. `==` eines Typs, der einen Typparameter nennt,
wartet als `GenericEq` auf die Kopie und vergleicht dort mit der einen Gleichheit, die es gibt;
ein Parameter unter `Equatable` wird dafür nie geteilt (wie unter assoziierten Typen). Das eigene
`equals(o: Self): bool` eines Typs ruft `==`, `x.equals(y)` ist `x == y`, wo der Typ keins hat.
**Gefunden beim Bauen (seit S3g):** ein Initialisierer eines generischen Typs an einem Parameter
`Box<T>` wurde gegen das offene `T` geprüft („expected T, found int“) — die Vorlage bei ihren
eigenen Parametern zählte nicht als „nennt einen Parameter“. Spec 05 Regel 8, 03 Regel 16; vier
Fälle, alle rot gegen S7c4. Sechs Mutanten in fünf Läufen: vier wie vorhergesagt; im ersten (kein `GenericEq`) wurde auch ein S7b-Fall rot — die Listen-Methoden der Prelude vergleichen selbst über `T`, das hatte die Vorhersage übersehen.
Fälle 415 → 419.

**S7c5b, Ergebnis (2026-10-30).** Die Prelude deklariert `Ordering`, `Ordered :: Equatable`
und `TotalOrder :: Ordered` (reine Constraints) und gibt beide `int`, `char`, `string` und
`float` als Script-Blöcke wie Lyric 5s `core` — `float` total geordnet (Fl) über den neuen
Native `float.orderKey` (die Bits, bei gesetztem Vorzeichen die übrigen umgedreht; Format 24).
`<`, `<=`, `>`, `>=` eines anderen Typs lesen sein `compare` (`null` macht alle vier falsch),
über einen Typparameter in der Kopie (`GenericCompare`, das `GenericEq` von S7c5a). Ein Typ, der
`Ordered` oder `TotalOrder` ohne das Mitglied aufführt, bekommt es synthetisiert,
lexikographisch, ein Enum zuerst nach der Variantenposition; seine Teile werden geprüft,
sobald alle Konformanzen stehen (`SEM0020`, einmal je Typ). Spec 05 Regel 16; drei Fälle, alle
rot gegen S7c5a. Sechs Mutanten in vier Läufen, die Fälle wie vorhergesagt; im ersten Lauf deckte ein Mutant (der `compare`-Weg für `<`) auch den Zweig über Typparameter ab und überdeckte damit den Native-Mutanten — der lief allein nach und scheiterte wie vorhergesagt.
Fälle 419 → 422.

**S7c5c, geschnitten (2026-10-30). Lücke ohne Uhr (P20):** Standardwerte für Typparameter
(Lyric 5 03 §9.1 Regel 5, T18: `interface Add<Rhs = Self>`, `class Map<K, V, H =
DefaultHasher>`) sind im Script-Design 03 („Generics: … Default-Typargumente, `_`“) übernommen,
die Spec zog nur §9.1 Regeln 1–3 nach, keine Zeile nannte sie; `interface Add<Rhs = Self>` ist
heute `PAR0004`. Und ein Typ hält in Script einen Namen einmal (05 Regel 13): zwei `mul` — eines
für `Mul`, eines für `Mul<float>` — und zwei Antworten `Out` gibt es erst mit Lyric 5 §3 Regeln
4–5 und §8 Regel 3 (05 Regel 13 nannte nur „S7“). Darum: **S7c5c1** Standard-Typargumente;
**S7c5c2** die Operator-Interfaces (`Add<Rhs = Self> { type Out = Self }` …, `Neg`, die
Bit-Operatoren, `Shl<Rhs = int>`), die Operatoren eigener Typen über sie nach dem statischen Typ
des rechten Operanden — eine Instanz je Operator-Interface und Typ —, `+=` abgeleitet, Generika
über `T :: [Add<Out = T>]`, die Skalare in Prelude-Blöcken; **S7c5c3** `++`/`--` als Ausdrücke,
`Contains<T>` für `in`; **S7c5d** mehrere Instanzen eines generischen Interfaces an einem Typ
(Mitglieder je Block, `SEM0122`; nebeneinander je Instanz), Antworten je Konformanz-Instanz, die
eingebauten gemischten Konformanzen (`int :: Add<float>`, 03 Mix).

**S7c5c1, Ergebnis (2026-10-30).** Ein Typparameter darf einen Standardwert tragen (`= T` nach
seinen Constraints); eine Verwendung mit weniger Argumenten — eines Typs, eines Interfaces, an
einem Aufruf, einer Methode — nimmt die nachfolgenden, gelesen, wo das Generic deklariert ist:
seine früheren Parameter die Argumente, `Self` in einer Konformanz der Konformer, in einem
Constraint der Parameter (`V :: [Add]` ist `V :: [Add<V>]`); ein Extend-Block nimmt keine
(`SEM0026`). `Coroutine<Y>` ist jetzt das `R = void` der Prelude — der fest eingebaute
Sonderfall ist weg. **Gefunden über einen überlebenden Mutanten (seit S7c1):** `T :: [Combine<T>]` einer `fn f<T>` war die Vorlage selbst — `typeInstance` gibt sie für Argumente zurück, die wie ihre eigenen Parameter lauten —, und die erfüllt jede Instanz: ein `B :: Combine<int>` ging als `T` durch, der Aufruf las ein `B` als `int`; ein geschriebenes Interface ist jetzt immer eine Instanz. Spec 03 Regel 12; drei Fälle, alle rot gegen S7c5b. Drei Mutanten in drei Läufen: zwei wie vorhergesagt (der ohne Standardwerte traf alle 30 Fälle mit `Coroutine<X>` und 15 Tests); der dritte (das `Self` einer Konformanz) überlebte zuerst — wegen des Fehlers oben — und scheiterte nach dem Fix wie vorhergesagt.
Fälle 422 → 425.

**S7c5c2, Ergebnis (2026-10-30).** Die Prelude deklariert die Operator-Interfaces — `Add`, `Sub`,
`Mul`, `Div`, `Rem`, `BitAnd`, `BitOr`, `BitXor` mit `Rhs = Self`, `Shl`/`Shr` mit `Rhs = int`,
`Neg`, `BitNot`, je `type Out = Self` — und gibt sie den Skalaren als Script-Blöcke. Ein
Operator eines Typs des Programms ist der Aufruf über die Konformanz, die der statische Typ des
rechten Operanden wählt (`v * 2.5` → `Mul<float>`, ein `int`-Literal passt sich an), über einen
Typparameter durch den Constraint; `-a`, `~a` über `Neg`, `BitNot`; `a op= b` ist `a = a op b`,
der Empfänger eines Felds, eine Liste samt Index einmal gehalten, `Out` der Typ des Orts. Spec 05
Regel 17; vier Fälle, alle rot gegen S7c5c1. Vier Mutanten in zwei Läufen, alle wie vorhergesagt.
Fälle 425 → 429.

**Uhren nachgeschärft (2026-10-30).** NYI-Meldungen nannten abgelaufene Uhren: ein Bereich als
Wert „S3“ (jetzt S7c6), die Konstante eines Blanket-Blocks „S7c4c3b“ und ein generischer Block auf
anderem Ziel „S3i“ (beides gibt es in Lyric 5 §13 nicht: jetzt `SEM0124`), ein `[]` ohne Typ
„S7b2“ (Lyric 5 §9.2 Regel 3: jetzt `SEM0060`); die Mitglieder eingebauter Typen nennen S7d,
S7e oder S7f statt „S7“; ein toter `??=`-Zweig ist weg.

**S7c5c3, Ergebnis (2026-10-30).** `++` und `--` (Lyric 5 08 §6) auf einem Zahlenort — Variable,
Feld, Element einer Liste oder eines `IndexSet` —, `x++` der alte Wert, `++x` der neue, was zum
Ort führt einmal ausgewertet: auf Ausdrucksebene über die vorhandene Zuweisung `ort op= 1`. Die
Prelude deklariert `Contains<T>`, der Listen-Block ist eines; `x in xs` ist `xs.contains(x)` über
das `Contains<T>` des rechten Operanden, `x` zuerst ausgewertet (Lyric 5 §12 Regel 10 — Script
wertete seit S7b2a den Behälter zuerst aus). **Gefunden beim Bauen:** (1) **seit S7c1:** eine
bedingte Konformanz zu einer *Instanz* eines generischen Interfaces wurde unter der gefragten
Instanz gesucht, nie unter dem Interface des Blocks — keine Bedingung griff (`Box<int>` galt als
`Holds<int>` ohne `int :: Show`); (2) die Tabelle einer Instanz kopierte die Mitglieder einer
bedingten Konformanz, deren Bedingung sie nicht erfüllt; (3) `operatorMember` rief die
Block-Methode einer Liste ohne ihr Element. Spec 05 Regel 8, 08 Regel 5; sechs Fälle (zwei davon
für die Uhren), alle rot gegen S7c5c2. Sieben Mutanten in zwei Läufen, alle wie vorhergesagt.
Fälle 429 → 435.

**S7c5d, Ergebnis (2026-10-30).** Mehrere Mitglieder eines Namens und mehrere Instanzen eines
generischen Interfaces an einem Typ (Lyric 5 05 §3 Regeln 1, 4–5, §8 Regel 3, 08 §1.2), in drei
Schritten. (d1) Jede Instanz eines generischen Interfaces hat eigene Slots: eine Tabelle hält
`From<int>`s und `From<string>`s Mitglied auseinander, eine Instanz eines generischen Typs bekommt
die Slots ihrer Interface-Instanzen. (d2) Die Mitglieder eines Typs teilen einen Namen bei
verschiedener Anzahl, je Konformanz-Block (der unqualifizierte Aufruf `LYS-SEM0122`) oder je
Instanz (Wahl nach den Argumenttypen, `LYS-SEM0086`; zwei für eine Instanz `LYS-SEM0085`); ein
Lesen ohne Aufruf nimmt das, das der Funktionstyp der Stelle sagt (`LYS-SEM0089`). (d3) Eine
Antwort gehört ihrer Konformanz-Instanz: `extend V :: [Mul<float>] { type Out = float }` neben
`V :: [Mul]`, `T.Out` unter `T :: [Mul<float>]` liest sie; die Prelude gibt `int :: [Add<float>,
…]` und `float :: [Add<int>, …]` (03 Mix). **Gefunden:** (1) **seit S2d** weitete ein Default
keine Anzahl — `fn f(a)` neben `fn f(a, b = 0)` kompilierte (Lyric 5 08 §1.2 Regel 2); (2) beim
Bauen von d3 sickerte die Antwort eines Blocks typweit in andere Konformanzen (`int`s `Neg` nahm
`Add<float>`s `Out`); (3) Lyric-5-ICE bei `Map<string, Map<string, Ty>>` als Feld (lyric#612).
Ein Block auf einer Instanz hält ein Mitglied je Namen (P22, Uhr S7f). Spec 05 Regel 18, Regeln 13
und 17 verweisen darauf; sieben Fälle, sechs rot gegen S7c5c3 — der siebte hält eine Ablehnung
fest, die schon galt. Mutanten: vier Läufe, 437, 437, 441 und 440 von 442; drei Abweichungen von der Vorhersage, alle erklärt (eine bestehende Prüfung von `5.add(3)` und eine von `G.Output` mehr getroffen als vorhergesagt; die Kopien über Klassen und Structs rufen über die Tabelle, nicht über `memberFor`).
Fälle 435 → 442.
