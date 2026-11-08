#!/bin/bash
# Messpunkt 3 (S7k): copies the bench to a directory on the Linux file system, compiles the 4.x
# programs with lyrc (profile release), checks them once against the oracle and writes the
# machine description into results/suite-machine.txt. Run under WSL after building both
# toolchains (see README.md).
#
#   L46=~/dev/projects/lyric46 OUT=~/dev/projects/s7k-bench SCRIPT=<lyric-script> bash bench/prepare_suite.sh
set -e
export DOTNET_ROOT=${DOTNET_ROOT:-$HOME/.dotnet}
HERE=$(cd "$(dirname "$0")" && pwd)
L46=${L46:-$HOME/dev/projects/lyric46}
OUT=${OUT:-$HOME/dev/projects/s7k-bench}
LYRC=$L46/src/Lyrc/bin/Release/net10.0/lyrc
LYRVM=$L46/src/Lyrvm/bin/Release/net10.0/lyrvm
rm -rf "$OUT"
mkdir -p "$OUT/bc" "$HERE/results"
cp "$HERE"/*.lyrsasm "$HERE/oracle.py" "$OUT/"
cp -r "$HERE/src" "$HERE/v46" "$OUT/"
for p in empty fib loop objects words sort sortby map strings; do
    "$LYRC" build "$OUT/v46/$p.lyr" -o "$OUT/bc/$p.release.lyrbc" --profile release \
        --stdlib "$L46/stdlib"
done
{
    echo "date: $(date -Iseconds)"
    echo "cpu: $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2- | xargs)"
    echo "vcpus: $(nproc)"
    echo "kernel: $(uname -r)"
    echo "os: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2)"
    echo "dotnet runtimes: $(dotnet --list-runtimes 2>/dev/null | grep NETCore | xargs)"
    echo "lyrc: $("$LYRC" --version)"
    echo "lyrvm: $("$LYRVM" --version)"
    echo "4.6 commit: $(git -C "$L46" rev-parse HEAD) ($(git -C "$L46" describe --tags))"
    echo "lyric-script: $("$SCRIPT" --version 2>&1 | head -1) ($SCRIPT)"
    echo "zig: $(zig version)"
} > "$HERE/results/suite-machine.txt"
cat "$HERE/results/suite-machine.txt"
