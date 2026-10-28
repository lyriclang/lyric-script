# Messsonde: Dispatch-Schleife eines Bytecode-Interpreters in Lyric 5

Status: **gemessen** (2026-10-28). Zahlen, keine Entscheidung.

## Frage

Wie gut trägt Lyric 5 (C#-Compiler → C → `zig cc`, Release `-O2`) die Dispatch-Schleife eines
Bytecode-Interpreters — und wo steht das gegen die Lyric-4.6-VM auf .NET? Bezüge: A2a (braucht
Lyric 5 eine Switch-/Sprungtabellen-Senkung?), A2d (Kosten der Indexprüfungen), V1 (Register-
gegen Stack-Maschine), Lyric 5 gegen 4.6.

## Erwartungen (vor dem ersten Lauf geschrieben, unverändert)

Maschine: Intel Core Ultra 5 228V (Lunar Lake, Lion-Cove-P-Kerne bis ~4,5 GHz), WSL2.
Programm: 8 VM-Befehle je Schleifendurchlauf, 8 verschiedene heiße Opcodes, 48 Arme im `match`.

| Variante | erwartete ns/Befehl | Begründung |
|---|---|---|
| P5 C `switch` | 0,8–1,5 | ein indirekter Sprung, Muster von 8 Befehlen, das ein moderner indirekter Prädiktor fast vollständig lernt |
| P5b C computed goto | 0,7–1,2 | wie P5, ohne Bereichsprüfung des Switch; auf neuen Kernen kaum noch Vorsprung |
| P1 Lyric 5, heiß zuerst | 1,5–2,5 | wie P5 plus 4 Indexprüfungen je Befehl (`code[pc]`, 3 Register) und geprüftes `pc += 1` / Zähler — vorhergesagte Vergleiche, aber Befehle im kritischen Pfad |
| P2 Lyric 5, heiß zuletzt | **= P1 (± 5 %)**, falls clang die `if`-Kette zu einem `switch` faltet und eine Sprungtabelle baut (erwartet: ja, SimplifyCFG faltet Vergleichsketten auf denselben Wert); falls nicht: +5–10 ns je Befehl (rund 40 zusätzliche Vergleiche) | |
| P3 Lyric 5, `Ptr` in `unsafe` | 10–30 % unter P1, wenn `Ptr.read/write/offset` inline gehen | |
| P4 Lyric 5, Stack-Maschine | ns/Befehl ähnlich P1 oder leicht darunter; ~21 statt 8 Befehle je Durchlauf, also **2–2,5× P1 je Durchlauf** | |
| P6 Lyric 4.6 VM | 6–7 (STATUS.md der 4.x-Linie: 6,1–7,3) | Switch-Dispatch in .NET, getypte Befehle |

Erwartet also: **P2 ≈ P1** (Sprungtabelle), Lyric 5 je VM-Befehl **3–5× schneller** als die
4.6-VM je ihrer Befehle; die Indexprüfungen kosten einen spürbaren, aber nicht dominanten Teil.

## Aufbau

**Das Programm** (in jeder Variante dasselbe; `n` aus `argv[1]`, Default 100 000 000, damit kein
Compiler den Bytecode falten kann):

```
i = 0; acc = 0
do {
    acc = acc +% ((i *% i) ^ k)              // k    = 0x9E3779B9
    acc = (acc -% (i & 0xFFFF)) & mask       // mask = 0x3FFF_FFFF_FFFF_FFFF
    i = i + 1
} while (i < n)
```

**Register-VM** (P1, P2, P3, P5, P5b): Befehl `@Layout(C) struct Instr { op: uint8, a: uint16,
b: uint16, c: uint16 }` (8 Byte, inline im Array), Register `uint64[]` (16), Konstanten `uint64[]`.
48 Opcodes im `match`, davon 8 heiß (`MUL XOR ADD ANDI SUB AND ADDI JLT`), 3 einmal (`LOADI LOADK
HALT`), 37 plausible Attrappen (DIV, MOD, Shifts, Vergleiche, Sprünge, CALL/RET über einen
Rahmen-Stack, LOADM/STOREM über ein Speicher-Array, MIN/MAX, CMOV …). Ausgeführt: **8n + 6**
Befehle. **Stack-VM** (P4, P4c): dieselbe Instr-Struktur, 48 Opcodes, 10 heiß
(`LOAD STORE ADD SUB MUL XOR AND ANDI ADDI JLT`), Stack `uint64[]` mit `sp`; ausgeführt **21n + 11**.
Jede Variante zählt jeden Dispatch (`executed += 1`) und druckt `acc=… executed=…`.

| Variante | was |
|---|---|
| P0 | dieselbe Rechnung als schlichte C-Schleife, ohne VM — Orakel für `acc` |
| P1 | Lyric-5-Register-VM, heiße Opcodes **zuerst** im `match` |
| P1-lto | P1 mit `--lto` |
| P1-man / -noidx / -bare | P1s **emittiertes C**, von Hand neu gebaut (`manual.sh`): unverändert (Kontrolle) / `LYR_CHECK_INDEX` leer / zusätzlich `LYR_CHECKED_ADD` ungeprüft und `LYR_LOOP_POLL` leer. Kein Lyric-Modus — nur zur Zerlegung von A2d |
| P2 | wie P1, heiße Opcodes **zuletzt** im `match` (derselbe Bytecode, nur die Armreihenfolge) |
| P3 | wie P1, Befehle und Register über `code.asPtr()` / `regs.asPtr()` und `Ptr.offset/read/write` in `unsafe {}` |
| P3-lto | P3 mit `--lto` |
| P4 | Lyric-5-Stack-VM, heiß zuerst |
| P5 / P5b | P1 in C: `switch` / computed goto (`zig cc -std=gnu11 -O2 -DNDEBUG -ffp-contract=off`, wie bench/run.py) |
| P4c | P4 in C, `switch` (Zusatz, damit V1 ohne Lyric-Prüfungen lesbar ist) |
| P6 | dieselbe Schleife als **schlichtes Lyric-4.6-Programm**, von der 4.6-VM interpretiert (in-process, `p6/`) |

Alle Lyric-5-/C-Varianten sind aus **einer** Opcode-Tabelle generiert (`gen.py`).

**Umgebung.** CPU Intel Core Ultra 5 228V (4 P- + 4 LP-E-Kerne, kein SMT), Windows 11 Pro
10.0.26200, WSL2 Arch (Kernel 6.18.54.1-microsoft-standard-WSL2, 8 vCPUs). Lyric 5:
`lyric 5.0.0+61c33e7`, Commit `61c33e73f4117cfc155ce3ce785b3cde6402a822` (origin/main, eigener
Worktree `lyric-worktrees/probe-dispatch`), `dotnet build src/Lyric5 -c Release`, Profil
`release` (`-O2 -g -DNDEBUG`, ohne `-target`, also auf diese CPU abgestimmt). C-Compiler
`zig 0.16.0` (= clang 21.1.8). Lyric 4.6: `lyric 4.6.0`, lyric-script `33339164`, `dotnet build
Lyric.slnx -c Release`, .NET 10.0.14, unter **Windows** (nicht WSL) gemessen.

**Methode.** `run.py`: jede Variante 9×, reihum (round-robin), Wandzeit und CPU-Zeit (wait4), Median;
ein Lauf mit n = 1 je Runde als Startkosten (≤ 1 ms, abgezogen = „net"). Kontrolle: alle `acc`
gleich dem Orakel P0, `executed` = 8n+6 bzw. 21n+11 — sonst INVALID. P6: `p6harness`
(Methode von `tools/Bench`): Kontrolllauf mit `ExecutionBudget` (acc + ausgeführte Befehle),
5 Läufe bei n = 10⁸ nach Aufwärmen (Median), dazu zwei Iterationszahlen (10⁷/2·10⁷) differenziert
über 9 Minima. `manual.sh` baut mit genau den Flags von `lyric5` (geprüft: die unveränderte
Einheit ergibt dasselbe Objekt; `run` von P1-man hat dieselbe Befehlsfolge wie P1s). Die Labels in
`results/p6-lyric46.txt` stammen aus der Harness-Fassung vor einer kosmetischen Änderung
(Profilname statt ganzem Record); gemessen wurde dasselbe.

**Ein verworfener Lauf.** Der erste Lauf (`results/lyric5-c-contended.md`) lief, während die
parallele Sitzung die Konformanz-Suite fuhr (loadavg 12 auf 8 vCPUs): alles 2–3× langsamer, P5
mit 1,75–3,29 s. Nicht verwendet; gemessen wurde danach auf ruhiger Maschine (loadavg < 1,1).

## Ergebnisse

`results/lyric5-c-run4.md` (n = 10⁸, 9 Läufe, loadavg 0,26 vorher). Lauf 3 (ohne die
Handvarianten) liefert dieselben Mediane auf ±3 %, Lauf 2 auf ±7 %. Alle `acc = 663007437317834240`, alle
`executed` wie erwartet — **jede Variante gültig**.

| Variante | Median s | Befehle ausgeführt | **ns/Befehl** | ns/Durchlauf | Prüfung |
|---|---:|---:|---:|---:|---|
| P0 C-Schleife ohne VM | 0,067 | (8n+6 nominell) | — | 0,67 | ok (Orakel) |
| **P1** Lyric 5, heiß zuerst | 1,042 | 800 000 006 | **1,30** | 10,4 | ok |
| P1-lto | 0,968 | 800 000 006 | 1,21 | 9,7 | ok |
| P1-man (Kontrolle) | 1,009 | 800 000 006 | 1,26 | 10,1 | ok |
| P1-noidx (ohne Indexprüfung) | 0,766 | 800 000 006 | **0,96** | 7,7 | ok |
| P1-bare (+ ohne Überlauf/Poll) | 0,736 | 800 000 006 | 0,92 | 7,4 | ok |
| **P2** Lyric 5, heiß zuletzt | 0,964 | 800 000 006 | **1,20** | 9,6 | ok |
| **P3** Lyric 5, `Ptr` | 3,091 | 800 000 006 | **3,86** | 30,9 | ok |
| P3-lto | 1,321 | 800 000 006 | 1,65 | 13,2 | ok |
| **P4** Lyric 5, Stack-VM | 2,815 | 2 100 000 011 | **1,34** | 28,1 | ok |
| **P5** C `switch` | 0,760 | 800 000 006 | **0,95** | 7,6 | ok |
| P5b C computed goto | 0,728 | 800 000 006 | 0,91 | 7,3 | ok |
| P4c C Stack-VM | 2,930 | 2 100 000 011 | 1,39 | 29,3 | ok |
| **P6** Lyric 4.6 VM, Profil release | 21,198 | 2 800 000 019 (28/Durchlauf) | **7,57** (diff.: 9,13) | 212 (diff.: 256) | ok |
| P6 Lyric 4.6 VM, Profil debug | 21,695 | 1 900 000 014 (19/Durchlauf) | 11,42 (diff.: 10,57) | 217 (diff.: 201) | ok |

P6 läuft unter Windows mit Desktop-Last (16–70 % CPU während der Messung; Spannweite der
Volläufe 19,5–23,7 s): die P6-Zahlen tragen ±15 %. P6 `acc` = 663007437317834240 (`RunEntry`).
Beiseite: der IL-Compiler der 4.x-Linie (`HostOptions.Compile = true`, release) brauchte für
dieselbe Schleife 26,6 s (266 ns/Durchlauf, Ergebnis = acc mod 2³²) — langsamer als der
Interpreter; nicht untersucht.

**`tools/Bench` der 4.6-Linie** (heute, dieselbe Maschine, Windows; Profil-Default = debug;
`results/p6-tools-bench.txt`), Interpreter-Tabelle: loopOnly 3,0 Befehle/Durchlauf 37,4 ns
→ **12,47 ns/Befehl**; intAdd 14,17; floatAdd 14,11; maskOnly 12,85; nativeSqrt 14,03;
randomFloat 12,49; arrayRead 10,38. Gegen die alte STATUS-Zeile (6,1–7,3 ns/Befehl,
loopOnly 9 Befehle/54,8 ns) sind die Befehle inzwischen verschmolzen — weniger, schwerere
Befehle: je Befehl teurer, je Durchlauf schneller.

## Codegen: Sprungtabelle, keine Kette

`lyric5 build --emit c` zeigt das `match` als `if`-Kette in Quellreihenfolge, ein Vergleich je Block
(`results/emit/p1_reg_run.c`):

```c
bb2:;
    LYR_CHECK_INDEX(t5, t4->len); t6 = &LYR_ARR_DATA(t4, lyr_ty_p1_reg_Instr)[t5];
    t7 = t6->f_op;  ...
    t13 = LYR_CHECKED_ADD(t11, t12);            // executed += 1
    t15 = (uint8_t)(t7 == t14);                 // op == 0 ?
    if (t15) goto bb4; else goto bb5;
bb5:;
    t30 = (uint8_t)(t7 == t29);                 // op == 1 ?
    if (t30) goto bb7; else goto bb8;
...
```

clang (`-O2`) faltet die Kette zu **einem** `switch` mit **48-Einträge-Sprungtabelle** — in P1,
P2 und P4 gleich (`results/asm/`). P1, Dispatch-Kopf und der ADD-Arm:

```
1015740: inc  r12                  ; pc += 1 (geprüft)
1015743: jo   <panic_overflow>
1015749: dec  r15d                 ; LYR_LOOP_POLL (Block nach dem match)
101574c: je   <safepoint>
1015752: dec  r15d                 ; LYR_LOOP_POLL (Schleifenkopf) — zweimal je Durchlauf
1015755: je   <safepoint>
101575b: mov  rax,[rdi+0x8]        ; code.length
101575f: cmp  r12,rax
1015762: jae  <panic_index>        ; code[pc]
1015768: inc  r14                  ; executed += 1 (geprüft)
101576b: jo   <panic_overflow>
1015771: movzx r10d,BYTE PTR [rdi+r12*8+0x10]   ; ins.op
1015777: cmp  r10,0x2f
101577b: ja   <default>
1015781: movzx r9d,WORD PTR [rdi+r12*8+0x12]    ; a, b, c
...
1015793: movsxd r10,DWORD PTR [rbx+r10*4]       ; Sprungtabelle
1015797: add  r10,rbx
101579a: jmp  r10                               ; der eine indirekte Sprung
101579d: mov  r10,[rsi+0x8]        ; ADD: regs.length, in jedem Arm neu geladen
10157a1: cmp  r10,rax / jbe        ; regs[b]
10157aa: cmp  r10,rdx / jbe        ; regs[c]
10157b3: cmp  r10,r9  / jbe        ; regs[a]
10157bc: mov  rdx,[r13+rdx*8]
10157c1: add  rdx,[r13+rax*8]
10157c6: jmp  1015739              ; mov [r13+r9*8],rdx → zurück zum Kopf
```

Pfadlänge eines ADD-Dispatchs: **P1 32 Maschinenbefehle**, P1-noidx 21, P5 15. Nebenbefunde:

- **P5b ist kein echtes computed goto**: clang führt die 48 `goto *labels[op]` zu **einem**
  indirekten Sprung zusammen (`jmp QWORD PTR [r11+r13*8]`) — es spart nur die Bereichsprüfung
  des Switch. Darum P5b ≈ P5.
- **`LYR_LOOP_POLL` steht zweimal je Durchlauf** (am Block nach dem `match` und am
  Schleifenkopf, `bb6` → `bb1`): zwei `dec/je` je Dispatch.
- **`regs.length` wird in jedem Arm neu geladen** — die `uint64_t`-Speicherungen in die Daten
  dürfen in C das `int64_t`-Längenfeld aliasen.
- **P3: `Ptr` ist ohne LTO ein Aufruf je Zugriff** (77 Aufrufe von `lyr_std_ffi_Ptr_uint__offset/
  read/write` in `run`, std-Instanzen liegen in einer anderen C-Einheit). Mit `--lto` inline,
  aber `offset` rechnet `address + n * sizeOf<T>()` geprüft (`add … / jo` je Zugriff), und das
  `match` wird anders gelegt (Fall 0 abgeschält, zwei Sprungtabellen 1–32 und 33–47).
- **P1-bare** (alle Prüfungen leer) hat zwei indirekte Sprünge: ohne Prüfungen dupliziert clang
  den Dispatch-Kopf.

## Befunde

**A2a — braucht Lyric 5 eine Switch-/Sprungtabellen-Senkung?** Für diese Form **nicht gemessen
nötig**: clang -O2 macht aus der `if`-Kette auf denselben Wert selbst eine Sprungtabelle. P2
(heiße Arme zuletzt, ~40 Vergleiche dahinter) ist nicht langsamer als P1 (1,20 gegen 1,30 ns;
Lauf 3: 1,22 gegen 1,29) — die Kette blieb nicht linear. Grenzen dieser Aussage: gemessen nur
für `match` über eine `uint8`-Ganzzahl mit Literal-Mustern ohne Guards, bei `-O2` mit
clang 21; nicht gemessen: Enum-Tags, Arme mit Guards/Bindungen, das Debug-Profil (`-O0`),
gcc als C-Compiler.

**A2d — Kosten der Indexprüfungen (P1 gegen P3).** P3 ist **nicht** der billigere Weg:
ohne LTO 3,0× langsamer als P1 (Aufruf je `Ptr`-Zugriff), mit LTO immer noch 27 % langsamer
(geprüfte Adressrechnung in `offset`, andere Lage des `match`). Die Prüfungskosten selbst zeigt
erst P1s eigenes C mit leerem `LYR_CHECK_INDEX`: **0,30 ns je Dispatch = 24 % von P1**
(1,26 → 0,96 ns). Überlaufprüfungen (`pc`, Zähler) und Poll zusammen: weitere 0,04 ns (3 %).
Ohne alle drei liegt Lyric-5-Code bei C (P1-bare 0,92 gegen P5 0,95 ns). Kurz: **die ganze
Lücke P1 → C (+37 %) sind die Indexprüfungen**; `Ptr` holt davon heute nichts zurück.

**V1 — Register gegen Stack (P1 gegen P4).** Je Befehl fast gleich teuer (1,34 gegen 1,30 ns),
aber der Stack braucht 21 statt 8 Befehle je Durchlauf: **2,7× langsamer je Durchlauf**
(28,1 gegen 10,4 ns). In C dasselbe Bild, schärfer: P4c 3,9× P5 je Durchlauf. Auffällig:
die Lyric-Stack-VM ist so schnell wie die C-Stack-VM (1,34 gegen 1,39 ns/Befehl) — dort
verstecken sich die Indexprüfungen hinter der Speicherabhängigkeit über `stack[sp]`.

**Lyric 5 gegen 4.6 (P1 gegen P6).** Je Durchlauf derselben Quellschleife: **P1 10,4 ns gegen
P6 200–256 ns, also ~19–25×**. Je Befehl: 1,30 gegen 7,6–11,4 ns (**6–9×**) — die Befehle sind
nicht dieselben: die 4.6-VM braucht für die Schleife 19 (debug) bzw. 28 (release) eigene
Befehle, die Register-VM 8. Nebenbefund 4.6: das release-Profil führt **mehr** Befehle aus als
debug (28 gegen 19 — es löst `brcmp` auf und legt Zwischenwerte in Slots ab:
`stloc 9; ldloc 9`), bei gleicher Zeit je Durchlauf. Unterschiedliche OS-Umgebung (P6 unter
Windows, P1 unter WSL2) auf derselben CPU.

**Erwartung gegen Messung.** P5/P5b/P2 wie erwartet; P1 besser als erwartet (1,30 statt
1,5–2,5); **P3 entgegen der Erwartung langsamer** statt 10–30 % schneller; P4 je Durchlauf
2,7× (erwartet 2–2,5×); P6 je Befehl etwas teurer als die alten 6,1–7,3 ns; der Abstand
Lyric 5 : 4.6 je Befehl größer als erwartet (6–9× statt 3–5×).

**Nicht gemessen.** Ein echtes repliziertes Threaded-Dispatch (clang fasst das computed goto
zusammen); `match` über Enums/mit Guards; gcc; macOS/ARM; P-/E-Kern-Zuordnung (WSL2 erlaubt
kein verlässliches Pinnen — die Streuung einzelner Runden bis 2× in Lauf 4 kommt daher oder
von der Nachbarsitzung, die Mediane sind über Lauf 3 und 4 stabil); P6 unter Linux; ein
Lyric-5-Interpreter mit GC-Objekten auf dem Stack (hier nur `uint64`).

## Reproduzieren

```
# WSL, eigener Worktree, Lyric-5-CLI gebaut
LYRIC5=…/src/Lyric5/bin/Release/net10.0/lyric5 bash build.sh ~/probe-dispatch
WT=…/lyric-worktrees/probe-dispatch bash manual.sh ~/probe-dispatch
python3 run.py ~/probe-dispatch/bin --runs 9 --json results/run.json
# Windows, p6/ nach außerhalb des Worktrees kopiert
dotnet build -c Release -p:LyricScript=C:\…\lyric-script
p6harness C:\…\lyric-script <results-dir> all
lyrvm disasm results/p6_release.lyrbc
```

Dateien: `gen.py` (alle Varianten; `generated/` ist seine Ausgabe, zum Lesen), `build.sh`, `manual.sh`, `run.py`, `p6/` (4.6-Harness),
`results/` (Tabellen je Lauf als `.md`/`.json`, `asm/` Disassemblate, `emit/` das emittierte C
der `run`-Funktionen, `p6*` 4.6-Ausgabe, Bytecode und Disassembly, `machine-wsl.txt`).
