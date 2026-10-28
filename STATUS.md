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
- **Open milestone: S2** — the front-end core.

## Milestones

| M | Name | Size | State |
|---|---|---|---|
| S0 | Cut and scaffold | M | **done** 2026-10-28 |
| S1 | VM core | L | **done** 2026-10-28 |
| S2 | Front-end core | XL | **open** |
| S3 | Type system complete | L | — |
| S4 | Errors and control | M | — |
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

### S2 — open

| Slice | State |
|---|---|
| S2a the delta chapters 01/02, the case format, the runner | done for the core — lyric-spec#382 (chapter 1, chapter 2's core, the format, the runner, 16 cases); CI runs the suite at `spec.pin` |
| S2b the lexer | done — Lyric 5's tokens and codes, the line end as a token (09 NL; `>` and `>>` kept out of rule 2) |
| S2c the parser | done for the core — `lyric-script check` parses; nesting bounded at 64 (measured on a test's task) |
| S2d names and types (core) | done — the checker for the core; `LYS-NYI0001` names what later milestones build |
| S2e code generation | done — one pass per function, registers Lua's way; the VM gains globals, natives and the core's missing operations; `lyric-script run` |
| S2f diagnostics | done — rustc's text form with columns in characters, Lyric 5's JSON events with `--json`, every code in the catalog |
| S2g `run` and the bytecode cache | done — `run`, `lyric-script x.lyrs`, `--json`, the cache in the user's cache directory (Lyric 5's place), `clean` |
| S2h measurement point 2 | open |

Exit criterion: `lyric-script run hello.lyrs` in CI on every Tier 1 target; measurement point 2 recorded.

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

## Open points for the maintainer

Collected while working autonomously; each one waits for a decision, none blocks the next slice.

| # | Point | Since |
|---|---|---|
| P1 | File A2d with Lyric 5 now (measurement point 1 missed 5×), or only if measurement point 3 misses? The call path is Script's own lever first. | S1h |
