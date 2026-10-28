#!/bin/bash
# Builds every program of the value probe in a WSL working copy.
#   LYRIC5=<path to lyric5> bash build.sh <workdir>
# gen.py is copied to <workdir>, generated there, built with the release profile; the C oracle
# with the flags of Lyric's release profile (bench/run.py), as in the dispatch probe.
set -u
export DOTNET_ROOT="${DOTNET_ROOT:-$HOME/.dotnet}" DOTNET_CLI_TELEMETRY_OPTOUT=1
HERE="$(cd "$(dirname "$0")" && pwd)"
WORK="${1:?workdir}"
mkdir -p "$WORK/src" "$WORK/bin" "$WORK/emit"
cp "$HERE/gen.py" "$WORK/"
python3 "$WORK/gen.py" "$WORK/src" >/dev/null || exit 1
cd "$WORK/src"
fail=0
for v in w1_coerce w2_a w2_b w2_bc w2_o w2_oc w3_map; do
    if ! "$LYRIC5" build "$v.lyr" --profile release > "$WORK/emit/$v.build.log" 2>&1; then
        echo "BUILD FAILED: $v"; cat "$WORK/emit/$v.build.log"; fail=1; continue
    fi
    exe=$(ls "$WORK"/src/out/release/*/"$v" 2>/dev/null | head -1)
    cp "$exe" "$WORK/bin/$v"
    "$LYRIC5" build "$v.lyr" --profile release --emit c > "$WORK/emit/$v.c" 2>/dev/null
    echo "built $v"
done
# W3 once more with link-time optimization: std's hashText instance lies in another C unit and is
# a call without it, so only --lto lets the monomorphized path inline the hash.
if ! "$LYRIC5" build w3_map.lyr --profile release --lto > "$WORK/emit/w3_map_lto.build.log" 2>&1; then
    echo "BUILD FAILED: w3_map --lto"; cat "$WORK/emit/w3_map_lto.build.log"; fail=1
else
    exe=$(ls "$WORK"/src/out/release/*/w3_map 2>/dev/null | head -1)
    cp "$exe" "$WORK/bin/w3_map_lto"
    echo "built w3_map_lto"
fi
CFLAGS="-std=gnu11 -O2 -DNDEBUG -ffp-contract=off -fno-sanitize=undefined"
if ! zig cc $CFLAGS w2_p0.c -o "$WORK/bin/w2_p0" 2> "$WORK/emit/w2_p0.build.log"; then
    echo "BUILD FAILED: w2_p0"; cat "$WORK/emit/w2_p0.build.log"; fail=1
else
    echo "built w2_p0"
fi
exit $fail
