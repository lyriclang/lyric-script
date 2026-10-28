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
- **Open milestone: S0** — the cut and the scaffold.

## Milestones

| M | Name | Size | State |
|---|---|---|---|
| S0 | Cut and scaffold | M | **open** |
| S1 | VM core | L | — |
| S2 | Front-end core | XL | — |
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

### S0 — open

| Slice | State |
|---|---|
| S0a the plan | done |
| S0b the cut (`v4.6-final`, `archive/4.x`, `docs/archive/4.x/`, new root files) | done |
| S0c scaffold (`lyric_script` package, `lyric-script --version`, C-ABI stub, `diagnostics.toml`) | open |
| S0d CI against pinned Lyric 5 on every Tier 1 target | open |
| S0e specification skeleton (`lyric-spec` branch `script`, `spec.pin`) | open |
| S0f value probe evaluated into 11 | open |

Exit criterion: `lyric-script --version` built and run in CI on every Tier 1 target.

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
| A2d | unchecked element access on the hot path | only if the throughput ratchet is missed |
| A3 | instance attribution in the GC | door (live memory limit per instance) |
