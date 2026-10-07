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
| Z2 | Laufzeit und Implementierung | **Lyric-Script wird in Lyric 5 neu geschrieben — Compiler und VM** —, sobald Lyric 5.0.0 veröffentlicht ist. Bis dahin wird nur geplant. Die C#-Codebasis von 4.6 ist Referenz, Testkorpus und Verhaltensquelle, kein Code, der überlebt. Keine .NET-Abhängigkeit in Sprache, Laufzeit oder Einbettung. |
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
| Baum-Interpreter oder native Kompilation | Bytecode trägt Budget, Hot-Reload und Sandbox-Prüfung beim Laden (Z4). |
| Rohes `extern "C"` / `extern "dotnet"` in Script | Grenze von Hand, Sandbox-Loch; native Module decken den Bedarf mit einem Mechanismus. |
| Gemeinsamer Frontend-Code mit Lyric 5 über Repos | Kopplung an ein bewegliches Ziel; die Familie entsteht aus den Dokumenten. Mit dem Neubau in Lyric 5 neu zu prüfen (Bereich 2/12). |

## Was das den späteren Bereichen vorgibt

- **Zeitlinie**: Die Runde endet in einem Plan; die Umsetzung beginnt nach Lyric 5.0.0. Der
  Plan braucht deshalb keine Zwischenreleases auf der C#-Basis.
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
| A2 | Lyric 5 muss eine VM tragen: schnelle Dispatch-Schleife (`match` über Opcodes zu Sprungtabelle), Arrays ohne Bounds-Check-Kosten im heißen Pfad, Koroutinen-API zum Einhängen von Skript-Koroutinen. Zu prüfen gegen die 5.0-Fähigkeiten, nicht zu fordern ohne Messung. | 01, 06, 03 | Bereich 2 dieser Runde |

## Fahrplan der Runde

| # | Bereich |
|---|---|
| 00 | Positionierung (dieses Dokument) |
| 01 | Host und Sicherheit: Profile, Capabilities, Budget, Hot-Reload, Determinismus |
| 02 | Laufzeit und VM in Lyric 5: Wertmodell der VM, Format, Startzeit, Einbettung |
| 03 | Wertmodell der Sprache: Zahlen, Strings, Sammlungsliterale, Mutabilität, `Any` |
| 04 | Typisierung: Inferenz, Parameter, Generics, `Any`-Grenze |
| 05 | Abstraktion: Klassen, Interfaces, Protokolle |
| 06 | Fehler |
| 07 | Nebenläufigkeit: Koroutinen, vom Host gepumpte Event-Loop |
| 08 | Programmstruktur und Module: Top-Level-Code, Shebang, Abhängigkeiten, Manifest |
| 09 | Syntax und Abweichungstabelle |
| 10 | Reflexion und Metaprogrammierung |
| 11 | Standardbibliothek |
| 12 | Werkzeuge: REPL, LSP, fmt, `run`, Debugger, native Module bauen |
| 13 | Migration 4.6 → 1.0 |
| 14 | Umsetzungsplan zu `lyric-script 1.0.0` |
