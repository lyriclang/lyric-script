00000000010017c0 <run>:
 10017c0:	push   rbp
 10017c1:	mov    rbp,rsp
 10017c4:	push   r15
 10017c6:	push   r14
 10017c8:	push   r13
 10017ca:	push   r12
 10017cc:	push   rbx
 10017cd:	mov    r9,rdx
 10017d0:	mov    r10d,0x1
 10017d6:	xor    r14d,r14d
 10017d9:	lea    r11,[rip+0x13c0]        # 1002ba0 <run.labels>
 10017e0:	xor    ebx,ebx
 10017e2:	mov    r12,rdi
 10017e5:	jmp    1001814 <run+0x54>
 10017e7:	mov    rax,QWORD PTR [rsi+rax*8]
 10017eb:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10017ef:	cmp    rax,rdx
 10017f2:	cmovb  rdx,rax
 10017f6:	cs nop WORD PTR [rax+rax*1+0x0]
 1001800:	mov    QWORD PTR [rsi+r15*8],rdx
 1001804:	inc    r14
 1001807:	mov    rdx,r14
 100180a:	lea    r12,[rdi+rdx*8]
 100180e:	inc    r10
 1001811:	mov    r14,rdx
 1001814:	movzx  r13d,BYTE PTR [rdi+r14*8]
 1001819:	movzx  r15d,WORD PTR [r12+0x2]
 100181f:	movzx  eax,WORD PTR [r12+0x4]
 1001825:	movzx  edx,WORD PTR [r12+0x6]
 100182b:	jmp    QWORD PTR [r11+r13*8]
 100182f:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1001833:	add    rdx,QWORD PTR [rsi+rax*8]
 1001837:	jmp    1001800 <run+0x40>
 1001839:	mov    r15,QWORD PTR [rsi+r15*8]
 100183d:	cmp    r15,QWORD PTR [rsi+rax*8]
 1001841:	je     1001804 <run+0x44>
 1001843:	jmp    100180a <run+0x4a>
 1001845:	mov    rax,QWORD PTR [rsi+rax*8]
 1001849:	sub    rax,rdx
 100184c:	mov    QWORD PTR [rsi+r15*8],rax
 1001850:	jmp    1001804 <run+0x44>
 1001852:	mov    rax,QWORD PTR [rsi+rax*8]
 1001856:	lea    rax,[rcx+rax*8]
 100185a:	mov    rax,QWORD PTR [rax+rdx*8]
 100185e:	mov    QWORD PTR [rsi+r15*8],rax
 1001862:	jmp    1001804 <run+0x44>
 1001864:	mov    r15,QWORD PTR [rsi+r15*8]
 1001868:	cmp    r15,QWORD PTR [rsi+rax*8]
 100186c:	jb     1001804 <run+0x44>
 100186e:	jmp    100180a <run+0x4a>
 1001870:	mov    r15,QWORD PTR [rsi+r15*8]
 1001874:	cmp    r15,QWORD PTR [rsi+rax*8]
 1001878:	jne    1001804 <run+0x44>
 100187a:	jmp    100180a <run+0x4a>
 100187c:	mov    rax,QWORD PTR [rsi+rax*8]
 1001880:	mov    r12,QWORD PTR [rsi+rdx*8]
 1001884:	mov    rdx,rax
 1001887:	or     rdx,r12
 100188a:	shr    rdx,0x20
 100188e:	je     1001af0 <run+0x330>
 1001894:	xor    edx,edx
 1001896:	div    r12
 1001899:	mov    QWORD PTR [rsi+r15*8],rax
 100189d:	jmp    1001804 <run+0x44>
 10018a2:	jmp    1001804 <run+0x44>
 10018a7:	mov    r15,QWORD PTR [rsi+r15*8]
 10018ab:	mov    rax,QWORD PTR [rsi+rax*8]
 10018af:	lea    rax,[rcx+rax*8]
 10018b3:	mov    QWORD PTR [rax+rdx*8],r15
 10018b7:	jmp    1001804 <run+0x44>
 10018bc:	mov    rax,QWORD PTR [rsi+rax*8]
 10018c0:	xor    rax,rdx
 10018c3:	mov    QWORD PTR [rsi+r15*8],rax
 10018c7:	jmp    1001804 <run+0x44>
 10018cc:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10018d0:	xor    rdx,QWORD PTR [rsi+rax*8]
 10018d4:	jmp    1001800 <run+0x40>
 10018d9:	xor    edx,edx
 10018db:	sub    rdx,QWORD PTR [rsi+rax*8]
 10018df:	jmp    1001800 <run+0x40>
 10018e4:	mov    rax,QWORD PTR [rsi+rax*8]
 10018e8:	or     rax,rdx
 10018eb:	mov    QWORD PTR [rsi+r15*8],rax
 10018ef:	jmp    1001804 <run+0x44>
 10018f4:	mov    rax,QWORD PTR [rsi+rax*8]
 10018f8:	xor    r12d,r12d
 10018fb:	cmp    rax,QWORD PTR [rsi+rdx*8]
 10018ff:	setb   r12b
 1001903:	mov    QWORD PTR [rsi+r15*8],r12
 1001907:	jmp    1001804 <run+0x44>
 100190c:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1001910:	imul   rdx,QWORD PTR [rsi+rax*8]
 1001915:	jmp    1001800 <run+0x40>
 100191a:	mov    rax,QWORD PTR [rsi+rax*8]
 100191e:	add    rax,rdx
 1001921:	mov    QWORD PTR [rsi+r15*8],rax
 1001925:	jmp    1001804 <run+0x44>
 100192a:	movzx  edx,BYTE PTR [rsi+rdx*8]
 100192e:	shlx   rax,QWORD PTR [rsi+rax*8],rdx
 1001934:	mov    QWORD PTR [rsi+r15*8],rax
 1001938:	jmp    1001804 <run+0x44>
 100193d:	mov    rax,QWORD PTR [rsi+rax*8]
 1001941:	sub    rax,QWORD PTR [rsi+rdx*8]
 1001945:	mov    QWORD PTR [rsi+r15*8],rax
 1001949:	jmp    1001804 <run+0x44>
 100194e:	cmp    QWORD PTR [rsi+r15*8],0x0
 1001953:	jne    1001804 <run+0x44>
 1001959:	jmp    100180a <run+0x4a>
 100195e:	mov    r15,QWORD PTR [rsi+r15*8]
 1001962:	cmp    r15,QWORD PTR [rsi+rax*8]
 1001966:	ja     1001804 <run+0x44>
 100196c:	jmp    100180a <run+0x4a>
 1001971:	mov    rax,QWORD PTR [rsi+rax*8]
 1001975:	xor    r12d,r12d
 1001978:	cmp    rax,QWORD PTR [rsi+rdx*8]
 100197c:	setae  r12b
 1001980:	mov    QWORD PTR [rsi+r15*8],r12
 1001984:	jmp    1001804 <run+0x44>
 1001989:	mov    rax,QWORD PTR [rsi+rax*8]
 100198d:	xor    r12d,r12d
 1001990:	cmp    rax,QWORD PTR [rsi+rdx*8]
 1001994:	sete   r12b
 1001998:	mov    QWORD PTR [rsi+r15*8],r12
 100199c:	jmp    1001804 <run+0x44>
 10019a1:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10019a5:	and    rdx,QWORD PTR [rsi+rax*8]
 10019a9:	jmp    1001800 <run+0x40>
 10019ae:	mov    rax,QWORD PTR [r9+rax*8]
 10019b2:	mov    QWORD PTR [rsi+r15*8],rax
 10019b6:	jmp    1001804 <run+0x44>
 10019bb:	dec    QWORD PTR [rsi+r15*8]
 10019bf:	jmp    1001804 <run+0x44>
 10019c4:	mov    rdx,QWORD PTR [r8+rbx*8-0x8]
 10019c9:	dec    rbx
 10019cc:	jmp    100180a <run+0x4a>
 10019d1:	mov    eax,DWORD PTR [rsi+rax*8]
 10019d4:	and    eax,edx
 10019d6:	mov    QWORD PTR [rsi+r15*8],rax
 10019da:	jmp    1001804 <run+0x44>
 10019df:	mov    r15,QWORD PTR [rsi+r15*8]
 10019e3:	cmp    r15,QWORD PTR [rsi+rax*8]
 10019e7:	jae    1001804 <run+0x44>
 10019ed:	jmp    100180a <run+0x4a>
 10019f2:	movzx  edx,BYTE PTR [rsi+rdx*8]
 10019f6:	shrx   rax,QWORD PTR [rsi+rax*8],rdx
 10019fc:	mov    QWORD PTR [rsi+r15*8],rax
 1001a00:	jmp    1001804 <run+0x44>
 1001a05:	jmp    100180a <run+0x4a>
 1001a0a:	shl    edx,0x10
 1001a0d:	or     rdx,rax
 1001a10:	jmp    1001800 <run+0x40>
 1001a15:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1001a19:	or     rdx,QWORD PTR [rsi+rax*8]
 1001a1d:	jmp    1001800 <run+0x40>
 1001a22:	mov    rax,QWORD PTR [rsi+rax*8]
 1001a26:	mov    r12,QWORD PTR [rsi+rdx*8]
 1001a2a:	mov    rdx,rax
 1001a2d:	or     rdx,r12
 1001a30:	shr    rdx,0x20
 1001a34:	je     1001afe <run+0x33e>
 1001a3a:	xor    edx,edx
 1001a3c:	div    r12
 1001a3f:	jmp    1001800 <run+0x40>
 1001a44:	inc    QWORD PTR [rsi+r15*8]
 1001a48:	jmp    1001804 <run+0x44>
 1001a4d:	mov    rax,QWORD PTR [rsi+rax*8]
 1001a51:	xor    r12d,r12d
 1001a54:	cmp    rax,QWORD PTR [rsi+rdx*8]
 1001a58:	setne  r12b
 1001a5c:	mov    QWORD PTR [rsi+r15*8],r12
 1001a60:	jmp    1001804 <run+0x44>
 1001a65:	mov    rax,QWORD PTR [rsi+rax*8]
 1001a69:	not    rax
 1001a6c:	mov    QWORD PTR [rsi+r15*8],rax
 1001a70:	jmp    1001804 <run+0x44>
 1001a75:	inc    r14
 1001a78:	mov    QWORD PTR [r8+rbx*8],r14
 1001a7c:	inc    rbx
 1001a7f:	jmp    100180a <run+0x4a>
 1001a84:	mov    rax,QWORD PTR [rsi+rax*8]
 1001a88:	xor    r12d,r12d
 1001a8b:	cmp    rax,QWORD PTR [rsi+rdx*8]
 1001a8f:	setbe  r12b
 1001a93:	mov    QWORD PTR [rsi+r15*8],r12
 1001a97:	jmp    1001804 <run+0x44>
 1001a9c:	mov    rax,QWORD PTR [rsi+rax*8]
 1001aa0:	xor    r12d,r12d
 1001aa3:	cmp    rax,QWORD PTR [rsi+rdx*8]
 1001aa7:	seta   r12b
 1001aab:	mov    QWORD PTR [rsi+r15*8],r12
 1001aaf:	jmp    1001804 <run+0x44>
 1001ab4:	cmp    QWORD PTR [rsi+r15*8],0x0
 1001ab9:	je     1001804 <run+0x44>
 1001abf:	jmp    100180a <run+0x4a>
 1001ac4:	cmp    QWORD PTR [rsi+rdx*8],0x0
 1001ac9:	je     1001804 <run+0x44>
 1001acf:	mov    rax,QWORD PTR [rsi+rax*8]
 1001ad3:	mov    QWORD PTR [rsi+r15*8],rax
 1001ad7:	jmp    1001804 <run+0x44>
 1001adc:	mov    rax,QWORD PTR [rsi+rax*8]
 1001ae0:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1001ae4:	cmp    rax,rdx
 1001ae7:	cmova  rdx,rax
 1001aeb:	jmp    1001800 <run+0x40>
 1001af0:	xor    edx,edx
 1001af2:	div    r12d
 1001af5:	mov    QWORD PTR [rsi+r15*8],rax
 1001af9:	jmp    1001804 <run+0x44>
 1001afe:	xor    edx,edx
 1001b00:	div    r12d
 1001b03:	jmp    1001800 <run+0x40>
 1001b08:	mov    rax,r10
 1001b0b:	pop    rbx
 1001b0c:	pop    r12
 1001b0e:	pop    r13
 1001b10:	pop    r14
 1001b12:	pop    r15
 1001b14:	pop    rbp
 1001b15:	ret
