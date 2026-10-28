0000000001016760 <lyr_w1_coerce_loopClass>:
 1016760:	push   rbp
 1016761:	mov    rbp,rsp
 1016764:	push   r15
 1016766:	push   r14
 1016768:	push   r13
 101676a:	push   r12
 101676c:	push   rbx
 101676d:	sub    rsp,0x28
 1016771:	lea    rbx,[rdi+0x10]
 1016775:	mov    rax,rdx
 1016778:	sar    rax,0x3f
 101677c:	andn   r14,rax,rdx
 1016781:	lea    rax,[rdi+0x1f]
 1016785:	mov    QWORD PTR [rbp-0x38],rax
 1016789:	mov    r13d,0x400
 101678f:	xor    r12d,r12d
 1016792:	lea    r11,[rip+0x25b77]        # 103c310 <lyr_vt_17_w1_coerce_HeapRef_22_w1_coerce_ScriptObject>
 1016799:	lea    r10,[rip+0x2bde0]        # 1042580 <lyr_gc_heap_base>
 10167a0:	lea    r15,[rip+0x2bdc1]        # 1042568 <lyr_gc_cards>
 10167a7:	mov    QWORD PTR [rbp-0x30],r14
 10167ab:	jmp    10167b3 <lyr_w1_coerce_loopClass+0x53>
 10167ad:	nop    DWORD PTR [rax]
 10167b0:	inc    r12
 10167b3:	dec    r13d
 10167b6:	je     10168cd <lyr_w1_coerce_loopClass+0x16d>
 10167bc:	cmp    r12,r14
 10167bf:	je     101690f <lyr_w1_coerce_loopClass+0x1af>
 10167c5:	mov    eax,r12d
 10167c8:	and    eax,0x7
 10167cb:	mov    rcx,QWORD PTR [rsi+0x8]
 10167cf:	cmp    rax,rcx
 10167d2:	jae    101691e <lyr_w1_coerce_loopClass+0x1be>
 10167d8:	mov    ecx,r12d
 10167db:	and    ecx,0xf
 10167de:	mov    rdx,QWORD PTR [rdi+0x8]
 10167e2:	cmp    rcx,rdx
 10167e5:	jae    1016929 <lyr_w1_coerce_loopClass+0x1c9>
 10167eb:	mov    rax,QWORD PTR [rsi+rax*8+0x10]
 10167f0:	shl    ecx,0x4
 10167f3:	lea    r9,[rbx+rcx*1]
 10167f7:	mov    QWORD PTR [rbx+rcx*1],rax
 10167fb:	mov    QWORD PTR [rbx+rcx*1+0x8],r11
 1016800:	mov    rdx,QWORD PTR [r10]
 1016803:	sub    r9,rdx
 1016806:	lea    rax,[rip+0x2bd7b]        # 1042588 <lyr_gc_heap_span>
 101680d:	cmp    r9,QWORD PTR [rax]
 1016810:	jae    10167b0 <lyr_w1_coerce_loopClass+0x50>
 1016812:	mov    rax,r9
 1016815:	shr    rax,0x8
 1016819:	add    r9,0xf
 101681d:	shr    r9,0x8
 1016821:	mov    r8,r9
 1016824:	sub    r8,rax
 1016827:	jb     10167b0 <lyr_w1_coerce_loopClass+0x50>
 1016829:	mov    r14,r10
 101682c:	mov    ecx,r12d
 101682f:	and    ecx,0xf
 1016832:	shl    ecx,0x4
 1016835:	sub    r9d,eax
 1016838:	inc    r9d
 101683b:	test   r9b,0x3
 101683f:	je     1016880 <lyr_w1_coerce_loopClass+0x120>
 1016841:	mov    r9,QWORD PTR [rbp-0x38]
 1016845:	add    r9d,ecx
 1016848:	sub    r9d,edx
 101684b:	shr    r9d,0x8
 101684f:	lea    r10d,[rbx+rcx*1]
 1016853:	sub    r10d,edx
 1016856:	shr    r10d,0x8
 101685a:	sub    r9b,r10b
 101685d:	inc    r9b
 1016860:	movzx  r9d,r9b
 1016864:	and    r9d,0x3
 1016868:	neg    r9
 101686b:	nop    DWORD PTR [rax+rax*1+0x0]
 1016870:	mov    r10,QWORD PTR [r15]
 1016873:	mov    BYTE PTR [r10+rax*1],0x1
 1016878:	inc    rax
 101687b:	inc    r9
 101687e:	jne    1016870 <lyr_w1_coerce_loopClass+0x110>
 1016880:	cmp    r8,0x3
 1016884:	mov    r10,r14
 1016887:	mov    r14,QWORD PTR [rbp-0x30]
 101688b:	jb     10167b0 <lyr_w1_coerce_loopClass+0x50>
 1016891:	add    rcx,QWORD PTR [rbp-0x38]
 1016895:	sub    rcx,rdx
 1016898:	shr    rcx,0x8
 101689c:	inc    rcx
 101689f:	nop
 10168a0:	mov    rdx,QWORD PTR [r15]
 10168a3:	mov    BYTE PTR [rdx+rax*1],0x1
 10168a7:	mov    rdx,QWORD PTR [r15]
 10168aa:	mov    BYTE PTR [rdx+rax*1+0x1],0x1
 10168af:	mov    rdx,QWORD PTR [r15]
 10168b2:	mov    BYTE PTR [rdx+rax*1+0x2],0x1
 10168b7:	mov    rdx,QWORD PTR [r15]
 10168ba:	mov    BYTE PTR [rdx+rax*1+0x3],0x1
 10168bf:	add    rax,0x4
 10168c3:	cmp    rcx,rax
 10168c6:	jne    10168a0 <lyr_w1_coerce_loopClass+0x140>
 10168c8:	jmp    10167b0 <lyr_w1_coerce_loopClass+0x50>
 10168cd:	lea    rax,[rip+0x2bc74]        # 1042548 <lyr_gc_stop_requested>
 10168d4:	mov    eax,DWORD PTR [rax]
 10168d6:	mov    r13d,0x400
 10168dc:	test   eax,eax
 10168de:	je     10167bc <lyr_w1_coerce_loopClass+0x5c>
 10168e4:	mov    QWORD PTR [rbp-0x48],rsi
 10168e8:	mov    QWORD PTR [rbp-0x40],rdi
 10168ec:	mov    r14,r10
 10168ef:	call   101e9e0 <lyr_gc_safepoint_slow>
 10168f4:	mov    r10,r14
 10168f7:	mov    r14,QWORD PTR [rbp-0x30]
 10168fb:	lea    r11,[rip+0x25a0e]        # 103c310 <lyr_vt_17_w1_coerce_HeapRef_22_w1_coerce_ScriptObject>
 1016902:	mov    rdi,QWORD PTR [rbp-0x40]
 1016906:	mov    rsi,QWORD PTR [rbp-0x48]
 101690a:	jmp    10167bc <lyr_w1_coerce_loopClass+0x5c>
 101690f:	add    rsp,0x28
 1016913:	pop    rbx
 1016914:	pop    r12
 1016916:	pop    r13
 1016918:	pop    r14
 101691a:	pop    r15
 101691c:	pop    rbp
 101691d:	ret
 101691e:	mov    rdi,rax
 1016921:	mov    rsi,rcx
 1016924:	call   1024b88 <lyr_panic_index>
 1016929:	mov    rdi,rcx
 101692c:	mov    rsi,rdx
 101692f:	call   1024b88 <lyr_panic_index>

