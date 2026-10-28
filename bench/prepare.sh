#!/bin/bash
# Messpunkt 1 (S1h): copies the programs to a directory on the Linux file system, compiles the
# 4.x versions with lyrc (profiles release and debug), writes their disassembly and the machine
# description into results/. Run under WSL after building both toolchains (see README.md).
#
#   L46=~/dev/projects/lyric46 OUT=~/dev/projects/lyric-script-bench/bench bash bench/prepare.sh
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
L46=${L46:-$HOME/dev/projects/lyric46}
OUT=${OUT:-$HOME/dev/projects/lyric-script-bench/bench}
LYRC=$L46/src/Lyrc/bin/Release/net10.0/lyrc
LYRVM=$L46/src/Lyrvm/bin/Release/net10.0/lyrvm
rm -rf "$OUT"
mkdir -p "$OUT/bc" "$HERE/results"
cp "$HERE"/*.lyrsasm "$OUT/"
cp -r "$HERE/v46" "$OUT/"
for p in empty fib loop objects objects1; do
    for prof in release debug; do
        "$LYRC" build "$OUT/v46/$p.lyr" -o "$OUT/bc/$p.$prof.lyrbc" --profile $prof \
            --stdlib "$L46/stdlib"
        "$LYRVM" disasm "$OUT/bc/$p.$prof.lyrbc" > "$HERE/results/v46-$p.$prof.disasm.txt"
    done
done
{
    echo "date: $(date -Iseconds)"
    echo "cpu: $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2- | xargs)"
    echo "vcpus: $(nproc)"
    echo "kernel: $(uname -r)"
    echo "os: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2)"
    echo "dotnet runtimes: $(dotnet --list-runtimes | grep NETCore | xargs)"
    echo "lyrc: $("$LYRC" --version)"
    echo "lyrvm: $("$LYRVM" --version)"
    echo "4.6 commit: $(git -C "$L46" rev-parse HEAD) ($(git -C "$L46" describe --tags))"
    echo "zig: $(zig version)"
} > "$HERE/results/machine.txt"
cat "$HERE/results/machine.txt"
