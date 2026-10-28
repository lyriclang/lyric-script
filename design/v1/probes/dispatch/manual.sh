#!/bin/bash
# A2d in isolation: P1's emitted C, rebuilt by hand with single checks switched off. Not a Lyric
# build mode — the macros are overridden after the runtime's headers, for measurement only.
#   WT=<lyric worktree> bash manual.sh <workdir>     (after build.sh)
# Variants, each from the SAME emitted C of p1_reg.lyr (release profile flags, as CBuild passes them):
#   p1_man     unchanged — the control: must time like P1
#   p1_noidx   LYR_CHECK_INDEX empty           (no index checks)
#   p1_bare    + LYR_CHECKED_ADD plain, LYR_LOOP_POLL empty (no index, overflow or poll checks)
set -u
WORK="${1:?workdir}"
CACHE="$WORK/src/out/cache"
main=$(ls "$CACHE"/p1_reg-*.c | head -1)
units="$(ls "$CACHE"/p1_reg-*.units | head -1)"
lib=$(ls "$HOME"/.cache/lyric/runtime/*/lib/x86_64-linux-gnu/release/liblyr-*.a | head -1)
# exactly the flags lyric5 passes for a host build (no -target: zig cc then tunes for this CPU,
# as the lyric5 build and the C twins do); checked: the unchanged unit compiles to the same object
FLAGS="-std=c11 -ffunction-sections -fdata-sections -ffp-contract=off -fdebug-compilation-dir=. -fno-sanitize=undefined -O2 -g -DNDEBUG -I $WT/runtime/include -ffile-prefix-map=$WORK/src=p1_reg -ffile-prefix-map=$WT=lyric"
mkdir -p "$WORK/manual" && cd "$WORK/manual" || exit 1
objs=()
while read -r src; do
    [ "$src" = "$main" ] && continue
    o="$(basename "$src" .c).o"
    zig cc $FLAGS -c "$src" -o "$o" || exit 1
    objs+=("$o")
done < "$units"
last=$(grep -n '^#include' "$main" | tail -1 | cut -d: -f1)
patch() {  # $1 name, $2 the overrides
    { head -n "$last" "$main"; printf '%b\n' "$2"; tail -n +"$((last + 1))" "$main"; } > "$1.c"
    zig cc $FLAGS -c "$1.c" -o "$1.o" || exit 1
    zig cc -O2 -g -DNDEBUG "$1.o" "${objs[@]}" "$lib" -o "$WORK/bin/$1" \
        -Wl,--gc-sections -lpthread -lm -ldl -fno-sanitize=undefined -lunwind || exit 1
    echo "built $1"
}
patch p1_man   '/* probe: unchanged */'
patch p1_noidx '#undef LYR_CHECK_INDEX\n#define LYR_CHECK_INDEX(index, length) ((void)0)'
patch p1_bare  '#undef LYR_CHECK_INDEX\n#define LYR_CHECK_INDEX(index, length) ((void)0)\n#undef LYR_CHECKED_ADD\n#define LYR_CHECKED_ADD(a, b) ((a) + (b))\n#undef LYR_LOOP_POLL\n#define LYR_LOOP_POLL(countdown) ((void)(countdown))'
