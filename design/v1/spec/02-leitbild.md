# 02 — Leitbild

Entschieden 2026-10-28 (Maintainer, im Fragedialog). Das Leitbild legt fest, wie Lyric-Script
aussieht und was es kann, bevor die Detailbereiche 03–10 die Einzelheiten als
Abweichungsrunden gegen Lyric 5 entscheiden. Grundlage: 00 (statisch typisiert, eine Sprache
mit zwei Profilen, Lyric 5 als Referenz mit Abweichungstabelle, Standardbibliothek nach dem
Python-Modell in Script selbst), 01 (Host und Sicherheit).

## Zielbild in Code

Vier typische Programme in der entschiedenen Form. APIs der Standardbibliothek sind
Veranschaulichung, nicht Entscheidung (Bereich 12).

**Terminal-Werkzeug** — die zehn häufigsten Wörter der übergebenen Dateien:

```
#!/usr/bin/env lyric-script
import std.fs { readText }

var counts: Map<string, int> = [:]
for (path in args) {
    for (word in readText(path).words()) {
        let w = word.lower()
        counts[w] = (counts[w] ?? 0) + 1
    }
}
for ((word, n) in counts.entries().sortedBy { -it.1 }.take(10)) {
    println(f"{n:>6} {word}")
}
```

**Mod** — eingebettet, der Host ruft `onTick`:

```
import host.game { onTick, spawnEnemy, Enemy }

var enemies: List<Enemy> = []
var timer = 0.0

onTick { dt =>
    timer += dt
    if (timer > 5.0) {
        enemies.push(spawnEnemy(x: 0.0, hp: 100))
        timer = 0.0
    }
    enemies.retain { it.hp > 0 }
}
```

**Daten** — JSON unbekannter Form neben typisiertem Decoding:

```
import std.net.http { get }
import std.json

struct Repo :: Codable { name: string, stars: int }

let data = json.parse(get("https://api.example.com/repos").text())
let total = data["total"].int ?? 0
let repos = json.decode<Repo[]>(data["items"])
for (r in repos.sortedBy { -it.stars }.take(5)) {
    println(f"{r.stars:>6}  {r.name}")
}
println(f"{repos.length()} von {total}")
```

**Automatisierung** — Dateien umbenennen, ein Programm aufrufen:

```
import std.fs { list, rename }
import std.process { run }

fn slug(name: string) = name.lower().replace(" ", "-")

for (file in list("photos")) {
    let target = f"photos/{slug(file.name)}"
    if (target != file.path) {
        rename(file.path, target)
        println(f"{file.name} -> {target}")
    }
}
let status = try? run("git", ["status", "--short"])
println(status?.stdout ?? "kein git")
```

## Entscheidungen

| # | Frage | Entscheidung |
|---|---|---|
| F1 | Grundform | **Kotlin-Form**: Klammern um Bedingungen und Blöcke bleiben, **kein `;`** — das Zeilenende beendet die Anweisung, mit Fortsetzungsregeln (Bereich 09: Zeile endet auf binären Operator, `,`, `(`, `.`; Zeile beginnt mit `.`). Lyric-5-Code wird durch Weglassen der `;` zu Script-Code. |
| K1a | Prelude | Häufiges ohne Import — **nur Namen, die kein Recht brauchen** (`println`, `print`, `args`, `exit`); Datei, Netz, Prozesse bleiben importiert, weil die Rechte aus den Importen abgeleitet werden (01 S1). |
| K1c | Interpolation | **Bleibt `f"…"`** (Formatsprache von Lyric 5); jeder String interpolierend wurde verworfen (Escape-Last bei JSON, Regex, Templates). |
| K1d | Rückgabetypen | **Erschlossen**, Ausdrucksrumpf `fn square(x: int) = x * x`; **Pflicht an exportierten Funktionen und an der Host-API** (Vertrag). |
| L | Sammlungsliterale | **`[]` für alles, der Inhalt entscheidet** (Swift-Form): `[1, 2]` Liste, `["a": 1]` Map, `[:]` leere Map (braucht erwarteten Typ), `Set` über den erwarteten Typ (`FromArrayLiteral`, Lyric 5 10 K4). |
| K2 | Fehler | **Keine `throws`-Klausel, keine `try`-Pflicht** (Kotlin/Python): jeder Aufruf darf werfen; ein unbehandelter Fehler beendet das Skript mit Meldung und Exit 1. `try?` und `try … catch` bleiben als Werkzeuge. Der Compiler **erschließt** die Fehlermengen und zeigt sie (Editor, `api`). Native Module und Host-API werfen weiter typisiert. |
| T1 | Zahlen | **Nur `int` (64 Bit, Panik bei Überlauf) und `float` (64 Bit).** Binärdaten als Bibliothekstyp `Bytes` (Index liefert `int` 0–255), große Zahlen als `BigInt` in der Standardbibliothek. Feste Breiten nur an der Grenze zu Host und nativen Modulen, mit Bereichsprüfung (`uint16`-Parameter, 70000 → wirft); `float32` wird dort gerundet. |
| T2 | Parametertypen | **Pflicht** an benannten Funktionen; Locals, Lambdas (aus dem Kontext) und Rückgaben (K1d) werden erschlossen. Jede Funktion wird einmal geprüft, auch ungerufen. Optionale Parametertypen (implizit generisch) sind Tür. |
| T4 | Unionen | **Ad-hoc-Unionen `A \| B`** mit Eingrenzung über `is` und `match`; benannt über `type X = …`. **Inferenz erzeugt nie still eine Union** (`if (c) 1 else "a"` bleibt ohne Annotation ein Fehler). |
| K4 | Dynamische Daten | **`Json` ist eine Union** (`null \| bool \| int \| float \| string \| Json[] \| Map<string, Json>`), die `std.json` um Zugriffe **erweitert**: `[]` liefert wieder `Json` (`null`, wenn es fehlt), `.string`/`.int`/… liefern `?T`. Hauptweg bleibt `json.decode<T>` über `Codable`. Kein `dynamic` (Tür). Folge: **Erweiterungen auf Unionstypen** sind erlaubt; die Methoden einer Union sind die, die ausdrücklich für sie erweitert wurden. |
| T7 | Werte und Objekte | **`struct` ist immer unveränderlich** (ein Record, Änderung über `p with { x = 5.0 }`), **`class` ist die veränderliche Referenz** mit Identität. Werte ändern sich nie, Objekte schon. |
| T8 | Interfaces | **Nominal mit `::`** wie Lyric 5; die Konformanzliste löst die Synthese aus. |
| T9 | Vererbung | **Keine** — Interfaces mit Defaults und Delegation `by` wie Lyric 5; Host-Hierarchien über Interfaces. |
| W | Weggelassen | **`&T`-Parameter, `comptime` und Makros, Threads/`Mutex`/`Atomic`, `T[N]`/`@Layout`/`unsafe`/`Ptr`.** |
| D | Laufzeit-Dynamik | **Reflexion zur Laufzeit, lesend, Sichtbarkeit gilt** (`reflect.fields(x)`); sie trägt auch die Synthese ohne `comptime`. `eval` und dynamischer Import sind Türen; **keine Comprehensions** (Ketten und `sequence { yield }` wie Lyric 5). |
| G | Generics | **Wie Lyric 5**: Typparameter, Constraints, assoziierte Typen, Default-Typargumente, generische `extend` — die Standardbibliothek ist in Script geschrieben (00 Z6) und braucht sie. |
| V | Sichtbarkeit | **Öffentlich als Vorgabe, `private` als Ausnahme** (Kotlin); Reflexion und Host sehen alles außer `private`. |

## Abweichungen von Lyric 5 (Beitrag zur Tabelle aus 00 Z3)

| Gebiet | Lyric 5 | Lyric-Script | Grund |
|---|---|---|---|
| Anweisungsende | `;` (08) | Zeilenende, Fortsetzungsregeln | F1 |
| Prelude | `println` in `std.io`, nicht im Prelude (10) | `println`, `print`, `args`, `exit` im Prelude | K1a |
| Rückgabetyp | geschrieben | erschlossen, `= expr`-Rumpf; Pflicht an Exporten | K1d |
| Map-Literal | keins; `[("a", 1)]` (10 K4) | `["a": 1]`, `[:]` | L |
| Fehler | `throws`-Klausel + `try`-Pflicht (05) | keine Klausel, keine Pflicht; Mengen erschlossen | K2 |
| Zahlentypen | `int8…uint64`, `float32/64` (03) | `int`, `float`; `Bytes`, `BigInt` in std | T1 |
| Unionen | keine, Tür „additiv" (03) | `A \| B` mit `is`-Eingrenzung, Erweiterungen auf Unionen | T4, K4 |
| Structs | `var`-Felder mit Bindungsregel (02) | immer unveränderlich, `with` | T7 |
| Referenzparameter | `&T` / `&x` (08) | entfällt | W |
| Metaprogrammierung | `comptime`, Makros (09) | entfällt | W |
| Threads | `Thread`, `Mutex`, `Atomic` (06) | entfällt, nur Koroutinen | W |
| Hardwarenahes | `T[N]`, `@Layout`, `unsafe`, `Ptr`, `extern "C"` (03, 11) | entfällt (00 Z5) | W |
| Reflexion | keine zur Laufzeit, `std.meta` zur Compile-Zeit (09) | lesend zur Laufzeit | D |
| Sichtbarkeit | `private` / `internal` (Vorgabe) / `pub` (07) | öffentlich (Vorgabe) / `private` | V |
| Map/Set-Reihenfolge | unspezifiziert (10 I8) | Einfügereihenfolge | 01 S8 |

**Ausdrücklich übernommen**: statische Typen, Parametertypen, `f"…"` und die Formatsprache,
`[]`-Literale mit Koerzion, Optionals `?T`/`??`/`!`, Lambdas mit `it` und nachgestellte Blöcke,
benannte und Default-Argumente, Ranges und `^n`, Pattern-Matching, Enums mit Payload, Tupel,
nominale Interfaces mit Synthese über `::`, keine Vererbung, Delegation `by`, Generics,
Koroutinen.

## Begründung

**Die Form (F1).** Die `;` sind das Förmlichste an Lyric 5; ohne sie fühlt sich die Sprache
nach Skript an, ohne die Familie zu verlassen: Lyric-5-Code wird durch Weglassen der `;` zu
Script-Code. Klammern um Bedingungen wegzulassen (Swift/Go) brächte optisch wenig und kostete
eine Regel gegen Struct-Literale in Bedingungen; Einrückung (Python) bricht mit den Blöcken als
Ausdrücken, von denen Lyric lebt (nachgestellte Lambdas, `sequence {}`, `match`-Arme).

**Weniger Zeremonie, gleiche Garantie (K1, K2, T2).** Script wird kürzer, wo Lyric 5
Information schreibt, die der Compiler selbst erschließen kann (Rückgabetypen, Fehlermengen),
und bleibt streng, wo die Information die Garantie trägt (Parametertypen: jede Funktion wird
geprüft, auch ungerufen). Die `try`-Pflicht wäre die größte Reibung in der Hauptrolle
(Terminal-Skripte) gewesen; ein unbehandelter Fehler, der das Skript mit Meldung beendet, ist
dort das gewünschte Verhalten.

**Ein Ganzzahltyp (T1).** Der deutlichste Vereinfacher einer Skriptsprache (Python, Lua,
GDScript). Feste Breiten gehören an die Grenze, wo ohnehin umgewandelt wird; Binärdaten bekommen
einen eigenen Typ statt eines eigenen Zahlentyps. 64-Bit mit Panik (statt Python-Bigints) hält
die Werte der VM einfach und findet Überläufe, statt sie zu verschlucken.

**Unionen statt `dynamic` (T4, K4).** Unionen sind das Merkmal, das statische Skriptsprachen
(TypeScript, Python mit Typen) am meisten nutzen; sie lösen JSON typsicher und fast so bequem
wie ein dynamischer Typ, ohne eine zweite Typwelt. Lyric 5 hat Unionen als additive Tür offen
gelassen — Script erprobt sie zuerst.

**Werte ändern sich nie (T7).** Ein unveränderlicher Struct ist unsichtbar geteilt oder kopiert;
damit entfallen die Kopier-Überraschung (Lyric 5, C#) und die Alias-Falle (Python) zugleich, und
die VM kopiert nie.

**Was bleibt (T8, T9, G).** Nominale Interfaces, keine Vererbung und volle Generics halten die
Familie und tragen die Standardbibliothek in Script (00 Z6). Einfach wird Script durch Inferenz,
nicht durch fehlende Fähigkeiten.

**Was fällt (W, D).** `&T`, `comptime`, Makros, Threads und Hardwarenahes dienen Lyric 5s Rolle
(Leistung, Systemnähe), nicht der einer Skriptsprache. Reflexion zur Laufzeit ersetzt die
Compile-Zeit-Synthese und dient Debug-Ausgaben und Inspektoren.

## Verworfene Alternativen

| Option | Warum nicht |
|---|---|
| Lyric 5 unverändert (F1 A) | Skript-Charakter nur über Merkmale, Form bleibt förmlich. |
| Swift/Go-Form (F1 C) | Regel gegen Struct-Literale in Bedingungen, Übertragung nur per Formatter. |
| Python-Einrückung (F1 D) | Mehrzeilige Lambdas und Block-Ausdrücke; Formatierung trägt Bedeutung; schwächste Erkennbarkeit. |
| Interpolation in jedem String (K1c) | Escape-Last bei `{`. |
| `{}` für Map/Set (L ii) | Kollidiert mit `{ … }` als Block und Lambda. |
| Eigene Klammern `%{}`/`#{}` (L iii) | Ungewohnt, zwei zusätzliche Literalformen. |
| `throws` + `try` wie Lyric 5 (K2 A), nur `try` (K2 C) | Reibung in der Hauptrolle; die Information erschließt der Compiler. |
| Volle Zahlenfamilie (T1 A), eigener `byte`-Typ (T1 B) | Zehn Typen bzw. ein Typ mehr ohne Gewinn gegenüber `Bytes`. |
| Beliebig große `int` (K3 B) | Jeder `int`-Slot müsste eine Referenz halten können; Umwandlung an der Grenze. |
| Optionale Parametertypen (T2 B/C) | Ungeprüfte Rümpfe bzw. überraschende Vorgabetypen; Tür. |
| Keine Unionen (T4 A), nur benannte (T4 C) | Zeremoniell bzw. halbe Bequemlichkeit. |
| `dynamic` (K4 D), eigener Json-Enum (K4 C) | Zweite Typwelt bzw. zweiter Weg neben Unionen. |
| Structs wie Lyric 5 (T7 A), nur Referenzen (T7 B) | Kopien in der VM und Kopier-Überraschung bzw. Alias-Falle und stille Bedeutungsänderung. |
| Strukturelle Interfaces (T8 B/C) | Zweiter Auslöser für die Synthese. |
| Vererbung (T9 B/C) | VTables, Reload über Hierarchien, Abstand zu Lyric 5; Host-Fall über Interfaces lösbar. |
| `eval`, dynamischer Import (D b/c) | Türen. |
| Comprehensions (D d) | Zweiter Weg neben Ketten; in Lyric 5 verworfen. |
| Generics ohne assoziierte Typen / ohne eigene (G B/C) | Abweichung ohne Gewinn bzw. std nicht in Script schreibbar. |
| Sichtbarkeit wie Lyric 5 (V A), `_`-Konvention (V C) | `pub` überall bzw. Sichtbarkeit am Namen. |

## Folgen für die VM (Bereich 11)

- **Zahlen**: zwei Skalartypen (`int`, `float`) plus `bool`; der Satz an Zahlen-Opcodes
  schrumpft gegenüber 4.6 (Operationen je Breite) erheblich.
- **Unionen und Typtests**: ein Wert vom Unionstyp trägt zur Laufzeit eine Typmarke; Skalare
  in einer Union werden geboxt oder getaggt. Typbeschreibungen mit Namen braucht die VM ohnehin
  (Reload 01 S7a, Reflexion D).
- **Structs** sind unveränderliche, teilbare Heap-Objekte — kein `StructCopy` wie in 4.6.
- **Fehler**: jeder Aufruf darf werfen; die VM wickelt ihre eigenen Frames ab (wie 4.6 `Throw`).
- **Keine Threads**: eine Instanz ist einfädig (passt zu 01 S9).
- **Kein `comptime`**: die Synthese entsteht im Compiler oder über Reflexion (Bereich 05/10).
- **Generics**: Monomorphisierung oder Typlöschung ist weiter offen (04/11); Unionen und
  Reflexion setzen Laufzeit-Typbeschreibungen in beiden Fällen voraus.

## Offene Folgefragen für die Detailbereiche

- **03**: Ist `[1, 2, 3]` eine wachsende `List` (Python) oder ein Array `int[]` (Lyric 5), und
  braucht Script beide? Stringmodell (Lyric 5: Bytes, `s[i]` = Zeichen an Byte `i`).
- **04**: `?T` als `T | null`? Umwandlungsregeln in Unionen; Erweiterungen auf Unionen;
  Monomorphisierung oder Typlöschung; Inferenzgrenzen.
- **05**: Synthese ohne `comptime` (Compiler-Fähigkeit oder Reflexion); `by`.
- **06**: Fehlertypen, Anzeige der erschlossenen Mengen, Grenze zu nativen Modulen und Host.
- **08**: genaue Prelude-Liste; `args` als Wert; Top-Level-Code.
- **09**: Fortsetzungsregeln am Zeilenende; `= expr`-Rümpfe; Struct-Literal-Form.
- **10**: Reflexions-API und ihre Sichtbarkeitsregeln.
