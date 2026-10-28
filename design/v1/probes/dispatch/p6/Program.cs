// P6 of the dispatch probe (see ../README.md): the probe's loop as a plain Lyric 4.6 program,
// run by the 4.6 interpreter in-process.
//
//   p6harness <lyric-script repo> <out dir> [interp|jit|all]
//
// Per profile (release, debug) it reports
//   - a control run at n = 100 000 000 with an ExecutionBudget: main's result (acc) and the
//     instructions executed,
//   - the median wall time of 5 runs at n = 100 000 000 (after one warm-up run),
//   - tools/Bench's method: two iteration counts, minima over interleaved trials, differenced;
//     instructions per iteration from the budget.
// It writes the release bytecode to <out dir>/p6_release.lyrbc for `lyrvm disasm`.
using System.Diagnostics;
using System.Globalization;
using Lyric.Bytecode;
using Lyric.Compiler;
using Lyric.Core;
using Lyric.Embedding;
using Lyric.Vm;

const string Template = """
    fn main(): int {
        let n = {N};
        let k = 0x9E3779B9;
        let mask = 0x3FFF_FFFF_FFFF_FFFF;
        var i = 0;
        var acc = 0;
        while (i < n) {
            acc = acc + ((i * i) ^ k);
            acc = (acc - (i & 0xFFFF)) & mask;
            i = i + 1;
        }
        return acc;
    }
    """;

const long Full = 100_000_000;
const int Low = 10_000_000;
const int High = 20_000_000;
const int Trials = 9;

var repo = args.Length > 0 ? args[0] : @"C:\Users\Olivier\CLionProjects\lyric-script";
var outDir = args.Length > 1 ? args[1] : ".";
var mode = args.Length > 2 ? args[2] : "interp";
var stdlib = Path.Combine(repo, "stdlib");
Directory.CreateDirectory(outDir);
var inv = CultureInfo.InvariantCulture;

Console.WriteLine($"runtime: .NET {Environment.Version}, {(Debugger.IsAttached ? "debugger" : "no debugger")}, " +
                  $"server GC {System.Runtime.GCSettings.IsServerGC}");
Console.WriteLine();

if (mode is "interp" or "all")
{
    foreach (var profile in new[] { Profile.Release, Profile.Debug })
    {
        var vm = new LangVm(new HostOptions { StdlibRoot = stdlib, Profile = profile });
        LoadedProgram Load(long n, bool save = false)
        {
            var module = vm.Compile(Template.Replace("{N}", n.ToString(inv)), "probe");
            if (save) File.WriteAllBytes(Path.Combine(outDir, $"p6_{profile.Name}.lyrbc"), module.Bytes);
            var loaded = VmHost.Load(module.Bytes, Console.Error) ?? throw new InvalidOperationException("did not load");
            return LoadedProgram.Load(loaded, NativeRegistry.CreateDefault(TextWriter.Null, TextWriter.Null), Capability.None);
        }

        var full = Load(Full, save: true);
        var budget = new ExecutionBudget(long.MaxValue / 2);
        var acc = full.RunEntry([], budget).AsI64;
        var executed = budget.Consumed;
        Console.WriteLine($"[{profile.Name}] control n={Full}: acc={acc} executed={executed}");

        full.RunEntry([]); // warm-up
        var times = new List<double>();
        for (var r = 0; r < 5; r++)
        {
            var t0 = Stopwatch.GetTimestamp();
            var got = full.RunEntry([]).AsI64;
            var secs = (Stopwatch.GetTimestamp() - t0) / (double)Stopwatch.Frequency;
            if (got != acc) throw new InvalidOperationException($"run {r}: acc {got} != {acc}");
            times.Add(secs);
        }
        times.Sort();
        var median = times[2];
        Console.WriteLine(string.Create(inv,
            $"[{profile.Name}] full runs (s): {string.Join(" ", times.Select(t => t.ToString("F3", inv)))}  median {median:F3}  " +
            $"=> {median * 1e9 / executed:F2} ns/instr, {median * 1e9 / Full:F2} ns/iteration"));

        var low = Load(Low);
        var high = Load(High);
        long Charged(LoadedProgram p) { var b = new ExecutionBudget(long.MaxValue / 2); p.RunEntry([], b); return b.Consumed; }
        var perIter = (Charged(high) - Charged(low)) / (double)(High - Low);
        low.RunEntry([]); high.RunEntry([]);
        long bestLow = long.MaxValue, bestHigh = long.MaxValue;
        for (var i = 0; i < Trials; i++)
        {
            var a = Stopwatch.GetTimestamp(); low.RunEntry([]); bestLow = Math.Min(bestLow, Stopwatch.GetTimestamp() - a);
            var b = Stopwatch.GetTimestamp(); high.RunEntry([]); bestHigh = Math.Min(bestHigh, Stopwatch.GetTimestamp() - b);
        }
        var nsIter = (bestHigh - bestLow) * (1e9 / Stopwatch.Frequency) / (High - Low);
        Console.WriteLine(string.Create(inv,
            $"[{profile.Name}] differenced ({High - Low} iterations, {Trials} trials, minima): {perIter:F1} instr/iter, " +
            $"{nsIter:F2} ns/iter, {nsIter / perIter:F2} ns/instr"));
        Console.WriteLine();
    }
}

if (mode is "jit" or "all")
{
    // HostOptions.Compile: the 4.6 line's IL compiler ("--jit"), release profile. Aside only.
    var vm = new LangVm(new HostOptions { StdlibRoot = stdlib, Profile = Profile.Release, Compile = true });
    var module = vm.Compile(Template.Replace("{N}", Full.ToString(inv)), "probe");
    var first = vm.Run(module);
    var times = new List<double>();
    for (var r = 0; r < 5; r++)
    {
        var t0 = Stopwatch.GetTimestamp();
        var got = vm.Run(module);
        times.Add((Stopwatch.GetTimestamp() - t0) / (double)Stopwatch.Frequency);
        if (got != first) throw new InvalidOperationException("jit result differs between runs");
    }
    times.Sort();
    Console.WriteLine(string.Create(inv,
        $"[jit release] result={first} runs (s): {string.Join(" ", times.Select(t => t.ToString("F3", inv)))}  median {times[2]:F3}  " +
        $"=> {times[2] * 1e9 / Full:F2} ns/iteration"));
}
