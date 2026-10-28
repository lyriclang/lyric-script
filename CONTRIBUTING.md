# Contributing to Lyric-Script

This is currently a solo project. The rules below are the maintainer's self-binding contract to
avoid the failure modes of a previous language project ("Oil"), where scope creep and
parallel-mechanism creep killed forward progress. They follow the Lyric 5 line's rules
([lyriclang/lyric](https://github.com/lyriclang/lyric/blob/main/CONTRIBUTING.md)), adapted to
Lyric-Script; the decisions they refer to live in [`design/v1/spec/`](design/v1/spec/)
(areas 00–14, the plan in 14).

---

## The Three Rules

### Rule 1 — No open idea store

Every idea written down in this repository carries **a decision or a clock**: it is decided in a
`design/v1/spec` document (with the reasoning and what was rejected), or it is named there as a
**door** together with what would open it, or it is an issue with a date by which it gets
decided. A list of wishes without an answer does not exist here.

### Rule 2 — One mechanism per concept

| Concept | Single mechanism | Decided in |
|---|---|---|
| Error handling | Thrown errors with inferred sets; a written `throws` is a checked contract; `try?` and `try … catch` handle; `Result` is a value | 02 K2, 05 |
| Cleanup on scope exit | `defer` and `using let` on one LIFO list | 05 |
| Memory management | Lyric 5's tracing GC | 00, 11 |
| Polymorphism | Interfaces with defaults, generic `extend`, delegation `by`; no inheritance | 02, 05 |
| Sum types | `enum` — no unions | 02 T4 |
| Concurrency | Coroutines and tasks on one scheduler per instance; waiting parks; no threads | 07 |
| Foreign code | Native modules (Lyric 5 packages) and the host API (`.lyrs` declarations) | 00 Z5, 11 |
| Code generation | None; synthesis from the compiler's list plus reflection in default bodies | 05 Syn, 09 |
| Sandbox | Rights from imports with optional scopes; budget; ownership per instance | 01 |

Changing a row reopens its area document: the change is written there with its reasoning and
what it replaces, before any code.

### Rule 3 — Every milestone ships something

A milestone is not done until:

1. Its exit criteria, as recorded in [`STATUS.md`](STATUS.md), are met.
2. A git tag exists.
3. Someone could clone the repo, follow the README, and *do something* with it.

No milestone may be marked done by intent alone. There must be an artifact.

---

## How to add a language feature before 1.0

Don't, unless its area document in [`design/v1/spec/`](design/v1/spec/) decides it. A door named
there is not a feature; it opens with its own decision.

If you really must add something not decided there:

1. Write the decision into the area document first — question, options, comparison with Lyric 5
   and other languages, what is rejected. Lyric 5 is the reference: a deviation names its reason
   and joins the deviation table (09).
2. Wait at least **7 days** before opening a PR. The waiting period is mandatory even for the
   maintainer.
3. The PR must include the specification delta and conformance cases (spec-first: the rule in
   `lyric-spec` branch `script`, then its twin here), user-facing documentation, and tests.

If the change would push the milestone it lands in by more than 100 % of its size (14), it is
rejected by default and stays a door.

---

## How to fix a bug

Bugs do not need the 7-day wait: add a failing test that demonstrates the bug, make it pass, open
a PR. A bug found in Lyric 5 goes to `lyriclang/lyric` as an issue, not as a workaround here.

---

## Scope check ritual

On the first Sunday of each month, do a **scope check**:

1. Read the current milestone and its estimate in [`STATUS.md`](STATUS.md).
2. Compare the actual elapsed time with the estimate.
3. If you are >50% over the estimate: honestly evaluate which features can be cut.
4. If you are >100% over: re-cut the milestone and record the change in `STATUS.md`.

A measurement point that misses its ratchet by more than 2× triggers the same re-cut (11 Perf).
Plan changes made on impulse are forbidden.

---

## Code style

| Topic | Convention |
|---|---|
| Naming (Lyric 5 and Lyric-Script code) | `PascalCase` types, `camelCase` everything else |
| Indentation | 4 spaces, no tabs |
| Line length | Soft 100, hard 120 |
| Comments | English, describing the technique and the logic. No justifications, no project history, no milestone or decision references. |

Lyric 5 code is kept in `lyric5 fmt`'s form; Lyric-Script code in `lyric-script fmt`'s form once
the formatter exists (S11). Diagnostics follow Lyric 5's house style; codes carry the prefix
`LYS-` and each has an entry in `diagnostics.toml`.

---

## Commits

```
<area>: <short imperative description>

[optional body explaining why, not what]
```

The area is the subsystem the change lands in (`vm`, `compiler`, `std`, `cli`, `ci`, `design`, …).

---

## Releases

Tags follow `vMAJOR.MINOR.PATCH` semver; every release has an **annotated tag** whose message is
the release note, a GitHub release page, and an entry in [`CHANGELOG.md`](CHANGELOG.md) listing
what changed for someone using Lyric-Script. The release process is decided in S13 and S15.

---

## Questions

Open a GitHub discussion, not an issue. Issues are for actionable work.
