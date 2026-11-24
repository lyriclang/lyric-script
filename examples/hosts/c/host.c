/* A host of C's (design/v1, 11 Emb b; the close of S8): a game that gives its mods the module
 * `host.game`, implemented in C through liblyric_script. A mod runs under a budget: one that loops
 * forever is halted and aborted, and the game goes on; one that asks for a right the game does not
 * give does not load.
 *
 * Built against the library and its header from `lyric5 build --lib`:
 *   zig cc examples/hosts/c/host.c -I out/debug/<target> out/debug/<target>/liblyric_script.a <libs> */
#include <stdio.h>
#include <string.h>
#include "lyric_script.h"

typedef lyric_script_abi_Budget Budget;

static const Budget unlimited = { -1, -1, -1 };

/* the game's world */
static int64_t score = 0;

static const char *gameModule =
    "fn say(text: string)\n"
    "fn add(points: int): int\n"
    "fn score(): int\n"
    "@Requires(\"cheats\")\n"
    "fn setScore(n: int)\n";

static const char *mod =
    "import host.game { add, say, score }\n"
    "pub fn onTick(n: int): int {\n"
    "    say(f\"tick {n}\")\n"
    "    return add(n * 10)\n"
    "}\n"
    "pub fn spin(): int {\n"
    "    var i = 0\n"
    "    while (true) {\n"
    "        i += 1\n"
    "    }\n"
    "    return i\n"
    "}\n";

static const char *cheat =
    "import host.game { setScore }\n"
    "pub fn win() {\n"
    "    setScore(1000000)\n"
    "}\n";

/* what failed last, as the runtime says it */
static const char *failure(void) {
    static char said[512];
    LyrError e;
    said[0] = 0;
    if (lyr_take_error(&e) != LYR_OK && e.message != NULL) {
        snprintf(said, sizeof said, "%s", e.message);
    }
    return said;
}

static int64_t intValue(int64_t n) {
    int64_t v = 0;
    lyrs_int(n, &v);
    return v;
}

/* host.game.say: the mod's line in the game's log */
static int64_t say(void *userdata, int64_t call, int64_t *args, int64_t count) {
    char text[256];
    int64_t n = 0, v = 0;
    (void)userdata, (void)call, (void)count;
    lyrs_value_text(args[0], (uint8_t *)text, sizeof text - 1, &n);
    text[n < (int64_t)sizeof text - 1 ? n : (int64_t)sizeof text - 1] = 0;
    printf("mod: %s\n", text);
    lyrs_void(&v);
    return v;
}

static int64_t add(void *userdata, int64_t call, int64_t *args, int64_t count) {
    int64_t points = 0;
    (void)userdata, (void)call, (void)count;
    lyrs_value_int(args[0], &points);
    score += points;
    return intValue(score);
}

static int64_t getScore(void *userdata, int64_t call, int64_t *args, int64_t count) {
    (void)userdata, (void)call, (void)args, (void)count;
    return intValue(score);
}

static int64_t setScore(void *userdata, int64_t call, int64_t *args, int64_t count) {
    int64_t v = 0;
    (void)userdata, (void)call, (void)count;
    lyrs_value_int(args[0], &score);
    lyrs_void(&v);
    return v;
}

/* how a call ended, as the game shows it */
static void show(const char *what, int64_t r) {
    int64_t kind = -1, v = 0, n = 0;
    lyrs_result_kind(r, &kind);
    if (kind == 0) {
        lyrs_result_value(r, &v);
        lyrs_value_int(v, &n);
        printf("%s = %lld\n", what, (long long)n);
        lyrs_release(v);
    } else if (kind == 3) {
        printf("%s = halted by its budget\n", what);
    } else if (kind == 4) {
        printf("%s = aborted\n", what);
    } else {
        printf("%s = ended as kind %lld\n", what, (long long)kind);
    }
    lyrs_release(r);
}

int main(void) {
    if (lyr_init(NULL) != LYR_OK) {
        return 1;
    }
    int64_t vm = 0, inst = 0, r = 0;
    lyrs_vm_new(NULL, &vm);
    if (lyrs_vm_host(vm, "game", gameModule) != LYR_OK) {
        printf("host.game: %s\n", failure());
        return 1;
    }
    lyrs_vm_implement(vm, "game", "say", say, NULL);
    lyrs_vm_implement(vm, "game", "add", add, NULL);
    lyrs_vm_implement(vm, "game", "score", getScore, NULL);
    lyrs_vm_implement(vm, "game", "setScore", setScore, NULL);

    if (lyrs_vm_load(vm, "mod.lyrs", mod, NULL, 0, false, false, 0, &inst) != LYR_OK) {
        printf("the mod: %s\n", failure());
        return 1;
    }
    lyrs_instance_init(inst, unlimited, &r);
    lyrs_release(r);
    Budget tick = { 1000, -1, -1 };
    for (int64_t n = 1; n <= 3; n++) {
        int64_t arg = intValue(n);
        char what[32];
        lyrs_instance_call(inst, "onTick", &arg, 1, tick, &r);
        snprintf(what, sizeof what, "onTick(%lld)", (long long)n);
        show(what, r);
        lyrs_release(arg);
    }
    Budget little = { 100000, -1, -1 };
    lyrs_instance_call(inst, "spin", NULL, 0, little, &r);
    show("spin()", r);
    lyrs_instance_abort(inst, &r);
    show("abort", r);
    lyrs_release(inst);

    int64_t cheater = 0;
    if (lyrs_vm_load(vm, "cheat.lyrs", cheat, NULL, 0, false, false, 0, &cheater) != LYR_OK) {
        printf("the cheat: %s\n", failure());
    } else {
        printf("the cheat loaded\n");
        lyrs_release(cheater);
    }
    printf("score = %lld\n", (long long)score);
    lyrs_release(vm);
    return 0;
}
