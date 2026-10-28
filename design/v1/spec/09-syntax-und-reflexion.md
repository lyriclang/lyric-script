# 09 — Syntax und Reflexion

Entschieden 2026-10-28 (Maintainer, im Fragedialog). Die Bereiche 09 (Syntax und Grammatik) und
10 (Reflexion und Metaprogrammierung) sind auf Wunsch des Maintainers **zusammengelegt**.
Abweichungsrunde gegen Lyric 5 `design/v5/spec/08-syntax.md` (Y1–Y12) und
`09-metaprogrammierung.md` (A1–A12). Am Ende steht, wie im Fahrplan (00) vorgesehen, die
**gesammelte Abweichungstabelle** aller Bereiche bis hier.

## Ausgangslage

Schon entschieden: Kotlin-Form ohne `;` (02 F1); `[]` für alle Sammlungsliterale (02 L);
`throws`, `try`, `pub`, `internal`, `fn main` werden aus Lyric-5-Code angenommen (05 Th, 07);
keine Makros, kein `comptime`, kein `inline fn` (02 W); Reflexion zur Laufzeit, lesend (02 D);
Synthese über die Compiler-Liste plus Reflexion in Default-Rümpfen (05 Syn).

## Entscheidungen

| # | Frage | Entscheidung |
|---|---|---|
| NL | Ende einer Anweisung | **Lexikalische Regel mit Fortsetzungsregeln** (Go, Swift): (1) innerhalb von `( )` und `[ ]` zählt ein Zeilenumbruch nicht; (2) ein Umbruch beendet die Anweisung, außer die Zeile endet mit einem binären Operator, `=`/Compound, `,`, `.`, `?.`, `=>`, `->`, `::`, `(`, `[`, `{`; (3) oder die nächste Zeile beginnt mit `.`, `?.`, `else`, `catch`, `)`, `]` oder einem nur-binären Operator (`*` `/` `%` `&&` `\|\|` `??` `==` `!=` `<` `>` `<=` `>=` `..` `\|` `&` `^`); (4) **`+`/`-` am Zeilenanfang beginnen eine neue Anweisung, mit Warnung** („Operator ans Zeilenende"); (5) `;` bleibt als Trenner erlaubt, am Zeilenende entfernt es der Formatter; (6) in einer Wert-Position (Lambda, Arm, `if`-Ausdruck) ist der letzte Ausdruck der Wert. |
| Hd | Abhängigkeitskopf | **Frontmatter** (Rust `cargo-script`, RFC 3503): TOML zwischen zwei `---`-Zeilen am Dateianfang, nach einer optionalen `#!`-Zeile; nur dort grammatisch. Ersetzt die Arbeitsnotation `//!` aus 07 Dep (`//!` bleibt die Moduldoku, Lyric 5 Y8). |
| Ret | Wann darf der Rückgabetyp fehlen | **Kotlin-Regel**: `fn f(…) = expr` erschließt den Typ des einen Ausdrucks; ein Blockrumpf ohne Angabe ist `void`; ein Blockrumpf, der einen Wert liefert, braucht die Angabe. Optionaler Lint **`explicit-api`** für Bibliotheken. Präzisiert 02 K1d: „Pflicht an Exporten" entfällt (die Host-API ist auf der Host-Seite typisiert, native Module sind Lyric 5) — es löst den Widerspruch zu „öffentlich als Vorgabe" (02 V). |
| Cmp | Lyric-5-Formen, die Script nicht hat | **Angenommen wird nur, was dasselbe bedeutet**: `;`, `throws`, `try`, `pub`, `internal`, `fn main`, `List<T>`, `Box<T>`, `mut fn` an Klassenmethoden (wirkungslos), `StringView` (Alias für `string`). **Alles andere ist ein Fehler mit Hinweis**: `&x`-Parameter, `int8…uint64`/`float32`, `var`-Felder in Structs, `mut fn` an Structs, `Slice<T>`, `T[N]`, `comptime`, `macro`/`quote`/`name!()`, `inline fn`, `unsafe`/`Ptr`/`extern "C"`/`@Layout`, `Thread`/`Mutex`/`Atomic`, `@When`, `for (x in try src)`. Was mechanisch geht, überträgt **`lyric-script fix --from-lyric5`** (Breiten → `int`, `try` im `for`-Kopf entfernen …). |
| Rf | Reichweite der Reflexion | **Lesen**: `reflect.typeOf(x)`/`TypeInfo.of<T>()` mit Name, Art, Feldern (`get` liefert `Any`), Varianten, Konformanzen, Attributen; Funktionen eines Moduls mit ihren Attributen und dem **Funktionswert als `Any`** — aufgerufen wird erst nach einer `is`-Prüfung, danach statisch typisiert. Kein dynamischer Aufruf, kein Schreiben, kein Bauen; **`reflect.construct<T>` ist Tür** (würde eigene Deserialisierer erlauben, umginge aber Fabriken). |
| At | Attribute | **Art 1 (Daten) und Art 2 (geschlossene Compiler-Liste)** wie Lyric 5; Art 3 (Makroanwendung) entfällt. **Daten-Attribute sind zur Laufzeit über die Reflexion lesbar** (`f.attribute<Route>()`) — Frameworks und Test-Runner entdecken Deklarationen, ohne dass beim Import Code läuft. Decorators im Python-Sinn sind Tür. |

## Syntax — übernommen aus Lyric 5 08 (Liste bestätigt)

| # | Regel | Script-Anpassung |
|---|---|---|
| Y1 | reservierte und kontextuelle Wörter wie Lyric 5 — **auch die, die Script nicht nutzt** (`comptime`, `quote`, `mut` …), damit Namen in beide Richtungen übertragbar bleiben; Breiten-Typnamen nicht deklarierbar | Benutzung → Hinweis nach Cmp |
| Y2 | Deklarationen: `,` zwischen Feldern, Enum-Methoden nach `;`, `:: [I, J]` mit Listenregel, `by`, `sealed interface`, Interface-Member (`type Item`, `static fn`), Koroutine über den Rückgabetyp, `extend`-Formen, `type X = …` | Zeilenumbruch trennt Felder auch ohne `,` (Formatter schreibt `,`); entfallen: `macro`, `extern`, `&`-Parameter, `inline fn`, `T[N]` |
| Y4 | Präzedenztabelle, nicht-assoziative Vergleiche (`a < b < c` Fehler mit Hinweis), `+%`-Familie; `if`/`match`/`loop`/`try … catch` als Ausdrücke; Wert-Blöcke | ohne Präfix-`&` und `comptime`; `as` nur zwischen `int`, `float`, `char` |
| Y5 | Rümpfe immer geklammert; `let p = e else { }`; `loop`, Labels, `using let`, `defer`; Zuweisung als Ausdruck (Warnung in Bedingungen); kein `switch` | `;` optional (NL) |
| Y6 | Patterns: bloße Namen binden, `.Red`, Typ-Patterns, `s in [A, B]`, `=` als Feldtest, `[a, ..rest]`, Erschöpfung | `..rest` bindet eine **Kopie** (keine Sichten, 03 S) |
| Y7 | Literale (Hex, Bin, `_`, Raw `r"…"`, `"""…"""`), `'😀'`, **eine Formatsprache**, keine Comprehensions | `b"…"` → `Bytes`; Map-Literal `["a": 1]`, `[:]` |
| Y8 | `//`, geschachteltes `/* */`, `///` Doku, `//!` Moduldoku | Frontmatter `---` (Hd), `#!`-Zeile |
| Y9 | `.Red`, `S { v }`, `Point(1, 2)`, `^n`, `!in`, `?.` `??` `!` `??=`, Ranges, benannte Argumente, nachlaufende Kommata | — |
| Y10 | eine Form, `lyric-script fmt` ohne Optionen, 4 Leerzeichen, K&R, weiche Breite 100 | Formatter entfernt `;` am Zeilenende — bringt Lyric-5-Code in Script-Form |
| Y11 | Lambdas: drei Formen, mehrere Parameter im Trailing-Block, `it`, Wert-Block-Rumpf, `return` verlässt das Lambda, lokale `fn`, Methodenreferenzen | ohne `inline fn`; `throws` in der Paren-Form erlaubt und geprüft (05 Th) |
| Y12 | Makro- und `comptime`-Syntax | **entfällt** (02 W) |

## Reflexion und Attribute — Einzelheiten (Liste bestätigt)

| Thema | Regel |
|---|---|
| Attribut-Arten | Art 1 = Struct mit Zielmarker (`OnFunction`, `OnType` …, Hierarchie wie Lyric 5 09 A2); Art 2 geschlossen; Identität am vollen Pfad (A3); an allen Deklarationen; **Argumente sind Konstantenausdrücke** (Literale, `let`-Konstanten, datenlose Varianten) — es gibt kein `comptime` |
| Art-2-Liste | `@Deprecated { message, until, replacement }`, `@Test`, `@Bench`, `@MustUse`, `@NonExhaustive`, `@callerExpr`/`@callerLine`/`@callerFile`, `@Allow`/`@Warn`/`@Deny`, `@Shared` (bei `Clone` von Klassen). **Weg**: `@AlwaysInline`/`@NoInline`/`@Cold`, `@When`, `@Export`, `@Layout` |
| Plattformen | Laufzeitprüfung (`if (os.name == "windows")`) statt `@When` |
| Doc-Tests | `///`-Codeblöcke laufen unter `lyric-script test` (A9) |
| Lints | `[lints]` im Manifest plus `@Allow`/`@Warn`/`@Deny` (A10) |
| Reflexions-API (Arbeitsform) | `reflect.typeOf(x)`, `TypeInfo.of<T>()` → `name`, `kind`, `fields` (Name, Typ, Attribute, `get`), `variants`, `conformances`, `attributes`; Enums `e.name()`, `E.variants()`, `E.fromName(s)`; `reflect.module(pfad).functions` (Name, Attribute, `value: Any`) |
| Sichtbarkeit | die Reflexion sieht, was an der Aufrufstelle sichtbar ist (Lyric 5 09 R7); die Host-API sieht alles Nicht-Private |
| Vorgabe an 11 | `typeOf([1, 2])` sagt `int[]` — **Typargumente bleiben zur Laufzeit erhalten** (Monomorphisierung oder reifizierte Generics, keine Typlöschung ohne Rest) |

## Begründung

**Zeilenende im Lexer (NL).** Lyric 5 hat `;` behalten, weil Zeilenumbruch-Regeln jedes Werkzeug
belasten; Script hat sich für die Form ohne `;` entschieden und muss den Preis klein halten. Eine
Regel, die der Lexer mit einem Token Vorausschau entscheidet, hält Formatter, Tree-sitter und LSP
einfach und das Verhalten vorhersagbar; die eine bekannte Falle (unäres `+`/`-` am Zeilenanfang)
fängt eine Warnung statt Kotlins Stille.

**Frontmatter (Hd).** Der Kopf soll etwas tun; Lyric 5 sagt „Kommentare tun nichts". Ein eigener,
nur am Dateianfang gültiger Block ist ehrlicher als ein Kommentar mit Bedeutung, und Rust hat
dieselbe Form gewählt.

**Kotlin-Regel (Ret).** Inferenz für Ausdrucksrümpfe bleibt lokal (der Typ eines Ausdrucks), was
Hot-Reload-Kaskaden und ferne Fehler vermeidet; Blockrümpfe mit Wert brauchen die Angabe. Alle
Zielprogramme des Leitbilds folgen der Regel bereits; sie macht K1d mit „öffentlich als Vorgabe"
verträglich.

**Was angenommen wird, bedeutet dasselbe (Cmp).** Übertragbarkeit (00 Z3) ist nur etwas wert, wenn
übertragener Code dasselbe tut. Stille Annahmen mit anderer Bedeutung (`Slice` als Kopie statt
Sicht) wären schlimmer als ein Fehler mit Hinweis; mechanische Fälle übernimmt `fix`.

**Lesende Reflexion, lesbare Attribute (Rf, At).** Zusammen ersetzen sie für Skripte, was in
Lyric 5 Makros und `comptime` leisten: Frameworks finden Handler, Test-Runner Tests, Inspektoren
Felder — ohne dass beim Import Code läuft (07 Top) und ohne einen zweiten, ungeprüften Aufrufweg.

## Verworfene Alternativen

| Option | Warum nicht |
|---|---|
| Parser entscheidet über das Zeilenende (NL B) | Regeln in der Grammatik, Werkzeuge bauen nach; Kotlins stille Falle. |
| Kommentarblock (Hd B), TOML-Zaun in `//!` (Hd C) | Ein Kommentar, der etwas tut; Doku und Konfiguration vermischt. |
| Volle Rückgabetyp-Inferenz (Ret B) | Ketten über Module, Reload-Kaskaden, ferne Fehler. |
| Rückgabetyp an allen nicht-privaten Funktionen (Ret C) | Mit „öffentlich als Vorgabe" fast überall Pflicht. |
| Lyric-5-Formen still annehmen (Cmp B) | Übertragener Code mit anderer Bedeutung. |
| Dynamischer Aufruf (Rf B) | Zweiter, ungeprüfter Aufrufweg. |
| Werte bauen (Rf C) | Umgeht Fabriken; Tür. |
| Decorators (At B) | Code beim Import, Reihenfolge, Reload-Fragen; Tür. |

## Gesammelte Abweichungstabelle (00 Z3), Stand Bereich 09

Lyric 5 ist die Referenz; jede Zeile ist eine begründete Abweichung. Quelle = Entscheidung in
diesem Plan.

| Gebiet | Lyric 5 | Lyric-Script | Quelle |
|---|---|---|---|
| **Rolle** | keine Capabilities, kein Budget | Rechte, Budget, Hot-Reload, Isolation je Instanz | 00 Z0, 01 |
| Map/Set-Reihenfolge | unspezifiziert (10 I8) | Einfügereihenfolge | 01 S8 |
| Hash-Schlüssel | zufälliger Prozessschlüssel (10 K2) | aus dem Instanz-Seed, wenn gesetzt | 01 S8 |
| **Anweisungsende** | `;` Pflicht (08 Y5) | Zeilenende mit Fortsetzungsregeln; `;` erlaubt | 02 F1, 09 NL |
| Prelude | ohne `println` (10 B1) | `print`, `println`, `eprintln`, `readLine`, `args`, `exit` | 02 K1a, 07 |
| Rückgabetyp | immer geschrieben (03 T8) | Kotlin-Regel: `= expr` erschlossen, Block ohne Angabe `void` | 02 K1d, 09 Ret |
| Map-Literal | keins (10 K4) | `["a": 1]`, `[:]` | 02 L |
| Literal-Protokolle | `FromArrayLiteral` | dazu Map, String, Int, Float, Bool, Null | 03 Lit |
| **Fehler** | `throws`-Pflicht, `try`-Pflicht (05) | erschlossene Mengen; `throws` optional und geprüft, `try` wirkungslos; Lint `unmarked-throw` | 02 K2, 05 Th |
| Funktionstypen | `throws` im Typ (03 T17) | ohne `throws` | 02 K2 |
| Iterator | `type Error`, `for (x in try src)` (10 B6) | ohne Fehlertyp | 05 |
| **Zahlen** | `int8…uint64`, `float32/64` (03 T1) | `int`, `float`; `Bytes`, `BigInt` in std | 02 T1 |
| `int`→`float` | nie implizit (03 T1c) | an `float`-Stellen und in gemischter Arithmetik | 03 Mix |
| `float` | kein `TotalOrder` (04 D6) | `TotalOrder` (IEEE-totalOrder) | 05 Fl |
| **Structs** | `var`-Felder, `mut fn`, Kopie (02 M2, M4) | immer unveränderlich, `with`, geteilt; kein `mut fn` | 02 T7, 03 |
| Rekursive Structs | `Box<T>` (02 M13) | direkt | 03 |
| Sequenzen | `T[]` fest, `List<T>`, `Slice<T>` (03 T13) | ein wachsender Typ `T[]`, `List<T>` Alias, Slices kopieren | 03 S |
| Strings | `StringView` (03 T13) | keine Sicht, `s[a..b]` neuer String | 03 Str |
| Konformanzen | Gleichheit/Hash nur über `::`, `Display` nie automatisch (02 M10, 04 D7) | Structs/Enums/Tupel automatisch `Equatable`/`Hashable`; `{x}` fällt auf `Debug` zurück | 03 Eq |
| Leere Literale | Typ an der Deklaration (03 T8) | erste Verwendung in derselben Funktion | 03 Leer |
| Struct als Interface-Wert | Kopie (04 D12) | geteilt | 05 |
| `Clone` | Structs und Klassen | nur Klassen sinnvoll | 05 |
| Referenzparameter | `&x: T` (03 T12) | entfällt | 02 W |
| **Metaprogrammierung** | `comptime`, Makros, `inline fn` (09) | entfällt; Synthese: Compiler-Liste + Reflexion in Default-Rümpfen | 02 W, 05 Syn |
| Reflexion | nur zur Compile-Zeit (09 R6) | lesend zur Laufzeit, Funktionswerte als `Any` | 02 D, 09 Rf |
| Attribute | drei Arten, Daten nur für `comptime`/Host lesbar (09 A1) | Art 1 + 2, Daten zur Laufzeit lesbar; Art-2-Liste ohne `@When`, `@Export`, Inline-Hinweise | 09 At |
| Bedingungskompilierung | `@When`, `comptime if` (09 A6) | Laufzeitprüfung | 09 |
| Threads | Threads, `Mutex`, `Atomic`, Speichermodell (06) | eine Instanz = ein Thread; `Semaphore` | 02 W, 07 |
| Hardwarenahes | `T[N]`, `@Layout`, `unsafe`, `Ptr`, `extern "C"` (03, 11) | entfällt; Fremdgrenze = native Module | 00 Z5, 02 W |
| Sichtbarkeit | `private`/`internal` (Vorgabe)/`pub` (07 V2) | öffentlich als Vorgabe, `private`; `pub`/`internal` angenommen | 02 V, 07 |
| **Top-Level-Code** | keine Top-Level-Statements (07 M7e) | Anweisungen = `main` des Moduls, nur der Einstieg führt aus | 00 Z1, 07 Top |
| Programmende | `main` endet → Ende (06 T6) | Top-Level ist ein `TaskScope` | 07 End |
| Global-Initializer | dürfen nicht werfen (07 V5) | dürfen werfen | 07 |
| Modulpfad | Paketname immer vorn (07 V1) | ohne Manifest ohne Präfix | 07 Path |
| Einzeldatei | nur `std` (11 W1) | Abhängigkeiten im Frontmatter | 07 Dep, 09 Hd |
| Manifest | `lyric.toml` | `lyric-script.toml` (gleiches Schema) | 07 Man |
| Patterns | `..rest` bindet einen View (08 Y6) | bindet eine Kopie | 09 |
| Byte-Strings | `b"…"` → `uint8[]` (08 Y7) | → `Bytes` | 02 T1, 09 |

**Bewusst gleich wie Lyric 5** (Auswahl): statische Typen; Parametertypen; keine Unionen; keine
Vererbung; nominale Interfaces mit Synthese über `::`; Generics mit assoziierten Typen;
Optionals mit `??T`; Überladung nur nach Arität; Paniken nicht fangbar; keine Färbung beim Warten;
Koroutinen, Tasks, Channels; Formatsprache; Präzedenz; Patterns; Klammern um Kontrollköpfe.
