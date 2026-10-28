0000000001017360 <lyr_w3_map_lookupIface>:
 1017360:	push   rbp
 1017361:	mov    rbp,rsp
 1017364:	push   r15
 1017366:	push   r14
 1017368:	push   r13
 101736a:	push   r12
 101736c:	push   rbx
 101736d:	push   rax
 101736e:	mov    rbx,rdx
 1017371:	mov    r15,rsi
 1017374:	mov    r14,rdi
 1017377:	mov    rax,0xffffffffffffffe0
 101737e:	mov    rax,QWORD PTR fs:[rax+0x10]
 1017383:	cmp    rax,rbp
 1017386:	ja     1017495 <lyr_w3_map_lookupIface+0x135>
 101738c:	mov    QWORD PTR [rbp-0x30],r15
 1017390:	mov    rdi,r15
 1017393:	mov    rsi,rbx
 1017396:	call   QWORD PTR [rbx+0x8]
 1017399:	mov    r13,rax
 101739c:	or     r13,0x1
 10173a0:	mov    r12,QWORD PTR [r14+0x20]
 10173a4:	and    r12,r13
 10173a7:	mov    r15d,0x400
 10173ad:	dec    r15d
 10173b0:	je     1017423 <lyr_w3_map_lookupIface+0xc3>
 10173b2:	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 10173c0:	mov    rax,QWORD PTR [r14+0x10]
 10173c4:	mov    rsi,QWORD PTR [rax+0x8]
 10173c8:	cmp    r12,rsi
 10173cb:	jae    1017481 <lyr_w3_map_lookupIface+0x121>
 10173d1:	mov    rax,QWORD PTR [rax+r12*8+0x10]
 10173d6:	test   rax,rax
 10173d9:	je     1017457 <lyr_w3_map_lookupIface+0xf7>
 10173db:	cmp    rax,r13
 10173de:	jne    1017410 <lyr_w3_map_lookupIface+0xb0>
 10173e0:	mov    rax,QWORD PTR [r14+0x8]
 10173e4:	mov    rsi,QWORD PTR [rax+0x8]
 10173e8:	cmp    r12,rsi
 10173eb:	jae    1017481 <lyr_w3_map_lookupIface+0x121>
 10173f1:	mov    rcx,r12
 10173f4:	shl    rcx,0x4
 10173f8:	mov    rdi,QWORD PTR [rax+rcx*1+0x10]
 10173fd:	mov    rsi,QWORD PTR [rax+rcx*1+0x18]
 1017402:	mov    rdx,QWORD PTR [rbp-0x30]
 1017406:	mov    rcx,rbx
 1017409:	call   QWORD PTR [rsi+0x10]
 101740c:	test   al,al
 101740e:	jne    1017460 <lyr_w3_map_lookupIface+0x100>
 1017410:	dec    r15d
 1017413:	je     101743d <lyr_w3_map_lookupIface+0xdd>
 1017415:	inc    r12
 1017418:	jo     1017489 <lyr_w3_map_lookupIface+0x129>
 101741a:	and    r12,QWORD PTR [r14+0x20]
 101741e:	dec    r15d
 1017421:	jne    10173c0 <lyr_w3_map_lookupIface+0x60>
 1017423:	lea    rax,[rip+0x2d13e]        # 1044568 <lyr_gc_stop_requested>
 101742a:	mov    eax,DWORD PTR [rax]
 101742c:	mov    r15d,0x400
 1017432:	test   eax,eax
 1017434:	je     10173c0 <lyr_w3_map_lookupIface+0x60>
 1017436:	call   1020ce0 <lyr_gc_safepoint_slow>
 101743b:	jmp    10173c0 <lyr_w3_map_lookupIface+0x60>
 101743d:	lea    rax,[rip+0x2d124]        # 1044568 <lyr_gc_stop_requested>
 1017444:	mov    eax,DWORD PTR [rax]
 1017446:	mov    r15d,0x400
 101744c:	test   eax,eax
 101744e:	je     1017415 <lyr_w3_map_lookupIface+0xb5>
 1017450:	call   1020ce0 <lyr_gc_safepoint_slow>
 1017455:	jmp    1017415 <lyr_w3_map_lookupIface+0xb5>
 1017457:	mov    rax,0xffffffffffffffff
 101745e:	jmp    1017472 <lyr_w3_map_lookupIface+0x112>
 1017460:	mov    rax,QWORD PTR [r14+0x18]
 1017464:	mov    rsi,QWORD PTR [rax+0x8]
 1017468:	cmp    r12,rsi
 101746b:	jae    1017481 <lyr_w3_map_lookupIface+0x121>
 101746d:	mov    rax,QWORD PTR [rax+r12*8+0x10]
 1017472:	add    rsp,0x8
 1017476:	pop    rbx
 1017477:	pop    r12
 1017479:	pop    r13
 101747b:	pop    r14
 101747d:	pop    r15
 101747f:	pop    rbp
 1017480:	ret
 1017481:	mov    rdi,r12
 1017484:	call   1026a88 <lyr_panic_index>
 1017489:	lea    rdi,[rip+0xfffffffffffeb5ce]        # 1002a5e <lyr_refmap_ty_w3_map_TableMono+0x119e>
 1017490:	call   1026ac9 <lyr_panic_overflow>
 1017495:	mov    rdi,rbp
 1017498:	call   1020d50 <lyr_gc_stack_slow>
 101749d:	jmp    101738c <lyr_w3_map_lookupIface+0x2c>

