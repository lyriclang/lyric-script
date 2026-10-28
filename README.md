# Lyric-Script

A statically typed scripting language of the Lyric family: scripts for the terminal, extensions
for hosts with a sandbox, an instruction budget and hot reload, and embedding in Lyric 5 programs.

> **In development.** The design is complete ([`design/v1/spec/`](design/v1/spec/)); the
> implementation follows the plan to `lyric-script 1.0.0` (milestones S0–S15 in
> [`14-migration-und-umsetzungsplan.md`](design/v1/spec/14-migration-und-umsetzungsplan.md)).
> The core of the language runs — functions, structs, classes, enums, loops, `int` and `float`,
> strings and f-strings, `print`/`println` —; collections, generics, errors, modules and the
> standard library follow. Where it stands: [`STATUS.md`](STATUS.md).

```
lyric-script run examples/scripts/tally.lyrs    # or: lyric-script examples/scripts/tally.lyrs
lyric-script check --json script.lyrs           # diagnostics as JSON lines
```

## The family

- **[Lyric 5](https://github.com/lyriclang/lyric)** is the native language: performance,
  applications, servers. It is the **reference** — Lyric-Script deviates from it only where a
  scripting language needs to, and every deviation is listed with its reason
  ([`09-syntax-und-reflexion.md`](design/v1/spec/09-syntax-und-reflexion.md), the collected table).
- **Lyric-Script** (this repository) is written **in Lyric 5**: compiler and bytecode VM are a
  Lyric 5 library, the command line is one binary `lyric-script`, source files end in `.lyrs`.
- The Lyric 4.x line ends here. Its last tree, the C# toolchain with the .NET VM, is the tag
  [`v4.6-final`](https://github.com/lyriclang/lyric-script/tree/v4.6-final) (never released;
  kept as a behaviour oracle) and the branch `archive/4.x`; its documents are in
  [`docs/archive/4.x/`](docs/archive/4.x/).

## What it will look like

The target picture from the design (not yet runnable):

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

## License

MIT — see [`LICENSE`](LICENSE).
