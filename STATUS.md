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
- **S4 done (2026-10-29)**: errors and control — throwing and the error path through the VM's
  frames, an error's record and `e.backtrace()`, inferred thrown sets with a written `throws` as a
  contract, `try?`/`try!`/`try … catch`, the rules among clauses and a match over a clause's set,
  `defer` and `using` with suppressed errors, labels, `do … while`, `never` and the prelude's
  panics; 245 tests, 165 conformance cases. Found on the way: a copy at a scalar handed it to an
  interface parameter as a reference (since S3g).
- **S5 done (2026-10-29)**: modules and packages — a program of modules below the entry's folder
  or a package's `src/`, the three forms of import and `pub import`, `private` per file and
  `internal` per package, types through modules, `fn main`; `lyric-script.toml` with path and git
  dependencies, the lock with commits and content hashes, minimal version selection, `[override]`,
  `update`, `--offline`, `--locked`; a script's frontmatter dependencies; rights from imports with
  `--allow`, `-A` and the question at a terminal; 278 tests, 230 conformance cases, bytecode
  format 9. Found on the way: loops over `Map.keys()` ordered per run, a lambda of no value that
  never ran (since S3e), `run` taking a cached module before the loader's errors (since S5a).
- **S6 done (2026-10-29)**: coroutines and tasks — tasks on VM frames with a cooperative scheduler
  per run, the top level a task scope; coroutine functions, generator lambdas, `sequence`, `for`
  over a coroutine, `close()` and `using`; `cancel`, `spawnDetached`, `TaskScope`, a task's status
  with its values; channels, semaphores, `select`; time — `Duration`, `sleep`, `Timer.after`,
  `withTimeout`; `readLine()` on a Lyric 5 task. 344 tests, 331 conformance cases, bytecode format
  19; `examples/concurrent/pipeline.lyrs` runs in CI. Found on the way: `join` took the first task
  spawned, not the first to fail; coroutines never equal to themselves; the lambda lookahead blind
  to `<…>` (since S3); the conformance runner without a timeout.
- **Open milestone: S7** — std core.

## Milestones

| M | Name | Size | State |
|---|---|---|---|
| S0 | Cut and scaffold | M | **done** 2026-10-28 |
| S1 | VM core | L | **done** 2026-10-28 |
| S2 | Front-end core | XL | **done** 2026-10-28 |
| S3 | Type system complete | L | **done** 2026-10-29 |
| S4 | Errors and control | M | **done** 2026-10-29 |
| S5 | Modules and packages | M | **done** 2026-10-29 |
| S6 | Coroutines and tasks | L | **done** 2026-10-29 |
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

### S4 — done

Errors and control (plan 14, S4): VM exceptions, inferred error sets, a written `throws` checked,
`try?`/`try!`/`try … catch`, `catch (e in […])`, `defer`/`using`, `loop`/`break value`, `never`
(05). The slices are made precise in 14 ("S4 — Slices").

| Slice | State |
|---|---|
| S4a throwing and the error path | done — `throw` (a statement, and an expression of type `never`, which now fits every type), the `try` block with typed clauses and the clause without a type; the VM's `throw` and a region table per function (format 4); an error leaves frame after frame to the first region that covers it; one no frame takes is reported through its `message()` and `cause()` in the same run, `error:`/`caused by:` and its frames, exit 1. `Error` and `Exception` in the prelude (from S4b), `LYS-SEM0030`, `LYS-SEM0036`. Found on the way: a copy at a scalar handed it to an interface parameter as a reference (since S3g) |
| S4b the error's record | done — an error keeps where it was first thrown (the frames as functions and instructions, text only when asked); a region's second register receives it, `rethrow` carries it on — `throw e` of a clause's own binding, and an error no clause takes; `e.backtrace()` at the binding (`?Backtrace` of the prelude), only there (`LYS-SEM0012`), the type's own member first; the report shows the first throw's frames. Format 5. `e.suppressed()` with the arrays (S7) |
| S4c thrown sets | done — each function's set inferred after the bodies, to a fixpoint over the calls (`throws.lyr`): its `throw`s and its calls' sets less what its clauses take; a function value throws anything, an interface member what it writes or else what its implementations throw (P14); the clause binding's rethrow throws what reached the clause (K7). A written `throws` is a contract (`LYS-SEM0034` naming type and line), an implementation within its member's (`LYS-SEM0042`), `LYS-SEM0137`, `LYS-PAR0049`; the mark `try e` changes nothing; the lint `unmarked-throw` with the lints (S11) |
| S4d expression forms, clause rules | done — `try?` (not flattened; `LYS-SEM0140` over no value), `try!` (panic `LYS-RT0010` with the error's message; op `panic.c`, format 6), `try e catch (x: A) v` lowered onto the block form, the nearest `try` takes a clause; the set clause `catch (e in [A, B])`; `LYS-SEM0035`, `LYS-SEM0141`, `LYS-SEM0142`, `LYS-PAR0050`, `LYS-PAR0051`; a `match` over a clause's set covers the set (K7, checked after inference). Deviation: the binding stays an `Error` where one type reaches (Lyric 5 M5-6) |
| S4e `defer`, `using` | done — lowered to `TStmt.Finally`, the rest of the scope the region (value blocks too); the defer on every way out: at the end, on the error path under a region whose errors are suppressed into the first (op `suppress`, format 7) before the first goes on, and at `return`/`break`/`continue` as a copy outside its own region (a gap in it); a `return`'s value taken first; the report's `suppressed:` lines. `using let` closes a `Closeable` (`LYS-SEM0143`, `LYS-PAR0052`); a dropped `Closeable` warns (`LYS-SEM0144`). A jump out of a defer's body is refused (`LYS-SEM0904`, P15) |
| S4f control and `never` | done — labels before `loop`/`while`/`do`/`for` (and a `loop` where a value stands), `break outer value`, `continue outer` (`LYS-SEM0101`, `LYS-SEM0102`, `LYS-SEM0103`); `do { … } while (c)`; `never` only as a return type (`LYS-SEM0145`), a `never` function does not return (`LYS-SEM0146`); `panic`, `assert { }` (quotes its condition, builds its message only on failure), `unreachable`, `todo` (RT0008/0011/0012/0013). Found: a `return` of what does not return emitted a `ret` of the wrong shape; `never` as an operand (`b || panic(…)`) was refused |

Exit criterion: the error examples run; exit codes 1 and 101.

### S5 — done

Modules and packages (plan 14, "S5 — Slices"): a file is a module, imports, globals, the path
rule, the prelude, `lyric-script.toml`, the lock, Git and path dependencies, frontmatter
dependencies, rights classes from imports (07).

| Slice | State |
|---|---|
| S5a modules of one root | done — a program is its entry and the modules its imports reach below the entry's folder (`LYS-RES0003`), read once and ordered depth first (`LYS-RES0005` names the cycle); each module's declarations under their own key, every name looked up through the module's view; the three forms of import and `pub import`; `private` on a function (`LYS-RES0009`), a name bound once (`LYS-RES0001`), `LYS-RES0004`, an unused import (`LYS-SEM0072`); only the entry runs its statements, an imported module's `let`/`var` are globals filled first, its other statements warned (`LYS-SEM0905`); diagnostics name their file; the cache keys a program by all its files. Found: three loops over `Map.keys()` (`LYS-SEM0042` from S4c among them) ordered differently per run once a map holds more than about eight entries |
| S5a2 types through modules, namespaces, the entry | done — the entry keyed like any module, so a name hiding the prelude's warns (`LYS-SEM0153`) and a builtin type's name is refused (`LYS-RES0011`); a type through its module (built, generic, variants, statics); `private` on types, fields and methods, a type with a private field built in its file alone (`LYS-RES0009`); members without a word public; exact file names on every platform (`LYS-RES0003`), a name that is also a submodule (`LYS-RES0012`); `fn main` the entry of a script without statements, its `int` the exit code (`LYS-SEM0906`, `LYS-SEM0021`); a frame of an imported module names its file (format 8, P16). Found: a lambda whose body is a call of no value never ran it (since S3e) |
| S5b manifest | done — `lyric-script.toml` (`[package]`, path `[dependencies]`) read through `std.toml`, its faults at their lines (`LYS-PKG0001`–`0005`, `LYS-PKG0009` exits 2); with a manifest Lyric 5's path rule (`app.a.b`, `app` = `src/lib.lyrs`), imports from declared packages only (`LYS-RES0014`); `run`/`check` without a file in a package (`LYS-CLI0005`); `internal` package-wide. The loader moved to `src/loader.lyr` |
| S5c1 git dependencies | done — a tag, a branch, a commit or HEAD's branch of a repository, its URL in its normal form, through the user's cache (a bare clone per repository, a checkout per commit, `git` as a process); `--offline`; `LYS-PKG0006`, `LYS-PKG0007` (exit 2) |
| S5c2 the lock | done — `lyric-script.lock` with commit and content hash (`h1:`), a locked revision read at its commit and checked (`LYS-PKG0008`), `--locked` (`LYS-PKG0011`), `lyric-script update [package…]` (`LYS-CLI0006`). Found: `run` took a cached module before the loader's errors were reported (since S5a) |
| S5c3 versions, overrides, content | done — version lines and minimal version selection over the versions read on the way, `[override]` with a folder, package cycles (`LYS-PKG0010`), `include`/`exclude` for a git package's content (a module outside it is not there), `update` raising a root tag within its line |
| S5d a script's frontmatter | done — `[dependencies]`, `[override]` and `toolchain` in a script's `---` frontmatter, its own modules by the path rule and its dependencies by their names; resolved at the first run and kept in a lock in the cache under the frontmatter's hash; `lyric-script lock tool.lyrs` writes `tool.lyrs.lock` beside it |
| S5e rights from imports | done — the classes `file`, `net`, `process`, `os`, `native`; each import of a module of a class asks for it, recorded with its place in the bytecode (format 9); `run` checks before the start: `--allow`, `-A`, the one question at a terminal, else `LYS-CAP0001` for all at once (exit 2); the table for `std` provisional until S7, `LYRIC_SCRIPT_RIGHTS` its stand-in in tests. Found: lyriclang/lyric#624 (an ICE of `?? null`) |

Exit criterion: a script project of several files with a Git dependency; a single script with
frontmatter. Met by the suite's package cases, which CI runs on all four
platforms (the runner builds the git repositories), and by `examples/project` and
`examples/scripts/square.lyrs` as steps of CI. Clocks elsewhere: the prelude's `eprintln`,
`readLine`, `args`, `exit` and the fixed rights table (S7); scopes on rights and host rights (S8);
`[lints]`, `test`, the note of a local hiding a module (S11).

### S6 — done

Coroutines and tasks (plan 14, "S6 — Slices"): tasks on VM frames, a scheduler per instance,
generators, `spawn`/`await`/`TaskScope` (the top level), channels, `select`, `sleep`, `Timer`,
`Semaphore`, cancellation, `withTimeout`, I/O through Lyric 5 tasks (07, 11).

Exit criterion: a concurrent example — `examples/concurrent/pipeline.lyrs`, a step of CI on all
four platforms. Clocks elsewhere: `Coroutine :: Iterator`, `os.signals`, `IoError` for `readLine`,
tasks and coroutines as interface values (S7); embedded waits, the budget's halt with tasks,
callbacks from natives (S8). Open: P17.

- **S6a done** — tasks in the VM: `spawn { }` → `Task<T>`, `await()`, `status()`, `yieldNow()`;
  a cooperative FIFO scheduler per run; the top level a scope (every task awaited, the first to
  fail by end order ends the run: exit 1, a panic 101); a deadlock panics (`RT0018`). Bytecode
  format 10. Cancelling the siblings on the first failure: S6c.
- **S6b1 done** — coroutines: contexts of their own within the pulling task (a wait parks the
  task), coroutine functions, `yield`, `return` as the result, `next()`, `result()`, `isDone()`;
  bytecode format 11.
- **S6b2 done** — generator lambdas (types from the place, or inferred by a quiet first pass),
  `sequence { }`, `for` over a coroutine; the lambda lookahead takes `<…>` as brackets.
- **S6b3 done** — `close()` throws `Cancelled` at the parked yield (defers run, a defer's error
  comes out), `using`, a `yield` in a called function met at run time, a coroutine an identity;
  bytecode format 12. Tasks and coroutines are no interface values until S7. Open: P17.
- **S6c1 done** — `task.cancel()`: a cancelled task's waits throw `Cancelled`; the top level's
  first failure cancels the others; `spawnDetached { }`; bytecode format 13. The conformance runner
  has a timeout of 60 s a call.
- **S6c2 done** — `TaskScope`: `new`, `spawn`, `close()` waits and throws the first failure,
  `cancel()`; bytecode format 14.
- **S6c3 done** — `TaskStatus<T>` with the value, the error or the `PanicInfo`; `isDone()`;
  bytecode format 15. S6c (cancellation and scopes) complete.
- **S6d1 done** — `Channel<T>` (send, recv, close, `ChannelClosed`), `Semaphore`; bytecode
  format 16.
- **S6d2 done** — `Select.on(c) { }.on(…) { }.run()`, prelude source over three VM intrinsics;
  bytecode format 17.
- **S6d3 done** — time: `Duration`, `sleep`, `Timer.after`, a select's timeout, `withTimeout`;
  the run waits for its earliest timer; bytecode format 18. S6d complete.
- **S6e done** — a native that waits runs on a Lyric 5 task while the script's task waits;
  `readLine()` the first; bytecode format 19. The conformance runner gives `stdin:`.

### S7 — open

std core (plan 14): the native core types (`T[]`, `Map`/`Set` in insertion order, `string`,
`BigInt`, `Bytes`); `core`, `iter`, `collections`, `string`, `fmt`, `math`, `io`, `fs` + `glob`,
`path`, `process`, `os`, `time`, `random`, `test`, `cli`, `log`, `csv`; the rights table; the cost
rules (12). Exit criterion: the target programs, a terminal tool and an automation, run;
measurement point 3, the bench suite at ≥ 5× 4.6. Slices (plan 14, "S7 — Slices"): S7a std as
Script modules, S7b lists, S7c iterators, S7d maps and sets, S7e strings and formats, S7f numbers,
`BigInt`, `Bytes`, S7g I/O and files, S7h processes, environment, time, S7i batteries, S7j the
VM's call path, S7k measurement point 3.

- **S7a done** — `import std.<m>` from Script sources in the binary (`std/`, `comptime embed`), a
  package of their own; the prelude a file too; natives of the std as `__module_name(…)` in a
  function whose signature is theirs; `std.os` (`env`), `std.fs` (`exists`); the rights table
  fixed, `LYRIC_SCRIPT_RIGHTS` retired; bytecode format 20. The conformance runner reads
  `stderr-has:` of a rejected case.
- **S7b1 done** (S7b split in three) — lists: `T[]` native in the VM, its elements' slots apart;
  literals, indexing with the bound (`LYS-RT0003`), `length`/`push`/`pop`, a `for` over a list,
  the Debug form; bytecode format 21.
- **S7b2a done** (S7b2 split in two) — `extend<T> T[]`; the list's methods (in the prelude, or
  written by the checker per element type where they compare), `+`, `*`, `in`, `==`, slices; a
  walk over a list panics after a change of its length (`LYS-RT0016`, Lyric 5's), which S7b1 got
  wrong; bytecode format 22.
- **S7b2b done** — `^n` and open ranges in a list's brackets; `var xs = []` typed by its first
  use; `e.suppressed()`; bytecode format 23. Found: the first pass of 03 Leer left stale
  synthesized functions (an empty line for a struct's Debug form, since S3b/S3h). Moved to S7c
  with generic interfaces (P18): `FromArrayLiteral`, a list as an interface value.
- Next: **S7b3** — `Index<K>`/`IndexSet<K>` for one's own types, array patterns.

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
| P12 | A type parameter whose constraints declare associated types is never shared: each argument gets a copy of its own, since an answer's slots differ by type (`IntBox`'s `Item` an `int`, `StrBox`'s a `string`). A deviation from 11 Gen's sharing for reference types, recorded in 05 rule 11; sharing by the answers' shapes would need descriptors for the answers in the copy. Keep, or share by shape later? | S3i |
| P13 | `id<int>` as a value: a `<` after a name opens type arguments where its `>` is followed by what no comparison goes on with — `(`, a closer, `,`, a line end, `.`, `==`, `!=` (C#'s set, narrowed; 03 rule 12). Lyric 5 writes the rule for a call only. Keep the set? | S3i |
| P14 | A call through an interface member that writes no `throws` throws what the member's implementations in the script throw (S4c). 05 K names `Error` for function values, host and native modules only; "anything" for members would make `e.message()` break every written `throws`. A host-provided implementation (S8) is not in the union — it would have to write its set. Keep the union, or ask members to write `throws`? | S4c |
| P15 | A `return`, or a `break`/`continue` to a loop outside it, in a defer's body is refused (`LYS-SEM0904`, S4e): the defer runs on the error path too, where the jump would drop the error. Lyric 5's spec does not say what such a jump does (its 06 §5 is silent, its compiler treats a defer's jumps as not the loop's). Keep the refusal, or take Lyric 5's answer once it gives one? | S4e |
| P16 | A frame of an imported module's function names its file below the root, `at f (util/deep.lyrs:2)`; the entry's frames keep `(line n)` (S5a2), so a single script's report reads as before. Lyric 5 names the file in every frame. Keep the mixed form, or name the entry's file too? | S5a2 |
| P17 | `spawn`, `yieldNow`, `sequence`, `Task`, `TaskStatus`, `Coroutine` and `Cancelled` stand in the prelude (S6a–S6b3), and so do `TaskScope`, `PanicInfo`, `Channel`, `ChannelClosed`, `Semaphore`, `Select`, `Selection`, `Duration`, `sleep`, `Timer`, `TimedOut` and `withTimeout` (S6c–S6d); Lyric 5 has them in `std.task`, `std.sync` and `std.time` (10 §2), `sequence` in `std.core`, and 07 V3 I8 lists the prelude without them. Keep them in the prelude — a script starts tasks without an import — or move them to `std.task` with the std core (S7), as Lyric 5 does? | S6a |
| P18 | Generic interfaces (`interface I<T>`, Lyric 5 §5) were never built and had no clock: 03 adopts Lyric 5's generics, the parser refuses `interface Maker<T>`, and no plan line names them (found in S7b2b, needed by `FromArrayLiteral<T>`, `FromIterator<T>`, `Contains<T>`). Clocked now to S7c, where `FromIterator` needs them, with `FromArrayLiteral` and a list as an interface value. Say if they should be an earlier slice of their own, or if Script keeps associated types (`type Element`) instead — a deviation that would need deciding. | S7b2b |
| P9 | Script's own codes moved from 0100 to **0900** (spec 16 rule 1): from 0100 they took numbers Lyric 5 uses (its `SEM` reach 0232; `SEM0101`/`0102` are the label codes Script needs in S4), and the catalogue already mirrored Lyric 5's 0106–0226. Done in S3b; say if another range suits better. | S3b |
