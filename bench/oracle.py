#!/usr/bin/env python3
"""Messpunkt 3 (S7k): the expected output of every bench program, computed here independently
of both VMs. run.py compares each run against it.

    python3 bench/oracle.py            prints name and output, one per line
"""


def lcg(x):
    return (x * 1103515245 + 12345) % 2147483648


def fib():
    a, b = 0, 1
    for _ in range(32):
        a, b = b, a + b
    return str(a)


def loop():
    acc = 0
    for i in range(10_000_000):
        acc = (acc + i * i) % 1000003
    return str(acc)


def objects():
    n, rounds = 100_000, 50
    return str(rounds * n * (n - 1) // 2)


def words():
    x, counts = 12345, {}
    for _ in range(100_000):
        x = lcg(x)
        w = "w" + str(x // 65536 % 5000)
        counts[w] = counts.get(w, 0) + 1
    return f"{len(counts)} {max(counts.values())}"


def numbers():
    x, xs = 12345, []
    for _ in range(50_000):
        x = lcg(x)
        xs.append(x % 1_000_000)
    return xs


def checksum(xs):
    check = 0
    for v in xs:
        check = (check * 31 + v) % 1_000_000_007
    return str(check)


def sort():
    return checksum(sorted(numbers()))


def map_():
    x, m = 12345, {}
    for i in range(100_000):
        x = lcg(x)
        m[x % 1000003] = i
    total = sum(m.get(i * 2, 1) for i in range(400_000))
    return f"{len(m)} {total}"


def strings():
    return str(sum(len(str(i)) + 1 for i in range(700_000)))


ORACLE = {
    "empty": lambda: "0",
    "fib": fib,
    "loop": loop,
    "objects": objects,
    "words": words,
    "sort": sort,
    "sortby": sort,
    "map": map_,
    "strings": strings,
}

if __name__ == "__main__":
    for name, f in ORACLE.items():
        print(name, f())
