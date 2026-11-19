# 15 — Script-Charakter

Entschieden 2026-11-18 (Maintainer, im Gespräch; die vier Gabelungen im Fragedialog, der Rest nach
Empfehlung). Anlass: Script war bis S7 vor allem Lyric mit weniger Zeremonie — kein `;`, zwei
Zahltypen, kein `throws`, Code auf oberster Ebene, erschlossene Rückgaben, `it`, Abhängigkeiten im
Kopf. Das ist Komfort, keine eigene Identität. Ziel dieser Runde: Script soll sich für schnelle
Arbeit lohnen wie Python, als Lyric erkennbar bleiben und eine eigene Sprache sein — nicht „Lyric
ohne Semikolons".

Leitgedanke: Pythons Script-Gefühl kommt nicht aus seiner Syntax, sondern aus drei Dingen — der Weg
von der Idee zum Lauf ist null Schritte lang; Text, Dateien und Prozesse gehen in einer Zeile; man
probiert interaktiv. Wo Script dabei die statischen Typen einsetzen kann, soll es Python
**übertreffen**, nicht nachahmen.

## Ausgangslage (belegt, S7)

| Gebiet | Stand | Lücke |
|---|---|---|
| Argumente | `args` (Prelude), `std.cli` mit Builder (S7i4) | ein kleines Werkzeug schreibt ein Dutzend Zeilen, bevor es arbeitet |
| Prozesse | `Command { program, args }.output()` (S7h3) | jede Automatisierung beginnt mit einem Struct und `.stdout` |
| Einzeiler | keiner; das REPL ist entschieden (12 Repl), noch nicht gebaut | kein `-e`, kein Zeilenmodus |
| Text | `Pattern` für `string`, `char`, Prädikate (S7e1); Regex in S10 als Adapter | kein Regex im Sprachkern; Muster erst zur Laufzeit geprüft |
| Mehrzeilige Strings | `"""…"""`, `r"""…"""` | die Einrückung des Codes landet im Text |

## Entscheidungen

| # | Frage | Entscheidung |
|---|---|---|
| C1 | Argumente eines Skripts | **Die Signatur von `main` ist die Kommandozeile.** Hat das Einstiegsskript `fn main(…)` mit Parametern, liest die Laufzeit die Argumente nach ihr, bevor `main` läuft: ein Parameter ohne Default ist ein Argument (in Reihenfolge); `bool` ein Flag `--name` (Default `false`); einer mit Default eine Option `--name wert`; ein letzter `string[]` der Rest. Namen werden zu Kebab-Case (`dryRun` → `--dry-run`). Erlaubte Typen: `string`, `int`, `float`, `bool`, `char`, Enums ohne Nutzlast (ihre Varianten als Wahl), `?T` davon (optional ohne Default), `string[]` als Rest. Die **Hilfe kommt aus dem Doc-Kommentar**: die erste Zeile über `main` ist die Beschreibung, `/// name: Text` je Parameter. `--help`, Fehler und Exit 2 wie `std.cli` (12 Regel 36) — die Signatur **erzeugt eine `Cli`-Deklaration**, es bleibt ein Mechanismus. Der Code auf oberster Ebene läuft vorher (07 Top), `main` danach mit den gelesenen Werten; ein `main` ohne Parameter bleibt, was es ist. |
| C2 | Prozesse im Code | **Befehlsliteral `` $`git log --oneline {branch}` ``.** Der Text wird an Leerraum in Wörter geteilt, **jedes `{x}` ist genau ein Argument** (ein `string[]` mehrere) — keine Shell, keine Injection, keine Anführungszeichen im Kopf des Autors. Ergebnis: die **Standardausgabe als `string`**, ohne das letzte Zeilenende. **Ein Exit-Code ≠ 0 wirft** `ProcessError { code, stderr }` (wie zx, `set -e`); wer den Status braucht, fängt ihn. Das Literal verlangt das Recht `process` wie ein Import von `std.process` (01 S1) — der Checker vermerkt es am Modul. Für Pipes, Umleitungen und Streams bleibt `Command` der Weg. |
| C3 | Einzeiler und Probieren | **`lyric-script -e 'code'`** läuft `code` als Skript; **`-n`** legt eine Schleife über die Zeilen der Standardeingabe darum, `line` gebunden; **`-p`** gibt `line` nach jedem Durchlauf aus (Perl, Ruby). Bei `-e`/`-n`/`-p` und im REPL wird **der Wert eines letzten Ausdrucks ausgegeben**, der nicht `void` ist (Debug-Form). Rechte wie jeder Lauf (`--allow`, `-A`, Abfrage). Reines Werkzeug: die Sprache bleibt gleich. |
| C4 | Regex | **Literal `re"\d+(\.\d+)?"`**, zur Übersetzungszeit geprüft (ein Fehler ist ein Diagnose-Code mit Stelle), in linearer Zeit (12 Strings). Es **erfüllt das bestehende `Pattern`-Interface**: `s.contains(re"…")`, `s.split(re"\s+")`, `s.replace(re"…", "x")`, `s.find(re"…")` — kein neuer Operator. Gruppen über `re"…".captures(s): ?Captures` (`c[1]`, `c["name"]`). `Regex.parse(text)` für Muster zur Laufzeit wirft. |
| C5 | Mehrzeilige Strings | **`"""…"""` (und `f"""…"""`) verlieren die gemeinsame Einrückung** ihrer Zeilen und die Zeilenenden direkt nach `"""` und vor dem schließenden `"""`; die Einrückung des schließenden `"""` bestimmt, was wegfällt (Swift). Eine Zeile, die weniger eingerückt ist, ist ein Fehler. `r"""…"""` bleibt roh. |

## Abweichungen von Lyric 5 (Nachtrag zur Tabelle in 09)

| Gebiet | Lyric 5 | Lyric-Script | Quelle |
|---|---|---|---|
| Argumente | `std.cli`-Paket (Ring) | `main`-Signatur → Kommandozeile | C1 |
| Prozesse | `std.process` | dazu das Befehlsliteral `` $`…` `` | C2 |
| Werkzeug | kein REPL in 5.0 | `-e`, `-n`, `-p`, REPL mit Ausgabe des letzten Ausdrucks | C3 |
| Regex | `std.regex` | Literal `re"…"`, geprüft beim Übersetzen, als `Pattern` | C4 |
| Strings | `"""` ohne Einrückungsregel | gemeinsame Einrückung fällt weg | C5 |

## Begründung

**Signatur als Kommandozeile (C1).** Hier schlagen die Typen Python: was typer und Swift
ArgumentParser mit Dekoratoren oder Property Wrappers erreichen, ergibt sich aus der Signatur, die
der Autor ohnehin schreibt — mit Prüfung, Hilfe und Exit-Code. Dass sie eine `Cli`-Deklaration
erzeugt, hält Regel 2 (ein Mechanismus): wer mehr braucht (Unterbefehle, Kurzformen), schreibt
`std.cli` aus. Der Doc-Kommentar als Hilfe vermeidet ein neues Sprachmittel und dokumentiert
zugleich.

**Befehlsliteral (C2).** Automatisierung ist die zweite Zielrolle (02); dort ist ein Prozess die
häufigste Zeile. Bash ist kurz und gefährlich (Wortteilung, Injection), `Command` sicher und lang;
zx zeigt, dass beides geht: ein Literal, das Interpolation als Argumente behandelt. Werfen bei Exit
≠ 0 folgt dem Grundsatz von 02 K2 — ein unbehandelter Fehler beendet das Skript mit Meldung —,
statt still mit falscher Ausgabe weiterzulaufen.

**Einzeiler (C3).** Kostet die Sprache nichts und bringt viel: `-n`/`-p` sind das, wofür man heute
awk oder Perl öffnet.

**Regex über Pattern (C4).** Ein geprüftes Literal ist etwas, das Python nicht hat (dort ist ein
Regex ein String, der zur Laufzeit scheitert). Über `Pattern` fügt es sich in die Methoden, die es
schon gibt — kein zweiter Weg, keine neue Syntax außer dem Präfix, das `r""` und `b""` schon haben.

**Einrückung in Strings (C5).** Klein, aber man spürt es bei jedem Template und jeder Hilfe; die
Swift-Regel ist eindeutig und braucht keinen Methodenaufruf (`trimIndent`).

## Verworfene Alternativen

| Option | Warum nicht |
|---|---|
| Einrückung statt Klammern | Nicht mehr als Lyric erkennbar; F1 entschied die Kotlin-Form mit Begründung. |
| List Comprehensions `[x*2 for x in xs if …]` | Zweiter Mechanismus neben `map`/`filter`/`it` (Regel 2). |
| Optionale Parametertypen | Gäbe den Vorteil auf, der Script von Python unterscheidet; bleibt Tür (02 T2). |
| `sh"…"` / nackte Backticks (C2) | `sh` verspricht eine Shell, die es nicht gibt; Backticks allein sind leicht zu übersehen. |
| Ergebnis statt Fehler bei Exit ≠ 0 (C2) | Jede Zeile bräuchte `.stdout` und eine Prüfung; Fehler gingen still verloren. |
| Operator `=~` (C4) | Zweiter Weg neben `Pattern`. |
| `@Help`-Attribut (C1) | Laut in der Signatur; ein neues Art-2-Attribut für Text, den der Doc-Kommentar schon trägt. |
| `/…/` als Regex | Mehrdeutig mit der Division. |

## Uhren

| # | Meilenstein | Warum dort |
|---|---|---|
| C5 | **S10** (std-Rest), mit den Strings | Lexer-Regel; klein, braucht nichts anderes |
| C4 | **S10**, mit dem Adapter `regex` | das Literal braucht die Engine |
| C2 | **S10**, neben `std.process` | `ProcessError`, das Recht vom Literal, `Command` darunter |
| C1 | **S11** (Werkzeuge I), mit `lyric-script test` | braucht die Doc-Kommentare (`doc`) und `std.cli` |
| C3 | **S12** (Werkzeuge II), mit dem REPL | `-e`/`-n`/`-p` teilen den Weg des REPL |
