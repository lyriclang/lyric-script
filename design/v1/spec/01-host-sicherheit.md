# 01 — Host und Sicherheit

Entschieden 2026-10-28 (Maintainer, im Fragedialog). Grundlage: 00 — Sandbox, Budget und
Hot-Reload sind Axiome (Z0), eine Sprache mit den Profilen *standalone* und *embedded* (Z1),
Compiler und VM in Lyric 5 (Z2), native Module statt `extern` (Z5). Schreibweisen in Beispielen
sind Arbeitsnotation; die Syntax entscheidet Bereich 09.

## Ausgangslage 4.6 (belegt)

| Gebiet | 4.6 | Lücke, die hier entschieden wird |
|---|---|---|
| Rechte | 5 grobe Bits (`file net os host process`), je Modul im Bytecode, beim Laden geprüft (`Capabilities.cs:8-70`, `LoadedProgram.cs:77-81`) | keine Feinheit; Host-Funktionen ohne Bit (`LangVm.cs:135-152`); `lyrvm` ohne `--grant` = alles (`Lyrvm/Program.cs:223`); REPL immer `All` |
| Budget | Instruktionszähler, unfangbare Panik `LYR-CAP0002`, kein `defer` (`ExecutionBudget.cs:26-70`) | geparkter Gast nicht stoppbar; Natives kostenlos; keine Speichergrenze |
| Hot-Reload | `ScriptInstance.Reload()` = neue Instanz (`ScriptInstance.cs:58-66`) | kein Zustand, keine Koroutinen-Regel |
| Bytecode | vollständiger Verifier, dann ungeprüfte Ausführung | Verifier ist die Sicherheitsgrenze |
| Instanzen | eine VM, mehrere Instanzen, Werte teilbar | — |

## Entscheidungen

| # | Frage | Entscheidung |
|---|---|---|
| S1 | Feinheit der Rechte | **Grob + optional fein.** Rechteklassen je Modul, aus den Importen abgeleitet, im Bytecode vermerkt, **beim Laden** geprüft (fehlend = `LYR-CAP0001`, alle auf einmal mit Zeile). Eine Freigabe darf einen **Bereich** tragen (`--allow file=./data`, `net=host:port`); nur dann prüft die VM zusätzlich **beim Aufruf** (`PermissionError`, Bereich 06). |
| S2 | Host-Funktionen | **Rechte-Tags, host-definiert.** Eine Host-Funktion oder ein ganzes Host-Modul darf ein Recht verlangen (`requires: .custom("saves")`); die Deklaration zeigt es dem Skriptautor; Prüfung beim Laden wie bei `std`. **Ein Mechanismus** für `std`, Host-API und native Module (00 Z5). Die Host-API ist immer ein typisiertes Modul (`import host.game`). |
| S3 | Prüfort | Folgt aus S1: Bit beim Laden, Bereich beim Aufruf. |
| S4 | Vorgabe *standalone* | **Nichts erlaubt, einmalige Abfrage vor dem Start**, wenn stdin und stderr ein Terminal sind: die VM listet alle verlangten Rechte mit Herkunft (Import, Zeile) und fragt einmal. Ohne Terminal: `LYR-CAP0001` mit `help: --allow …`. `--allow` und `-A` (alles) für nicht-interaktive Läufe. Keine Vertrauensliste in 1.0 (Tür). Kein Rechte-Kopf im Skript (ein Weg, Rechte anzugeben). |
| S5a | Messung | **Fuel und/oder Deadline**, pro Aufruf wählbar, an denselben Prüfstellen (Rückwärtssprünge, Aufrufe); Fuel pro Grundblock abgerechnet. Fuel ist deterministisch, Deadline nicht. Nichts gesetzt = ein Vergleich. |
| S5b | Erschöpfung | **Anhalten, der Host entscheidet**: Ergebnis `.Suspended`, dann `resume(budget)` oder `abort()`. Eine angehaltene Instanz nimmt nur `resume`/`abort` an. **`abort()` wirkt immer**, auch auf geparkte Koroutinen; beim Abbruch läuft **kein** `defer`, die VM schließt die Ressourcen der Instanz. |
| S5c | Kosten | **Bytecode + Natives nach Arbeit.** Jedes schwere Native (`sort`, Regex, Parser, `repeat`, `replace` …) rechnet proportional ab (`budget.charge(n)`) und prüft in langen Schleifen die Deadline. Pflicht: Kostenregel und Test je schwerem Native. |
| S6 | Speicher | **Allokationsbudget pro Aufruf** (`alloc: 4.mb`, deterministisch, Zähler im Allokationspfad der VM und der Natives) **+ Prozessgrenze** (`LyrConfig.heap_limit`, Lyric 5 11 H1). Live-Grenze pro Instanz ist Tür → Anforderung A3. |
| S7a | Hot-Reload | **Stufe 2: automatische Übernahme nach Name und Typ.** Gleicher Name + gleicher Typ = übernommen; neue Felder mit Default; entfernte fallen weg; Objekte geänderter Typen werden **am Ort** umgebaut (Identität bleibt, Host-Referenzen gültig), erreicht über die Wurzeln der Instanz (Globals, Koroutinen, Host-Referenzen). Typänderung = Reset oder **typisierter Hook** `@Migrate fn score(old: int): float`. Bericht (übernommen / neu berechnet / zurückgesetzt) als Wert und in `run --watch`. Stufe 3 (Funktionstausch am Ort, Erlang) ist Tür. |
| S7b | Koroutinen beim Reload | **Abbruch mit `Cancelled`**, `defer` läuft (Lyric 5 06 X1/A5); der neue Top-Level-Code startet sie neu. |
| S7c | Alte Funktionswerte | **Ungültig**: ein Aufruf liefert `.Stale`. Registrierungen über die Host-API **gehören der Instanz** und werden beim Reload verworfen. Alter Code läuft nie gegen neue Daten. |
| S7d | Top-Level beim Reload | **`var` übernommen** (Initialisierer läuft nicht erneut), **`let` neu berechnet** (tief unveränderlich, Lyric 5 02 — also abgeleitet), **Anweisungen laufen erneut** (Registrierungen erneuern sich). |
| S8 | Determinismus | **Aus den Rechten, auf gleicher Plattform**: eine Instanz ohne Zeit-, Zufalls- und I/O-Rechte ist deterministisch. Die Sprache garantiert dafür: **Map/Set iterieren immer in Einfügereihenfolge**, keine Adress-Hashes, Zufall nur geseedet oder per Recht, der Hasher-Schlüssel kommt aus dem Instanz-Seed, wenn einer gesetzt ist. Plattformübergreifend (eigene Mathe-Funktionen, fdlibm wie Java `StrictMath`) ist Tür. |
| S9 | Isolation | **Eigentum je Instanz**: jedes Objekt gehört genau einer Instanz; zwischen Instanzen nur **tiefe Kopie** oder unveränderliche Werte (`string`). Kompilierter Code wird geteilt. |
| S10 | Fremder Bytecode | **Die Quelle ist das Format** für alles Fremde (`vm.load(source)`, Cache-Schlüssel Hash(Quelle + Compilerversion), Verzeichnis wählt der Host). Bytecode nur über **`vm.loadTrusted(bytes)`** (eigene Artefakte, `pack`), ungeprüft; der Name sagt, dass Fremdes dort die Sandbox umgeht. Strukturprüfung der Compilerausgabe nur in Tests und im Debug-Profil. |
| S11 | Fehler an der Grenze | Ergebnis eines Aufrufs: `.Ok(v)` · `.Error(e)` (Typname, Meldung, Ursachenkette, Backtrace) · `.Panic(p)` (Code, Meldung, Backtrace) · `.Suspended` · `.Aborted` · `.Stale`. **Nach einer Panik bleibt die Instanz benutzbar** (Frames verworfen, Globals unverändert; wie Lua, Godot, Lyric 5 11 H3). |

## Abläufe, die aus den Entscheidungen folgen

**Reload** (S7a–d), nur wenn die Instanz ruht (kein Aufruf aktiv, nicht `.Suspended`):

1. neue Quelle kompilieren — Fehler: alte Instanz läuft unverändert weiter;
2. Typen alt/neu vergleichen (statisch), Übernahmeplan aufstellen;
3. Koroutinen der Instanz mit `Cancelled` abbrechen, `defer` laufen auf altem Code und alten Daten;
4. Übernahme und `@Migrate`-Hooks auf Kopien berechnen;
5. gemeinsam tauschen (Code, Globals, umgebaute Objekte), Host-Registrierungen der Instanz verwerfen;
6. Top-Level-Code der neuen Version ausführen (S7d).

**Nicht ganz atomar**: wirft ein Hook in Schritt 4, bleibt die Instanz auf der alten Version, hat
aber keine Koroutinen mehr; der Host bekommt einen Fehler. Ein vollständig atomarer Reload
bräuchte Stufe 3 (alter Code darf weiterlaufen) — Teil derselben Tür.

**Abfrage im Terminal** (S4):

```
$ lyric-script tool.lyrs
tool.lyrs möchte:
  file   (import std.fs, Zeile 1)
  net    (import std.net.http, Zeile 2)
Erlauben? [j/N]
```

## Abweichungen von Lyric 5 (Beitrag zur Tabelle aus 00 Z3)

| Lyric 5 | Lyric-Script | Grund |
|---|---|---|
| `Map`/`Set`-Reihenfolge unspezifiziert, Einfügereihenfolge ausdrücklich verworfen (10 I8) | **Einfügereihenfolge garantiert** | Determinismus aus den Rechten (S8); Python-Erwartung an `dict` |
| SipHash mit zufälligem Prozessschlüssel (10 K2) | Schlüssel aus dem Instanz-Seed, wenn gesetzt, sonst zufällig | Determinismus (S8) ohne HashDoS-Schutz aufzugeben, wo kein Seed gesetzt ist |
| keine Capabilities (11, Sandbox → Lyric-Script) | Rechte, Budget, Isolation | Rolle der Sprache (00 Z0, Z1) |
| Panik im Export lässt das Runtime nutzbar (11 H3) | gleich, je Instanz (S11) | — (keine Abweichung, Bestätigung) |

## Begründung

**Rechte (S1–S4).** Die groben Rechte kosten nichts und stehen beim Laden fest; daraus ergibt
sich die einmalige, vollständige Abfrage vor dem Start, die Deno mangels statischer Kenntnis
nicht hat (Deno fragt mitten im Lauf). Feine Bereiche gibt es nur, wo jemand sie verlangt —
damit tragen nur diese Läufe die bekannten Pfadrisiken (Symlinks, `..`, Groß-/Kleinschreibung,
Prüfen-dann-Öffnen). Objekt-Capabilities (WASI) wären die sauberste Sandbox, hätten aber die
wichtigste Rolle (Terminal-Skripte, 00 Z1) mit einer ungewohnten `std`-API und ambienten
Wurzelobjekten belastet. Ein Rechte-Mechanismus für `std`, Host und native Module verhindert,
dass Host-Funktionen wie in 4.6 an der Sandbox vorbeigehen.

**Budget (S5).** Fuel und Deadline sind zwei Bedürfnisse (Determinismus, Zeitscheibe) an
denselben Prüfstellen. Anhalten statt Panik macht lange Arbeit über Frames verteilbar und
enthält die Panik als Host-Entscheidung (`abort`). Ohne Abrechnung schwerer Natives wäre das
Budget mit einem einzigen `repeat` zu umgehen — das Python-Modell der `std` (00 Z6) hält die
Natives wenige, aber gerade die schweren.

**Speicher (S6).** Auf dem gemeinsamen GC-Heap von Lyric 5 sieht die VM, was allokiert wird,
nicht, was lebt. Das Allokationsbudget pro Aufruf ist die ehrliche Grenze, die ohne GC-Arbeit
geht; die echte Grenze pro Instanz (Luau: Allocator je State) braucht Instanz-Zuordnung im
Lyric-5-GC.

**Hot-Reload (S7).** Statische Typen machen die Übernahme prüfbar: wo Godot (dynamisch) nach
Namen rät, vergleicht Lyric-Script Name und Typ und meldet, was übernommen, neu berechnet oder
zurückgesetzt wird. Die Regel für den Top-Level-Code fällt aus der Unterscheidung, die die
Sprache ohnehin hat: `var` ist Zustand, `let` ist abgeleitet. „Alter Code läuft nie gegen neue
Daten" ist die eine Invariante, die Stufe 2 sicher macht; deshalb werden Koroutinen abgebrochen
und alte Funktionswerte ungültig, statt weiterzulaufen.

**Determinismus und Isolation (S8, S9).** Determinismus braucht keinen eigenen Modus, wenn alle
Quellen von Nichtdeterminismus an Rechten hängen und die Sprache den Rest (Reihenfolge, Hashes,
Zufall) festlegt. Eigentum je Instanz hält Reload, Abbruch, Budget und eine spätere
Speichergrenze lokal; geteilte Objekte hätten S7 gesprengt (ein Reload von A müsste B's
Referenzen umbauen).

**Bytecode (S10).** Der Compiler ist nach 00 Z2 in jedem Host dabei; ein Verifier als
Sicherheitsgrenze wäre die größte Angriffsfläche des Systems gewesen, nur damit Mods ohne
Quelltext ausgeliefert werden können. Lua (ab 5.2) und Luau behandeln Binärcode genauso als
vertrauenswürdige Eingabe. Dass die VM in Lyric 5 speichersicher ist, begrenzt zusätzlich den
Schaden eines Fehlers in `loadTrusted`-Bytecode.

## Verworfene Alternativen

| Option | Warum nicht |
|---|---|
| Nur grobe Bits (S1 A, 4.6) | „file" heißt jede Datei; für Erweiterungen zu grob. |
| Nur feine Laufzeitprüfung (S1 B, Deno) | Jede I/O-Funktion als Sicherheitsgrenze; Javas SecurityManager scheiterte an genau diesem Muster (JEP 411). |
| Objekt-Capabilities (S1 C, WASI) | Belastet die Hauptrolle (Terminal-Skripte) mit zwei Stilen. |
| Registrieren = Freigeben (S2 A, Lua) | Eine API je Vertrauensstufe; Autor sieht nicht, was er bekommt. |
| Alles erlaubt im Terminal (S4 A, Python) | Erklärt die 4.6-Lücke zur Regel; Sandbox nur noch eingebettet. |
| Nur Flags (S4 B, Deno streng) | Gewöhnung an `-A`. |
| Selbstbeschränkung per Kopf (S4 D) | Schützt den Autor, nicht den Nutzer; zweiter Weg, Rechte anzugeben. |
| Panik bei Erschöpfung (S5b A, 4.6) | Lange Arbeit nie fertig; als `abort()` in B enthalten. |
| Wählbares Erschöpfungsverhalten (S5b C) | Zwei Formen für ein Konzept. |
| Natives kostenlos (S5c A) | Budget-Loch. |
| Allokationen auf dem Fuel-Zähler (S5c C) | Vermischt Zeit und Speicher. |
| Live-Grenze pro Instanz in 1.0 (S6 C) | Braucht GC-Arbeit in Lyric 5 vor Script 1.0; Tür (A3). |
| Neustart (S7a 0), reine Hook-Übergabe (S7a 1) | Zustand weg bzw. untypisierte Boilerplate. |
| Funktionstausch am Ort in 1.0 (S7a 3) | Eigenes Projekt; Tür. |
| Reload verweigern bei laufenden Koroutinen (S7b B) | Unbrauchbar für Koroutinen-Mods. |
| Benannte Funktionen umbinden (S7c B) | Zwei Regeln; Signaturänderung macht doch ungültig. |
| Alter Code läuft weiter (S7c C) | Liest umgebaute Daten — bricht die Typen. |
| Alles übernehmen, Top-Level nicht erneut (S7d B) | `let`-Konfiguration bleibt alt; Registrierungen brauchen Hooks. |
| Plattformübergreifender Determinismus in 1.0 (S8 C) | fdlibm-Port ohne bestätigten Bedarf; Tür. |
| Immer deterministisch (S8 D, Starlark) | Passt nicht zu *standalone*. |
| Geteilte Werte (S9 A, 4.6) | Kollidiert mit Reload, Abbruch, Budget je Instanz. |
| VM je Instanz (S9 C, Luau) | Speicher- und Startkosten je Instanz. |
| Verifier als Grenze (S10 A), signierter Bytecode (S10 C) | Größte Angriffsfläche bzw. Schlüsselinfrastruktur. |
| Vergiftete Instanz nach Panik (S11 B/C) | Ein seltener Fehler legt den Mod still; Host kann selbst neu laden. |

## Vorgaben für spätere Bereiche

- **02 Laufzeit/VM**: Prüfstellen (Rückwärtssprünge, Aufrufe) für Fuel und Deadline; Fuel je
  Grundblock; Anhalten = Rückkehr aus der Dispatch-Schleife mit aufgehobenem Frame-Stack;
  Allokationszähler im Allokationspfad; Objekte tragen ihre Instanz (S9) und eine Typversion
  (S7a, Umbau am Ort); Ressourcen-Register je Instanz (S5b `abort`); Bytecode-Cache-Schlüssel;
  `loadTrusted`.
- **03 Wertmodell**: Map/Set in Einfügereihenfolge (S8); tiefe Kopie über die Instanzgrenze (S9)
  — welche Typen kopierbar sind, und was mit nicht kopierbaren (Handles) geschieht.
- **06 Fehler**: `PermissionError`; `Cancelled` beim Reload; Ergebnisform an der Grenze (S11).
- **07 Nebenläufigkeit**: Skript-Koroutinen müssen abbrechbar sein, auch geparkt (S5b, S7b).
- **08 Programmstruktur**: Top-Level-Code-Regel beim Reload (S7d); Rechte aus Importen (S1);
  dynamisches Laden von Modulen bräuchte eine zweite Prüfung (S1) — ob es das gibt.
- **09 Syntax**: `@Migrate`, ggf. `@BeforeReload`/`@AfterReload` entfallen (Stufe 2).
- **10 Reflexion**: Hasher und Identität ohne Adressen (S8).
- **11 std**: Kostenregel je schwerem Native (S5c); `std.random` geseedet/per Recht (S8).
- **12 Werkzeuge**: Abfrage-UX, `--allow`/`-A`, `run --watch` mit Reload-Bericht.

## Anforderungen an Lyric 5

| # | Anforderung | Wann nötig |
|---|---|---|
| A3 | **Instanz-Zuordnung im GC** (Heap-Partitionen oder Abrechnung beim Markieren), damit eine Live-Speichergrenze pro Instanz möglich wird (S6 Tür) | erst wenn die Tür geöffnet wird |

## Türen

- Stufe 3 des Hot-Reload (Funktionstausch am Ort, vollständig atomarer Reload).
- Live-Speichergrenze pro Instanz (A3).
- Plattformübergreifender Determinismus (eigene Mathe-Funktionen).
- Vertrauensliste für Skripte im Terminal (S4).
