00000000010177b0 <lyr_w3_map_lookupWit>:
 10177b0:	push   rbp
 10177b1:	mov    rbp,rsp
 10177b4:	push   r15
 10177b6:	push   r14
 10177b8:	push   r13
 10177ba:	push   r12
 10177bc:	push   rbx
 10177bd:	push   rax
 10177be:	mov    rcx,rdx
 10177c1:	mov    rdx,rsi
 10177c4:	mov    r14,rdi
 10177c7:	mov    rax,0xffffffffffffffe0
 10177ce:	mov    rax,QWORD PTR fs:[rax+0x10]
 10177d3:	cmp    rax,rbp
 10177d6:	ja     10178f0 <lyr_w3_map_lookupWit+0x140>
 10177dc:	mov    rdi,QWORD PTR [r14+0x28]
 10177e0:	mov    rsi,QWORD PTR [r14+0x30]
 10177e4:	mov    QWORD PTR [rbp-0x30],rdx
 10177e8:	mov    r15,rcx
 10177eb:	call   QWORD PTR [rsi+0x8]
 10177ee:	mov    r13,rax
 10177f1:	or     r13,0x1
 10177f5:	mov    r12,QWORD PTR [r14+0x20]
 10177f9:	and    r12,r13
 10177fc:	mov    ebx,0x400
 1017801:	dec    ebx
 1017803:	je     101787d <lyr_w3_map_lookupWit+0xcd>
 1017805:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 1017810:	mov    rax,QWORD PTR [r14+0x10]
 1017814:	mov    rsi,QWORD PTR [rax+0x8]
 1017818:	cmp    r12,rsi
 101781b:	jae    10178dc <lyr_w3_map_lookupWit+0x12c>
 1017821:	mov    rax,QWORD PTR [rax+r12*8+0x10]
 1017826:	test   rax,rax
 1017829:	je     10178b2 <lyr_w3_map_lookupWit+0x102>
 101782f:	cmp    rax,r13
 1017832:	jne    101786c <lyr_w3_map_lookupWit+0xbc>
 1017834:	mov    rax,QWORD PTR [r14+0x8]
 1017838:	mov    rsi,QWORD PTR [rax+0x8]
 101783c:	cmp    r12,rsi
 101783f:	jae    10178dc <lyr_w3_map_lookupWit+0x12c>
 1017845:	mov    rdi,QWORD PTR [r14+0x28]
 1017849:	mov    rsi,QWORD PTR [r14+0x30]
 101784d:	mov    rcx,r12
 1017850:	shl    rcx,0x4
 1017854:	mov    rdx,QWORD PTR [rax+rcx*1+0x10]
 1017859:	mov    rcx,QWORD PTR [rax+rcx*1+0x18]
 101785e:	mov    r8,QWORD PTR [rbp-0x30]
 1017862:	mov    r9,r15
 1017865:	call   QWORD PTR [rsi+0x10]
 1017868:	test   al,al
 101786a:	jne    10178bb <lyr_w3_map_lookupWit+0x10b>
 101786c:	dec    ebx
 101786e:	je     1017899 <lyr_w3_map_lookupWit+0xe9>
 1017870:	inc    r12
 1017873:	jo     10178e4 <lyr_w3_map_lookupWit+0x134>
 1017875:	and    r12,QWORD PTR [r14+0x20]
 1017879:	dec    ebx
 101787b:	jne    1017810 <lyr_w3_map_lookupWit+0x60>
 101787d:	lea    rax,[rip+0x2cce4]        # 1044568 <lyr_gc_stop_requested>
 1017884:	mov    eax,DWORD PTR [rax]
 1017886:	mov    ebx,0x400
 101788b:	test   eax,eax
 101788d:	je     1017810 <lyr_w3_map_lookupWit+0x60>
 101788f:	call   1020ce0 <lyr_gc_safepoint_slow>
 1017894:	jmp    1017810 <lyr_w3_map_lookupWit+0x60>
 1017899:	lea    rax,[rip+0x2ccc8]        # 1044568 <lyr_gc_stop_requested>
 10178a0:	mov    eax,DWORD PTR [rax]
 10178a2:	mov    ebx,0x400
 10178a7:	test   eax,eax
 10178a9:	je     1017870 <lyr_w3_map_lookupWit+0xc0>
 10178ab:	call   1020ce0 <lyr_gc_safepoint_slow>
 10178b0:	jmp    1017870 <lyr_w3_map_lookupWit+0xc0>
 10178b2:	mov    rax,0xffffffffffffffff
 10178b9:	jmp    10178cd <lyr_w3_map_lookupWit+0x11d>
 10178bb:	mov    rax,QWORD PTR [r14+0x18]
 10178bf:	mov    rsi,QWORD PTR [rax+0x8]
 10178c3:	cmp    r12,rsi
 10178c6:	jae    10178dc <lyr_w3_map_lookupWit+0x12c>
 10178c8:	mov    rax,QWORD PTR [rax+r12*8+0x10]
 10178cd:	add    rsp,0x8
 10178d1:	pop    rbx
 10178d2:	pop    r12
 10178d4:	pop    r13
 10178d6:	pop    r14
 10178d8:	pop    r15
 10178da:	pop    rbp
 10178db:	ret
 10178dc:	mov    rdi,r12
 10178df:	call   1026a88 <lyr_panic_index>
 10178e4:	lea    rdi,[rip+0xfffffffffffeb173]        # 1002a5e <lyr_refmap_ty_w3_map_TableMono+0x119e>
 10178eb:	call   1026ac9 <lyr_panic_overflow>
 10178f0:	mov    rdi,rbp
 10178f3:	mov    rbx,rcx
 10178f6:	mov    r15,rdx
 10178f9:	call   1020d50 <lyr_gc_stack_slow>
 10178fe:	mov    rdx,r15
 1017901:	mov    rcx,rbx
 1017904:	jmp    10177dc <lyr_w3_map_lookupWit+0x2c>

