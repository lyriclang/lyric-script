# 00 — Positionierung und Zielbild

Entschieden 2026-10-07 (Maintainer, im Dialog). Erster Bereich der Lyric-Script-Designrunde;
alles Weitere baut darauf. Ergebnis der Runde ist der Plan für `lyric-script 1.0.0`.

Ausgangslage: Lyric macht mit 4.5/4.6 einen Cut. **Lyric 5** (Repo `lyriclang/lyric`) ist das
Arbeitspferd — nativ, von Grund auf neu, auf Leistung gebaut. **Lyric-Script** setzt
„Legacy-Lyric“ fort: die Sprache und die Ideen von Lyric 4 (unreleaste 4.6 inklusive der dort
gebauten Fehlerkorrekturen), umgebaut zu einer Skriptsprache. Eine 4.x-Linie mit eigenen
Releases gibt es nicht mehr; 4.6 ist Ausgangsmaterial, nicht Kompatibilitätsversprechen.

## Entscheidungen

| # | Frage | Entscheidung |
|---|---|---|
| Z0 | Was ist unverhandelbar? | **Statisch typisiert** (die VM-Sicherheit hängt daran), **Sandbox**, **Instruktionsbudget**, **Hot-Reload**. Typisierung „statisch mit explizitem Ausweg“: Inferenz so weit wie möglich, ein expliziter Typ `Any` für dynamische Daten mit geprüftem `is`/`as?`; **eine fehlende Annotation bedeutet nie `Any`**. |
| Z1 | Primärer Einsatz | **Terminal-Skripte und Automatisierung (b)** vor **Erweiterungssprache in Hosts (a)** und **Einbettung in Lyric-5-Programme (d)**. **Eine Sprache, eine Endung `.lyrs`, zwei Profile**: *standalone* (Top-Level-Code als Einstieg, volle `std`, Freigaben per Flag/Manifest, kein Budget) und *embedded* (der Host bestimmt Rechte, API und Budget; Vorgabe: nichts erlaubt). Top-Level-Code ist in beiden Profilen erlaubt; eingebettet läuft er beim Instanziieren als Initialisierung. |
| Z2 | Laufzeit und Implementierung | **Lyric-Script wird in Lyric 5 neu geschrieben — Compiler, VM und native Teile der std.** Präzisiert 2026-10-28 (Strategie B): **Beginn vor 5.0 gegen einen gepinnten `dev`-Build** — nach den Sprachbereichen und dem VM-Bereich (11); vorgezogen nur die sprachunabhängige Dispatch-Probe (Reihenfolge geändert 2026-10-28, siehe Fahrplan). Die C#-Codebasis von 4.6 ist Vorlage (VM, Format, Sema), Testorakel und Korpus, kein Code, der überlebt; der Lyric-Quelltext von 4.6 (std 8,4k Zeilen, Beispiele 5k) wandert über `lyric fix --from-4` (Lyric 5, M16) mit. Keine .NET-Abhängigkeit in Sprache, Laufzeit oder Einbettung. |
| Z6 | Sprache der Standardbibliothek | **Python-Modell**: der Großteil in Lyric-Script selbst; nativ (Lyric 5, als native Module nach Z5) nur I/O, OS-Zugang und gemessene heiße Pfade (Text-Kerne, Hashing, Regex, Parser). 4.6 steht bei 74 % Lyric zu 26 % nativ (617 Funktionen, 162 ohne Rumpf). Der Compiler wird **nicht** selbst gehostet (Startzeit und Reload, Bootstrap). |
| Z3 | Verhältnis zu Lyric 5 | **Sprachfamilie: Lyric 5 ist die Referenz.** Script weicht nur ab, wo die Abweichung dem Skript-Charakter dient; jede Abweichung steht mit Begründung in einer **Abweichungstabelle** (je Bereich, gesammelt im Plan). „Als Lyric erkennbar, mit den Abkürzungen einer Skriptsprache.“ |
| Z4 | Abstand zu 4.6 | **Bytecode-VM bleibt das Ausführungsmodell** (kein Baum-Interpreter, kein nativer Compile); **Oberfläche und VM entstehen neu** (aus Z2, Z3). Das **Format darf brechen**: Erato 2 / Lyricpp hält eigene Werkzeugkopien und ist kein Abnehmer laufender Änderungen. |
| Z5 | Fremdgrenze | **Native Module statt `extern`**: ein Lyric-5-Paket wird als Script-Modul gebaut (Bibliothek + erzeugte Schnittstellenbeschreibung aus `@Export`/`lyric api`), das Skript schreibt nur `import paket.modul`. **Kein rohes FFI in Script** (kein `extern "C"`, kein `extern "dotnet"`); C-Bibliotheken über eine Lyric-5-Hülle. Native Module tragen ein **eigenes Capability-Bit**, im Profil *embedded* standardmäßig gesperrt. Die Gegenrichtung (Lyric 5 bettet Script ein) geht über eine vom Host registrierte API (Lyric 5, 11 H9a). |
| — | Name, Endung, Version | Binary `lyric-script`, Endung `.lyrs`, eigener Versionszähler ab 1.0.0 (bestätigt aus Lyric 5, 12 R6). |

## Begründung

**Statisch bleibt (Z0).** In 4.6 ist die Typisierung tragend, nicht Geschmack: `LyrValue`
trägt kein Typ-Tag, jeder Opcode trägt eins, der Loader prüft einmal und führt dann ungeprüft
aus. Eine graduelle Typisierung, in der Nicht-Annotiertes `any` ist (TypeScript, Python+mypy),
hätte dieses Fundament und die Sandbox-Argumentation aufgegeben, ohne dass Sandbox oder Budget
dynamische Typen brauchen. Der Hybrid folgt **Dart 2**, das von optionaler zu solider
statischer Typisierung mit explizitem `dynamic` wechselte: Python-artige Kürze kommt aus
Inferenz, dynamische Daten aus einem benannten Typ.

**Eine Sprache, zwei Profile (Z1).** CLI-Skript und Erweiterung unterscheiden sich in der
Umgebung (Einstieg, Rechte, Budget, Host-API), nicht in der Sprache. Lua, Python, Luau und
Deno lösen das gleich: der Host bestimmt, was erreichbar ist. Zwei Endungen (`.lyrs`/`.lyrse`)
wären zwei Dialekte mit doppeltem Formatter-, LSP- und Testaufwand für ein Konzept.

**In Lyric 5 neu (Z2).** Eine Skriptsprache braucht ihren Compiler zur Laufzeit (`run`,
Hot-Reload), also wird überall eingebettet, was Compiler *und* VM ist. Geschrieben in Lyric 5
ist Lyric-Script eine gewöhnliche Lyric-5-Bibliothek: **ein Runtime, ein GC** im Prozess eines
Lyric-5-Hosts, C-ABI-Einbettung über Lyric 5s `@Export` (11 W5) für alle anderen Hosts, keine
.NET-Installation, kein zweiter GC. Die verworfene Zwischenstufe (C#-Toolchain als NativeAOT)
hätte einen zweiten GC und das ungeklärte Risiko verwalteten Codes auf Lyric-5-Koroutinen-Stacks
gebracht. Nebenwirkung: Lyric-Script ist das erste große Lyric-5-Programm außerhalb von `std`
und damit ein Abnahmetest für 5.0.

**Familie statt Fork (Z3/Z4).** Die 4.6-Syntax liegt an vielen Stellen bereits weg von Lyric 5
(`module`-Header, `resume`, `throws A, B`, `params`, `inout`). „Als Lyric erkennbar“ heißt
deshalb, sich auf 5 zuzubewegen; da ohnehin neu geschrieben wird, kostet das nichts extra.
Die Abweichungstabelle hält die Familie ehrlich: jede Abweichung muss sich begründen.

**Native Module (Z5).** Eine `extern`-Form im Skript wäre eine Grenze, die jeder Skriptautor
von Hand beschreibt und die die Sandbox durchlöchert. Ein gebautes Modul mit erzeugter
Schnittstelle ist ein Mechanismus, typsicher, und als Ganzes per Capability sperrbar
(Vorbild PyO3/maturin).

## Verworfene Alternativen

| Option | Warum nicht |
|---|---|
| Graduell, Nicht-Annotiertes = `any` (TS, mypy, Luau-nonstrict) | Unsound auf Dauer; gibt die statische Grundlage der VM-Sicherheit auf. |
| Dynamisch (Python, Lua) | Neue Sprache mit neuem Wertmodell; nicht mehr Lyric (Z3). |
| Zwei Endungen `.lyrs`/`.lyrse` | Zwei Dialekte für ein Konzept; Unterschied gehört Profil und Host. |
| .NET-Einbettung als Hauptweg (4.6) | Lyric 5 kann sie nicht nutzen (11 H9 verwirft CoreCLR-Hosting); Maintainer will weg von .NET. |
| C#-Toolchain als NativeAOT mit C-Schnittstelle | Zweiter GC im Prozess, Risiko auf Lyric-5-Koroutinen-Stacks, Zwischenstufe vor dem ohnehin gewollten Neubau. |
| Warten auf 5.0.0 vor dem ersten Code (Strategie A) | Die Sprache Lyric 5 ist nach M14 fertig genug für eine VM; Befunde aus Script sind vor dem 5.0-Release am billigsten. Preis von B: ein bewegliches Ziel bis M17. |
| 4.6 in C# weiterentwickeln, 1.0 auf .NET, später portieren (Strategie C) | Frontend zweimal neu (Z3 verlangt ohnehin eine neue Oberfläche), .NET in 1.0, Lyric-5-Einbettung erst nach dem Port. |
| Compiler in Lyric-Script selbst gehostet (Strategie D) | Compile im Interpreter bei jedem Start und Reload (geschätzt eine Zehnerpotenz langsamer, nicht gemessen) trifft Rolle b; Bootstrap-Abbild. Bei Skriptsprachen selten (PyPy, Pharo). |
| Baum-Interpreter oder native Kompilation | Bytecode trägt Budget, Hot-Reload und Sandbox-Prüfung beim Laden (Z4). |
| Rohes `extern "C"` / `extern "dotnet"` in Script | Grenze von Hand, Sandbox-Loch; native Module decken den Bedarf mit einem Mechanismus. |
| Gemeinsamer Frontend-Code mit Lyric 5 über Repos | Kopplung an ein bewegliches Ziel; die Familie entsteht aus den Dokumenten. Mit dem Neubau in Lyric 5 neu zu prüfen (Bereich 11/13). |

## Was das den späteren Bereichen vorgibt

- **Zeitlinie**: Die Runde endet in einem Plan; die Umsetzung beginnt gegen Lyric 5 `dev`
  (gepinnt) — nach den Sprachbereichen 02–10 und dem VM-Bereich 11; vorgezogen nur die
  Dispatch-Probe, die die Anforderungen A2a–c belegt. Kein Zwischenrelease auf
  der C#-Basis. Befunde in Lyric 5 gehen als Issues an `lyriclang/lyric`, nicht als
  Umgehungen in Script.
- **Host und Sicherheit**: Capabilities, Budget, Hot-Reload als Axiome; heutige Lücken
  (Host-Funktionen ohne Bit, `lyrvm` ohne `--grant` = alles, REPL immer `All`, Budget stoppt
  keinen geparkten Gast, Reload = Neustart ohne Zustandsübernahme) sind zu entscheiden, nicht
  zu erben.
- **Laufzeit und VM**: VM in Lyric 5; zu entscheiden u. a. Wertdarstellung inkl. `Any`-Box,
  Format, Skript-Koroutinen als VM-Frames oder auf Lyric-5-Koroutinen, Startzeit-Ziel für das
  Profil *standalone*, Bytecode-Cache.
- **Typisierung**: Reichweite der Inferenz, insbesondere Parameter (implizit generisch?).
- **Programmstruktur**: Top-Level-Code, Shebang, Einzeldatei mit Abhängigkeiten, Profile im
  Manifest.
- **Abweichungstabelle**: jeder Bereich trägt seine Zeilen bei.

## Anforderungen an Lyric 5 (nicht in dieser Runde entscheidbar)

| # | Anforderung | Betrifft | Wann nötig |
|---|---|---|---|
| A1 | **Mehrere Lyric-5-Bibliotheken in einem Prozess** (geteiltes Runtime): ein `lyric-script`-Prozess, der zwei native Module lädt, hätte heute zwei Runtimes — 11 H1 erlaubt eines, H7 lässt `--shared-runtime` als Tür. Alternative ohne Änderung an 5: native Module statisch in ein eigenes `lyric-script`-Binary linken. | 11 H1, H7 | erst bei dynamisch geladenen nativen Modulen |
| A2a | ~~Dispatch-Senkung~~ — **gemessen 2026-10-28: nicht nötig** für `match` über `uint8` mit Literal-Mustern: clang `-O2` faltet die `if`-Kette zu einer Sprungtabelle (48 Einträge, ein indirekter Sprung; heiß zuerst/zuletzt gleich schnell). Nicht gemessen: Enum-/Guard-`match`, `-O0`, gcc (`design/v1/probes/dispatch/`) | IR, C-Emitter | erledigt, sofern Bereich 11 bei dieser Form bleibt |
| A2b | **Anhalten aus verschachtelten Aufrufen**: öffentliches `park`/`unpark` oder typisiertes Yield aus Hilfsfunktionen (heute `park` in std privat) — für Budget-Anhalten und Skript-Koroutinen (01 S5b) | 06, std.task | Bereich 11 |
| A2c | **Exakter Toolchain-Pin** (heute nur Mindestversion; `lyric toolchain install` kommt mit M15); bis dahin baut die CI von Lyric-Script Lyric 5 aus einem festen Commit | 11 W9, M15 | Umsetzungsbeginn |
| A2d | **Indexprüfung im heißen Pfad: gemessen 24 %** der Dispatch-Zeit (1,26 → 0,96 ns/Befehl, wenn nur `LYR_CHECK_INDEX` entfällt — praktisch der ganze Abstand zu C); der `Ptr`-Weg ist **kein** Ausweg (ohne LTO 3× langsamer, mit LTO +27 %, weil `offset` geprüft rechnet). Anforderung, falls Bereich 11 die 24 % holen will: ein ungeprüfter, inline gehender Elementzugriff (z. B. `getUnchecked` in `unsafe {}`) oder Elimination der Prüfung in Schleifen | 03 N5, std.ffi | Bereich 11 |
| A3 | **Instanz-Zuordnung im GC** (Heap-Partitionen oder Abrechnung beim Markieren) für eine Live-Speichergrenze pro Instanz (01 S6, Tür) | 01 S6; Lyric 5 01, M11 | erst wenn die Tür geöffnet wird |

## Fahrplan der Runde

| # | Bereich |
|---|---|
| 00 | Positionierung (dieses Dokument) |
| 01 | Host und Sicherheit: Profile, Capabilities, Budget, Hot-Reload, Determinismus |
| 02 | **Leitbild**: Beispielprogramme in Stilvarianten, Katalog der Skript-Merkmale |
| 03 | **Werte und Typen** (Wertmodell und Typsystem zusammen, 2026-10-28) |
| 04 | — in 03 aufgegangen |
| 05 | **Abstraktion und Fehler** (zusammen, 2026-10-28) |
| 06 | — in 05 aufgegangen |
| 07 | Nebenläufigkeit: Koroutinen, vom Host gepumpte Event-Loop |
| 08 | Programmstruktur und Module: Top-Level-Code, Shebang, Abhängigkeiten, Manifest |
| 09 | Syntax und Grammatik, Abweichungstabelle |
| 10 | Reflexion und Metaprogrammierung |
| 11 | Laufzeit und VM in Lyric 5: Grundform, Werte, Format, Startzeit, Einbettung |
| 12 | Standardbibliothek |
| 13 | Werkzeuge: REPL, LSP, fmt, `run`, Debugger, native Module bauen |
| 14 | Migration 4.6 → 1.0 |
| 15 | Umsetzungsplan zu `lyric-script 1.0.0` |

**Reihenfolge geändert (2026-10-28, Maintainer):** die Sprache vor der VM — was die VM können
muss, folgt aus Sprachentscheidungen (Generics gelöscht oder monomorphisiert, Ganzzahlbreite,
Vererbung, Fehlerform). Methode für 03–10: **Abweichungsrunden** — je Gebiet das
Entscheidungsdokument von Lyric 5 und der Stand von 4.6, je Punkt übernehmen / ändern /
streichen. Die schon gestellten VM-Fragen (Stack/Register, Wertdarstellung, Referenzform) sind
Material für 11.
