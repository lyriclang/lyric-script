# Messpunkt 1: Durchsatz der Lyric-Script-VM gegen die Lyric-4.6-VM

Status: **gemessen und entschieden** (2026-10-28). Die Zahlen hier; die Entscheidung in
design/v1/spec/11 (Offen) und 14 (S1): V3 bleibt A', kein Neuzuschnitt (verfehlt um weniger als
2×), der Aufrufpfad ist der erste Hebel vor Messpunkt 3.

**Kurz:** Script ist **3,2–3,5× (fib), 6,0× (loop), 4,0–4,2× (objects)** schneller als die
4.6-VM (Profil release, Wandzeit des ganzen Prozesses), geometrisches Mittel **4,3×** (ohne
Startkosten 3,8–3,9×). Der Ratchet ≥ 5× hält nur für `loop`; `fib` und `objects` verfehlen ihn,
keiner um mehr als 2× (alle ≥ 2,5×; `fib` ohne Startkosten mit 2,7× am knappsten). Kontrolle:
alle 216 Läufe (189 gezählte, 27 Aufwärmläufe) liefern das Orakel. lyric#610 (A4) ist **offen**.

## Frage

Wie schnell führt die neue VM (`src/vm/interp.lyr`, Lyric 5 → C → `zig cc`, Profil `release`)
handgeschriebenen Bytecode aus — gegen die Lyric-4.6-VM (C#/.NET, Interpreter), dieselben
Programme, dieselbe Maschine, dasselbe OS (WSL2)? Hält der Ratchet **Script ≥ 5× 4.6**?

## Erwartungen (vor dem ersten Lauf geschrieben, 2026-10-28 17:31, unverändert)

Grundlage: die Dispatch-Sonde (`design/v1/probes/dispatch/`): eine schlanke Lyric-5-Register-VM
(P1, nur `uint64`-Register, `match` über `uint8`) 1,3 ns/Befehl, die 4.6-VM 7,6–11,4 ns/Befehl
und 2–3,5× mehr Befehle je Quellschleife → 19–25× je Durchlauf; die Werte-Sonde: +2,4 ns je
Speicherung eines Interface-Werts (A4, lyric#610). Die echte VM ist schwerer als P1: `Op` als
Enum, Register über `bs + a`, geprüfte Arithmetik über `checked*` (Optional), zwei
Registerdateien, `HeapRef`-Interface-Werte (16 Byte) mit Schreibbarriere, Frames in einer
`List<CallFrame>`, `new` = drei GC-Objekte (Objekt + zwei Felder-Arrays).

| Programm | Script erwartet | 4.6 erwartet | **Verhältnis erwartet** | Ratchet ≥ 5× erwartet |
|---|---|---|---:|---|
| B1 `fib` (Aufrufe) | 25–50 ns je Aufruf (Ø 5,5 Befehle + `call`/`ret` über die `List`) | 120–300 ns je Aufruf | **3–8×** | auf der Kippe |
| B2 `loop` (Dispatch + `int`) | 12–25 ns je Durchlauf (5 Befehle, einer davon `rem` = 64-Bit-Division) | 100–250 ns je Durchlauf | **6–15×** | hält |
| B3 `objects` (Allokation + Felder) | Aufbau 100–200 ns je Knoten (3 Allokationen, 2 Barrieren); Lauf 15–30 ns je Knoten (5 Befehle, zwei Typtests, ein Ref-Move mit Barriere) | Aufbau 50–150 ns, Lauf 40–100 ns je Knoten | **2–4×** | verfehlt, aber nicht um mehr als 2× (≥ 2,5×) |
| Start (leeres Programm) | 1–5 ms (natives Binary, Laufzeit-Init, ein Task) | 60–150 ms (.NET-Start, JIT der VM, kein ReadyToRun) | — | — |

**Geometrisches Mittel erwartet: 4–8×**, also um die Linie. Erwartete Rangfolge der
Verhältnisse: B2 > B1 > B3 — die neue VM gewinnt am meisten beim reinen Dispatch und am wenigsten
dort, wo Referenzen bewegt werden (Interface-Werte, Barriere, Typtests). Erwartet für lyric#610:
**offen** (gestellt heute). Erwartet: keine Kontroll-Abweichung (beide Seiten rechnen in 64-Bit
ohne Überlauf; die Ergebnisse sind geschlossen nachrechenbar).

**Zusatz, geschrieben nach Lauf 1 und vor Lauf 2** (lyric#610 ist offen, also verlangt S1h
„Referenz-Moves messen"): B3 mit ROUNDS = 1 (`objects1`) trennt den Aufbau vom Lauf über die
Liste. Erwartet, schon von Lauf 1 beeinflusst (B3 gesamt dort ~34 ns je besuchtem Knoten in
Script): Script-Aufbau 10–20 ms je 10⁵ Knoten (100–200 ns je Knoten), Lauf 28–32 ns je Knoten,
also **5,5–6,5 ns je VM-Befehl im Lauf gegen ~3,2 ns in B2** — der Aufpreis der Referenzarbeit
(`get.r` mit Barriere, zwei Typtests in `same`). 4.6: Aufbau 5–15 ms, Lauf 100–120 ns je Knoten.

## Aufbau

**Programme** — je eines als `.lyrsasm` (hier) und als idiomatisches 4.x-Programm (`v46/`),
derselbe Algorithmus, dieselbe Ausgabe. Die Größen sind so gewählt, dass die 4.6-VM 0,6–1,0 s
braucht (ein Kalibrierlauf vor der Messung: fib(30) lag dort bei ~0,37 s, darum fib(32)).

| Programm | Inhalt | Orakel | VM-Befehle je Einheit: Script / 4.6 release / 4.6 debug |
|---|---|---:|---|
| `empty` | `main` gibt 0 aus | 0 | — |
| B1 `fib` | fib(32) rekursiv, 7 049 155 Aufrufe | 2178309 | innerer Aufruf 8 / 11 / 11, Blatt 3 / 3 / 3 |
| B2 `loop` | 10⁷ × `acc = (acc + i*i) % 1000003` | 990548 | Durchlauf 5 / 16 / 11 |
| B3 `objects` | Liste aus 10⁵ Knoten (`int` + Referenz), 50× summiert | 249997500000 | Aufbau 6 / 23 / 18 je Knoten, Lauf 5 / 18 / 18 je Knoten |
| `objects1` (Zusatz, nur Lauf 2) | B3 mit 1 Runde | 4999950000 | wie B3 |

Die Script-Programme sind handgeschrieben, wie ein ordentlicher Compiler sie ausgäbe: Schleifen
rotiert (Test unten, B2 mit dem fusionierten `jump.lt.i`), keine Abkürzungen über den
Algorithmus hinaus. Die 4.6-Befehle stammen von `lyrc` (`results/v46-*.disasm.txt`); das
release-Profil inlined die obersten Ebenen des `fib`-Baums in `main` (127 Aufrufstellen dort —
gegen 7 Mio. Aufrufe vernachlässigbar; `fib` selbst ist in beiden Profilen gleich) und legt in Schleifen Zwischenwerte in Slots (`stloc`/`ldloc`) — mehr Befehle
als debug, wie schon in der Dispatch-Sonde.

**Maschine.** Intel Core Ultra 5 228V (4 P- + 4 LP-E-Kerne, kein SMT), Windows 11 Pro
10.0.26200, WSL2 Arch Linux (Kernel 6.18.54.1-microsoft-standard-WSL2, 8 vCPUs), Energieschema
„Ausbalanciert". **Netzbetrieb in beiden Messläufen** (`BatteryStatus` 2 vor und nach jedem
Lauf; beim Sitzungsbeginn lief das Gerät auf Akku, 21 %, um 17:42 wurde es angeschlossen —
`results/power.txt`). Beide VMs liefen unter WSL2 aus dem Linux-Dateisystem.

**Stände.** Lyric-Script: Worktree `s1/vm-core`, Commit `85b4651b50140913bab6e78ed3efbe9039cefc53`
(`src/` unverändert), gebaut mit dem gepinnten Lyric 5 `c2e88a9620b1ae37bd1c9a35c415a243121eeefa`
(`lyric 5.0.0+c2e88a9`, `lyric5 build --profile release`, zig 0.16.0, ohne LTO), Binary 3,5 MB.
Lyric 4.6: Tag `v4.6-final` (Commit `33339164f0a9785336ece22deec4b933d2101260`), `lyrc` und
`lyrvm` mit `dotnet build -c Release` (Restore offline aus dem lokalen Paket-Cache), .NET
10.0.12. Programme mit `lyrc build --profile release` (Hauptzahl — die Spec misst gegen
„4.6 Release") und `--profile debug` (zum Vergleich) übersetzt, ausgeführt mit
`lyrvm run X.lyrbc`: der **Interpreter**, Default ohne `--jit`; .NET mit seinen Defaults
(Tiered Compilation, OSR).

## Methode

`run.py`: je Messlauf eine Aufwärmrunde (nicht gezählt) und **7 Runden**, reihum (jede Runde
alle Programme in allen drei VM-Varianten, die Reihenfolge der VMs rotiert je Runde). Gemessen
wird die Wandzeit des ganzen Prozesses (`perf_counter` um `subprocess.run`, also Start, Laden,
Ausführen, Ausgabe, Ende) und die CPU-Zeit des Kindes (rusage). Bericht: **Median**; „netto" =
Median minus Median des leeren Programms derselben VM. Vor jedem Lauf wartete das Skript, bis die
1-Minuten-Last in WSL zweimal hintereinander unter 1,0 lag (die parallele Sitzung fuhr bis 17:45
Testsuiten, loadavg bis 12); während der Läufe 0,67–0,88. Lauf 1 (17:46) ist der Messpunkt,
Lauf 2 (17:50) dieselbe Messung zur Prüfung der Stabilität plus `objects1`.
`derive.py` rechnet die Zahlen je Einheit (`results/derived.txt`).

## Ergebnisse

Mediane in Sekunden (Wandzeit), 7 Läufe je Zelle. Lauf 1 | Lauf 2.

| Programm | Script | 4.6 release | 4.6 debug |
|---|---:|---:|---:|
| `empty` | 0,002 \| 0,002 | 0,090 \| 0,091 | 0,092 \| 0,100 |
| B1 `fib` | 0,199 \| 0,194 | 0,692 \| 0,610 | 0,659 \| 0,616 |
| B2 `loop` | 0,163 \| 0,152 | 0,973 \| 0,905 | 0,876 \| 0,786 |
| B3 `objects` | 0,171 \| 0,160 | 0,677 \| 0,671 | 0,712 \| 0,695 |
| `objects1` | — \| 0,024 | — \| 0,165 | — \| 0,167 |

**Verhältnis 4.6 / Script** (Lauf 1 | Lauf 2):

| Programm | release brutto | release netto | debug brutto | debug netto | Ratchet ≥ 5× (release) |
|---|---:|---:|---:|---:|---|
| B1 `fib` | **3,47 \| 3,15** | 3,05 \| 2,71 | 3,31 \| 3,18 | 2,88 \| 2,70 | **verfehlt**, nicht um > 2× |
| B2 `loop` | **5,98 \| 5,96** | 5,50 \| 5,45 | 5,38 \| 5,18 | 4,88 \| 4,60 | **hält** |
| B3 `objects` | **3,96 \| 4,20** | 3,48 \| 3,69 | 4,17 \| 4,35 | 3,68 \| 3,79 | **verfehlt**, nicht um > 2× |
| geom. Mittel | **4,35 \| 4,29** | 3,88 \| 3,79 | 4,20 \| 4,16 | 3,73 \| 3,61 | **verfehlt**, nicht um > 2× |

Das Verhältnis der CPU-Zeiten weicht davon um höchstens 0,07 ab (`results/run*.txt`). Die
Mediane beider Läufe liegen für Script um 2–7 %, für 4.6 um 1–13 % auseinander (am meisten
`fib` release: 0,692 gegen 0,610); innerhalb einer Zelle reicht die Spannweite (max/min) bis
1,9× (Lauf 1) bzw. 1,6× (Lauf 2) — WSL2 pinnt nicht an P-Kerne. Die Verhältnisse beider Läufe
liegen trotzdem um höchstens 0,35 auseinander (`fib`), sonst um ≤ 0,3.

**Je Einheit** (netto; Lauf 2, in Klammern Lauf 1; Befehlszahlen aus der Tabelle oben):

| | Script | 4.6 release | 4.6 debug |
|---|---:|---:|---:|
| Start (leeres Programm) | 2,5 ms (2,1) | 91 ms (90) | 100 ms (92) |
| B1 je Aufruf | 27,1 ns (28,0) | 73,6 ns (85,4) | 73,2 ns (80,5) |
| B1 je VM-Befehl | 4,9 ns (5,1) | 10,5 ns (12,2) | 10,5 ns (11,5) |
| B2 je Durchlauf | 14,9 ns (16,1) | 81,4 ns (88,3) | 68,6 ns (78,4) |
| B2 je VM-Befehl | 3,0 ns (3,2) | 5,1 ns (5,5) | 6,2 ns (7,1) |
| B3 Lauf je Knoten (aus `objects` − `objects1`) | 27,6 ns | 103,3 ns | 107,8 ns |
| B3 Lauf je VM-Befehl | 5,5 ns | 5,7 ns | 6,0 ns |
| B3 Aufbau je Knoten (Rest von `objects1`) | 191 ns | 635 ns | 562 ns |

Je VM-Befehl ist Script in B2 1,7× (gegen debug 2,1×) und im B3-Lauf kaum (1,04×) schneller als
4.6 — dort kommt der Vorsprung fast ganz daher, dass die Registermaschine 2,2–3,6× weniger Befehle
braucht. In B1 ist es umgekehrt: kaum weniger Befehle (innerer Aufruf 8 gegen 11, Blatt 3 gegen
3), dafür je Befehl samt Aufruf 2,1× schneller. Die Dispatch-Sonde (P1, 1,3 ns/Befehl, „6–9× je
Befehl") überträgt sich nicht: die echte VM kostet je skalarem Befehl ~2,3× P1, je Befehl mit
Referenzarbeit ~4×. (Befehle verschiedener Befehlssätze sind nur grob vergleichbar; 4.6s
`ldloc`/`stloc` sind billig.)

## Kontrolle

Jeder Lauf druckt sein Ergebnis; `run.py` vergleicht es mit dem Orakel (geschlossen bzw. in
Python nachgerechnet) und markiert eine Abweichung als INVALID. **Alle 216 Läufe gültig** (Lauf 1:
96, Lauf 2: 120, je einschließlich Aufwärmrunde), Exit-Code überall 0 — kein Paar ist entwertet.
Schon der Rauchlauf vor der Messung lieferte in beiden VMs dieselben Ergebnisse (fib(30) =
832040).

## Urteil je Ratchet (Script ≥ 5× 4.6, Hauptzahl: release, brutto)

- **B1 `fib`: verfehlt** — 3,15–3,47× (netto 2,71–3,05×). Nicht um mehr als 2× (≥ 2,5×), aber
  netto nur knapp darüber: der schwächste Punkt der Messung sind die **Aufrufe**.
- **B2 `loop`: hält** — 5,96–5,98× (netto 5,45–5,50×). Gegen das debug-Profil netto 4,6–4,9×,
  also knapp darunter.
- **B3 `objects`: verfehlt** — 3,96–4,20× (netto 3,48–3,69×), nicht um mehr als 2×.
- **Geometrisches Mittel: verfehlt** — 4,29–4,35× (netto 3,79–3,88×), nicht um mehr als 2×. Die
  Regel „verfehlt um mehr als 2× → Plan neu schneiden" (11 Perf) greift damit **nicht**; das Ziel
  selbst ist verfehlt. (Der Ratchet gilt laut 11 Perf für die Bench-Suite — Messpunkt 3 in S7;
  Messpunkt 1 ist eine Mikro-Bench.)

## Erwartung gegen Messung

- **Script-Seite wie erwartet**: je Aufruf 27–28 ns (erwartet 25–50), je B2-Durchlauf 15–16 ns
  (12–25), B3-Lauf 27,6 ns je Knoten (15–30, oberer Rand; Zusatz 28–32: knapp darunter), Aufbau
  191 ns je Knoten (100–200, oberer Rand), Start 2,1–2,5 ms (1–5).
- **4.6 schneller als erwartet**: je Aufruf 74–85 ns (erwartet 120–300), je B2-Durchlauf
  69–88 ns (100–250) — die Erwartung stützte sich auf die P6-Zahlen der Dispatch-Sonde, unter
  Windows mit Desktop-Last und mit einer anderen, längeren Schleife gemessen. B3-Lauf 103–108 ns
  (40–100, knapp darüber; Zusatz 100–120: getroffen). B3-Aufbau 56–64 ms statt 5–15 ms: in einem
  165-ms-Prozess steckt darin vermutlich das Aufwärmen der .NET-Tiered-Compilation (nicht
  getrennt). Start 90–100 ms (60–150).
- **Verhältnisse am unteren Rand**: fib 3,2–3,5 (erwartet 3–8), loop 6,0 (6–15), objects 4,0–4,2
  (2–4, knapp darüber), Mittel 4,3 (4–8). **Rangfolge anders als erwartet**: B2 > B3 > B1 statt
  B2 > B1 > B3 — nicht die Referenzen, sondern die Aufrufe sind die teuerste Stelle relativ zu 4.6.
  Warum, ist nicht zerlegt; Kandidaten im Aufrufpfad von `interp.lyr`: `List<CallFrame>`-`push`/
  `pop` (Optional), `module.functions[a]`, zwei Wachstumsprüfungen, `spend` je Aufruf.
- lyric#610 wie erwartet offen; keine Kontroll-Abweichung, wie erwartet.

## Für die Entscheidung V3 (nur Zahlen)

- **lyric#610 (A4): `OPEN`** (`gh issue view 610 --repo lyriclang/lyric`, 2026-10-28 ~17:38 und
  ~17:53; letzte Änderung 15:56 UTC).
- Im B3-Lauf kostet ein Script-Befehl 5,5 ns, in B2 3,0 ns (und B2 enthält eine 64-Bit-Division):
  die Referenzarbeit (`get.s`/`get.r` mit Typtest `is ScriptObject`, `same` mit bis zu zwei
  Typtests, 16-Byte-Ladungen, die Speicherung von `get.r` ins Register mit Barriere) kostet grob
  **≥ 12 ns der 27,6 ns je Knoten**. Davon entfällt auf die eine Interface-Speicherung je Knoten
  nach der Werte-Sonde (+2,4 ns) etwa **2,4 ns ≈ 9 %** — Schätzung, hier nicht gemessen.
- Selbst wenn A4 diese 2,4 ns ganz wegnähme, stiege das Verhältnis des B3-Laufs von 3,7× auf
  rund 4,1× (103,3 / 25,2) — **A4 allein hebt B3 nicht über 5×**. Ein eigener Messfall nur für
  Referenz-Moves (`move.r`-Schleife) wurde nicht gebaut.
- Aufbau: 191 ns je Knoten = drei GC-Allokationen (`ScriptObject` + zwei Felder-Arrays) und zwei
  Interface-Speicherungen; schneller als 4.6s 562–635 ns, deren Zahl aber das JIT-Aufwärmen enthält.

## Grenzen

- Eine Maschine, WSL2, kein Pinnen (P-/LP-E-Kerne); Spannweite je Zelle bis 1,9×. Der
  Windows-Wirt lief nicht leer: 30–65 % CPU bei Laufbeginn (andere Sitzungen, Defender), die
  WSL-Last lag unter 0,9.
- Brutto enthält den Start: bei 4.6 ~90 ms je Prozess (.NET-Laufzeit, JIT), bei Script ~2 ms.
  „Netto" zieht den Median des leeren Programms ab und nimmt an, dass die Startkosten nicht vom
  Programm abhängen — für 4.6 nur näherungsweise (Tiered Compilation wärmt je Programm anders auf).
- Mikro-Bench aus drei Programmen: keine Strings, Arrays, Closures, Maps, Ausnahmen; wenig
  GC-Druck (3 · 10⁵ Objekte). Der Script-Bytecode ist handgeschrieben (rotierte Schleifen,
  fusionierter Vergleich+Sprung) — die Verhältnisse gelten nur, wenn der S2-Compiler mindestens
  so guten Code erzeugt.
- 4.6 lief mit .NET 10.0.12 unter Linux; die Dispatch-Sonde maß 4.6 mit 10.0.14 unter Windows.
- Ohne LTO (Release-Default von Lyric 5); `--lto` gab in der Dispatch-Sonde ~7 %.
- Die Zerlegung von B3 (Aufbau/Lauf) beruht auf einem Lauf (Lauf 2) und auf der Differenz
  zweier Mediane.

## Reproduzieren

```
# WSL. Lyric 4.6:
git clone /mnt/c/Users/Olivier/CLionProjects/lyric-script ~/dev/projects/lyric46
git -C ~/dev/projects/lyric46 checkout v4.6-final
cd ~/dev/projects/lyric46
dotnet restore src/Lyrc/Lyrc.csproj --source ~/.nuget/packages     # ebenso src/Lyrvm/Lyrvm.csproj
dotnet build src/Lyrc/Lyrc.csproj -c Release --no-restore           # ebenso src/Lyrvm/Lyrvm.csproj
# Lyric-Script: lyric.toml, src, tests, examples nach ~/dev/projects/lyric-script-bench kopieren
lyric5 build --profile release                                     # gepinnter lyric5 (script-pin)
# Messung (aus dem Worktree):
bash bench/prepare.sh                                              # Kopie, lyrc, Disassembly, machine.txt
python3 bench/run.py --script ~/dev/projects/lyric-script-bench/out/release/x86_64-linux-gnu/lyric-script \
    --lyrvm ~/dev/projects/lyric46/src/Lyrvm/bin/Release/net10.0/lyrvm \
    --dir ~/dev/projects/lyric-script-bench/bench --runs 7 --out bench/results/run1.json
python3 bench/derive.py bench/results/run1.json bench/results/run2.json
```

Dateien: `*.lyrsasm` (Script), `v46/*.lyr` (4.x), `prepare.sh`, `run.py`, `derive.py`;
`results/`: `run1.json`/`run2.json` (alle Einzelzeiten), `run1.txt`/`run2.txt` (Tabellen),
`run1.log`/`run2.log` (Vorbereitung und Warten auf Leerlauf), `derived.txt`, `machine.txt`,
`power.txt`, `v46-*.disasm.txt` (4.6-Bytecode beider Profile). Lauf 1 lief mit `run.py` ohne
`objects1`; sonst identisch.
