00000000010018c0 <run>:
 10018c0:	push   rbp
 10018c1:	mov    rbp,rsp
 10018c4:	push   r15
 10018c6:	push   r14
 10018c8:	push   r12
 10018ca:	push   rbx
 10018cb:	mov    r9,rdx
 10018ce:	mov    r10d,0x1
 10018d4:	xor    r11d,r11d
 10018d7:	lea    rbx,[rip+0xffffffffffffec52]        # 1000530 <__abi_tag+0x2a4>
 10018de:	xor    r14d,r14d
 10018e1:	jmp    10018fa <run+0x3a>
 10018e3:	cmp    QWORD PTR [rsi+rdx*8],0x0
 10018e8:	je     10018f4 <run+0x34>
 10018ea:	mov    rax,QWORD PTR [rsi+rax*8]
 10018ee:	xchg   ax,ax
 10018f0:	mov    QWORD PTR [rsi+r15*8],rax
 10018f4:	inc    r14
 10018f7:	inc    r10
 10018fa:	movzx  r12d,BYTE PTR [rdi+r14*8]
 10018ff:	cmp    r12,0x2f
 1001903:	ja     1001c55 <run+0x395>
 1001909:	movzx  r15d,WORD PTR [rdi+r14*8+0x2]
 100190f:	movzx  eax,WORD PTR [rdi+r14*8+0x4]
 1001915:	movzx  edx,WORD PTR [rdi+r14*8+0x6]
 100191b:	movsxd r12,DWORD PTR [rbx+r12*4]
 100191f:	add    r12,rbx
 1001922:	jmp    r12
 1001925:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1001929:	add    rdx,QWORD PTR [rsi+rax*8]
 100192d:	mov    QWORD PTR [rsi+r15*8],rdx
 1001931:	jmp    10018f4 <run+0x34>
 1001933:	mov    rax,QWORD PTR [rsi+rax*8]
 1001937:	mov    rdx,QWORD PTR [rsi+rdx*8]
 100193b:	cmp    rax,rdx
 100193e:	cmovb  rdx,rax
 1001942:	mov    QWORD PTR [rsi+r15*8],rdx
 1001946:	jmp    10018f4 <run+0x34>
 1001948:	mov    r15,QWORD PTR [rsi+r15*8]
 100194c:	cmp    r15,QWORD PTR [rsi+rax*8]
 1001950:	je     1001c05 <run+0x345>
 1001956:	mov    r14,rdx
 1001959:	inc    r10
 100195c:	jmp    10018fa <run+0x3a>
 100195e:	mov    rax,QWORD PTR [rsi+rax*8]
 1001962:	not    rax
 1001965:	jmp    10018f0 <run+0x30>
 1001967:	mov    rax,QWORD PTR [rsi+rax*8]
 100196b:	lea    rax,[rcx+rax*8]
 100196f:	mov    rax,QWORD PTR [rax+rdx*8]
 1001973:	jmp    10018f0 <run+0x30>
 1001978:	movzx  edx,BYTE PTR [rsi+rdx*8]
 100197c:	shlx   rax,QWORD PTR [rsi+rax*8],rdx
 1001982:	jmp    10018f0 <run+0x30>
 1001987:	mov    r15,QWORD PTR [rsi+r15*8]
 100198b:	cmp    r15,QWORD PTR [rsi+rax*8]
 100198f:	jb     1001c10 <run+0x350>
 1001995:	mov    r14,rdx
 1001998:	inc    r10
 100199b:	jmp    10018fa <run+0x3a>
 10019a0:	mov    r15,QWORD PTR [rsi+r15*8]
 10019a4:	cmp    r15,QWORD PTR [rsi+rax*8]
 10019a8:	jne    1001af6 <run+0x236>
 10019ae:	jmp    1001ba0 <run+0x2e0>
 10019b3:	mov    rax,QWORD PTR [r9+rax*8]
 10019b7:	jmp    10018f0 <run+0x30>
 10019bc:	mov    r15,QWORD PTR [rsi+r15*8]
 10019c0:	mov    rax,QWORD PTR [rsi+rax*8]
 10019c4:	lea    rax,[rcx+rax*8]
 10019c8:	mov    QWORD PTR [rax+rdx*8],r15
 10019cc:	jmp    10018f4 <run+0x34>
 10019d1:	mov    rax,QWORD PTR [rsi+rax*8]
 10019d5:	or     rax,rdx
 10019d8:	jmp    10018f0 <run+0x30>
 10019dd:	movzx  edx,BYTE PTR [rsi+rdx*8]
 10019e1:	shrx   rax,QWORD PTR [rsi+rax*8],rdx
 10019e7:	jmp    10018f0 <run+0x30>
 10019ec:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10019f0:	imul   rdx,QWORD PTR [rsi+rax*8]
 10019f5:	mov    QWORD PTR [rsi+r15*8],rdx
 10019f9:	jmp    10018f4 <run+0x34>
 10019fe:	mov    rax,QWORD PTR [rsi+rax*8]
 1001a02:	sub    rax,QWORD PTR [rsi+rdx*8]
 1001a06:	jmp    10018f0 <run+0x30>
 1001a0b:	mov    rax,QWORD PTR [rsi+rax*8]
 1001a0f:	sub    rax,rdx
 1001a12:	jmp    10018f0 <run+0x30>
 1001a17:	mov    rax,QWORD PTR [rsi+rax*8]
 1001a1b:	xor    r12d,r12d
 1001a1e:	cmp    rax,QWORD PTR [rsi+rdx*8]
 1001a22:	setne  r12b
 1001a26:	mov    QWORD PTR [rsi+r15*8],r12
 1001a2a:	jmp    10018f4 <run+0x34>
 1001a2f:	cmp    QWORD PTR [rsi+r15*8],0x0
 1001a34:	jne    1001af6 <run+0x236>
 1001a3a:	jmp    1001ba0 <run+0x2e0>
 1001a3f:	mov    eax,DWORD PTR [rsi+rax*8]
 1001a42:	and    eax,edx
 1001a44:	jmp    10018f0 <run+0x30>
 1001a49:	mov    r15,QWORD PTR [rsi+r15*8]
 1001a4d:	cmp    r15,QWORD PTR [rsi+rax*8]
 1001a51:	ja     1001c1b <run+0x35b>
 1001a57:	mov    r14,rdx
 1001a5a:	inc    r10
 1001a5d:	jmp    10018fa <run+0x3a>
 1001a62:	mov    rax,QWORD PTR [rsi+rax*8]
 1001a66:	xor    r12d,r12d
 1001a69:	cmp    rax,QWORD PTR [rsi+rdx*8]
 1001a6d:	seta   r12b
 1001a71:	mov    QWORD PTR [rsi+r15*8],r12
 1001a75:	jmp    10018f4 <run+0x34>
 1001a7a:	mov    rax,QWORD PTR [rsi+rax*8]
 1001a7e:	xor    rax,rdx
 1001a81:	jmp    10018f0 <run+0x30>
 1001a86:	shl    edx,0x10
 1001a89:	or     rdx,rax
 1001a8c:	mov    QWORD PTR [rsi+r15*8],rdx
 1001a90:	jmp    10018f4 <run+0x34>
 1001a95:	dec    QWORD PTR [rsi+r15*8]
 1001a99:	jmp    10018f4 <run+0x34>
 1001a9e:	mov    r14,QWORD PTR [r8+r11*8-0x8]
 1001aa3:	dec    r11
 1001aa6:	inc    r10
 1001aa9:	jmp    10018fa <run+0x3a>
 1001aae:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1001ab2:	xor    rdx,QWORD PTR [rsi+rax*8]
 1001ab6:	mov    QWORD PTR [rsi+r15*8],rdx
 1001aba:	jmp    10018f4 <run+0x34>
 1001abf:	mov    rax,QWORD PTR [rsi+rax*8]
 1001ac3:	xor    r12d,r12d
 1001ac6:	cmp    rax,QWORD PTR [rsi+rdx*8]
 1001aca:	setae  r12b
 1001ace:	mov    QWORD PTR [rsi+r15*8],r12
 1001ad2:	jmp    10018f4 <run+0x34>
 1001ad7:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1001adb:	and    rdx,QWORD PTR [rsi+rax*8]
 1001adf:	mov    QWORD PTR [rsi+r15*8],rdx
 1001ae3:	jmp    10018f4 <run+0x34>
 1001ae8:	mov    r15,QWORD PTR [rsi+r15*8]
 1001aec:	cmp    r15,QWORD PTR [rsi+rax*8]
 1001af0:	jb     1001ba0 <run+0x2e0>
 1001af6:	inc    r14
 1001af9:	mov    rdx,r14
 1001afc:	jmp    1001ba0 <run+0x2e0>
 1001b01:	mov    rax,QWORD PTR [rsi+rax*8]
 1001b05:	add    rax,rdx
 1001b08:	jmp    10018f0 <run+0x30>
 1001b0d:	mov    rax,QWORD PTR [rsi+rax*8]
 1001b11:	mov    r12,QWORD PTR [rsi+rdx*8]
 1001b15:	mov    rdx,rax
 1001b18:	or     rdx,r12
 1001b1b:	shr    rdx,0x20
 1001b1f:	je     1001c31 <run+0x371>
 1001b25:	xor    edx,edx
 1001b27:	div    r12
 1001b2a:	mov    QWORD PTR [rsi+r15*8],rdx
 1001b2e:	jmp    10018f4 <run+0x34>
 1001b33:	mov    rax,QWORD PTR [rsi+rax*8]
 1001b37:	mov    r12,QWORD PTR [rsi+rdx*8]
 1001b3b:	mov    rdx,rax
 1001b3e:	or     rdx,r12
 1001b41:	shr    rdx,0x20
 1001b45:	je     1001c3f <run+0x37f>
 1001b4b:	xor    edx,edx
 1001b4d:	div    r12
 1001b50:	jmp    10018f0 <run+0x30>
 1001b55:	inc    QWORD PTR [rsi+r15*8]
 1001b59:	jmp    10018f4 <run+0x34>
 1001b5e:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1001b62:	or     rdx,QWORD PTR [rsi+rax*8]
 1001b66:	mov    QWORD PTR [rsi+r15*8],rdx
 1001b6a:	jmp    10018f4 <run+0x34>
 1001b6f:	mov    rax,QWORD PTR [rsi+rax*8]
 1001b73:	xor    r12d,r12d
 1001b76:	cmp    rax,QWORD PTR [rsi+rdx*8]
 1001b7a:	sete   r12b
 1001b7e:	mov    QWORD PTR [rsi+r15*8],r12
 1001b82:	jmp    10018f4 <run+0x34>
 1001b87:	xor    edx,edx
 1001b89:	sub    rdx,QWORD PTR [rsi+rax*8]
 1001b8d:	mov    QWORD PTR [rsi+r15*8],rdx
 1001b91:	jmp    10018f4 <run+0x34>
 1001b96:	inc    r14
 1001b99:	mov    QWORD PTR [r8+r11*8],r14
 1001b9d:	inc    r11
 1001ba0:	inc    r10
 1001ba3:	mov    r14,rdx
 1001ba6:	jmp    10018fa <run+0x3a>
 1001bab:	mov    rax,QWORD PTR [rsi+rax*8]
 1001baf:	xor    r12d,r12d
 1001bb2:	cmp    rax,QWORD PTR [rsi+rdx*8]
 1001bb6:	setb   r12b
 1001bba:	mov    QWORD PTR [rsi+r15*8],r12
 1001bbe:	jmp    10018f4 <run+0x34>
 1001bc3:	mov    rax,QWORD PTR [rsi+rax*8]
 1001bc7:	xor    r12d,r12d
 1001bca:	cmp    rax,QWORD PTR [rsi+rdx*8]
 1001bce:	setbe  r12b
 1001bd2:	mov    QWORD PTR [rsi+r15*8],r12
 1001bd6:	jmp    10018f4 <run+0x34>
 1001bdb:	cmp    QWORD PTR [rsi+r15*8],0x0
 1001be0:	je     1001c26 <run+0x366>
 1001be2:	mov    r14,rdx
 1001be5:	inc    r10
 1001be8:	jmp    10018fa <run+0x3a>
 1001bed:	mov    rax,QWORD PTR [rsi+rax*8]
 1001bf1:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1001bf5:	cmp    rax,rdx
 1001bf8:	cmova  rdx,rax
 1001bfc:	mov    QWORD PTR [rsi+r15*8],rdx
 1001c00:	jmp    10018f4 <run+0x34>
 1001c05:	inc    r14
 1001c08:	inc    r10
 1001c0b:	jmp    10018fa <run+0x3a>
 1001c10:	inc    r14
 1001c13:	inc    r10
 1001c16:	jmp    10018fa <run+0x3a>
 1001c1b:	inc    r14
 1001c1e:	inc    r10
 1001c21:	jmp    10018fa <run+0x3a>
 1001c26:	inc    r14
 1001c29:	inc    r10
 1001c2c:	jmp    10018fa <run+0x3a>
 1001c31:	xor    edx,edx
 1001c33:	div    r12d
 1001c36:	mov    QWORD PTR [rsi+r15*8],rdx
 1001c3a:	jmp    10018f4 <run+0x34>
 1001c3f:	xor    edx,edx
 1001c41:	div    r12d
 1001c44:	jmp    10018f0 <run+0x30>
 1001c49:	mov    rax,r10
 1001c4c:	pop    rbx
 1001c4d:	pop    r12
 1001c4f:	pop    r14
 1001c51:	pop    r15
 1001c53:	pop    rbp
 1001c54:	ret
 1001c55:	call   1001ce0 <abort@plt>
