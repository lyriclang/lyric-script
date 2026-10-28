# 07 — Nebenläufigkeit und Programmstruktur

Entschieden 2026-10-28 (Maintainer, im Fragedialog). Die Bereiche 07 (Nebenläufigkeit) und 08
(Programmstruktur und Module) sind auf Wunsch des Maintainers **zusammengelegt** — beide klären,
wie ein Skript läuft. Abweichungsrunde gegen Lyric 5 `design/v5/spec/06-nebenlaeufigkeit.md`
(N1–N10) und `07-module.md` (V1–V10).

## Ausgangslage

Schon entschieden: nur Koroutinen, keine Threads, kein `Mutex`/`Atomic` (02 W); Eigentum je
Instanz (01 S9); Budget hält die Instanz an (01 S5b); Reload bricht Koroutinen ab (01 S7b);
Paniken nicht fangbar, Abschottung über Tasks (05 Pn); Top-Level-Code in beiden Profilen (00 Z1);
Prelude nur mit rechtefreien Namen (02 K1a); öffentlich als Vorgabe (02 V); Rechte aus den
Importen, Abfrage vor dem Start (01 S1, S4).

Übernommen ohne Frage, weil es der größte Gewinn für Skripte ist: **Warten färbt keine Funktion**
(Lyric 5 06 N3). `let body = http.get(url)` parkt den laufenden Task; kein `async`, kein `await`
im Code; andere Tasks laufen weiter.

## Entscheidungen

| # | Frage | Entscheidung |
|---|---|---|
| End | Ende eines Skripts (*standalone*) | **Der Top-Level-Code ist ein `TaskScope`** (Lyric 5 06 T5): am Ende des Codes wird auf die selbst gestarteten Kinder gewartet; ein Fehler eines Kindes bricht die Geschwister ab und beendet das Skript mit Exit 1; `spawnDetached { … }` wird ausdrücklich nicht abgewartet. |
| Wait | Warten im eingebetteten Aufruf | **Beides**: `inst.call(f, …)` ist synchron und pumpt, bis der Aufruf fertig ist (Lyric 5 11 H2); `inst.start(f, …)` liefert ein Handle, der Host pumpt mit `inst.step()` (Lyric 5 06 S5). Dieselbe Mechanik wie `.Suspended` beim Budget (01 S5b). |
| Top | Top-Level-Code in Modulen | **Die Anweisungen eines Moduls sind sein `main`**: nur das Einstiegsmodul führt sie aus; ein Import initialisiert nur die Globalen (Abhängigkeitsreihenfolge, Lyric 5 07 V5). Hat ein Modul keine Anweisungen, aber `fn main`, ist `main` der Einstieg (übernommener Lyric-5-Code); beides ist ein Fehler („zwei Einstiege"). Eingebettet ist das instanziierte Modul der Einstieg (01 S7d). Anweisungen in einem nur importierten Modul: Lint. |
| Path | Modulpfade | **Ohne Manifest ist der Ordner des Einstiegsskripts die Wurzel, ohne Präfix** (`import helper`, `import lib.util`); **mit Manifest gilt Lyric 5** (Paketname als erstes Segment, 07 V1 M1). Eine Regel: Pfad relativ zur Wurzel, Präfix = Paketname, falls es eines gibt. `std` und Abhängigkeitsnamen sind reserviert. |
| Dep | Abhängigkeiten eines Einzelskripts | **Kopf im Skript** (Python PEP 723 / `uv`, Rust `cargo-script`): Frontmatter zwischen `---`-Zeilen am Dateianfang (Form entschieden in 09 Hd; hier zuerst als `//!` notiert) mit derselben Teilmenge wie das Manifest; beim ersten Lauf aufgelöst und gecacht (Schlüssel: Hash des Kopfs); Lock optional (`lyric-script lock tool.lyrs` → `tool.lyrs.lock`). Der Kopf enthält **keine Rechte** (01 S4); die Abfrage listet die Rechte der Abhängigkeiten mit, `native` eingeschlossen. |
| Man | Manifest | **Eigenes `lyric-script.toml`** plus `lyric-script.lock`, Schema wie Lyric 5s `lyric.toml` (`[package]` mit `name`, `version`, `edition`, `toolchain`; `[dependencies]` mit Pfad und Git; `[lints]`; `[override]`). Ein Lyric-5-Paket als natives Modul (00 Z5) ist eine gewöhnliche Abhängigkeit. |

## Nebenläufigkeit — übernommen aus Lyric 5 06 (Liste bestätigt)

| # | Regel | Script-Anpassung |
|---|---|---|
| N2 | `Coroutine<Y, R>`: `next(): ?Y`, `result()`, `isDone()`, `close()` (wirft `Cancelled`); Generator-Lambdas, `sequence { yield }`; `Coroutine :: Iterator`; kein Senden hinein | — |
| N3 | Warten ist kein `yield`: es parkt den Task; Generatoren dürfen warten; keine Färbung | — |
| N4 | `spawn { }` → `Task<T>`, `await()` als Methode, Zustände `Running`/`Done`/`Failed`/`Panicked`/`Cancelled`, `status()`; Panik im Task → `Panicked`, `await()` paniert erneut; `TaskScope`, `spawnDetached` | Top-Level ist ein Scope (End); `Task<T>` ohne `throws` (03: keine Fehler in Funktionstypen) |
| N5 | `Channel<T>` (gepuffert, ungepuffert), `select` als Builder, `sleep`, `Timer.after`, `Semaphore`; `os.signals` als Channel | **kein `Mutex`** (02 W) — `Semaphore(1)` schützt Abschnitte über Wartepunkte; Signale brauchen das Recht `os` |
| N6 | keine blockierenden Natives; I/O parkt | **ein Scheduler je Instanz**; *standalone* pumpt die Laufzeit, eingebettet der Host (Wait) |
| N8 | kooperativ; Code zwischen zwei Wartepunkten läuft ohne Geschwister-Tasks dazwischen; `yieldNow()` | Budget-Anhalten (01 S5b) hält die ganze Instanz an, kein Taskwechsel — die Invariante bleibt |
| N9 | `task.cancel()` → `Cancelled` am nächsten Wartepunkt, `scope.cancel()`, `withTimeout(d) { }`, `Cancelled` fangbar | — |
| N1, N7, N10 | Threads, Speichermodell, Thread-Sicherheit | **entfallen** (eine Instanz, ein Thread); Parallelität über **Worker-Instanzen** mit kopierten Nachrichten (01 S9) ist Tür |

## Programmstruktur — übernommen aus Lyric 5 07 (Liste bestätigt)

| # | Regel | Script-Anpassung |
|---|---|---|
| V1 | Datei = Modul; Name aus dem Pfad, kein `module`-Header, case-sensitiv; Loader dedupliziert nach Datei | Wurzel nach Path |
| V1 M7 | Exit-Codes: normales Ende 0, `exit(n)`, ungefangener Fehler 1, Panik 101; `fn main(): int` liefert den Code | Einstieg nach Top; `#!`-Zeile erlaubt |
| V5 | Modul-`let`/`var` beim ersten Import in Abhängigkeitsreihenfolge, Zyklen Fehler; `Lazy<T>` als Bibliothek; kein `init()` | **Initializer dürfen werfen** (02 K2): *standalone* Abbruch mit Exit 1, eingebettet `.Error` beim Instanziieren |
| V3 | Importe selektiv `{ f, g as h }`, qualifiziert, Alias; kein Glob; `pub import` re-exportiert; Nichtnutzungswarnung; Formatter sortiert | — |
| V2 | Sichtbarkeit | öffentlich als Vorgabe, `private` = Datei (02 V); **Lyric-5-Wörter erlaubt** (wie 05 Th): `pub` wirkungslos, `internal` = paketweit (ohne Manifest öffentlich); Importe nur über `pub import` weitergereicht |
| V3 I8 | Prelude von Lyric 5 (`panic`, `assert`, `unreachable`, `Error`, `Result`, Ranges, Kern-Interfaces, `List`/`Map`/`Set`) | **dazu `print`, `println`, `eprintln`, `readLine`, `args`, `exit`** — rechtefrei, stdin/stdout sind immer da; Verdecken warnt |
| V6 | Namensräume (Modul/Typ getrennt, Kollision Fehler, Local verdeckt Modul still mit Note) | — |
| V4 | Tests: `@Test` im Modul, `tests/`-Ordner | `lyric-script test` |
| V7 | Pakete: Semver, MVS, Lock mit Hashes, Pfad und Git, keine Registry in 1.0, `[override]`, nur Deklariertes importierbar; `edition`, `toolchain` | Manifest nach Man |
| V10 | `std` mit der Toolchain ausgeliefert und versioniert; Intrinsics nur für `std` | — |

## Abweichungen von Lyric 5 (Beitrag zur Tabelle aus 00 Z3)

| Gebiet | Lyric 5 | Lyric-Script | Grund |
|---|---|---|---|
| Top-Level-Code | keine Top-Level-Statements (07 V1 M7e), Modul ohne Rumpf (V5 G1) | Anweisungen = `main` des Moduls; nur der Einstieg führt sie aus | 00 Z1, Top |
| Programmende | `main` endet → Programm endet (06 T6) | Top-Level ist ein `TaskScope` | End |
| Modulpfad | Paketname immer vorn (07 V1 M1) | ohne Manifest ohne Präfix | Path |
| Einzeldatei | Skript-Modus nur mit `std` (11 W1 C8) | Abhängigkeiten im Kopf | Dep |
| Manifest | `lyric.toml` | `lyric-script.toml` (gleiches Schema) | Man |
| Global-Initializer | dürfen nicht werfen (07 V5 G3) | dürfen werfen | 02 K2 |
| Threads | Threads, ein Scheduler je Thread, `Mutex`, `Atomic`, Speichermodell (06 N1, N5, N7, N10) | eine Instanz = ein Thread, ein Scheduler je Instanz; `Semaphore` statt `Mutex` | 02 W |
| Prelude | ohne `println` (10 B1) | mit `print`, `println`, `eprintln`, `readLine`, `args`, `exit` | 02 K1a |

## Begründung

**Strukturiert ohne Zeremonie (End).** Lyric 5 hat strukturierte Nebenläufigkeit als Hauptform
gewählt; den Top-Level-Code als Scope zu lesen gibt Skripten genau die Erwartung („der Server
läuft, bis er fertig ist"), ohne Nodes Fehlerklasse, dass ein vergessener Timer das Programm am
Leben hält — gewartet wird nur auf das, was das Skript selbst gestartet hat.

**Zwei Aufrufformen (Wait).** Ein Spiel darf nicht stocken, weil ein Mod auf das Netz wartet;
ein Werkzeug will einen kurzen Aufruf nicht pumpen müssen. Beide Formen sitzen auf derselben
Mechanik wie das Budget-Anhalten.

**Jede Datei ist Bibliothek und Programm (Top).** Lyric 5 erlaubt `main` in jedem Modul und lässt
den Einstieg das Artefakt wählen; Script liest die Anweisungen eines Moduls als dessen `main`.
Damit bleibt Lyric 5s Grundsatz „ein Import führt nichts aus", und Pythons
`if __name__ == "__main__"` wird überflüssig. Dass `fn main` ohne Anweisungen der Einstieg ist,
hält übernommenen Lyric-5-Code lauffähig.

**Skripte ohne Projekt (Path, Dep).** Ein Skriptordner ist kein Paket; seine Module heißen so,
wie sie neben dem Skript liegen. Abhängigkeiten im Kopf halten ein Skript eine Datei — das Modell,
auf das Python (PEP 723) und Rust (`cargo-script`) zuletzt beide gekommen sind.

**Eigenes Manifest (Man).** Zwei Werkzeuge, zwei Dateinamen: ein Lyric-5-Paket, das als natives
Modul dient, und das Script-Projekt, das es nutzt, liegen nebeneinander, ohne dass ein Feld
entscheiden muss, wem die Datei gehört.

## Verworfene Alternativen

| Option | Warum nicht |
|---|---|
| Ende des Codes = Ende (End A) | Gestartete Tasks sterben ungewollt. |
| Laufen, solange etwas wartet (End B) | Vergessene Timer und Verbindungen halten das Skript ewig am Leben. |
| Nur synchron (Wait A) / nur asynchron (Wait B) | Spiel stockt bzw. jeder Host muss pumpen. |
| Import führt Anweisungen aus (Top A) | Import-Seiteneffekte, `__main__`-Muster; von Lyric 5 verworfen. |
| Anweisungen im importierten Modul als Fehler (Top C) | Hilfsmodul nicht selbst startbar. |
| Impliziter Paketname (Path A) / relative Importe (Path C) | Umbenennen bricht Importe bzw. zweite Pfadform. |
| Nur mit Manifest (Dep A) / URL-Importe (Dep C) | Projekt für jedes Skript bzw. Version je Importzeile; Deno hat es verlassen. |
| Gemeinsames `lyric.toml` (Man B) | Feld entscheidet über den Leser; ein Ordner kann nicht beides sein. |

## Folgen für spätere Bereiche

- **09 Syntax**: Form des Abhängigkeitskopfs (entschieden: Frontmatter `---`); `;` als Trenner auf einer Zeile;
  `spawn { }`, `withTimeout(d) { }`.
- **11 Laufzeit**: Scheduler je Instanz über Lyric-5-Koroutinen oder VM-Frames; `call`/`start`/
  `step` an der Einbettungsschnittstelle; Abbruch geparkter Skript-Koroutinen (01 S5b).
- **12 Standardbibliothek**: Prelude-Liste; `std.task`, `std.os.signals`, `readLine`.
- **13 Werkzeuge**: `lyric-script run|test|lock`, Cache der Kopf-Abhängigkeiten, Lint für
  Anweisungen in nur importierten Modulen.
