# Messpunkt 2: Start von `hello.lyrs`, warm und kalt

Status: **Erwartung geschrieben** (2026-10-28, vor der ersten Messung). Ratchets aus
design/v1/spec/11 Perf: `hello.lyrs` warm (Bytecode aus dem Cache) **≤ 10 ms**, kalt **≤ 50 ms**.

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
