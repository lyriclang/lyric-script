/* Messpunkt 4 (S8, design/v1 11 Perf): a VM and a small instance embedded through the C ABI, its
 * time and its memory. Linux only (it reads /proc/self/statm).
 *
 *   lyric5 build --lib --profile release
 *   zig cc -O2 bench/embed/measure.c -I out/release/<target> out/release/<target>/liblyric_script.a \
 *       -lpthread -lm -lunwind -o measure
 *   ./measure                        (writes small.lyrsc, the small script's bytecode)
 *   ./measure --bytecode small.lyrsc
 *
 * It prints, in milliseconds and KiB:
 *   first from bytecode — with --bytecode: a fresh process's lyr_init, a VM, the small script from
 *             the bytecode its host kept, init and one call, the file read included;
 *   first   — lyr_init, a VM, the small script loaded from its source, init and one call: what a
 *             host pays for its first instance in a fresh process;
 *   source  — the same load from source once the VM is warm, the median of 20;
 *   trusted — an instance from the script's bytecode, init and one call, the median of 20;
 *   empty   — what one more empty instance holds, over 1000 instances of the empty script kept
 *             alive: the collector's live bytes after a full collection (before and after `init`),
 *             and the resident set's growth, each divided by the count.
 * The collector's functions are the runtime's own (lyr/gc.h), in the archive beside the ABI. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include "lyric_script.h"

typedef lyric_script_abi_Budget Budget;

void lyr_gc_collect(void);
int64_t lyr_gc_stat(int64_t which);
enum { LIVE_BYTES = 8 };

static double liveKiB(void) {
    lyr_gc_collect();
    return (double)lyr_gc_stat(LIVE_BYTES) / 1024.0;
}

static const Budget unlimited = { -1, -1, -1 };

static const char *small = "var calls = 0\npub fn f(n: int): int {\n    calls += 1\n    return n * 2 + calls\n}\n";
static const char *empty = "pub fn f() {\n}\n";

static double now(void) {
    struct timespec t;
    clock_gettime(CLOCK_MONOTONIC, &t);
    return (double)t.tv_sec * 1e3 + (double)t.tv_nsec / 1e6;
}

static long residentKiB(void) {
    long pages = 0, resident = 0;
    FILE *f = fopen("/proc/self/statm", "r");
    if (f == NULL) {
        return -1;
    }
    if (fscanf(f, "%ld %ld", &pages, &resident) != 2) {
        resident = -1;
    }
    fclose(f);
    return resident * (sysconf(_SC_PAGESIZE) / 1024);
}

static void must(LyrStatus s, const char *what) {
    if (s != LYR_OK) {
        LyrError e;
        lyr_take_error(&e);
        fprintf(stderr, "%s failed: %s\n", what, e.message ? e.message : "?");
        exit(1);
    }
}

/* init and one call of `f` */
static void run(int64_t inst, int withArgument) {
    int64_t r = 0, arg = 0;
    must(lyrs_instance_init(inst, unlimited, &r), "init");
    lyrs_release(r);
    if (withArgument) {
        lyrs_int(20, &arg);
        must(lyrs_instance_call(inst, "f", &arg, 1, unlimited, &r), "call");
        lyrs_release(arg);
    } else {
        must(lyrs_instance_call(inst, "f", NULL, 0, unlimited, &r), "call");
    }
    lyrs_release(r);
}

static int byValue(const void *a, const void *b) {
    double x = *(const double *)a, y = *(const double *)b;
    return x < y ? -1 : x > y;
}

static double median(double *xs, int n) {
    qsort(xs, (size_t)n, sizeof xs[0], byValue);
    return xs[n / 2];
}

/* `measure --bytecode <file>`: a fresh process's first instance from bytecode the host keeps */
static int fromBytecode(const char *path) {
    double t0 = now();
    FILE *f = fopen(path, "rb");
    if (f == NULL) {
        return 1;
    }
    fseek(f, 0, SEEK_END);
    long length = ftell(f);
    fseek(f, 0, SEEK_SET);
    uint8_t *bytes = malloc((size_t)length);
    if (fread(bytes, 1, (size_t)length, f) != (size_t)length) {
        return 1;
    }
    fclose(f);
    must(lyr_init(NULL), "lyr_init");
    int64_t vm = 0, inst = 0;
    must(lyrs_vm_new(NULL, &vm), "vm");
    must(lyrs_vm_load_trusted(vm, bytes, length, NULL, 0, false, false, 0, &inst), "loadTrusted");
    run(inst, 1);
    printf("first from bytecode %.2f ms (%ld bytes)\n", now() - t0, length);
    return 0;
}

int main(int argc, char **argv) {
    if (argc == 3 && strcmp(argv[1], "--bytecode") == 0) {
        return fromBytecode(argv[2]);
    }
    double t0 = now();
    must(lyr_init(NULL), "lyr_init");
    int64_t vm = 0, inst = 0;
    must(lyrs_vm_new(NULL, &vm), "vm");
    must(lyrs_vm_load(vm, "small.lyrs", small, NULL, 0, false, false, 0, &inst), "load");
    run(inst, 1);
    double first = now() - t0;
    lyrs_release(inst);

    double xs[20];
    for (int k = 0; k < 20; k++) {
        double t = now();
        must(lyrs_vm_load(vm, "small.lyrs", small, NULL, 0, false, false, 0, &inst), "load");
        run(inst, 1);
        xs[k] = now() - t;
        lyrs_release(inst);
    }
    double source = median(xs, 20);

    int64_t code = 0, length = 0;
    must(lyrs_vm_compile(vm, "small.lyrs", small, &code), "compile");
    lyrs_bytes(code, NULL, 0, &length);
    uint8_t *bytes = malloc((size_t)length);
    lyrs_bytes(code, bytes, length, &length);
    for (int k = 0; k < 20; k++) {
        double t = now();
        must(lyrs_vm_load_trusted(vm, bytes, length, NULL, 0, false, false, 0, &inst), "loadTrusted");
        run(inst, 1);
        xs[k] = now() - t;
        lyrs_release(inst);
    }
    double trusted = median(xs, 20);
    /* the bytecode for `--bytecode`, the next process's */
    FILE *out = fopen("small.lyrsc", "wb");
    if (out != NULL) {
        fwrite(bytes, 1, (size_t)length, out);
        fclose(out);
    }
    free(bytes);

    int64_t emptyCode = 0;
    must(lyrs_vm_compile(vm, "empty.lyrs", empty, &emptyCode), "compile");
    lyrs_bytes(emptyCode, NULL, 0, &length);
    bytes = malloc((size_t)length);
    lyrs_bytes(emptyCode, bytes, length, &length);
    enum { N = 1000 };
    static int64_t kept[N];
    /* one instance first, so that what every instance shares is there before the count starts */
    must(lyrs_vm_load_trusted(vm, bytes, length, NULL, 0, false, false, 0, &kept[0]), "loadTrusted");
    run(kept[0], 0);
    long before = residentKiB();
    double live0 = liveKiB();
    for (int k = 1; k < N; k++) {
        must(lyrs_vm_load_trusted(vm, bytes, length, NULL, 0, false, false, 0, &kept[k]), "loadTrusted");
    }
    double live1 = liveKiB();
    for (int k = 1; k < N; k++) {
        run(kept[k], 0);
    }
    double live2 = liveKiB();
    long after = residentKiB();
    double loaded = (live1 - live0) / (N - 1);
    double ready = (live2 - live0) / (N - 1);
    double perInstance = (double)(after - before) / (N - 1);

    printf("first   %.2f ms\n", first);
    printf("source  %.2f ms\n", source);
    printf("trusted %.3f ms\n", trusted);
    printf("empty   %.1f KiB live loaded, %.1f KiB live after init, %.1f KiB resident\n", loaded, ready,
           perInstance);
    return 0;
}
