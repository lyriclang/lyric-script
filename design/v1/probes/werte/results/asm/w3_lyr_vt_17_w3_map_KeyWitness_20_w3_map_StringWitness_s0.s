0000000001016330 <lyr_vt_17_w3_map_KeyWitness_20_w3_map_StringWitness_s0>:
 1016330:	push   rbp
 1016331:	mov    rbp,rsp
 1016334:	push   r15
 1016336:	push   r14
 1016338:	push   rbx
 1016339:	push   rax
 101633a:	mov    rbx,0xffffffffffffffe0
 1016341:	mov    rax,QWORD PTR fs:[rbx+0x10]
 1016346:	cmp    rax,rbp
 1016349:	ja     10163af <lyr_vt_17_w3_map_KeyWitness_20_w3_map_StringWitness_s0+0x7f>
 101634b:	mov    rax,QWORD PTR [rcx]
 101634e:	cmp    rax,0x103e368
 1016355:	jne    10163d5 <lyr_vt_17_w3_map_KeyWitness_20_w3_map_StringWitness_s0+0xa5>
 1016357:	mov    rdi,QWORD PTR [rdx+0x8]
 101635b:	mov    rax,QWORD PTR fs:[rbx+0x10]
 1016360:	cmp    rax,rbp
 1016363:	ja     10163c5 <lyr_vt_17_w3_map_KeyWitness_20_w3_map_StringWitness_s0+0x95>
 1016365:	mov    QWORD PTR [rbp-0x20],0x0
 101636d:	mov    rsi,QWORD PTR [rdi+0x8]
 1016371:	add    rdi,0x10
 1016375:	lea    rdx,[rbp-0x20]
 1016379:	call   101edf0 <lyr_std_core_hashText_w3_map_Fx__be0ed00d>
 101637e:	mov    rax,QWORD PTR [rbp-0x20]
 1016382:	mov    rcx,rax
 1016385:	shr    rcx,0x1d
 1016389:	xor    rcx,rax
 101638c:	movabs rdx,0xbf58476d1ce4e5b9
 1016396:	imul   rdx,rcx
 101639a:	mov    rax,rdx
 101639d:	shr    rax,0x20
 10163a1:	xor    rax,rdx
 10163a4:	add    rsp,0x8
 10163a8:	pop    rbx
 10163a9:	pop    r14
 10163ab:	pop    r15
 10163ad:	pop    rbp
 10163ae:	ret
 10163af:	mov    rdi,rbp
 10163b2:	mov    r14,rdx
 10163b5:	mov    r15,rcx
 10163b8:	call   1020d50 <lyr_gc_stack_slow>
 10163bd:	mov    rcx,r15
 10163c0:	mov    rdx,r14
 10163c3:	jmp    101634b <lyr_vt_17_w3_map_KeyWitness_20_w3_map_StringWitness_s0+0x1b>
 10163c5:	mov    rbx,rdi
 10163c8:	mov    rdi,rbp
 10163cb:	call   1020d50 <lyr_gc_stack_slow>
 10163d0:	mov    rdi,rbx
 10163d3:	jmp    1016365 <lyr_vt_17_w3_map_KeyWitness_20_w3_map_StringWitness_s0+0x35>
 10163d5:	lea    rdi,[rip+0x28564]        # 103e940 <lyr_lit18>
 10163dc:	call   1026b1b <lyr_panic_message>
 10163e1:	ud2

