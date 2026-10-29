# Status

The one file that changes often. It says where Lyric-Script stands, which milestone is open, and
how the work is done. The decisions live in [`design/v1/spec/`](design/v1/spec/) (areas 00–14);
the plan with sizes, artefacts and dependencies is
[`14-migration-und-umsetzungsplan.md`](design/v1/spec/14-migration-und-umsetzungsplan.md). The
Lyric 4.x status up to the 4.6 cut is archived at
[`docs/archive/4.x/STATUS.md`](docs/archive/4.x/STATUS.md).

## Where things stand

- **The design round is complete** (2026-10-28, lyric-script#1): areas 00–14, two probes.
- **The 4.x line ends**: tag `v4.6-final` and branch `archive/4.x` hold the C# toolchain and the
  .NET VM; `main` is Lyric-Script 1.0 in development, written in Lyric 5, version `1.0.0-dev`.
- **S0 done** (2026-10-28, lyric-script#2, tag `s0-complete`): `lyric-script --version` built and run in CI on every Tier 1 target against Lyric 5 `c2e88a96`.
- **S1 done** (2026-10-28, lyric-script#3, tag `s1-complete`): the VM core runs hand-written
  bytecode in CI on every Tier 1 target; measurement point 1: **4.3×** 4.6 (target 5×, missed by
  less than 2× — no re-cut; the call path is the first lever before measurement point 3; V3 stays
  A').
- **S2 done** (2026-10-28, lyric-script#4, lyric-spec#382, tag `s2-complete`): `lyric-script run
  hello.lyrs` in CI on every Tier 1 target — lexer, parser, checker and code generator for the
  core, diagnostics as text and JSON, the bytecode cache; measurement point 2: warm 1.36 ms, cold
  1.66 ms (targets 10 and 50 ms).
- **S3 done** (2026-10-29, lyric-script#5, lyric-spec#384, tag `s3-complete`): the type system
  complete — optionals, definite assignment, tuples, enums with payloads and `match`, function
  values, interfaces, generics with descriptors as values of the VM, equality and the Debug form
  without a list, `with`, `Self` and static members, associated types, the literal protocols,
  generic extend blocks; 191 tests, 115 conformance cases. Three bugs since S3g found and fixed
  on the way, and one silent choice (05 §3 rule 2).
- **Open milestone: S4** — errors and control.

## Milestones

| M | Name | Size | State |
|---|---|---|---|
| S0 | Cut and scaffold | M | **done** 2026-10-28 |
| S1 | VM core | L | **done** 2026-10-28 |
| S2 | Front-end core | XL | **done** 2026-10-28 |
| S3 | Type system complete | L | **done** 2026-10-29 |
| S4 | Errors and control | M | **open** |
| S5 | Modules and packages | M | — |
| S6 | Coroutines and tasks | L | — |
| S7 | std core | XL | — |
| S8 | Security and embedding | L | — |
| S9 | Hot reload | L | — |
| S10 | std rest | L | — |
| S11 | Tools I | L | — |
| S12 | Tools II | XL | — |
| S13 | Distribution | M | — |
| S14 | Migration, spec, guide | L | — |
| S15 | Release 1.0.0 | M | — |

Sizes are sessions, not dates: S days, M 1–2 weeks, L 3–4 weeks, XL more. A milestone more than
100 % over its size is re-cut here (CONTRIBUTING, scope check).

### S1 — done

| Slice | State |
|---|---|
| S1a the instruction set | done — the opcode enum folds into one jump table (checked on the pin) |
| S1b modules, functions, types, the structure check | done |
| S1c the text assembler and disassembler | done |
| S1d the interpreter | done — two register stacks, the VM's own frames, the script's panics with frames, `execute` on a task |
| S1e objects | done — `HeapRef`, `ScriptObject`, `ScriptString`, one `nil` |
| S1f the fuel scaffold | done — a loop stops at the same backward jump |
| S1g `lyric-script asm` | done |
| S1h measurement point 1 against 4.6; decide V3 | done — 4.3× (fib 3.2–3.5×, loop 6.0×, objects 4.0–4.2×); target 5× missed by less than 2×; V3 stays A' ([`bench/README.md`](bench/README.md)) |

Exit criterion: hand-written bytecode runs in CI on every Tier 1 target; measurement point 1 recorded.

### S2 — done

| Slice | State |
|---|---|
| S2a the delta chapters 01/02, the case format, the runner | done for the core — lyric-spec#382 (chapter 1, chapter 2's core, the format, the runner, 16 cases); CI runs the suite at `spec.pin` |
| S2b the lexer | done — Lyric 5's tokens and codes, the line end as a token (09 NL; `>` and `>>` kept out of rule 2) |
| S2c the parser | done for the core — `lyric-script check` parses; nesting bounded at 64 (measured on a test's task) |
| S2d names and types (core) | done — the checker for the core; `LYS-NYI0001` names what later milestones build |
| S2e code generation | done — one pass per function, registers Lua's way; the VM gains globals, natives and the core's missing operations; `lyric-script run` |
| S2f diagnostics | done — rustc's text form with columns in characters, Lyric 5's JSON events with `--json`, every code in the catalog |
| S2g `run` and the bytecode cache | done — `run`, `lyric-script x.lyrs`, `--json`, the cache in the user's cache directory (Lyric 5's place), `clean` |
| S2h measurement point 2 | done — warm 1.36 ms, cold 1.66 ms (release, median); both targets hold ([`bench/startup/README.md`](bench/startup/README.md)) |

Exit criterion: `lyric-script run hello.lyrs` in CI on every Tier 1 target; measurement point 2 recorded.

### S3 — done

| Slice | State |
|---|---|
| S3a optionals | done — Lyric 5 §3.1–3.3 with its codes; every value has a slot shape (11 V2: `?int` two scalar slots, `??int` three, a `?T` of a reference the reference with `nil`); results of several slots; narrowing ends at a write; ten cases in the delta's 03 |
| S3b definite assignment, empty literals | done — Lyric 5's definite assignment (`SEM0018`), a global takes its value where declared (`SEM0903`); `var x = null` takes the type of the first use that fixes one (two passes, the first quiet); `[]` and `[:]` take the same way with S7. Follow-ups of S3a: narrowing behind `break`/`continue` and in a value `if`, `==` on optionals. Own codes moved to 0900 (P9) |
| S3c tuples | done — Lyric 5 §6 rules 1–5: labels outside the type, `t.0`/`t.x`, `let (a, b) = t` nested and with `_`; in the VM a tuple is its elements' slots in order, inline. Equality and display with S3h, `for ((a, b) in …)` with S7 |
| S3d enums with values, `match`, patterns | done — tuple and struct variants, `.Variant` where the position names the enum; an enum with payloads is a reference (an object per variant, the tag its first scalar), so it holds itself without a box; `match` as statement and value, Lyric 5's patterns (type patterns with S3f, array patterns with S7), coverage with a witness (Maranget), unreachable arms; patterns in `if let`, `while let`, `let … else`. Arms stand apart by `,` or a line end (P10) |
| S3e function values | done — `fn(A) -> R`, lambdas in three forms (trailing blocks with `it` or named parameters), functions, statics and bound methods as values, calls through values (`call.v`, new); captures: a `let` copied, a `var` in a box made at its declaration, so fresh per loop pass; local `fn` calling itself. Without `throws` until S4 |
| S3f interfaces | done — declarations, defaults (their `this` the interface value), parents, conformance in a list or `extend` (also on `int`, `string`), `by`; an interface value is the conformer's reference or a box; each descriptor carries its slot table and interfaces (format 2), `call.i`, `is.t`, `is.i`; `Any`, `is` with narrowing, type patterns, `sealed`. `Self`, statics, associated types, object safety with S3g |
| S3g generics | done — generic functions (inference, constraints, written type arguments) and types; copies per shape: one shared by VM-object types (constraint calls through the value's table), one per other type. `Self`, statics through a type parameter, associated types, object safety and a generic function as a value go with the descriptors to S3i |
| S3h synthesis, `with` | done — `==`/`!=` on structs, enums, tuples and optionals without a list when every part compares, a class only as an `Identity` (one synthesized function per type); the Debug form given unasked to `{x}` and `println` for every value but the scalars and strings; `with` as Lyric 5 §2.5 has it, paths into held structs, a path after a whole replacement as Lyric 5's stores. `Hashable` with the collections (S7) |
| S3i runtime descriptors | done — every type has a descriptor, a value of the VM: a shared copy gets its arguments' (hidden parameters, or its receiver's) and builds the exact type, a lambda of it holds them, a generic function is a value; values print through their table. `Self` and static members (`static fn`, `static let`), associated types (answers, defaults, bounds, paths, fixations, the value form `Iterator<Item = int>`), the literal protocols, generic extend blocks with conditional conformance, one method set (two defaults of one name: `LYS-SEM0043`; before, the first was taken in silence) and the qualified call `I.m(x)`. Found on the way: three bugs since S3g (a shared copy built `Pair<Any>`; a constrained parameter handed on said `SEM0028`; a lambda of a shared copy erased `T`). With S7: a generic type's constant, blocks on one instance, on built-in constructors and blanket blocks, one name implemented apart per interface (05 §3 rule 4) |

Exit criterion: generic code and interfaces in scripts, in CI; the delta's chapter 03 with its cases.

### S4 — open

Errors and control (plan 14, S4): VM exceptions, inferred error sets, a written `throws` checked,
`try?`/`try!`/`try … catch`, `catch (e in […])`, `defer`/`using`, `loop`/`break value`, `never`
(05). The slices are made precise in 14 before the work starts.

Exit criterion: the error examples run; exit codes 1 and 101.

## Working mode

Decided 2026-10-28 (14): **autonomous, as on the Lyric 5 line** — Claude plans each slice and
implements it, commits and pushes per slice, opens a PR per milestone, reads CI itself and
merges green PRs; the maintainer reviews and releases at milestone boundaries. Watched: whether
the understanding of the code keeps pace with its size.

## Environment

- **Lyric 5 is pinned** in [`lyric5.pin`](lyric5.pin) (from S0d): CI builds `lyric5` from that
  commit until Lyric 5's `lyric toolchain install` allows an exact pin (Lyric 5 M15; requirement
  A2c).
- Under WSL the pinned build lives in its own worktree (`~/dev/projects/lyric-worktrees/script-pin`),
  never in the Lyric 5 session's checkout; no Lyric 5 test runs from here (shared `/tmp` caches);
  no builds while a measurement probe runs.
- Findings in Lyric 5 go to `lyriclang/lyric` as issues, not as workarounds here.

## Requirements on Lyric 5

| # | Requirement | State |
|---|---|---|
| A1 | several Lyric 5 libraries in one process | door (dynamically loaded native modules) |
| A2c | exact toolchain pin | worked around until Lyric 5 M15 |
| A2d | unchecked element access on the hot path | not yet: measurement point 1 missed 5× (4.3×), the ratchet binds at measurement point 3 — open point |
| A3 | instance attribution in the GC | door (live memory limit per instance) |
| A4 | one card mark for a 16-byte store (interface values) | filed: lyric#610 (open); V3 decided without it at measurement point 1 |
| F1 | a bug: a field of type `List<Map<…>>` does not lower (LYR-ICE0002) | filed: lyric#612; the checker holds its scopes in a class of their own until it is fixed |

## Open points for the maintainer

Collected while working autonomously; each one waits for a decision, none blocks the next slice.

| # | Point | Since |
|---|---|---|
| P1 | File A2d with Lyric 5 now (measurement point 1 missed 5×), or only if measurement point 3 misses? The call path is Script's own lever first. | S1h |
| P2 | `>` and `>>` kept out of 09 NL rule 2, because they close type arguments too (recorded in 09 as a precision; spec 1 D1). | S2b |
| P3 | `Name {` opens an initializer only after a capital name (spec 2 D4): with line ends instead of `;`, Lyric 5's rule (what ends the first value) cannot tell an initializer from a trailing block. | S2c |
| P4 | The parser's nesting bound is 64 (spec 2 D6), below Lyric 5's floor of 128: measured, the parser overflowed a test's task at 95 levels. Raise it by a stack the compiler chooses, once Lyric 5 lets a task choose its stack? *S3h:* the expression spine had grown to about 35 KB a level at -O0 (every temporary of every arm has its own slot) and overflowed the 2 MiB debug task at 60 levels on three targets; its arms moved into methods of their own, 14 KB a level now. The statement spine (`parseStmt` 20 KB, `parseIf` 12 KB), the checker's (`expr` 24 KB, `binary` 15 KB) and the code generator's (`to` 26 KB) are as large: main's 8 MiB holds 64 levels of each, a 2 MiB task about 60. | S2c |
| P5 | A parameter's default is filled in where the call stands, so it cannot read the parameters before it (Lyric 5 §8.1.1 rule 2 lets it). Evaluate defaults in the callee (S3), or keep the narrower rule? | S2d |
| P6 | After a lexical or syntax error the checker does not run, so a file reports its first kind of fault only. Check the parts that parsed? | S2f |
| P7 | An unclosed `(` or `[` swallows the line ends after it (09 NL rule 1), so the parser's recovery skips the rest of the file. | S2c |
| P8 | A global of the script takes its value where it is declared (`SEM0903`): definite assignment cannot follow a function that reads it. Allow `var g: T` at the top where no function reads `g`? | S3b |
| P10 | Arms of a `match` stand apart by `,` or a line end; a line that begins with `.` goes on the line before (09 NL rule 3), so a value arm before a `.Variant` arm needs its `,` (`LYS-PAR0035`, with a hint). Lyric 5 requires the `,` always. Keep the leniency, or require `,` as Lyric 5 does? | S3d |
| P11 | The bytecode cache's key is the source, the toolchain's version and the format (11 Fmt), so a compiler changed within one version gets the old bytecode back: a control in S3h stayed green until the cache was fresh (the check script now sets one). Only a development build meets it; add the build's identity (its binary's hash) to the key, or keep the design's key? | S3h |
| P9 | Script's own codes moved from 0100 to **0900** (spec 16 rule 1): from 0100 they took numbers Lyric 5 uses (its `SEM` reach 0232; `SEM0101`/`0102` are the label codes Script needs in S4), and the catalogue already mirrored Lyric 5's 0106–0226. Done in S3b; say if another range suits better. | S3b |
