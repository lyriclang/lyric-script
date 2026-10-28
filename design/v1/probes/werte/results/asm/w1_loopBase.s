0000000001016630 <lyr_w1_coerce_loopBase>:
 1016630:	push   rbp
 1016631:	mov    rbp,rsp
 1016634:	push   r15
 1016636:	push   r14
 1016638:	push   r13
 101663a:	push   r12
 101663c:	push   rbx
 101663d:	sub    rsp,0x18
 1016641:	lea    rbx,[rdi+0x10]
 1016645:	mov    rax,rdx
 1016648:	sar    rax,0x3f
 101664c:	andn   r14,rax,rdx
 1016651:	mov    r12d,0x400
 1016657:	xor    r15d,r15d
 101665a:	lea    r8,[rip+0x2bee7]        # 1042548 <lyr_gc_stop_requested>
 1016661:	lea    r9,[rip+0x2bf18]        # 1042580 <lyr_gc_heap_base>
 1016668:	lea    r13,[rip+0x2bf19]        # 1042588 <lyr_gc_heap_span>
 101666f:	lea    r10,[rip+0x2bef2]        # 1042568 <lyr_gc_cards>
 1016676:	jmp    1016683 <lyr_w1_coerce_loopBase+0x53>
 1016678:	nop    DWORD PTR [rax+rax*1+0x0]
 1016680:	inc    r15
 1016683:	dec    r12d
 1016686:	je     10166ce <lyr_w1_coerce_loopBase+0x9e>
 1016688:	cmp    r14,r15
 101668b:	je     1016707 <lyr_w1_coerce_loopBase+0xd7>
 101668d:	mov    eax,r15d
 1016690:	and    eax,0x7
 1016693:	mov    rcx,QWORD PTR [rsi+0x8]
 1016697:	cmp    rax,rcx
 101669a:	jae    1016716 <lyr_w1_coerce_loopBase+0xe6>
 101669c:	mov    ecx,r15d
 101669f:	and    ecx,0xf
 10166a2:	mov    rdx,QWORD PTR [rdi+0x8]
 10166a6:	cmp    rcx,rdx
 10166a9:	jae    1016721 <lyr_w1_coerce_loopBase+0xf1>
 10166ab:	mov    rdx,QWORD PTR [rsi+rax*8+0x10]
 10166b0:	lea    rax,[rbx+rcx*8]
 10166b4:	mov    QWORD PTR [rbx+rcx*8],rdx
 10166b8:	sub    rax,QWORD PTR [r9]
 10166bb:	cmp    rax,QWORD PTR [r13+0x0]
 10166bf:	jae    1016680 <lyr_w1_coerce_loopBase+0x50>
 10166c1:	mov    rcx,QWORD PTR [r10]
 10166c4:	shr    rax,0x8
 10166c8:	mov    BYTE PTR [rcx+rax*1],0x1
 10166cc:	jmp    1016680 <lyr_w1_coerce_loopBase+0x50>
 10166ce:	mov    eax,DWORD PTR [r8]
 10166d1:	mov    r12d,0x400
 10166d7:	test   eax,eax
 10166d9:	je     1016688 <lyr_w1_coerce_loopBase+0x58>
 10166db:	mov    QWORD PTR [rbp-0x38],rsi
 10166df:	mov    QWORD PTR [rbp-0x30],rdi
 10166e3:	call   101e9e0 <lyr_gc_safepoint_slow>
 10166e8:	lea    r10,[rip+0x2be79]        # 1042568 <lyr_gc_cards>
 10166ef:	lea    r9,[rip+0x2be8a]        # 1042580 <lyr_gc_heap_base>
 10166f6:	lea    r8,[rip+0x2be4b]        # 1042548 <lyr_gc_stop_requested>
 10166fd:	mov    rdi,QWORD PTR [rbp-0x30]
 1016701:	mov    rsi,QWORD PTR [rbp-0x38]
 1016705:	jmp    1016688 <lyr_w1_coerce_loopBase+0x58>
 1016707:	add    rsp,0x18
 101670b:	pop    rbx
 101670c:	pop    r12
 101670e:	pop    r13
 1016710:	pop    r14
 1016712:	pop    r15
 1016714:	pop    rbp
 1016715:	ret
 1016716:	mov    rdi,rax
 1016719:	mov    rsi,rcx
 101671c:	call   1024b88 <lyr_panic_index>
 1016721:	mov    rdi,rcx
 1016724:	mov    rsi,rdx
 1016727:	call   1024b88 <lyr_panic_index>

