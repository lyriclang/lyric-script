0000000001017040 <lyr_w1_coerce_loopMove>:
 1017040:	push   rbp
 1017041:	mov    rbp,rsp
 1017044:	push   r15
 1017046:	push   r14
 1017048:	push   r13
 101704a:	push   r12
 101704c:	push   rbx
 101704d:	sub    rsp,0x28
 1017051:	lea    rax,[rsi+0x10]
 1017055:	mov    QWORD PTR [rbp-0x50],rax
 1017059:	lea    r14,[rdi+0x10]
 101705d:	mov    rax,rdx
 1017060:	sar    rax,0x3f
 1017064:	andn   r15,rax,rdx
 1017069:	lea    rax,[rdi+0x1f]
 101706d:	mov    QWORD PTR [rbp-0x38],rax
 1017071:	mov    r12d,0x400
 1017077:	xor    r13d,r13d
 101707a:	lea    r11,[rip+0x2b4ff]        # 1042580 <lyr_gc_heap_base>
 1017081:	lea    r10,[rip+0x2b500]        # 1042588 <lyr_gc_heap_span>
 1017088:	lea    rbx,[rip+0x2b4d9]        # 1042568 <lyr_gc_cards>
 101708f:	mov    QWORD PTR [rbp-0x30],r15
 1017093:	jmp    10170a3 <lyr_w1_coerce_loopMove+0x63>
 1017095:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 10170a0:	inc    r13
 10170a3:	dec    r12d
 10170a6:	je     10171bd <lyr_w1_coerce_loopMove+0x17d>
 10170ac:	cmp    r13,r15
 10170af:	je     10171ff <lyr_w1_coerce_loopMove+0x1bf>
 10170b5:	mov    eax,r13d
 10170b8:	and    eax,0x7
 10170bb:	mov    rcx,QWORD PTR [rsi+0x8]
 10170bf:	cmp    rax,rcx
 10170c2:	jae    101720e <lyr_w1_coerce_loopMove+0x1ce>
 10170c8:	mov    ecx,r13d
 10170cb:	and    ecx,0xf
 10170ce:	mov    rdx,QWORD PTR [rdi+0x8]
 10170d2:	cmp    rcx,rdx
 10170d5:	jae    1017219 <lyr_w1_coerce_loopMove+0x1d9>
 10170db:	shl    eax,0x4
 10170de:	shl    ecx,0x4
 10170e1:	lea    r9,[r14+rcx*1]
 10170e5:	mov    rdx,QWORD PTR [rbp-0x50]
 10170e9:	vmovaps xmm0,XMMWORD PTR [rdx+rax*1]
 10170ee:	vmovaps XMMWORD PTR [r14+rcx*1],xmm0
 10170f4:	mov    rdx,QWORD PTR [r11]
 10170f7:	sub    r9,rdx
 10170fa:	cmp    r9,QWORD PTR [r10]
 10170fd:	jae    10170a0 <lyr_w1_coerce_loopMove+0x60>
 10170ff:	mov    rax,r9
 1017102:	shr    rax,0x8
 1017106:	add    r9,0xf
 101710a:	shr    r9,0x8
 101710e:	mov    r8,r9
 1017111:	sub    r8,rax
 1017114:	jb     10170a0 <lyr_w1_coerce_loopMove+0x60>
 1017116:	mov    r15,r10
 1017119:	mov    ecx,r13d
 101711c:	and    ecx,0xf
 101711f:	shl    ecx,0x4
 1017122:	sub    r9d,eax
 1017125:	inc    r9d
 1017128:	test   r9b,0x3
 101712c:	je     1017170 <lyr_w1_coerce_loopMove+0x130>
 101712e:	mov    r9,QWORD PTR [rbp-0x38]
 1017132:	add    r9d,ecx
 1017135:	sub    r9d,edx
 1017138:	shr    r9d,0x8
 101713c:	lea    r10d,[r14+rcx*1]
 1017140:	sub    r10d,edx
 1017143:	shr    r10d,0x8
 1017147:	sub    r9b,r10b
 101714a:	inc    r9b
 101714d:	movzx  r9d,r9b
 1017151:	and    r9d,0x3
 1017155:	neg    r9
 1017158:	nop    DWORD PTR [rax+rax*1+0x0]
 1017160:	mov    r10,QWORD PTR [rbx]
 1017163:	mov    BYTE PTR [r10+rax*1],0x1
 1017168:	inc    rax
 101716b:	inc    r9
 101716e:	jne    1017160 <lyr_w1_coerce_loopMove+0x120>
 1017170:	cmp    r8,0x3
 1017174:	mov    r10,r15
 1017177:	mov    r15,QWORD PTR [rbp-0x30]
 101717b:	jb     10170a0 <lyr_w1_coerce_loopMove+0x60>
 1017181:	add    rcx,QWORD PTR [rbp-0x38]
 1017185:	sub    rcx,rdx
 1017188:	shr    rcx,0x8
 101718c:	inc    rcx
 101718f:	nop
 1017190:	mov    rdx,QWORD PTR [rbx]
 1017193:	mov    BYTE PTR [rdx+rax*1],0x1
 1017197:	mov    rdx,QWORD PTR [rbx]
 101719a:	mov    BYTE PTR [rdx+rax*1+0x1],0x1
 101719f:	mov    rdx,QWORD PTR [rbx]
 10171a2:	mov    BYTE PTR [rdx+rax*1+0x2],0x1
 10171a7:	mov    rdx,QWORD PTR [rbx]
 10171aa:	mov    BYTE PTR [rdx+rax*1+0x3],0x1
 10171af:	add    rax,0x4
 10171b3:	cmp    rcx,rax
 10171b6:	jne    1017190 <lyr_w1_coerce_loopMove+0x150>
 10171b8:	jmp    10170a0 <lyr_w1_coerce_loopMove+0x60>
 10171bd:	lea    rax,[rip+0x2b384]        # 1042548 <lyr_gc_stop_requested>
 10171c4:	mov    eax,DWORD PTR [rax]
 10171c6:	mov    r12d,0x400
 10171cc:	test   eax,eax
 10171ce:	je     10170ac <lyr_w1_coerce_loopMove+0x6c>
 10171d4:	mov    QWORD PTR [rbp-0x48],rsi
 10171d8:	mov    QWORD PTR [rbp-0x40],rdi
 10171dc:	mov    r15,r10
 10171df:	call   101e9e0 <lyr_gc_safepoint_slow>
 10171e4:	mov    r10,r15
 10171e7:	mov    r15,QWORD PTR [rbp-0x30]
 10171eb:	lea    r11,[rip+0x2b38e]        # 1042580 <lyr_gc_heap_base>
 10171f2:	mov    rdi,QWORD PTR [rbp-0x40]
 10171f6:	mov    rsi,QWORD PTR [rbp-0x48]
 10171fa:	jmp    10170ac <lyr_w1_coerce_loopMove+0x6c>
 10171ff:	add    rsp,0x28
 1017203:	pop    rbx
 1017204:	pop    r12
 1017206:	pop    r13
 1017208:	pop    r14
 101720a:	pop    r15
 101720c:	pop    rbp
 101720d:	ret
 101720e:	mov    rdi,rax
 1017211:	mov    rsi,rcx
 1017214:	call   1024b88 <lyr_panic_index>
 1017219:	mov    rdi,rcx
 101721c:	mov    rsi,rdx
 101721f:	call   1024b88 <lyr_panic_index>

