#!/bin/bash
# Builds every Lyric 5 / C variant of the dispatch probe in a WSL working copy.
#   LYRIC5=<path to lyric5> bash build.sh <workdir>
# The probe sources (gen.py) are copied to <workdir>, generated there, and built with the
# release profile; the C twins with the flags of Lyric's release profile (bench/run.py).
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
WORK="${1:?workdir}"
mkdir -p "$WORK/src" "$WORK/bin" "$WORK/emit"
cp "$HERE/gen.py" "$WORK/"
python3 "$WORK/gen.py" "$WORK/src" >/dev/null || exit 1
cd "$WORK/src"
fail=0
for v in p1_reg p2_reg_hotlast p3_reg_ptr p4_stack; do
    if ! "$LYRIC5" build "$v.lyr" --profile release > "$WORK/emit/$v.build.log" 2>&1; then
        echo "BUILD FAILED: $v"; cat "$WORK/emit/$v.build.log"; fail=1; continue
    fi
    exe=$(ls "$WORK"/src/out/release/*/"$v" 2>/dev/null | head -1)
    cp "$exe" "$WORK/bin/$v"
    "$LYRIC5" build "$v.lyr" --profile release --emit c > "$WORK/emit/$v.c" 2>/dev/null
    echo "built $v"
done
# P1 and P3 once more with link-time optimization: std.ffi's Ptr methods live in another C unit
# and are calls without it.
for v in p1_reg p3_reg_ptr; do
    if ! "$LYRIC5" build "$v.lyr" --profile release --lto > "$WORK/emit/${v}_lto.build.log" 2>&1; then
        echo "BUILD FAILED: ${v} --lto"; cat "$WORK/emit/${v}_lto.build.log"; fail=1; continue
    fi
    exe=$(ls "$WORK"/src/out/release/*/"$v" 2>/dev/null | head -1)
    cp "$exe" "$WORK/bin/${v}_lto"
    echo "built ${v}_lto"
done
CFLAGS="-std=gnu11 -O2 -DNDEBUG -ffp-contract=off -fno-sanitize=undefined"
for v in p0_native p5_switch p5b_goto p4c_stack; do
    if ! zig cc $CFLAGS "$v.c" -o "$WORK/bin/$v" 2> "$WORK/emit/$v.build.log"; then
        echo "BUILD FAILED: $v"; cat "$WORK/emit/$v.build.log"; fail=1; continue
    fi
    zig cc $CFLAGS -S -masm=intel "$v.c" -o "$WORK/emit/$v.s" 2>/dev/null
    echo "built $v"
done
exit $fail
