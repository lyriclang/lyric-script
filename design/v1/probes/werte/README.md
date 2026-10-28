# Messsonde: Werte, Rahmen und Zeugen einer VM in Lyric 5

Status: **gemessen** (2026-10-28). Zahlen, keine Entscheidung.

## Fragen

Bereich 11 (die VM von Lyric-Script in Lyric 5), vorläufiger Entwurf: Register-VM; Rahmen und
Objekte halten `scalars: uint64[]` und `refs: HeapRef[]`, `interface HeapRef` von den VM-Klassen
implementiert und möglichst auch von `string` (`extend string :: HeapRef`); Generics hybrid
(.NET-artig: eine geteilte Instanz für Referenztypen, Aufrufe über eine Zeugentabelle).

1. **W1 — Koerzion in einen Interface-Wert**: alloziert der Übergang von `string`, Klasseninstanz,
   kleinem Struct, `int` zu einem Interface-Wert? Ist `extend string :: [I]` / `extend int :: [I]`
   im Programm erlaubt? Was kostet er je Übergang, was wird daraus in C?
2. **W2 — Rahmenlayout in der Dispatch-Schleife**: die Register-VM der Dispatch-Sonde mit einer
   Last aus Skalararithmetik *und* Referenzbewegungen; getrennte Dateien gegen Zwei-Wort-Slots.
3. **W3 — Zeugenaufruf**: Nachschlagen in einer Tabelle mit String-Schlüsseln, Hash und Gleichheit
   direkt (monomorphisiert) gegen über eine Interface-Tabelle (geteilte Instanz).

## Vorab gesehen (vor den Erwartungen, ehrlich vermerkt)

Bevor die Erwartungen unten geschrieben wurden, lagen vor: (1) eine Machbarkeitsprobe
(`extend string/int :: [HeapRef]` übersetzt; je ein Übergang string/int/Struct zählte eine
Allokation, Klasse keine; Summe 64 B), (2) das emittierte C des Übergangs (`CEmitter.cs`:
`MakeInterface` auf Klasse = Fat Pointer bauen, sonst `lyr_alloc` einer Box), (3) Rauchläufe aller
Programme bei voller Last der Nachbarsitzung (loadavg 12 auf 8 vCPUs) — nur zur Prüfung der
Prüfsummen, Zeiten unbrauchbar und nicht verwendet, (4) das emittierte C der W2-Arme: jede
Speicherung eines Werts mit Referenz (Interface-Wert, `Value`-Slot im Ganzen) läuft durch
`LYR_WRITE_BARRIER_VALUE` (Kartenmarkierung über die Zeilen des Slots); eine Speicherung nur in
`.bits` nicht. W1-Allokationszahlen sind damit keine echte Vorhersage mehr; die Zeiten schon.
Nach Lauf 1 kamen zwei Varianten dazu (W3 `hash` und `mbox`, zur Zerlegung); sie haben keine
Erwartung.

## Erwartungen (vor dem ersten gültigen Lauf geschrieben, unverändert)

Maschine wie in der Dispatch-Sonde (Intel Core Ultra 5 228V, WSL2), Release-Profil.

**W1** (n = 10⁷, Schleife `refs[i & 15] = x`):

| Modus | Allokationen/Übergang | ns/Iteration | Begründung |
|---|---:|---:|---|
| base (Klasse → `ScriptObject[]`) | 0 | 0,7–1,2 | Laden, Indexprüfungen, Speichern mit Kartenbarriere |
| class → `HeapRef` | 0 | base + 0–0,5 | Fat Pointer aus Konstante + Zeiger; 16 statt 8 B speichern; Barriere über Spanne |
| move (fertiger `HeapRef`) | 0 | ≈ class | 16-B-Kopie |
| string → `HeapRef` | 1 (16 B) | 3–6 | Bump-Allokation inline (~1 ns) + Barriere + junge Sammlungen: 160 MB je Lauf, alles tot |
| int → `HeapRef` | 1 (16 B) | 3–6 | wie string |
| struct `{a, b}` → `HeapRef` | 1 (32 B: 8 Kopf + 16, auf 16 gerundet) | 4–8 | doppelte Bytes, mehr Sammlungen |

**W2** (n = 10⁸, 13 Befehle je Durchlauf, davon 3 `MOVR` und 1 `GETF`):

| Variante | erwartete ns/Befehl | Begründung |
|---|---:|---|
| a (getrennt) | 1,5–2,0 | Skalarbefehle wie P1 (1,30); `MOVR` = 16-B-Kopie + Barriere (Kartenschleife); `GETF` = Typtest (Deskriptor aus der VTable) + `o.scalars[c]` (zwei Ladungen, eine Indexprüfung) |
| b (Slot, `.bits`) | a ± 10 % | gleiche Prüfungen; Stride 24 statt 8, alles im L1 |
| bc (Slot ganz schreiben) | b + 20–50 % | jede Skalarschreibung baut einen Slot und läuft durch die Barriere |
| o (`?HeapRef`, `.bits`) | ≈ b, `GETF` etwas teurer (Has-Prüfung) | 32-B-Slots |
| oc | ≥ bc | 32-B-Slot je Schreibung |

Rahmengröße (16 Register): a = 144 + 272 = 416 B in zwei Objekten; b = 16 + 16·24 = 400 B;
o = 16 + 16·32 = 528 B, je ein Objekt.

**W3** (10⁷ Nachschlagungen, 75 % Treffer, billiger Hash):

| Größe | mono ns/Suche | iface | wit | Begründung |
|---|---:|---:|---:|---|
| klein (4000 Schlüssel, alles im L1/L2) | 8–15 | mono + 3–6 (1,2–1,5×) | ≈ iface + 0–2 | zwei indirekte Aufrufe, ein Typtest, eine Box-Ladung mehr je Schlüssel |
| groß (10⁶ Schlüssel, Tabelle 2²¹) | 60–120 | 1,3–1,8× mono | ≈ iface | Cache-Fehler dominieren; die Box ist eine zusätzliche abhängige Ladung je Vergleich und je Anfrage, das Schlüsselarray ist doppelt so breit |

## Aufbau

Alle Programme aus **einer** Quelle (`gen.py`), gebaut mit `build.sh` (Release-Profil), gemessen
mit `run.py`: je Konfiguration 9 Läufe reihum, Median; gemessen wird **im Prozess** um die
Schleife (`Monotonic.now()` … `elapsed().nanos()`); wo ein Programm keine Zeit druckt (C-Orakel,
P1 der Dispatch-Sonde), Wandzeit minus Median eines Laufs mit n = 1. Allokationen über die
Zähler des Threads (`lyr_gc_thread_allocations`/`_allocated_bytes`, per `extern "C"` wie
`bench/gc`), Sammlungen und Pausen über `lyr_gc_stat` (0, 3; vorher RESET 9).

**W1 `w1_coerce <modus> <n>`** (n = 10⁷): `@NoInline`-Schleife `refs[i & 15] = x`, `x` je Modus:
`pool[i & 7]` (Klasse, in `ScriptObject[]` = base, in `HeapRef[]` = class), `strs[i & 7]`
(string), `Small { a = i, b = i }` (struct), `i` (int), `src[i & 7]` aus einem fertigen
`HeapRef[]` (move). `HeapRef` hat ein Member `tag()`; `extend string :: [HeapRef]`,
`extend int :: [HeapRef]`. Kontrolle: `check` = Σ `tag()` über die 16 Slots danach (56, 72,
16n−136, 32n−272 je Modus) und die Allokationszahl (n bzw. 0) — sonst INVALID.

**W2 `w2_<layout> <n>`** (n = 10⁸): die Register-VM der Dispatch-Sonde — `@Layout(C) struct Instr
{ op: uint8, a, b, c: uint16 }`, 48 Arme im `match`, `executed += 1` je Befehl —, die Opcode-Tabelle
um Referenzbefehle ergänzt (`MOVR`, `GETF`, `SETF`, `GETR`, `SETR`, `LOADKR`, `ISNIL`, `KIND` statt
`LOADM`/`STOREM`/`CMOV`/…), 10 heiße Opcodes. Je Durchlauf 13 Befehle:

```
MUL r4 = r0*r0; XOR r4 ^= r3; ADD r2 += r4            (wie die Dispatch-Sonde)
MOVR q10 = q8; MOVR q8 = q9; MOVR q9 = q10             (zwei Referenzen tauschen)
GETF r5 = q8.field[1]; ADD r2 += r5                    (Feld eines ScriptObject lesen: Typtest + Laden)
ANDI r5 = r0 & 0xFFFF; SUB r2 -= r5; AND r2 &= mask; ADDI r0 += 1; JLT r0 < n
```

Ausgeführt **13n + 8** Befehle. `GETF` prüft den Typ mit `if (o is ScriptObject)` (ein Vergleich
des Deskriptors aus der VTable) und liest `o.scalars[c]` bzw. `o.slots[c].bits` — das Objekt hält
dasselbe Layout wie der Rahmen. Layouts: siehe `gen.py` (a, b, bc, o, oc). Orakel `w2_p0.c`
(dieselbe Rechnung in C, acc); zum Vergleich P1 der Dispatch-Sonde (nur Skalare, 8 Befehle je
Durchlauf, derselbe Commit). Rahmengröße: Bytes der Allokation von 16 Registern (Zähler).

**W3 `w3_map <modus> <schlüssel> <anfragen> <suchen>`** (10⁷ Suchen): offene Adressierung,
lineares Sondieren, Tabelle `keys: K[]`, `hashes: uint64[]` (0 = leer), `vals: int[]`, Kapazität
die Zweierpotenz ≥ 2·Schlüssel; wie .NET wird erst der gespeicherte Hash verglichen, dann `equals`
gerufen. Schlüssel `"key<i>"`, Anfragen als **eigene** String-Objekte (`"key<(j·7919) mod n>"`,
jede vierte `"miss<j>"`), vorab gebaut und — für iface/wit — vorab in den Interface-Wert
gewandelt; die Suchschleife alloziert nichts (geprüft). Hash: ein billiger Fx-Hasher über
`string.hash(&h)` aus std (acht Bytes je Schritt), damit der Hash den Aufruf nicht verdeckt.
`check` = Σ gefundene Werte + Treffer·2³², aus der Konstruktion in Python berechnet.

| Modus | K | Hash | Gleichheit |
|---|---|---|---|
| mono | `string` | `hashStr(k)` direkt | `a == b` direkt (`lyr_str_eq`) |
| iface | `KeyRef` (Interface-Wert, string geboxt) | `k.keyHash()` über die VTable | `a.keyEquals(b)` über die VTable, darin `b is string` |
| wit | `HeapRef` (Interface-Wert) | `t.wit.hash(k)` über ein Zeugenobjekt, darin `k is string` | `t.wit.eq(a, b)`, darin zwei Typtests |
| mbox (nach Lauf 1) | `StrBox` (Klasse `{ s: string }`, 8-B-Referenz) | `hashStr(k.s)` direkt | `a.s == b.s` direkt — die Box ohne den Dispatch |
| hash (nach Lauf 1) | — | nur `hashStr(anfrage)`, keine Tabelle | — |

Je Suche ein Hash-Aufruf und, bei gleichem gespeichertem Hash, ein Gleichheitsaufruf: bei 75 %
Treffern und 64-Bit-Hashes **≈ 1,75 Zeugenaufrufe je Suche**.

Je Interface ein zweiter Konformer (`IntKey`, `IntWitness`), einmal gerufen, damit nichts an die
einzige Implementierung gebunden werden kann. Größen: **klein** 4000 Schlüssel, Kapazität 8192,
4096 Anfragen (alles im L2); **groß** 10⁶ Schlüssel, Kapazität 2²¹, 2²⁰ Anfragen. Dazu derselbe
Quelltext mit `--lto` (`w3_map_lto`): ohne LTO liegt die std-Instanz `hashText<Fx>` in einer
anderen C-Einheit und ist auch im mono-Pfad ein Aufruf.

**Umgebung.** CPU Intel Core Ultra 5 228V (4 P- + 4 LP-E-Kerne), Windows 11 Pro 10.0.26200,
WSL2 Arch (Kernel 6.18.54.1-microsoft-standard-WSL2, 8 vCPUs). Lyric 5: `lyric 5.0.0+61c33e7`,
Commit `61c33e73f4117cfc155ce3ce785b3cde6402a822` — **derselbe** wie die Dispatch-Sonde (eigener
Worktree `lyric-worktrees/probe-dispatch`, nach `git fetch` bewusst nicht bewegt: die drei
Commits bis `origin/main` = `aba389ed` betreffen nur `lyric toolchain`/Pakete, und P1 bleibt so
vergleichbar). Profil `release` (`-O2 -g -DNDEBUG`, ohne `-target`), `zig 0.16.0` (clang 21.1.8).
`results/machine-wsl.txt`.

**Achtung, langsamere Maschine als in der Dispatch-Sonde.** Gemessen im **Akkubetrieb**
(Win32_Battery: entladend, 52 → 44 %, Energieschema „Ausbalanciert"). P1 der Dispatch-Sonde,
im selben Lauf mitgemessen: **1,86–1,99 ns/Befehl statt 1,30** — alle absoluten Zahlen hier
liegen rund **1,4–1,5× über** denen der Dispatch-Sonde. Die Vergleiche innerhalb eines Laufs
(reihum, gleiche Bedingungen) gelten; absolute Zahlen nur gegen P1 desselben Laufs lesen.

**Läufe.** Nachbarsitzung fuhr bis 16:15 Konformanzläufe (loadavg 11–16): gewartet, bis
loadavg < 1,5 dreimal in Folge; während der Läufe loadavg ≈ 1,0 (der Messprozess selbst).
Lauf 1 (W1, W2, W3, W3-lto) und Lauf 2 (dasselbe, W3 mit `hash`) und Lauf 3 (W3 und W3-lto mit
`mbox` und `hash`). Die Binärdateien von W1/W2 sind über alle Läufe bitgleich (md5 vor/nach dem
Neubau); W3 wurde für `hash` und `mbox` neu gebaut. **Jede Konfiguration jedes Laufs gültig**
(Prüfsummen, `executed`, Allokationszahlen; der `hash`-Modus gibt in `w3_map` und
`w3_map_lto` dieselbe Summe).

## Ergebnisse

### W1 — Übergang in einen Interface-Wert

**Erlaubt?** Ja: `extend string :: [HeapRef] { fn tag(): int … }` und `extend int :: [HeapRef]`
übersetzen in einem Programmmodul ohne Diagnose (keine Orphan-Regel, 04 „Kohärenz ohne
Orphan-Regel"), und der Aufruf über den Interface-Wert trifft die Implementierung (Prüfsumme).

**Was daraus wird** (`results/emit/w1_*.c`, `CEmitter.cs` `MakeInterface`):

```c
// Klasse: nur der Fat Pointer
t13 = (LyrIface){ t12, &lyr_vt_17_w1_coerce_HeapRef_22_w1_coerce_ScriptObject };
// string (ebenso int, Struct): eine Box je Übergang
{ lyr_box_ty_0_box_string__1067cdbf *lyr_box = lyr_alloc(&lyr_desc_box_ty_0_box_string__1067cdbf);
  lyr_box->value = t12;
  t13 = (LyrIface){ lyr_box, &lyr_vt_17_w1_coerce_HeapRef_22_0_box_string__1067cdbf }; }
// die Speicherung in HeapRef[]: Wert speichern, dann die Karten über die 16 Bytes markieren
LYR_CHECK_INDEX(t7, t4->len); LYR_WRITE_BARRIER_VALUE(t4, &LYR_ARR_DATA(t4, LyrIface)[t7], t13);
```

Box-Layouts (`_Static_assert` im emittierten C): `<box:string>` = `{ LyrObj header; LyrStr
*value; }` 16 B, `<box:int>` = `{ header; int64_t value; }` 16 B, `box<Small>` 24 B (auf 32
gerundet). `lyr_alloc` ist der Bump inline (zwei TLS-Ladungen, Vergleich, Speichern). **Jeder**
Übergang boxt neu — 8 verschiedene Strings 10⁷-mal gewandelt ergeben 10⁷ Boxen; nichts wird
zwischengespeichert. Ein Wert, der schon `HeapRef` ist (move), alloziert nicht.

`results/run2-w1.md` (Lauf 1 in Klammern), n = 10⁷:

| Modus | Allok./Übergang | Bytes/Übergang | Sammlungen je 10⁷ | Pausen gesamt | **ns/Iteration** | Δ |
|---|---:|---:|---:|---:|---:|---|
| base (Klasse → `ScriptObject[]`) | 0 | 0 | 0 | – | **1,16** (1,06) | Basis |
| class (Klasse → `HeapRef[]`) | 0 | 0 | 0 | – | **3,56** (3,07) | +2,4 gegen base |
| move (fertiger `HeapRef` → `HeapRef[]`) | 0 | 0 | 0 | – | **3,46** (3,10) | = class |
| string → `HeapRef[]` | **1** | 16 | 37 (jung) | 2,5 ms (4,0) | **11,40** (10,89) | +7,9 gegen move |
| int → `HeapRef[]` | **1** | 16 | 37 | 6,6 ms (1,7) | **11,10** (10,58) | +7,6 |
| struct `Small { a, b }` → `HeapRef[]` | **1** | 32 | 75 | 4,2 ms (2,8) | **12,48** (11,54) | +9,0 |

- Der Übergang **Klasse → Interface kostet selbst nichts** (class = move). Die +2,4 ns gegen
  base kommen von der **Speicherung** eines 16-B-Interface-Werts: `LYR_WRITE_BARRIER_VALUE` ruft
  `lyr_gc_card_span` — eine allgemeine Schleife über die Kartenzeilen, von clang mit
  Restschleife und 4×-Entrollung übersetzt, die `lyr_gc_cards` vor jeder Bytespeicherung neu lädt
  (Aliasing); rund 60 Maschinenbefehle je Iteration statt 25 mit `LYR_WRITE_BARRIER` (eine Karte)
  bei base (`results/asm/w1_loopBase.s`, `w1_loopClass.s`). Auch für 16 B (höchstens zwei Karten)
  steht dort die allgemeine Schleife — eine Frage des Codegens, nicht des Wertmodells.
- **string/int/struct → Interface: eine Allokation je Übergang, +7,6–9 ns.** Die Pausen der
  Sammlungen sind davon nur 0,2–0,7 ns je Übergang; der Rest (Bump, Kopf schreiben, frischer
  Speicher, Barriere) ist nicht weiter zerlegt (keine Zähler der CPU in WSL genutzt).

### W2 — Rahmenlayout

`results/run2-w2.md` (Lauf 1 in Klammern), n = 10⁸, 13n + 8 = 1,3·10⁹ Befehle, alle `acc` =
670165716117834240 = Orakel P0:

| Variante | ns/Befehl | ns/Durchlauf | gegen a | Rahmen, 16 Register |
|---|---:|---:|---:|---|
| P0 C-Schleife ohne VM | – | 1,53 (1,53) | | |
| P1 Dispatch-Sonde, nur Skalare, 8 Befehle | 1,86 (1,99) | 14,9 (16,0) | | 16 + 128 = 144 B |
| **a** getrennt: `uint64[]` + `HeapRef[]` | **2,29** (2,27) | **29,8** (29,5) | 1,00 | **416 B in 2 Objekten** (144 + 272) |
| **b** `Value { bits, ref: HeapRef }`, Nil-Objekt, Skalar → `.bits` | **2,31** (2,38) | **30,1** (30,9) | 1,01 (1,05) | **400 B in 1 Objekt** (16 + 16·24) |
| bc wie b, Skalar → ganzer Slot | 8,83 (9,07) | 114,7 (117,9) | **3,85** (4,0) | 400 B |
| **o** `Value { bits, ref: ?HeapRef }`, Skalar → `.bits` | **2,79** (2,75) | **36,3** (35,8) | **1,22** (1,21) | **528 B in 1 Objekt** (16 + 16·32) |
| oc wie o, Skalar → ganzer Slot | 9,15 (9,44) | 118,9 (122,8) | 3,99 (4,2) | 528 B |

Rahmengröße: gemessen 480 / 448 / 576 B; darin je `arrayOf`/`[x] * n` ein **temporäres
Ein-Element-Array** (32 bzw. 48 B: `filled` senkt `[x] * n` als Literal + Wiederholung) — die
Rahmen selbst sind 416 / 400 / 528 B (Zahlen oben, aus Kopf 16 B + n·Elementgröße, die
`_Static_assert`s nennen `sizeof(Value)` = 24, mit `?HeapRef` 32, `LyrIface` 16). Die Refmaps
sind exakt: in `HeapRef[]` ist je Element ein Wort von zwei eine Referenz, in `Value[]` eines von
drei (bzw. vier) — `bits` wird nie gescannt. Ein Rahmen nach a sind zwei Allokationen, nach b/o
eine.

- **a ≈ b** (±1–5 %, je Lauf andersherum): der 24-B-Schritt statt 8 B kostet in der Schleife
  nichts Messbares. Gegen P1 (nur Skalare) +23 % je Befehl: mit P1s 1,86 ns für die 9
  Skalarbefehle bleiben ≈ 13 ns für 3 `MOVR` + 1 `GETF`, ≈ 3,3 ns je Referenzbefehl
  (Schätzung — die heißen Opcodes sind nicht dieselben wie in P1). Beide `MOVR`-Fassungen
  laufen durch `LYR_WRITE_BARRIER_VALUE` (16 B bzw. 24 B) — dieselbe Kartenschleife wie in W1.
- **o (`?HeapRef`) +22 %**: 32-B-Slots, und `GETF` prüft erst `has`, dann den Typ.
- **bc/oc: ≈ 4× langsamer.** Jede Skalarschreibung baut einen ganzen `Value` in einem
  Stack-Temporär (die `run`-Funktion nullt im Prolog rund 40 solcher Temporäre), führt die Barriere
  für dessen `ref` aus (Bereichsprüfung, außerhalb des Heaps keine Karte) und speichert den Slot
  über `LYR_WRITE_BARRIER_VALUE` mit Kartenschleife; dazu 8-B- und 16-B-Speicherungen
  überlappend in denselben Temporär, die als 16 B zurückgeladen werden (Store-Forwarding
  scheitert; `results/emit/w2_bc_run.c`, Arm `ADD`). `run` hat in bc 89 Barrieren statt 5.
  Mit Zwei-Wort-Slots ist also nur die `.bits`-Schreibung so billig wie a; sie lässt die alte
  Referenz im Slot stehen (die ein sonst totes Objekt am Leben hält, bis der Slot überschrieben
  wird).

### W3 — Zeugenaufruf

`results/run3-w3.md` und `run3-w3lto.md` (Lauf 3; Lauf 2 ohne `mbox` gibt dieselben Werte auf
±6 %), 10⁷ Suchen, alle `check` richtig, 0 Allokationen
in der Suchschleife:

| | mono | mbox | iface | wit | hash allein | **iface/mono** | wit/mono |
|---|---:|---:|---:|---:|---:|---:|---:|
| klein, ohne LTO | 51,8 | 54,4 | 58,4 | 58,4 | 17,6 | **1,13** | 1,13 |
| klein, `--lto` | 44,2 | 45,1 | 49,2 | 51,1 | 14,4 | **1,11** | 1,16 |
| groß, ohne LTO | 219,9 | 303,8 | 383,5 | 419,3 | 19,7 | **1,74** | 1,91 |
| groß, `--lto` | 202,6 | 272,1 | 306,3 | 312,9 | 20,0 | **1,51** | 1,54 |

(ns je Suche, Median aus 9.)

Zerlegung (mbox = dieselben direkten Aufrufe, der Schlüssel hinter einem Objekt mehr):

| | Box (mbox − mono) | Dispatch (iface − mbox) | je Zeugenaufruf (÷ 1,75) |
|---|---:|---:|---:|
| klein, ohne LTO | +2,7 ns | +4,0 ns | **≈ 2,3 ns** |
| klein, `--lto` | +0,9 ns | +4,1 ns | **≈ 2,3 ns** |
| groß, ohne LTO | **+84 ns** | +80 ns (Dispatch + 16-B-Schlüsselarray: 32 statt 16 MB) | – |
| groß, `--lto` | **+70 ns** | +34 ns | – |

- **Im Cache kostet der Zeugenaufruf ≈ 2,3 ns** (indirekter Aufruf in den Thunk, Typtest
  `b is string` = ein Vergleich des Deskriptors aus der VTable, Auspacken der Box, dann derselbe
  direkte Aufruf wie mono: `hashText`, `lyr_str_eq`; `results/asm/w3_lyr_vt_*`). Als Verhältnis
  1,11–1,13 — weil die Suche selbst teuer ist: der Hash allein 14–18 ns (std's `hashText` ruft
  `Fx.writeByte` je Byte ohne LTO als Funktion; der „billige" Hash war nicht billig).
- **Groß dominiert die Indirektion, nicht der Aufruf**: ein String hinter einem Interface-Wert
  ist Box → `LyrStr`, eine abhängige Ladung mehr je Schlüsselvergleich und je Anfrage (+70–84 ns
  allein durch die Box, mbox), dazu das doppelt breite Schlüsselarray. Zusammen 1,5–1,7× mono.
- **wit ≈ iface** (+0–2 ns klein; groß ohne LTO +36 ns, mit LTO +7 — nicht aufgeklärt; der
  Zeuge liegt im Cache, der Unterschied ist Codelage/Inlining der Thunks).
- LTO hilft mono (`lookup` in `bench` inline, `lyr_str_eq` zu `bcmp`), `hashText` bleibt ein
  Aufruf (`results/asm/w3lto_bench*.s`); die Aufrufe über Interface bleiben indirekt.

## Erwartung gegen Messung

| | erwartet | gemessen (gegen P1 desselben Laufs lesen) |
|---|---|---|
| W1 Allokationen | 0/0/1/1/1 | **so** (vorab gesehen, s. o.) |
| W1 base | 0,7–1,2 ns | 1,16 — im Rahmen trotz Akku |
| W1 class gegen base | +0–0,5 ns | **+2,4 ns** — die Kartenschleife der Wert-Barriere unterschätzt |
| W1 string/int | 3–6 ns | **10,6–11,4 ns** — deutlich teurer |
| W1 struct | 4–8 ns | 11,5–12,5 ns |
| W2 a | 1,5–2,0 ns/Befehl | 2,29 (= 1,23× P1; auf die Maschine der Dispatch-Sonde umgerechnet ≈ 1,6) |
| W2 b gegen a | ±10 % | **+1 %** |
| W2 bc gegen b | +20–50 % | **+280 %** — weit unterschätzt (Stack-Temporär, Barriere, Store-Forwarding) |
| W2 o gegen b | ≈ b, `GETF` etwas teurer | **+21 %** |
| W2 Rahmen | 416 / 400 / 528 B | **so** (+ temporäres Ein-Element-Array beim Bauen) |
| W3 klein mono | 8–15 ns | **44–52 ns** — der Hash über std's `Hasher` kostet allein 14–18 |
| W3 klein iface | +3–6 ns, 1,2–1,5× | **+5–7 ns, 1,11–1,13×** |
| W3 groß mono | 60–120 ns | **200–220 ns** |
| W3 groß iface | 1,3–1,8× | **1,51–1,74×** |
| W3 wit | ≈ iface | so (klein); groß ohne LTO +9 % |

## Nicht gemessen

- **C-Zwillinge für W2** (Referenzbefehle in C): die Lücke Lyric → C für `MOVR`/`GETF` ist offen;
  nur P0 (C ohne VM) und P1 stehen daneben.
- **Zerlegung der +7,6–9 ns einer Box-Allokation** (Bump, frischer Speicher, Barriere,
  Sammlungen außerhalb der Pausen): keine CPU-Zähler (perf) benutzt.
- **Scan-Kosten der Rahmen** für den Sammler je Layout; nur Bytes und Refmaps.
- **Ein String ohne Box**: der Compiler boxt jeden eingebauten Typ beim Übergang (S8b); eine
  VM-Klasse `ScriptString { s: string }` hätte dieselbe eine Allokation bei der Erzeugung — ihr
  Lesepfad ist mbox in W3, ihre Erzeugung nicht gesondert gemessen.
- **.NET-Laufzeitwörterbuch** (generischer Kontext, Lookup des Zeugen je Aufruf): emuliert ist
  nur der Aufruf über ein Interface bzw. ein im Objekt gehaltenes Zeugenobjekt.
- **Netzstrom**: die Zahlen gelten für Akkubetrieb; Verhältnisse innerhalb der Läufe sind stabil
  (Lauf 1 gegen 2: ±10 %), absolute Zahlen nicht mit der Dispatch-Sonde gleichsetzen.
- gcc, macOS/ARM, Debug-Profil, Kernzuordnung (WSL2 pinnt nicht verlässlich).

## Reproduzieren

```
# WSL, Worktree probe-dispatch auf 61c33e73, lyric5 gebaut (dotnet build src/Lyric5 -c Release)
LYRIC5=…/src/Lyric5/bin/Release/net10.0/lyric5 bash build.sh ~/probe-werte
python3 run.py ~/probe-werte/bin w1 --json results/w1.json
python3 run.py ~/probe-werte/bin w2 --dispatch ~/probe-dispatch/bin --json results/w2.json
python3 run.py ~/probe-werte/bin w3 --json results/w3.json
python3 run.py ~/probe-werte/bin w3 --exe w3_map_lto --json results/w3lto.json
```

Dateien: `gen.py` (alle Programme; `generated/` ist seine Ausgabe, zum Lesen), `build.sh`,
`run.py`, `results/` — `run<N>-<teil>.md/.json/.log` je Lauf (Lauf 1: W3 ohne `hash`/`mbox`; Lauf
2: W3 ohne `mbox`), `machine-wsl.txt`, `asm/` Disassemblate der heißen Funktionen, `emit/` das
emittierte C der Schleifen bzw. `run` (a, b, bc).
