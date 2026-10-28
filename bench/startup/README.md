# Messpunkt 2: Start von `hello.lyrs`, warm und kalt

Status: **gemessen** (2026-10-28). Ratchets aus design/v1/spec/11 Perf: `hello.lyrs` warm
(Bytecode aus dem Cache) **≤ 10 ms**, kalt **≤ 50 ms**.

**Kurz:** warm **1,36 ms**, kalt **1,66 ms** (release, Median) — beide Ratchets halten, mit 7×
und 30× Abstand. Alle 240 Läufe gültig. Beides liegt *unter* der Erwartung: der Start ist fast
ganz Prozess- und Laufzeit-Init; `hello` zu übersetzen kostet ~0,3 ms, so wenig, dass der Cache
hier kaum spart.

## Frage

Wie lange braucht `lyric-script run hello.lyrs` vom Prozessstart bis zum Ende — warm, wenn der
Bytecode im Cache liegt (S2g), und kalt, wenn das Skript erst übersetzt und der Cache
geschrieben wird? Halten die Ratchets?

## Erwartungen (vor dem ersten Lauf geschrieben)

Grundlage: Messpunkt 1 (`bench/README.md`): das Release-Binary braucht für ein leeres
Bytecode-Programm (Start, Laufzeit-Init, eine Task, Datei lesen, assemblieren) 2,1–2,5 ms
Wandzeit unter WSL2 auf derselben Maschine.

| Fall | Was dazukommt | Erwartet (release) |
|---|---|---:|
| warm | Quelle lesen, SHA-256 über ~25 Byte, Cache-Datei (~1 KB) lesen, dekodieren, Strukturprüfung, ein `println` | **2–4 ms** |
| kalt | statt des Lesens: Lexer, Parser, Checker, Codegen einer Zeile (Mikrosekunden), dazu der Cache geschrieben (Verzeichnis, Datei, `rename`) | **3–6 ms** |

Beide Ratchets halten also mit großem Abstand (warm ≥ 2,5×, kalt ≥ 8×). Kalt soll höchstens
1–2 ms über warm liegen; liegt es weit darüber, kostet etwas anderes als das Übersetzen (das
Schreiben des Caches, die Initialisierung der Compiler-Module). Das Debug-Profil erwarte ich
1,5–3× langsamer.

## Methode

`run.py`: je Profil (release, debug) eine Aufwärmrunde und 30 Läufe je Fall, abwechselnd.
**Warm**: ein Cache-Verzeichnis, das der erste Lauf füllt (`LYRIC_SCRIPT_CACHE`). **Kalt**: für
jeden Lauf ein neues, leeres Cache-Verzeichnis. Gemessen wird die Wandzeit des ganzen Prozesses
(`perf_counter` um `subprocess.run`). Bericht: Median, Minimum, 90. Perzentil.

**Kontrolle**: jeder Lauf muss `Hello, world!` ausgeben und mit 0 enden; nach jedem kalten Lauf
muss genau eine Cache-Datei existieren (der Lauf hat übersetzt und geschrieben), vor jedem warmen
Lauf liegt sie schon da. Ein Lauf, der das nicht erfüllt, ist ungültig.

## Aufbau

Intel Core Ultra 5 228V (4 P- + 4 LP-E-Kerne), Windows 11, WSL2 (Kernel
6.18.54.1-microsoft-standard-WSL2, 8 vCPUs), Netzbetrieb. Lyric-Script `s2/frontend` nach S2g
(Commit `283d0da`; `diff -rq` zeigte das gemessene Paket gleich dem Worktree), gebaut mit dem
gepinnten Lyric 5 `c2e88a96` in beiden Profilen (release 11,8 MB, debug 5,4 MB). Skript und Cache
auf dem Linux-Dateisystem (`/tmp`), nicht unter `/mnt/c`. Gemessen, als die 1-Minuten-Last unter
1,0 lag (am Anfang 0,95; eine parallele Sitzung hatte WSL vorher bis 6,9 belastet).

## Ergebnisse

Wandzeit des ganzen Prozesses, 30 Läufe je Zelle, abwechselnd kalt und warm
(`results/run1.json` hält jede Einzelzeit).

| Profil | warm Median | warm Min | warm p90 | kalt Median | kalt Min | kalt p90 |
|---|---:|---:|---:|---:|---:|---:|
| release | **1,36 ms** | 1,12 | 4,51 | **1,66 ms** | 1,35 | 2,09 |
| debug | 1,64 ms | 1,35 | 3,70 | 2,25 ms | 1,89 | 3,55 |

Ein erster Lauf (19:26) maß versehentlich eine Binary, in der noch die Mutation einer Kontrolle
steckte (die Versionsprüfung des Caches aus; für die Zeit belanglos, für den Bericht nicht): release
warm 1,77, kalt 2,08 ms; debug 1,96 und 2,88 ms. Er wurde mit dem sauberen Bau wiederholt; die
Läufe liegen um bis zu 25 % auseinander — die Streuung der Maschine, nicht des Programms.

**Kontrolle:** alle 240 Läufe (2 Profile × 2 Fälle × 30, ohne die Aufwärmrunden) gaben
`Hello, world!` aus, endeten mit 0, und nach jedem Lauf lag genau eine Cache-Datei da — keiner
ist ungültig.

## Urteil

- **warm ≤ 10 ms: hält** — 1,36 ms (p90 4,51 ms).
- **kalt ≤ 50 ms: hält** — 1,66 ms (p90 2,09 ms).

## Erwartung gegen Messung

- Beide Fälle liegen **unter** der Erwartung (warm 2–4, kalt 3–6 ms): der Prozess startet etwas
  schneller als das leere Programm von Messpunkt 1 (2,1–2,5 ms) — dort wurde Bytecode-Text erst
  assembliert —, und das Übersetzen kostet weniger als gedacht.
- **Kalt minus warm: 0,3 ms** in release (in beiden Läufen), 0,6 ms in debug — das Übersetzen einer Zeile und das
  Schreiben des Caches. Für `hello` spart der Cache also kaum etwas; ob er sich lohnt, zeigt erst
  ein größeres Skript (Zeit des Übersetzens wächst mit der Quelle, das Lesen des Caches kaum).
  Nicht gemessen; ein Fall für Messpunkt 3 (S7), wenn die Zielprogramme laufen.
- Debug ist nur 1,2× (warm) bis 1,4× (kalt) langsamer, nicht 1,5–3×: im Start rechnet fast nichts,
  was ein Optimierer beschleunigt.

## Grenzen

- Ein Skript aus einer Zeile; der Aufwand des Compilers für echte Skripte ist hier nicht gemessen.
- Eine Maschine, WSL2, kein Pinnen auf P-Kerne; die p90 liegt bis 3,3× über dem Median, zwei Läufe
  um bis zu 25 % auseinander.
- Der Cache liegt in `/tmp` (tmpfs): auf einer Platte kostet das Schreiben im kalten Fall mehr.

## Reproduzieren

```
# WSL, im Paket (lyric.toml, src, tests, examples) auf dem Linux-Dateisystem:
lyric5 build --profile release && lyric5 build
cp examples/scripts/hello.lyrs /tmp/hello.lyrs
python3 bench/startup/run.py --binary release=out/release/x86_64-linux-gnu/lyric-script \
    --binary debug=out/debug/x86_64-linux-gnu/lyric-script --script /tmp/hello.lyrs --runs 30 \
    --out bench/startup/results/run1.json
```
