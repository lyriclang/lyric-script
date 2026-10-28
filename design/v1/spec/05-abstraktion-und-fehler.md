# 05 — Abstraktion und Fehler

Entschieden 2026-10-28 (Maintainer, im Fragedialog). Die Bereiche 05 (Abstraktion) und 06
(Fehler) sind auf Wunsch des Maintainers **zusammengelegt**. Abweichungsrunde gegen Lyric 5
`design/v5/spec/04-abstraktion.md` (D1–D15) und `05-fehler.md` (E1–E12), auf der Grundlage von
02 (Leitbild) und 03 (Werte und Typen).

## Ausgangslage

Schon entschieden: nominale Interfaces mit `::` (02 T8), keine Vererbung (02 T9), Structs,
Enums und Tupel automatisch `Equatable`/`Hashable`, Klassen wie Lyric 5, `{x}` fällt auf `Debug`
zurück (03 Eq); **keine `throws`-Klausel, keine `try`-Pflicht**, `try?`/`try … catch` bleiben,
Fehlermengen erschlossen (02 K2); Paniken bleiben beim Host `.Panic` (01 S11).

## Entscheidungen

| # | Frage | Entscheidung |
|---|---|---|
| Syn | Synthese ohne `comptime` | **Feste Liste im Compiler**: `Equatable`, `Hashable`, `Ordered`, `TotalOrder`, `Debug`, `Default`, `Clone`, `Identity`, `Codable` (Lyric 5 04 D7, erste Fassung). **Eigene „ableitbare" Interfaces über Default-Rümpfe mit Reflexion** (`fn toCsv(): string = reflect.fields(this).map { … }.join(",")`) — erweiterbar ohne neuen Mechanismus, Kosten je Aufruf. Grenze: die Reflexion liest nur (02 D); Werte aus Feldern *bauen* kann nur die Compiler-Synthese (deshalb `Codable` in der Liste). |
| Fl | `float` ordnen und hashen | **`float` ist `TotalOrder`** über die totale Ordnung nach IEEE 754 (`−NaN < −∞ < … < −0 < +0 < … < +∞ < NaN`), damit `scores.sort()` geht; **`<` bleibt IEEE** (NaN-Vergleiche `false`) — die beiden Ordnungen unterscheiden sich nur bei NaN und −0 (dokumentiert). **Kein `Hashable`** (wie Lyric 5): `Map<float, …>` und Structs mit `float`-Feldern als Schlüssel bleiben Fehler. |
| Th | `throws` und `try`, wenn sie dastehen | **Beide erlaubt.** Ein geschriebenes `throws [A, B]` ist ein **geprüfter Vertrag** (wirft die Funktion außerhalb der Liste: Übersetzungsfehler); **`try f()` ist erlaubt und wirkungslos**. Lyric-5-Code überträgt sich damit unverändert (02 F1). Lint **`unmarked-throw`** (Vorgabe `allow`) für Projekte, die Lyric 5s Strenge wollen. |
| Pn | Paniken fangen | **Nein, wie Lyric 5** (05 E8): eine Panik ist ein Bug — Skript endet mit Exit 101, eingebettet `.Panic` an den Host; kein `recover`. Abschottung über Tasks (Bereich 07). Regel bleibt: Panik aus Programmtext, nie aus Daten. |

## Abstraktion — übernommen aus Lyric 5 04 (Liste bestätigt)

| # | Regel | Script-Anpassung |
|---|---|---|
| D1 | Delegation `by` (`class Dog :: [Walker by legs]`), nur Interface-Member, kein `this`-Durchgriff | — |
| D2 | eine Methodenmenge je Typ, ein Name genau einmal, Kollision = Fehler an der Deklaration, qualifizierter Aufruf `Walker.describe(x)` | — |
| D3 | zwei Defaults → eigene Implementierung Pflicht; getrennte Konformanzblöcke beschränken den Namen | — |
| D4 | **Überladung nur nach Arität**, Defaults sind derselbe Mechanismus | — |
| D5 | Default einmal am Interface, je Aufruf ausgewertet, frühere Parameter nutzbar; jeder Parameter benennbar (`name: value`), Namen sind API; positionell vor benannt; `...` zuletzt; nachgestelltes Lambda | — |
| D6 | Operator-Interfaces (`Add<Rhs = Self> { type Out = Self }` …), `++`/`--` als Ausdrücke, `+=` abgeleitet, `Equatable`, `Ordered` (`?Ordering`), `TotalOrder`, `Contains` (`in`, `!in`), `Index`, `Display`; Konversion über `From`/`Into` | `float :: TotalOrder` (Fl); gemischte Arithmetik über eingebaute Konformanzen (`int :: Add<float>` …, 03 Mix); `as` nur zwischen `int`, `float`, `char` |
| D8 | `sealed interface`, Konformer im selben Modul, `match` ohne `_` erschöpfend | — |
| D9 | Objektsicherheit | — |
| D10 | Kind-Interface-Wert → Eltern-Wert als Koerzion | — |
| D11 | keine Konstruktoren: Initializer `C { f = v }` und Fabriken `static fn new`; `Point(1, 2)` ≡ `Point.new(1, 2)` | — |
| D12 | Struct als Interface-Wert | **geteilt statt kopiert** (unveränderlich, 02 T7) |
| D13 | `Clone` folgt der Konformanz | **nur bei Klassen** sinnvoll; Structs werden geteilt |
| D14 | Interface-Member immer öffentlich | — |
| D15 | drei Extension-Formen (inhärent, Konformanz, generisch); `extend Interface` ist ein Fehler | — |

## Fehler — übernommen aus Lyric 5 05 (Liste bestätigt)

| # | Regel | Script-Anpassung |
|---|---|---|
| E3 | werfbar ist jeder `:: Error`-Typ (Klassen, Structs, Enums); Fertigtyp `Exception(message)` | — |
| E4 | `try? f()` → `?T` ohne Abflachung; `try! f()` → Panik; `try f() catch (e: A) expr` als Ausdruck; Blockform `try { } catch` | bloßes `try f()` erlaubt und wirkungslos (Th) |
| K | Fehlermengen | **erschlossen statt deklariert** (02 K2); geschriebenes `throws` geprüft (Th); Teilmengenregel für Implementierungen **nur, wenn** der Interface-Member `throws` deklariert; über Funktionswerte, Host und native Module ist die Menge `Error` |
| K7 | `catch (e)` ohne Typ trägt die erschlossene Menge; `match (e)` erschöpfend darüber; `throw e` wirft sie genau | — |
| E5 | eine Funktion je Operation: `?T` für Abwesenheit ohne Grund, Wurf für Scheitern mit Grund; `map[k] ?? throw NotFound { key }` | — |
| E6 | `interface Error { message(), cause() }`; Backtrace und unterdrückte Fehler am geworfenen Objekt | unbehandelt auf oberster Ebene: `error: …` mit Ursachenkette, **Exit 1**; eingebettet `.Error(e)` (01 S11) |
| E7 | `defer` (LIFO, jedes Verlassen außer Panik; werfender `defer`: erster gewinnt, zweiter hängt an), kein `errdefer`; `using let` für `Closeable` mit Warnung „nie geschlossen"; `for` schließt `Closeable`-Iteratoren | — |
| E8 | Panik: Meldung, Backtrace, Exit 101, kein `recover`, Isolation an der Task-/Koroutinengrenze | nicht fangbar (Pn) |
| E9 | `catch`-Regeln: kein Typ doppelt, unerreichbare Klausel Fehler, Catch-all zuletzt, `catch (e in [A, B])` | ungefangener Rest propagiert immer |
| E10 | Task-Ergebnis trägt den Fehler; Host sieht ein strukturiertes Fehlerobjekt | — |
| E11 | `loop` + `break value` (nur aus `loop`), `while`, `do-while`, `for`, Labels, `let`-Bedingungen; `if`/`match`/`try` als Ausdruck; kein `switch` | — |
| E12 | `never` nur als Rückgabetyp, koerziert zu jedem Typ | — |
| — | `Result<T, E>` als Bibliothekstyp (`Result.of { f() }`, `r.get()`), kein eigener Operator | — |
| — | Iteratoren | **ohne assoziierten Fehlertyp**: `Iterator { type Item; fn next(): ?Item }` — jeder Aufruf darf werfen, also entfallen Lyric 5s `type Error = never` und `for (x in try src)` (10 B6, 05 K7) |

## Abweichungen von Lyric 5 (Beitrag zur Tabelle aus 00 Z3)

| Gebiet | Lyric 5 | Lyric-Script | Grund |
|---|---|---|---|
| Synthese | `comptime`-Default-Rümpfe über `fields(Self)` (09) | feste Compiler-Liste + Reflexion in Default-Rümpfen | Syn, 02 W |
| `float` | kein `TotalOrder` (04 D6) | `TotalOrder` (IEEE-totalOrder) | Fl |
| `throws` | Pflicht-Klausel (05 E1/E2) | optional, wenn geschrieben geprüft | 02 K2, Th |
| `try` | Pflicht an jedem werfenden Aufruf | erlaubt, wirkungslos; Lint `unmarked-throw` | 02 K2, Th |
| Iterator | `type Error`, `for (x in try src)` (10 B6) | kein Fehlertyp | Folge aus K2 |
| Struct als Interface-Wert | Kopie beim Übergang (04 D12) | geteilt | 02 T7 |
| `Clone` | für Structs und Klassen | nur Klassen sinnvoll | 02 T7 |

## Begründung

**Synthese (Syn).** Ohne `comptime` ist die feste Liste die natürliche Grundlage — sie war Lyric 5s
erste Fassung, bevor Bereich 9 sie in Default-Rümpfe verlegte. Reflexion in Default-Rümpfen ist
die Laufzeitentsprechung dieses späteren Lyric-5-Wegs: dieselbe Form (das Interface trägt die
Synthese), nur zur Laufzeit statt zur Übersetzungszeit. Weil die Reflexion nur liest, bleibt alles,
was Werte baut, beim Compiler.

**`float` sortierbar (Fl).** Zahlen sortieren ist Skript-Alltag; die IEEE-Totalordnung ist
wohldefiniert (Rust `total_cmp`). `Hashable` bleibt weg, weil NaN ≠ NaN mit gleichem Hash zu
Mengen führt, die ein eingefügtes Element nicht wiederfinden.

**`throws` und `try` erlaubt (Th).** Ohne diese Regel hätte K2 den Satz des Leitbilds gebrochen,
dass Lyric-5-Code durch Weglassen der `;` zu Script-Code wird. Ein geschriebenes `throws` bleibt
ehrlich, weil es geprüft wird; wer Lyric 5s Strenge will, schaltet sie per Lint ein — dieselbe
Sprache, eine Stellschraube.

**Paniken nicht fangbar (Pn).** Lyric 5s Trennung (Panik = Bug, Wurf = Scheitern mit Grund)
bleibt in der Familie gleich. Robustheit gegen Bugs kommt über Isolation (Tasks, Host-Aufruf),
nicht über Wegfangen.

## Verworfene Alternativen

| Option | Warum nicht |
|---|---|
| Nur feste Liste (Syn A) | Eigene ableitbare Interfaces unmöglich. |
| Alles über Reflexion (Syn C) | `==` und Hash zur Laufzeit; Map-Schlüssel sind ein heißer Pfad. |
| `float` wie Lyric 5 (Fl A) | `sort()` auf `float[]` ein Fehler. |
| `float` auch `Hashable` (Fl C) | NaN-Eigenart in Mengen. |
| `throws`/`try` verboten (Th B) | Lyric-5-Code bräuchte erst `fix`. |
| `throws` ungeprüft (Th C) | Ein ungeprüfter Vertrag lügt irgendwann. |
| Paniken als `Panic` fangbar (Pn B) | Abweichung bei `defer`; Bugs lassen sich wegfangen. |

## Folgen für spätere Bereiche

- **07 Nebenläufigkeit**: Abschottung gegen Paniken über Tasks muss im Skript einfach sein (Pn).
- **09 Syntax**: `throws [A, B]`, `catch (e in [A, B])`, `using let`, `loop`/`break value`, `by`.
- **10 Reflexion**: `reflect.fields`, Feldwerte als `Any`, Sichtbarkeit — trägt Syn.
- **11 Laufzeit**: Fehler wickeln VM-Frames ab (jeder Aufruf darf werfen); Synthese als Methoden
  oder VM-Operationen.
- **13 Werkzeuge**: Anzeige der erschlossenen Fehlermengen (Editor, `api`); Lint `unmarked-throw`.
