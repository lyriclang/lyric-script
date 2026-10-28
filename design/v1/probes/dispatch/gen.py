#!/usr/bin/env python3
"""Generates the dispatch-probe variants from ONE opcode table, so every variant runs the same
bytecode through the same 48-arm dispatch and differs only in what it is meant to measure.

    python3 gen.py <outdir>

Register VM (P1, P2, P3, P5, P5b): 48 opcodes, 8 of them hot. Stack VM (P4, P4c): 48 opcodes,
10 of them hot. The program both run (written out in each file):

    i = 0; acc = 0
    do {
        acc = acc +% ((i *% i) ^ k)
        acc = (acc -% (i & 0xFFFF)) & mask
        i = i + 1
    } while (i < n)

k = 0x9E3779B9, mask = 0x3FFFFFFFFFFFFFFF, n from argv[1] (default 100 000 000), so no compiler
can fold the bytecode. Every variant prints `acc=<acc> executed=<dispatches>`.
"""
import pathlib, sys

# ------------------------------------------------------------------------------- register VM
# (number, name, Lyric body over R()/W(), C body). Numbers 0..7 are the hot opcodes.
# In Lyric: R(x) reads register x, W(x, e) writes it; `NEXT` advances pc.

def reg_ops(R, W):
    a, b, c = 'ins.a', 'ins.b', 'ins.c'
    N = ' pc += 1;'
    imm = '(ins.c as uint64)'
    def binop(op): return W(a, f'{R(b)} {op} {R(c)}') + N
    def immop(op): return W(a, f'{R(b)} {op} {imm}') + N
    def cmp(op): return f'if ({R(b)} {op} {R(c)}) {{ {W(a, "1")} }} else {{ {W(a, "0")} }}' + N
    def jcond(cond): return f'if ({cond}) {{ pc = ins.c as int; }} else {{ pc += 1; }}'
    return [
        (0, 'ADD', binop('+%')),
        (1, 'SUB', binop('-%')),
        (2, 'MUL', binop('*%')),
        (3, 'XOR', binop('^')),
        (4, 'AND', binop('&')),
        (5, 'ANDI', immop('&')),
        (6, 'ADDI', immop('+%')),
        (7, 'JLT', jcond(f'{R(a)} < {R(b)}')),
        (8, 'HALT', 'return executed;'),
        (9, 'NOP', N.strip()),
        (10, 'MOV', W(a, R(b)) + N),
        (11, 'LOADI', W(a, '(ins.b as uint64) | ((ins.c as uint64) << 16)') + N),
        (12, 'LOADK', W(a, 'consts[ins.b]') + N),
        (13, 'DIV', binop('/')),
        (14, 'MOD', binop('%')),
        (15, 'OR', binop('|')),
        (16, 'SHL', W(a, f'{R(b)} << ({R(c)} & 63)') + N),
        (17, 'SHR', W(a, f'{R(b)} >> ({R(c)} & 63)') + N),
        (18, 'NEG', W(a, f'(0 as uint64) -% {R(b)}') + N),
        (19, 'NOT', W(a, f'~{R(b)}') + N),
        (20, 'SUBI', immop('-%')),
        (21, 'MULI', immop('*%')),
        (22, 'ORI', immop('|')),
        (23, 'XORI', immop('^')),
        (24, 'SHLI', W(a, f'{R(b)} << (ins.c & 63)') + N),
        (25, 'SHRI', W(a, f'{R(b)} >> (ins.c & 63)') + N),
        (26, 'EQ', cmp('==')),
        (27, 'NE', cmp('!=')),
        (28, 'LT', cmp('<')),
        (29, 'LE', cmp('<=')),
        (30, 'GT', cmp('>')),
        (31, 'GE', cmp('>=')),
        (32, 'JMP', 'pc = ins.c as int;'),
        (33, 'JZ', jcond(f'{R(a)} == 0')),
        (34, 'JNZ', jcond(f'{R(a)} != 0')),
        (35, 'JEQ', jcond(f'{R(a)} == {R(b)}')),
        (36, 'JNE', jcond(f'{R(a)} != {R(b)}')),
        (37, 'JLE', jcond(f'{R(a)} <= {R(b)}')),
        (38, 'JGE', jcond(f'{R(a)} >= {R(b)}')),
        (39, 'INC', W(a, f'{R(a)} +% 1') + N),
        (40, 'DEC', W(a, f'{R(a)} -% 1') + N),
        (41, 'MIN', f'if ({R(b)} < {R(c)}) {{ {W(a, R(b))} }} else {{ {W(a, R(c))} }}' + N),
        (42, 'MAX', f'if ({R(b)} > {R(c)}) {{ {W(a, R(b))} }} else {{ {W(a, R(c))} }}' + N),
        (43, 'LOADM', W(a, f'mem[({R(b)} +% {imm}) as int]') + N),
        (44, 'STOREM', f'mem[({R(b)} +% {imm}) as int] = {R(a)};' + N),
        (45, 'CALL', 'frames[fp] = pc + 1; fp += 1; pc = ins.c as int;'),
        (46, 'RET', 'fp -= 1; pc = frames[fp];'),
        (47, 'CMOV', f'if ({R(c)} != 0) {{ {W(a, R(b))} }}' + N),
    ]

def reg_ops_c():
    R = lambda x: f'regs[{x}]'
    W = lambda x, e: f'regs[{x}] = {e};'
    a, b, c = 'ins.a', 'ins.b', 'ins.c'
    N = ' pc++;'
    imm = '(uint64_t)ins.c'
    def binop(op): return W(a, f'{R(b)} {op} {R(c)}') + N
    def immop(op): return W(a, f'{R(b)} {op} {imm}') + N
    def cmp(op): return W(a, f'{R(b)} {op} {R(c)} ? 1 : 0') + N
    def jcond(cond): return f'pc = ({cond}) ? (int64_t)ins.c : pc + 1;'
    return [
        (0, 'ADD', binop('+')), (1, 'SUB', binop('-')), (2, 'MUL', binop('*')),
        (3, 'XOR', binop('^')), (4, 'AND', binop('&')), (5, 'ANDI', immop('&')),
        (6, 'ADDI', immop('+')), (7, 'JLT', jcond(f'{R(a)} < {R(b)}')),
        (8, 'HALT', 'return executed;'), (9, 'NOP', N.strip()), (10, 'MOV', W(a, R(b)) + N),
        (11, 'LOADI', W(a, '(uint64_t)ins.b | ((uint64_t)ins.c << 16)') + N),
        (12, 'LOADK', W(a, 'consts[ins.b]') + N),
        (13, 'DIV', binop('/')), (14, 'MOD', binop('%')), (15, 'OR', binop('|')),
        (16, 'SHL', W(a, f'{R(b)} << ({R(c)} & 63)') + N),
        (17, 'SHR', W(a, f'{R(b)} >> ({R(c)} & 63)') + N),
        (18, 'NEG', W(a, f'0 - {R(b)}') + N), (19, 'NOT', W(a, f'~{R(b)}') + N),
        (20, 'SUBI', immop('-')), (21, 'MULI', immop('*')), (22, 'ORI', immop('|')),
        (23, 'XORI', immop('^')),
        (24, 'SHLI', W(a, f'{R(b)} << (ins.c & 63)') + N),
        (25, 'SHRI', W(a, f'{R(b)} >> (ins.c & 63)') + N),
        (26, 'EQ', cmp('==')), (27, 'NE', cmp('!=')), (28, 'LT', cmp('<')),
        (29, 'LE', cmp('<=')), (30, 'GT', cmp('>')), (31, 'GE', cmp('>=')),
        (32, 'JMP', 'pc = ins.c;'),
        (33, 'JZ', jcond(f'{R(a)} == 0')), (34, 'JNZ', jcond(f'{R(a)} != 0')),
        (35, 'JEQ', jcond(f'{R(a)} == {R(b)}')), (36, 'JNE', jcond(f'{R(a)} != {R(b)}')),
        (37, 'JLE', jcond(f'{R(a)} <= {R(b)}')), (38, 'JGE', jcond(f'{R(a)} >= {R(b)}')),
        (39, 'INC', W(a, f'{R(a)} + 1') + N), (40, 'DEC', W(a, f'{R(a)} - 1') + N),
        (41, 'MIN', W(a, f'{R(b)} < {R(c)} ? {R(b)} : {R(c)}') + N),
        (42, 'MAX', W(a, f'{R(b)} > {R(c)} ? {R(b)} : {R(c)}') + N),
        (43, 'LOADM', W(a, f'mem[{R(b)} + {imm}]') + N),
        (44, 'STOREM', f'mem[{R(b)} + {imm}] = {R(a)};' + N),
        (45, 'CALL', 'frames[fp] = pc + 1; fp++; pc = ins.c;'),
        (46, 'RET', 'fp--; pc = frames[fp];'),
        (47, 'CMOV', f'if ({R(c)} != 0) {W(a, R(b))}' + N),
    ]

# The register program: (op, a, b, c, comment). Executes 5 + 8n + 1 = 8n + 6 instructions.
REG_PROGRAM = [
    (11, 0, 0, 0, 'LOADI r0 = 0            (i)'),
    (12, 1, 0, 0, 'LOADK r1 = K0           (n)'),
    (11, 2, 0, 0, 'LOADI r2 = 0            (acc)'),
    (12, 3, 1, 0, 'LOADK r3 = K1           (k)'),
    (12, 6, 2, 0, 'LOADK r6 = K2           (mask)'),
    (2, 4, 0, 0, 'MUL   r4 = r0 *% r0     -- loop @5'),
    (3, 4, 4, 3, 'XOR   r4 = r4 ^ r3'),
    (0, 2, 2, 4, 'ADD   r2 = r2 +% r4'),
    (5, 5, 0, 65535, 'ANDI  r5 = r0 & 0xFFFF'),
    (1, 2, 2, 5, 'SUB   r2 = r2 -% r5'),
    (4, 2, 2, 6, 'AND   r2 = r2 & r6'),
    (6, 0, 0, 1, 'ADDI  r0 = r0 +% 1'),
    (7, 0, 1, 5, 'JLT   r0 < r1 -> 5'),
    (8, 0, 0, 0, 'HALT                    (acc in r2)'),
]

# ------------------------------------------------------------------------------- stack VM

def stack_ops():
    N = ' pc += 1;'
    imm = '(ins.c as uint64)'
    def binop(op): return f'sp -= 1; stack[sp - 1] = stack[sp - 1] {op} stack[sp];' + N
    def immop(op): return f'stack[sp - 1] = stack[sp - 1] {op} {imm};' + N
    def cmp(op): return f'sp -= 1; if (stack[sp - 1] {op} stack[sp]) {{ stack[sp - 1] = 1; }} else {{ stack[sp - 1] = 0; }}' + N
    def jcond1(cond): return f'sp -= 1; if ({cond}) {{ pc = ins.c as int; }} else {{ pc += 1; }}'
    def jcond2(op): return f'sp -= 2; if (stack[sp] {op} stack[sp + 1]) {{ pc = ins.c as int; }} else {{ pc += 1; }}'
    return [
        (0, 'LOAD', 'stack[sp] = locals[ins.a]; sp += 1;' + N),
        (1, 'STORE', 'sp -= 1; locals[ins.a] = stack[sp];' + N),
        (2, 'ADD', binop('+%')), (3, 'SUB', binop('-%')), (4, 'MUL', binop('*%')),
        (5, 'XOR', binop('^')), (6, 'AND', binop('&')), (7, 'ANDI', immop('&')),
        (8, 'ADDI', immop('+%')), (9, 'JLT', jcond2('<')),
        (10, 'HALT', 'return executed;'),
        (11, 'PUSHI', 'stack[sp] = (ins.b as uint64) | ((ins.c as uint64) << 16); sp += 1;' + N),
        (12, 'PUSHK', 'stack[sp] = consts[ins.b]; sp += 1;' + N),
        (13, 'NOP', N.strip()),
        (14, 'DUP', 'stack[sp] = stack[sp - 1]; sp += 1;' + N),
        (15, 'POP', 'sp -= 1;' + N),
        (16, 'SWAP', 'let t = stack[sp - 1]; stack[sp - 1] = stack[sp - 2]; stack[sp - 2] = t;' + N),
        (17, 'DIV', binop('/')), (18, 'MOD', binop('%')), (19, 'OR', binop('|')),
        (20, 'SHL', 'sp -= 1; stack[sp - 1] = stack[sp - 1] << (stack[sp] & 63);' + N),
        (21, 'SHR', 'sp -= 1; stack[sp - 1] = stack[sp - 1] >> (stack[sp] & 63);' + N),
        (22, 'NEG', 'stack[sp - 1] = (0 as uint64) -% stack[sp - 1];' + N),
        (23, 'NOT', 'stack[sp - 1] = ~stack[sp - 1];' + N),
        (24, 'SUBI', immop('-%')), (25, 'MULI', immop('*%')), (26, 'ORI', immop('|')),
        (27, 'XORI', immop('^')),
        (28, 'SHLI', 'stack[sp - 1] = stack[sp - 1] << (ins.c & 63);' + N),
        (29, 'SHRI', 'stack[sp - 1] = stack[sp - 1] >> (ins.c & 63);' + N),
        (30, 'EQ', cmp('==')), (31, 'NE', cmp('!=')), (32, 'LT', cmp('<')),
        (33, 'LE', cmp('<=')), (34, 'GT', cmp('>')), (35, 'GE', cmp('>=')),
        (36, 'JMP', 'pc = ins.c as int;'),
        (37, 'JZ', jcond1('stack[sp] == 0')), (38, 'JNZ', jcond1('stack[sp] != 0')),
        (39, 'JEQ', jcond2('==')),
        (40, 'INC', 'locals[ins.a] = locals[ins.a] +% 1;' + N),
        (41, 'DEC', 'locals[ins.a] = locals[ins.a] -% 1;' + N),
        (42, 'MIN', 'sp -= 1; if (stack[sp] < stack[sp - 1]) { stack[sp - 1] = stack[sp]; }' + N),
        (43, 'MAX', 'sp -= 1; if (stack[sp] > stack[sp - 1]) { stack[sp - 1] = stack[sp]; }' + N),
        (44, 'LOADM', f'stack[sp - 1] = mem[(stack[sp - 1] +% {imm}) as int];' + N),
        (45, 'STOREM', f'sp -= 2; mem[(stack[sp] +% {imm}) as int] = stack[sp + 1];' + N),
        (46, 'CALL', 'frames[fp] = pc + 1; fp += 1; pc = ins.c as int;'),
        (47, 'RET', 'fp -= 1; pc = frames[fp];'),
    ]

def stack_ops_c():
    N = ' pc++;'
    imm = '(uint64_t)ins.c'
    def binop(op): return f'sp--; stack[sp - 1] = stack[sp - 1] {op} stack[sp];' + N
    def immop(op): return f'stack[sp - 1] = stack[sp - 1] {op} {imm};' + N
    def cmp(op): return f'sp--; stack[sp - 1] = stack[sp - 1] {op} stack[sp] ? 1 : 0;' + N
    def jcond1(cond): return f'sp--; pc = ({cond}) ? (int64_t)ins.c : pc + 1;'
    def jcond2(op): return f'sp -= 2; pc = (stack[sp] {op} stack[sp + 1]) ? (int64_t)ins.c : pc + 1;'
    return [
        (0, 'LOAD', 'stack[sp] = locals[ins.a]; sp++;' + N),
        (1, 'STORE', 'sp--; locals[ins.a] = stack[sp];' + N),
        (2, 'ADD', binop('+')), (3, 'SUB', binop('-')), (4, 'MUL', binop('*')),
        (5, 'XOR', binop('^')), (6, 'AND', binop('&')), (7, 'ANDI', immop('&')),
        (8, 'ADDI', immop('+')), (9, 'JLT', jcond2('<')),
        (10, 'HALT', 'return executed;'),
        (11, 'PUSHI', 'stack[sp] = (uint64_t)ins.b | ((uint64_t)ins.c << 16); sp++;' + N),
        (12, 'PUSHK', 'stack[sp] = consts[ins.b]; sp++;' + N),
        (13, 'NOP', N.strip()),
        (14, 'DUP', 'stack[sp] = stack[sp - 1]; sp++;' + N),
        (15, 'POP', 'sp--;' + N),
        (16, 'SWAP', '{ uint64_t t = stack[sp - 1]; stack[sp - 1] = stack[sp - 2]; stack[sp - 2] = t; }' + N),
        (17, 'DIV', binop('/')), (18, 'MOD', binop('%')), (19, 'OR', binop('|')),
        (20, 'SHL', 'sp--; stack[sp - 1] = stack[sp - 1] << (stack[sp] & 63);' + N),
        (21, 'SHR', 'sp--; stack[sp - 1] = stack[sp - 1] >> (stack[sp] & 63);' + N),
        (22, 'NEG', 'stack[sp - 1] = 0 - stack[sp - 1];' + N),
        (23, 'NOT', 'stack[sp - 1] = ~stack[sp - 1];' + N),
        (24, 'SUBI', immop('-')), (25, 'MULI', immop('*')), (26, 'ORI', immop('|')),
        (27, 'XORI', immop('^')),
        (28, 'SHLI', 'stack[sp - 1] = stack[sp - 1] << (ins.c & 63);' + N),
        (29, 'SHRI', 'stack[sp - 1] = stack[sp - 1] >> (ins.c & 63);' + N),
        (30, 'EQ', cmp('==')), (31, 'NE', cmp('!=')), (32, 'LT', cmp('<')),
        (33, 'LE', cmp('<=')), (34, 'GT', cmp('>')), (35, 'GE', cmp('>=')),
        (36, 'JMP', 'pc = ins.c;'),
        (37, 'JZ', jcond1('stack[sp] == 0')), (38, 'JNZ', jcond1('stack[sp] != 0')),
        (39, 'JEQ', jcond2('==')),
        (40, 'INC', 'locals[ins.a]++;' + N), (41, 'DEC', 'locals[ins.a]--;' + N),
        (42, 'MIN', 'sp--; if (stack[sp] < stack[sp - 1]) stack[sp - 1] = stack[sp];' + N),
        (43, 'MAX', 'sp--; if (stack[sp] > stack[sp - 1]) stack[sp - 1] = stack[sp];' + N),
        (44, 'LOADM', f'stack[sp - 1] = mem[stack[sp - 1] + {imm}];' + N),
        (45, 'STOREM', f'sp -= 2; mem[stack[sp] + {imm}] = stack[sp + 1];' + N),
        (46, 'CALL', 'frames[fp] = pc + 1; fp++; pc = ins.c;'),
        (47, 'RET', 'fp--; pc = frames[fp];'),
    ]

# The stack program. Executes 10 + 21n + 1 = 21n + 11 instructions.
STACK_PROGRAM = [
    (11, 0, 0, 0, 'PUSHI 0'), (1, 0, 0, 0, 'STORE l0       (i)'),
    (12, 0, 0, 0, 'PUSHK K0'), (1, 1, 0, 0, 'STORE l1       (n)'),
    (11, 0, 0, 0, 'PUSHI 0'), (1, 2, 0, 0, 'STORE l2       (acc)'),
    (12, 0, 1, 0, 'PUSHK K1'), (1, 3, 0, 0, 'STORE l3       (k)'),
    (12, 0, 2, 0, 'PUSHK K2'), (1, 4, 0, 0, 'STORE l4       (mask)'),
    (0, 0, 0, 0, 'LOAD l0        -- loop @10'), (0, 0, 0, 0, 'LOAD l0'), (4, 0, 0, 0, 'MUL'),
    (0, 3, 0, 0, 'LOAD l3'), (5, 0, 0, 0, 'XOR'), (0, 2, 0, 0, 'LOAD l2'), (2, 0, 0, 0, 'ADD'),
    (1, 2, 0, 0, 'STORE l2       acc = acc + ((i*i)^k)'),
    (0, 2, 0, 0, 'LOAD l2'), (0, 0, 0, 0, 'LOAD l0'), (7, 0, 0, 65535, 'ANDI 0xFFFF'),
    (3, 0, 0, 0, 'SUB'), (0, 4, 0, 0, 'LOAD l4'), (6, 0, 0, 0, 'AND'),
    (1, 2, 0, 0, 'STORE l2       acc = (acc - (i & 0xFFFF)) & mask'),
    (0, 0, 0, 0, 'LOAD l0'), (8, 0, 0, 1, 'ADDI 1'), (1, 0, 0, 0, 'STORE l0       i = i + 1'),
    (0, 0, 0, 0, 'LOAD l0'), (0, 1, 0, 0, 'LOAD l1'), (9, 0, 0, 10, 'JLT -> 10'),
    (10, 0, 0, 0, 'HALT           (acc in l2)'),
]

# ------------------------------------------------------------------------------- emitters

LYRIC_HEAD = '''// GENERATED by gen.py — {title}
// Dispatch probe (lyric-script design round, A2a/A2d/V1). See README.md.
import std.io {{ println }};
import std.os {{ args }};{extra_import}

@Layout(C)
struct Instr {{ op: uint8, a: uint16, b: uint16, c: uint16 }}

fn mk(op: int, a: int, b: int, c: int): Instr {{
    return Instr {{ op = op as uint8, a = a as uint16, b = b as uint16, c = c as uint16 }};
}}
'''

LYRIC_MAIN = '''
fn main(): int {{
    let argv = args();
    var n = 100000000;
    if (argv.length() > 1) {{
        n = (try? int.parse(argv[1])) ?? n;
    }}
    let code: Instr[] = [
{program}
    ];
    let {store}: uint64[] = [0u64] * 16;
    let consts: uint64[] = [n as uint64, 0x9E3779B9, 0x3FFFFFFFFFFFFFFF];
    let mem: uint64[] = [0u64] * 1024;
    let frames: int[] = [0] * 256;{extra_alloc}
    let executed = run(code, {args});
    println(f"acc={{{store}[2]}} executed={{executed}}");
    return 0;
}}
'''

def lyric_program(prog):
    return '\n'.join(f'        mk({op}, {a}, {b}, {c}),  // {i:2} {cm}' for i, (op, a, b, c, cm) in enumerate(prog))

def lyric_arms(ops, order, indent):
    by = {n: (name, body) for n, name, body in ops}
    lines = []
    for n in order:
        name, body = by[n]
        lines.append(f'{indent}{n} => {{ {body} }}  // {name}')
    lines.append(f'{indent}_ => {{ panic("bad opcode"); }}')
    return '\n'.join(lines)

def gen_reg_lyric(title, order, ptr):
    if ptr:
        R = lambda x: f'rp.offset({x}).read()'
        W = lambda x, e: f'rp.offset({x}).write({e});'
    else:
        R = lambda x: f'regs[{x}]'
        W = lambda x, e: f'regs[{x}] = {e};'
    ops = reg_ops(R, W)
    head = LYRIC_HEAD.format(title=title, extra_import='\nimport std.ffi;' if ptr else '')
    if ptr:
        run = f'''
fn run(code: Instr[], regs: uint64[], consts: uint64[], mem: uint64[], frames: int[]): int {{
    var pc = 0;
    var fp = 0;
    var executed = 0;
    let cp = code.asPtr();
    let rp = regs.asPtr();
    unsafe {{
        while (true) {{
            let ins = cp.offset(pc).read();
            executed += 1;
            match (ins.op) {{
{lyric_arms(ops, order, ' ' * 16)}
            }}
        }}
    }}
}}
'''
    else:
        run = f'''
fn run(code: Instr[], regs: uint64[], consts: uint64[], mem: uint64[], frames: int[]): int {{
    var pc = 0;
    var fp = 0;
    var executed = 0;
    while (true) {{
        let ins = code[pc];
        executed += 1;
        match (ins.op) {{
{lyric_arms(ops, order, ' ' * 12)}
        }}
    }}
}}
'''
    main = LYRIC_MAIN.format(program=lyric_program(REG_PROGRAM), store='regs', extra_alloc='',
                             args='regs, consts, mem, frames')
    return head + run + main

def gen_stack_lyric(title):
    ops = stack_ops()
    head = LYRIC_HEAD.format(title=title, extra_import='')
    run = f'''
fn run(code: Instr[], locals: uint64[], consts: uint64[], mem: uint64[], frames: int[], stack: uint64[]): int {{
    var pc = 0;
    var fp = 0;
    var sp = 0;
    var executed = 0;
    while (true) {{
        let ins = code[pc];
        executed += 1;
        match (ins.op) {{
{lyric_arms(ops, range(48), ' ' * 12)}
        }}
    }}
}}
'''
    main = LYRIC_MAIN.format(program=lyric_program(STACK_PROGRAM), store='locals',
                             extra_alloc='\n    let stack: uint64[] = [0u64] * 256;',
                             args='locals, consts, mem, frames, stack')
    return head + run + main

C_HEAD = '''// GENERATED by gen.py — {title}
// Dispatch probe (lyric-script design round). Reference in C; see README.md.
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

typedef struct {{ uint8_t op; uint16_t a, b, c; }} Instr;
'''

C_MAIN = '''
int main(int argc, char **argv) {{
    int64_t n = argc > 1 ? strtoll(argv[1], NULL, 10) : 100000000;
    static const Instr program[] = {{
{program}
    }};
    Instr *code = malloc(sizeof program);
    for (size_t i = 0; i < sizeof program / sizeof program[0]; i++) code[i] = program[i];
    uint64_t *{store} = calloc(16, sizeof(uint64_t));
    uint64_t consts[3] = {{ (uint64_t)n, 0x9E3779B9u, 0x3FFFFFFFFFFFFFFFu }};
    uint64_t *mem = calloc(1024, sizeof(uint64_t));
    int64_t *frames = calloc(256, sizeof(int64_t));{extra_alloc}
    int64_t executed = run(code, {args});
    printf("acc=%" PRIu64 " executed=%" PRId64 "\\n", {store}[2], executed);
    return 0;
}}
'''

def c_program(prog):
    return '\n'.join(f'        {{{op}, {a}, {b}, {c}}},  // {i:2} {cm}' for i, (op, a, b, c, cm) in enumerate(prog))

def c_switch(ops, sig, locals_decl):
    arms = '\n'.join(f'        case {n}: {body}{"" if body.startswith("return") else " break;"}  // {name}'
                     for n, name, body in ops)
    return f'''
__attribute__((noinline))
static int64_t run({sig}) {{
    int64_t pc = 0, fp = 0, executed = 0;{locals_decl}
    for (;;) {{
        Instr ins = code[pc];
        executed++;
        switch (ins.op) {{
{arms}
        default: abort();
        }}
    }}
}}
'''

def c_goto(ops, sig):
    labels = ', '.join(f'&&L{n}' for n, _, _ in ops)
    arms = '\n'.join(f'    L{n}: {body}{"" if body.startswith("return") else " DISPATCH();"}  // {name}'
                     for n, name, body in ops)
    return f'''
#define DISPATCH() do {{ ins = code[pc]; executed++; goto *labels[ins.op]; }} while (0)

__attribute__((noinline))
static int64_t run({sig}) {{
    static void *const labels[48] = {{ {labels} }};
    int64_t pc = 0, fp = 0, executed = 0;
    Instr ins;
    DISPATCH();
{arms}
}}
'''

REG_SIG = 'const Instr *code, uint64_t *regs, const uint64_t *consts, uint64_t *mem, int64_t *frames'
STACK_SIG = 'const Instr *code, uint64_t *locals, const uint64_t *consts, uint64_t *mem, int64_t *frames, uint64_t *stack'

def gen_c_reg_switch():
    return (C_HEAD.format(title='P5: register VM in C, switch') + c_switch(reg_ops_c(), REG_SIG, '')
            + C_MAIN.format(program=c_program(REG_PROGRAM), store='regs', extra_alloc='',
                            args='regs, consts, mem, frames'))

def gen_c_reg_goto():
    return (C_HEAD.format(title='P5b: register VM in C, computed goto') + c_goto(reg_ops_c(), REG_SIG)
            + C_MAIN.format(program=c_program(REG_PROGRAM), store='regs', extra_alloc='',
                            args='regs, consts, mem, frames'))

def gen_c_stack_switch():
    return (C_HEAD.format(title='P4c: stack VM in C, switch') + c_switch(stack_ops_c(), STACK_SIG, ' int64_t sp = 0;')
            + C_MAIN.format(program=c_program(STACK_PROGRAM), store='locals',
                            extra_alloc='\n    uint64_t *stack = calloc(256, sizeof(uint64_t));',
                            args='locals, consts, mem, frames, stack'))

C_NATIVE = '''// GENERATED by gen.py — P0: the same computation as a plain C loop (oracle, no VM).
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

int main(int argc, char **argv) {
    int64_t n = argc > 1 ? strtoll(argv[1], NULL, 10) : 100000000;
    uint64_t k = 0x9E3779B9u, mask = 0x3FFFFFFFFFFFFFFFu, acc = 0, i = 0;
    do {
        acc = acc + ((i * i) ^ k);
        acc = (acc - (i & 0xFFFF)) & mask;
        i = i + 1;
    } while (i < (uint64_t)n);
    printf("acc=%" PRIu64 " executed=%" PRId64 "\\n", acc, 8 * n + 6);
    return 0;
}
'''

def main():
    out = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else '.')
    out.mkdir(parents=True, exist_ok=True)
    hot_first = list(range(48))
    hot_last = list(range(8, 48)) + list(range(8))
    files = {
        'p1_reg.lyr': gen_reg_lyric('P1: register VM, hot opcodes FIRST in the match', hot_first, False),
        'p2_reg_hotlast.lyr': gen_reg_lyric('P2: register VM, hot opcodes LAST in the match', hot_last, False),
        'p3_reg_ptr.lyr': gen_reg_lyric('P3: register VM, code and registers through Ptr in unsafe', hot_first, True),
        'p4_stack.lyr': gen_stack_lyric('P4: stack VM, hot opcodes first'),
        'p5_switch.c': gen_c_reg_switch(),
        'p5b_goto.c': gen_c_reg_goto(),
        'p4c_stack.c': gen_c_stack_switch(),
        'p0_native.c': C_NATIVE,
    }
    for name, text in files.items():
        (out / name).write_text(text, newline='\n')
        print('wrote', out / name)

if __name__ == '__main__':
    main()
