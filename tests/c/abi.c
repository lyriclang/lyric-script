/* The C ABI of Lyric-Script against its static library (S8h1; spec 13 rule 11): a host of C's
 * makes a VM, loads a script, calls it with values and reads what comes back; its mistakes come
 * back as statuses. Built and run by the CI on every target:
 *   lyric5 build --lib
 *   zig cc tests/c/abi.c -I out/debug/<target> out/debug/<target>/liblyric_script.a <libs> */
#include <stdio.h>
#include <string.h>
#include "lyric_script.h"

static int checks = 0;
static int failed = 0;

static void check(int ok, const char *what) {
    checks++;
    if (!ok) {
        failed++;
        printf("FAIL %s\n", what);
    }
}

/* the message of the error the last export left, as text */
static char said[512];
static const char *taken(void) {
    LyrError e;
    said[0] = 0;
    /* it answers the failed export's status; LYR_OK where nothing failed */
    if (lyr_take_error(&e) != LYR_OK && e.message != NULL) {
        snprintf(said, sizeof said, "%s", e.message);
    }
    return said;
}

static int64_t ok(LyrStatus s, int64_t n, const char *what) {
    if (s != LYR_OK) {
        printf("FAIL %s: status %d: %s\n", what, (int)s, taken());
        failed++;
    }
    checks++;
    return n;
}

static const char *text(int64_t v) {
    static char buf[256];
    int64_t n = 0;
    if (lyrs_value_text(v, (uint8_t *)buf, sizeof buf - 1, &n) != LYR_OK) {
        return taken();
    }
    buf[n < (int64_t)sizeof buf - 1 ? n : (int64_t)sizeof buf - 1] = 0;
    return buf;
}

static const char *message(int64_t r) {
    static char buf[256];
    int64_t n = 0;
    if (lyrs_result_message(r, (uint8_t *)buf, sizeof buf - 1, &n) != LYR_OK) {
        return taken();
    }
    buf[n < (int64_t)sizeof buf - 1 ? n : (int64_t)sizeof buf - 1] = 0;
    return buf;
}

static const char *source =
    "var calls = 0\n"
    "pub fn add(a: int, b: int): int = a + b\n"
    "pub fn greet(name: string): string = \"hi \" + name\n"
    "pub fn total(xs: int[]): int {\n"
    "    var t = 0\n"
    "    for (x in xs) {\n"
    "        t += x\n"
    "    }\n"
    "    return t\n"
    "}\n"
    "pub fn count(m: Map<string, int>): Map<string, int> {\n"
    "    m[\"n\"] = m.length()\n"
    "    return m\n"
    "}\n"
    "pub fn half(x: float): float = x / 2.0\n"
    "pub fn next(c: char): char = (c as int + 1) as char\n"
    "pub fn boom(): int = [1][3]\n"
    "pub fn spin(): int {\n"
    "    var i = 0\n"
    "    while (i < 100000) {\n"
    "        i += 1\n"
    "    }\n"
    "    return i\n"
    "}\n"
    "pub fn nap(): int {\n"
    "    sleep(Duration.ofMillis(5))\n"
    "    return 7\n"
    "}\n";

int main(void) {
    lyr_init(NULL);
    lyric_script_abi_Budget none = { -1, -1, -1 };
    int64_t vm = 0;
    ok(lyrs_vm_new(NULL, &vm), 0, "vm");

    /* a source with an error is a status, the error's message from lyr_take_error */
    int64_t bad = 0;
    check(lyrs_vm_load(vm, "bad.lyrs", "pub fn f(): int = \"no\"\n", NULL, 0, false, false, 0, &bad) == LYR_ERROR, "a bad source");
    check(strstr(taken(), "bad.lyrs:1:") != NULL, "its message names the place");

    int64_t inst = 0;
    ok(lyrs_vm_load(vm, "abi.lyrs", source, NULL, 0, false, true, 42, &inst), 0, "load");
    int64_t r = 0;
    ok(lyrs_instance_init(inst, none, &r), 0, "init");
    int64_t kind = -1;
    ok(lyrs_result_kind(r, &kind), 0, "init's kind");
    check(kind == 0, "init gives a value");
    lyrs_release(r);

    /* scalars */
    int64_t a = 0, b = 0, v = 0, n = 0;
    lyrs_int(40, &a);
    lyrs_int(2, &b);
    int64_t args[3] = { a, b, 0 };
    ok(lyrs_instance_call(inst, "add", args, 2, none, &r), 0, "add");
    ok(lyrs_result_value(r, &v), 0, "add's value");
    ok(lyrs_value_int(v, &n), 0, "add's int");
    check(n == 42, "40 + 2");
    lyrs_release(r);
    lyrs_release(v);

    int64_t f = 0;
    double half = 0;
    lyrs_float(5.0, &f);
    ok(lyrs_instance_call(inst, "half", &f, 1, none, &r), 0, "half");
    lyrs_result_value(r, &v);
    ok(lyrs_value_float(v, &half), 0, "half's float");
    check(half == 2.5, "5 / 2");

    int64_t c = 0;
    uint32_t next = 0;
    lyrs_char('a', &c);
    ok(lyrs_instance_call(inst, "next", &c, 1, none, &r), 0, "next");
    lyrs_result_value(r, &v);
    ok(lyrs_value_char(v, &next), 0, "next's char");
    check(next == 'b', "a + 1");

    /* text both ways, a NUL among its bytes */
    int64_t s = 0;
    ok(lyrs_str((uint8_t *)"w\0rld", 5, &s), 0, "a string");
    ok(lyrs_instance_call(inst, "greet", &s, 1, none, &r), 0, "greet");
    lyrs_result_value(r, &v);
    int64_t len = 0;
    ok(lyrs_value_text(v, NULL, 0, &len), 0, "measure");
    check(len == 8, "its length with the NUL");
    char buf[16] = { 0 };
    lyrs_value_text(v, (uint8_t *)buf, sizeof buf, &len);
    check(memcmp(buf, "hi w\0rld", 8) == 0, "the bytes");
    /* a buffer too small takes what fits */
    memset(buf, 0, sizeof buf);
    lyrs_value_text(v, (uint8_t *)buf, 2, &len);
    check(len == 8 && strcmp(buf, "hi") == 0, "a short buffer");

    /* a list */
    int64_t xs[3];
    lyrs_int(1, &xs[0]);
    lyrs_int(2, &xs[1]);
    lyrs_int(3, &xs[2]);
    int64_t list = 0;
    ok(lyrs_list(xs, 3, &list), 0, "a list");
    ok(lyrs_instance_call(inst, "total", &list, 1, none, &r), 0, "total");
    lyrs_result_value(r, &v);
    lyrs_value_int(v, &n);
    check(n == 6, "1 + 2 + 3");

    /* a map, back in its order */
    int64_t keys[2], vals[2], map = 0;
    lyrs_str((uint8_t *)"a", 1, &keys[0]);
    lyrs_str((uint8_t *)"b", 1, &keys[1]);
    lyrs_int(10, &vals[0]);
    lyrs_int(20, &vals[1]);
    ok(lyrs_map(keys, vals, 2, &map), 0, "a map");
    ok(lyrs_instance_call(inst, "count", &map, 1, none, &r), 0, "count");
    lyrs_result_value(r, &v);
    int64_t entries = 0, k2 = 0, v2 = 0;
    ok(lyrs_value_length(v, &entries), 0, "the map's length");
    check(entries == 3, "three entries");
    lyrs_value_key(v, 2, &k2);
    lyrs_value_item(v, 2, &v2);
    check(strcmp(text(k2), "n") == 0, "the new key last");
    lyrs_value_int(v2, &n);
    check(n == 2, "its value");
    int64_t kk = 0;
    ok(lyrs_value_kind(v, &kk), 0, "the map's kind");
    check(kk == 7, "a map");

    /* a panic of the script is a result; the instance goes on */
    ok(lyrs_instance_call(inst, "boom", NULL, 0, none, &r), 0, "boom");
    lyrs_result_kind(r, &kind);
    check(kind == 2, "a panic");
    char code[32] = { 0 };
    lyrs_result_code(r, (uint8_t *)code, sizeof code - 1, &len);
    check(strncmp(code, "LYS-RT", 6) == 0, "its code");
    check(strstr(message(r), "index") != NULL, "its message");

    /* the budget halts a call, resume goes on */
    lyric_script_abi_Budget little = { 100, -1, -1 };
    ok(lyrs_instance_call(inst, "spin", NULL, 0, little, &r), 0, "spin");
    lyrs_result_kind(r, &kind);
    check(kind == 3, "halted");
    int64_t phase = -1;
    lyrs_instance_phase(inst, &phase);
    check(phase == 4, "suspended");
    ok(lyrs_instance_resume(inst, none, &r), 0, "resume");
    lyrs_result_value(r, &v);
    lyrs_value_int(v, &n);
    check(n == 100000, "the loop's end");

    /* a started call that waits, stepped to its end */
    int64_t done = 0;
    ok(lyrs_instance_start(inst, "nap", NULL, 0, none, &done), 0, "start");
    check(done == 0, "it waits");
    bool resting = false;
    lyrs_instance_resting(inst, &resting);
    check(resting, "a call waiting for a timer rests");
    int steps = 0;
    LyrStatus stepped = LYR_OK;
    while (stepped == LYR_OK && done == 0 && steps < 1000000) {
        stepped = lyrs_instance_step(inst, false, none, &done);
        steps++;
    }
    check(stepped == LYR_OK && done != 0, "stepped to the end");
    lyrs_result_value(done, &v);
    lyrs_value_int(v, &n);
    check(n == 7, "nap's value");

    /* the host's mistakes are statuses */
    check(lyrs_value_int(s, &n) == LYR_ERROR, "a string read as an int");
    check(strstr(taken(), "is no int") != NULL, "said so");
    check(lyrs_instance_call(vm, "add", NULL, 0, none, &r) == LYR_ERROR, "a VM as an instance");
    check(strstr(taken(), "is no instance") != NULL, "said so");
    check(lyrs_instance_call(inst, "add", NULL, 0, none, &r) == LYR_ERROR, "too few arguments");
    check(strstr(taken(), "takes 2 arguments") != NULL, "said so");
    check(lyrs_release(a) == LYR_OK, "a release");
    check(lyrs_release(a) == LYR_ERROR, "a second release");
    check(lyrs_value_int(a, &n) == LYR_ERROR, "a released number");
    check(lyrs_value_int(987654321, &n) == LYR_ERROR, "a number never given");
    check(lyrs_value_int(0, &n) == LYR_ERROR, "zero");

    /* abort ends it */
    ok(lyrs_instance_abort(inst, &r), 0, "abort");
    lyrs_result_kind(r, &kind);
    check(kind == 4, "aborted");
    check(lyrs_instance_call(inst, "add", args, 2, none, &r) == LYR_ERROR, "no call after abort");
    lyrs_release(inst);
    lyrs_release(vm);

    printf("abi: %d checks, %d failed\n", checks, failed);
    return failed == 0 ? 0 : 1;
}
