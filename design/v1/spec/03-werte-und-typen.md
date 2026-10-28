# 03 — Werte und Typen

Entschieden 2026-10-28 (Maintainer, im Fragedialog). Die Bereiche 03 (Wertmodell) und 04
(Typsystem) sind auf Wunsch des Maintainers **zusammengelegt**: das Typsystem wird als Ganzes
betrachtet. Abweichungsrunde gegen Lyric 5 `design/v5/spec/02-wertmodell.md` (M1–M14) und
`03-typsystem.md` (T1–T19), auf der Grundlage des Leitbilds (02).

## Ausgangslage

Durch das Leitbild bereits entschieden: nur `int` und `float` (T1), Parametertypen Pflicht und
Rückgabetypen erschlossen (T2, K1d), **keine Unionen** (T4, in dieser Runde zurückgenommen —
siehe 02), JSON aus vier Bausteinen (K4), `struct` immer unveränderlich und `class` veränderlich
(T7), nominale Interfaces (T8), keine Vererbung (T9), Generics wie Lyric 5 (G), `&T` entfällt
(W).

## Entscheidungen

| # | Frage | Entscheidung |
|---|---|---|
| S | Sequenzen | **Ein Typ: `T[]` ist die wachsende Liste**, `List<T>` ein Alias desselben Typs; `[1, 2, 3]` ist `int[]`. **Slices sind Kopien** (`xs[1..3]` ist eine neue Liste). Kein `Slice<T>`; Sichten sind Tür, falls die Standardbibliothek sie für Parser messbar braucht. |
| Str | Strings | **UTF-8 wie Lyric 5, ohne `StringView`**: `length()` in Bytes (O(1)), `s[i]` ist das Zeichen ab Byte `i`, `s[a..b]` liefert einen neuen String, `chars()` iteriert Codepoints. Ein Script-String ist in der VM ein Lyric-5-String (Natives ohne Kopie). `char` bleibt (Unicode-Skalarwert, keine Zahl). |
| O | Optionals | **Wie Lyric 5** (03 T4): `?T` ist ein eigener Konstruktor, `??T` möglich, `??`, `!`, `?.` (flacht ab), Eingrenzung über `!= null`, Member über `extend<T> ?T`. Iterator-Protokoll `next(): ?Item` unverändert. *(Die Frage „`?T` = `T \| null`?" entfiel mit den Unionen.)* |
| Eq | Automatische Konformanzen | **Structs, Enums und Tupel sind automatisch `Equatable` und `Hashable`**, wenn alle Felder es sind (`float` ist nicht `Hashable` — Lyric 5 04). **Klassen wie Lyric 5**: `:: Identity` (Identitäts-`==` und Adress-Hash) oder `:: Equatable`, sonst kein `==`. **`{x}` ohne `Display` fällt auf die `Debug`-Form zurück** — jeder Wert ist druckbar. Die Synthese macht der Compiler (kein `comptime`, 02 W). |
| Mix | `int` und `float` | **`int` wird zu `float`** in gemischter Arithmetik (`done / 3.0`) und an Stellen, die `float` erwarten (`let pct: float = count`). **`int / int` bleibt Ganzzahldivision.** Ab 2⁵³ verliert die Umwandlung still an Genauigkeit (wie Java, Kotlin). |
| Leer | Leere Literale | **Die erste festlegende Verwendung in derselben Funktion bestimmt den Typ** — nur für leere Sammlungsliterale (`var names = []`) und `null`-Initialisierung (`var best = null`). Legt nichts den Typ fest: Fehler an der Deklaration mit Vorschlag. |
| Lit | Literale, die Typen bauen | **`FromArrayLiteral`** (Lyric 5 10 K4) **plus `FromMapLiteral`, `FromStringLiteral`, `FromIntLiteral`, `FromFloatLiteral`, `FromBoolLiteral`, `FromNullLiteral`** (Swift `ExpressibleBy…Literal`). Wirken **nur bei Literalen an Stellen mit Zieltyp**, nie bei Variablen — keine benutzerdefinierten impliziten Umwandlungen (Lyric 5 03 T3). Träger von `let body: Json = ["name": "Anna", "age": 31, "boss": null]` (02 K4). |

## Übernommen (Liste bestätigt)

| Gebiet | Regel | Quelle Lyric 5 |
|---|---|---|
| Typtests | `is` mit Eingrenzung, Typ-Patterns in `match`, `Any` = leeres Interface; **kein `as?`** | 03 T10, T11 |
| Konversion | `as`: `float → int` sättigend (NaN → 0), `char ↔ int` ausdrücklich; `char` und `bool` sind keine Zahlen | 03 T1d, T1e |
| Literale | adaptieren an den Kontext, ohne Kontext `int`/`float`; Unterstriche, Hex/Bin/Okt | 03 T1b |
| Überlauf | Panik in jedem Profil; Wrap-Operatoren `+% -% *%` und `checked*`/`saturating*`/`wrapping*` | 03 T2 |
| Keine Subtypen | feste Liste von Koerzionen an Stellen mit Zieltyp, durch `?` hindurch; keine Varianz, kein LUB | 03 T3 |
| Generics | `Self`, statische Interface-Member, Objektsicherheit; assoziierte Typen; generische `extend` (auch `T[]`, `?T`), Kohärenz ohne Orphan-Regel, keine Spezialisierung; Phantom-Parameter, Default-Typargumente, `_` | 03 T5–T7, T18 |
| Index | `Index<K>`/`IndexSet<K>`, `m[k]` → `?V`, Index-Typ `int`, `^n`, Bereichsprüfung immer | 03 T14 |
| Aliase, Tupel | `type X = …` transparent, parametrisiert; Newtype als Ein-Feld-Struct; benannte Tupel (Namen sind Etiketten) | 03 T15, T16 |
| Funktionstypen | `fn(A, B) -> R`, Closures und freie Funktionen einheitlich, instanziierte Generik als Wert, Methode als Wert — **ohne `throws`** (02 K2) | 03 T17 |
| Inferenz | bidirektional je Statement (außer „Leer" oben); `var x: int` mit Definite Assignment | 03 T8 |
| `with` | W1–W8: Kopie mit ersetzten Feldern, alte Werte rechts, verschachtelte Pfade; jetzt **die** Form, einen Struct „zu ändern" | 02 M6 |
| `let`/`var` | `let` bindet fest; Klassenfelder veränderlich, wenn `var`; eine Referenz wurzelt neu | 02 M2, M3 |
| Identität | kein `===`; `same(a, b)` nur für Referenzen | 02 M10 |
| Captures | Schleifenbindungen je Durchlauf frisch | 02 C1 |
| Initialisierung | `?T`-Felder Default `null`, Felddefaults, Kurzform `S { v }`, fehlendes Feld nennt alle; `Point(1, 2)` ≡ `Point.new(1, 2)` | 02 M14, 08 |
| Kein RAII | Scope-Freigabe über `using` (Details Bereich 06) | 02 M12 |

**Zwingende Folgen**: **`mut fn` entfällt** (Structs unveränderlich, Klassenmethoden schreiben
`var`-Felder ohne Marker); **rekursive Structs ohne `Box`** (`struct Node { v: int, next: ?Node }`
— Structs sind in der VM Heap-Objekte, Teilen ist bei unveränderlichen Werten unsichtbar).

## Abweichungen von Lyric 5 (Beitrag zur Tabelle aus 00 Z3)

| Gebiet | Lyric 5 | Lyric-Script | Grund |
|---|---|---|---|
| Sequenzen | `T[]` fest, `List<T>` wachsend, `Slice<T>` Sicht (03 T13) | ein Typ `T[]` wachsend, `List<T>` Alias, Slices kopieren | S |
| Strings | `StringView` (03 T13, 10) | keine Sicht, `s[a..b]` neuer String | Str |
| Konformanzen | Gleichheit/Hash nur über `::`; `Display` nie automatisch (02 M10, 04) | Structs/Enums/Tupel automatisch `Equatable`/`Hashable`; `{x}` fällt auf `Debug` zurück | Eq |
| `int`→`float` | nie implizit (03 T1c) | an `float`-Stellen und in gemischter Arithmetik | Mix |
| Inferenz | keine Variable aus späterer Verwendung (03 T8) | leere Literale und `null`: erste Verwendung in der Funktion | Leer |
| Literal-Protokolle | `FromArrayLiteral` (10 K4) | dazu Map, String, Int, Float, Bool, Null | Lit |
| Rekursive Structs | über `Box<T>` (02 M13) | direkt | Folge |
| `mut fn` | Methodenmarker (02 M4) | entfällt | Folge |
| Funktionstypen | `throws` im Typ (03 T17) | ohne `throws` | 02 K2 |

## Begründung

**Ein Sequenztyp, keine Sichten (S, Str).** Die Unterscheidung fest/wachsend/Sicht dient Lyric 5s
Leistungsrolle (inline Blöcke, kopierfreie Sichten). Im Skript führt sie zur ersten Stolperfalle
(`var xs = [1]; xs.push(2)` auf einem festen Array) und zur Aliasfalle über durchschreibende
Sichten. Kopierende Slices sind Python-, JavaScript- und Swift-Erfahrung; die Kosten (O(k))
treffen nur, wer viel schneidet, und für die Standardbibliothek bleibt die Sicht als Tür.
UTF-8 wie Lyric 5 macht jeden Script-String zu einem Lyric-5-String — die nativen Textkerne der
Standardbibliothek (00 Z6) arbeiten ohne Umwandlung.

**Records vergleichen sich selbst (Eq).** Ein unveränderlicher Struct hat genau eine sinnvolle
Gleichheit, den Inhalt (C#-Records, Kotlin `data class`); sie ausdrücklich anzufordern ist
Zeremonie ohne Information. Bei Klassen bleibt Lyric 5s Regel, weil dort `==` sonst still von
Identität zu Inhalt wechseln würde, sobald jemand `:: Equatable` ergänzt (Javas `equals`-Problem).
Dass jeder Wert druckbar ist, ist Python-Erfahrung und kostet nichts: die `Debug`-Form gibt es
ohnehin für alles.

**Zahlen mischen (Mix).** Durchschnitte und Prozente sind Skript-Alltag; `as float` an jeder
Stelle wäre Zeremonie. Ganzzahldivision bleibt, weil Lyric-5-Code mit `/` auf `int` sonst beim
Übertragen still seine Bedeutung änderte und `//` in Lyric der Kommentar ist.

**Leere Literale (Leer).** `var names = []` mit anschließendem `push` ist das häufigste
Skript-Muster, das Lyric 5s Statement-Inferenz ablehnt. Die Einschränkung auf leere Literale und
`null`, und auf dieselbe Funktion, hält die Fehler nah an der Ursache — der Grund, aus dem Lyric 5
Whole-Function-Inferenz verworfen hat.

**Literale bauen Typen (Lit).** Die Verallgemeinerung eines Lyric-5-Mechanismus statt einer neuen
Typwelt; Script braucht `FromMapLiteral` für das Map-Literal ohnehin. Die Beschränkung auf
Literale hält Lyric 5s Grundsatz der festen Koerzionsliste.

## Verworfene Alternativen

| Option | Warum nicht |
|---|---|
| Drei Sequenztypen wie Lyric 5 (S A) | Stolperfalle `push` auf festem Array, Aliasfalle über Sichten. |
| `T[]` wachsend plus `Slice<T>` (S C) | Aliasfalle bleibt; Sicht als Tür. |
| `StringView` (Str A) | Sichttyp ohne Bedarf im Skript. |
| Codepoint-Strings wie Python (Str B) | Eigene Darstellung je String, Umwandlung an jeder Lyric-5-Grenze. |
| `?T` = `T \| null` (O A) | Entfiel mit den Unionen (02 T4). |
| Konformanzen nur ausdrücklich (Eq A) | Zeremonie bei jedem Record. |
| Klassen automatisch mit Identitäts-`==` (Eq B) | Stiller Bedeutungswechsel beim Ergänzen von `Equatable`. |
| Nie implizit `int`→`float` (Mix A) | `as float` überall im Skript-Alltag. |
| `/` immer `float` (Mix C) | Neuer Operator; Lyric-5-Code ändert beim Übertragen still die Bedeutung. |
| Leeres Literal nur mit Typ (Leer A) | Häufigstes Skript-Muster abgelehnt. |
| Unionen mit Koerzion oder Gitter (U A/B) | Entfiel mit den Unionen. |

## Folgen für die VM (Bereich 11)

- **Ein Sequenztyp**: ein wachsendes Array-Objekt; Slices allokieren.
- **Strings** sind Lyric-5-Strings; Natives arbeiten ohne Kopie.
- **Structs** sind unveränderliche, teilbare Heap-Objekte, auch rekursiv; kein `StructCopy`.
- **`??T`** braucht eine Darstellung, die verschachtelte Optionals unterscheidet (ein Nullzeiger
  allein reicht nicht für `??int`).
- **Gleichheit und Hash** für Structs/Enums/Tupel synthetisiert der Compiler (Methode oder
  VM-Operation, Bereich 11).
- **`int`→`float`** ist eine vom Compiler eingesetzte Umwandlung.
- Leer-Inferenz und Literal-Protokolle sind reine Compilerarbeit.

## Offen für spätere Bereiche

- **05 Abstraktion**: die übrigen Lyric-5-Entscheidungen aus 04 (Delegation `by`, Defaults,
  benannte Argumente, Operator-Familie, `sealed`, Fabriken); die Synthese ohne `comptime` im
  Einzelnen.
- **06 Fehler**: Fehlertypen, Anzeige erschlossener Fehlermengen, `using`.
- **11 Laufzeit**: Monomorphisierung oder Typlöschung (die Sprache erlaubt beides, ein bloßes
  `T` ist opak); Darstellung von `??T`.
