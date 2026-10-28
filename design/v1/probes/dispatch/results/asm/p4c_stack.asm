00000000010019a0 <run>:
 10019a0:	push   rbp
 10019a1:	mov    rbp,rsp
 10019a4:	push   r15
 10019a6:	push   r14
 10019a8:	push   r13
 10019aa:	push   r12
 10019ac:	push   rbx
 10019ad:	push   rax
 10019ae:	mov    r10,rcx
 10019b1:	mov    QWORD PTR [rbp-0x30],rdx
 10019b5:	mov    ebx,0x1
 10019ba:	xor    r13d,r13d
 10019bd:	lea    r14,[rip+0xffffffffffffeb6c]        # 1000530 <__abi_tag+0x2a4>
 10019c4:	xor    r15d,r15d
 10019c7:	xor    r12d,r12d
 10019ca:	jmp    10019e9 <run+0x49>
 10019cc:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 10019d1:	xor    ecx,ecx
 10019d3:	cmp    rax,QWORD PTR [r9+r13*8-0x8]
 10019d8:	setae  cl
 10019db:	mov    QWORD PTR [r9+r13*8-0x10],rcx
 10019e0:	dec    r13
 10019e3:	inc    r12
 10019e6:	inc    rbx
 10019e9:	movzx  r11d,BYTE PTR [rdi+r12*8]
 10019ee:	cmp    r11,0x2f
 10019f2:	ja     1001d2b <run+0x38b>
 10019f8:	movzx  eax,WORD PTR [rdi+r12*8+0x2]
 10019fe:	movzx  edx,WORD PTR [rdi+r12*8+0x4]
 1001a04:	movzx  ecx,WORD PTR [rdi+r12*8+0x6]
 1001a0a:	movsxd r11,DWORD PTR [r14+r11*4]
 1001a0e:	add    r11,r14
 1001a11:	jmp    r11
 1001a14:	mov    rax,QWORD PTR [rsi+rax*8]
 1001a18:	jmp    1001b71 <run+0x1d1>
 1001a1d:	dec    QWORD PTR [rsi+rax*8]
 1001a21:	jmp    10019e3 <run+0x43>
 1001a23:	not    QWORD PTR [r9+r13*8-0x8]
 1001a28:	jmp    10019e3 <run+0x43>
 1001a2a:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001a2f:	cmp    rax,QWORD PTR [r9+r13*8-0x10]
 1001a34:	ja     1001d0c <run+0x36c>
 1001a3a:	jmp    1001d11 <run+0x371>
 1001a3f:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001a44:	or     QWORD PTR [r9+r13*8-0x10],rax
 1001a49:	jmp    10019e0 <run+0x40>
 1001a4b:	inc    r12
 1001a4e:	cmp    QWORD PTR [r9+r13*8-0x8],0x0
 1001a54:	lea    r13,[r13-0x1]
 1001a58:	cmovne r12,rcx
 1001a5c:	inc    rbx
 1001a5f:	jmp    10019e9 <run+0x49>
 1001a61:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001a66:	jmp    1001b71 <run+0x1d1>
 1001a6b:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001a70:	lea    rax,[r10+rax*8]
 1001a74:	mov    rax,QWORD PTR [rax+rcx*8]
 1001a78:	mov    QWORD PTR [r9+r13*8-0x8],rax
 1001a7d:	jmp    10019e3 <run+0x43>
 1001a82:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001a87:	imul   rax,rcx
 1001a8b:	mov    QWORD PTR [r9+r13*8-0x8],rax
 1001a90:	jmp    10019e3 <run+0x43>
 1001a95:	movzx  ecx,BYTE PTR [r9+r13*8-0x8]
 1001a9b:	shr    QWORD PTR [r9+r13*8-0x10],cl
 1001aa0:	jmp    10019e0 <run+0x40>
 1001aa5:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001aaa:	sub    QWORD PTR [r9+r13*8-0x10],rax
 1001aaf:	jmp    10019e0 <run+0x40>
 1001ab4:	add    QWORD PTR [r9+r13*8-0x8],rcx
 1001ab9:	jmp    10019e3 <run+0x43>
 1001abe:	mov    rcx,QWORD PTR [r9+r13*8-0x8]
 1001ac3:	dec    r13
 1001ac6:	mov    QWORD PTR [rsi+rax*8],rcx
 1001aca:	jmp    10019e3 <run+0x43>
 1001acf:	sub    QWORD PTR [r9+r13*8-0x8],rcx
 1001ad4:	jmp    10019e3 <run+0x43>
 1001ad9:	shl    QWORD PTR [r9+r13*8-0x8],cl
 1001ade:	jmp    10019e3 <run+0x43>
 1001ae3:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 1001ae8:	mov    rcx,QWORD PTR [r9+r13*8-0x8]
 1001aed:	mov    rdx,rax
 1001af0:	or     rdx,rcx
 1001af3:	shr    rdx,0x20
 1001af7:	je     1001cf7 <run+0x357>
 1001afd:	xor    edx,edx
 1001aff:	div    rcx
 1001b02:	jmp    1001cfb <run+0x35b>
 1001b07:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001b0c:	add    QWORD PTR [r9+r13*8-0x10],rax
 1001b11:	jmp    10019e0 <run+0x40>
 1001b16:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 1001b1b:	xor    ecx,ecx
 1001b1d:	cmp    rax,QWORD PTR [r9+r13*8-0x8]
 1001b22:	setbe  cl
 1001b25:	jmp    10019db <run+0x3b>
 1001b2a:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001b2f:	and    QWORD PTR [r9+r13*8-0x10],rax
 1001b34:	jmp    10019e0 <run+0x40>
 1001b39:	inc    r12
 1001b3c:	cmp    QWORD PTR [r9+r13*8-0x8],0x0
 1001b42:	lea    r13,[r13-0x1]
 1001b46:	jmp    1001c48 <run+0x2a8>
 1001b4b:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 1001b50:	xor    ecx,ecx
 1001b52:	cmp    rax,QWORD PTR [r9+r13*8-0x8]
 1001b57:	setne  cl
 1001b5a:	jmp    10019db <run+0x3b>
 1001b5f:	or     QWORD PTR [r9+r13*8-0x8],rcx
 1001b64:	jmp    10019e3 <run+0x43>
 1001b69:	mov    rax,QWORD PTR [rbp-0x30]
 1001b6d:	mov    rax,QWORD PTR [rax+rdx*8]
 1001b71:	mov    QWORD PTR [r9+r13*8],rax
 1001b75:	inc    r13
 1001b78:	jmp    10019e3 <run+0x43>
 1001b7d:	inc    QWORD PTR [rsi+rax*8]
 1001b81:	jmp    10019e3 <run+0x43>
 1001b86:	inc    r12
 1001b89:	mov    QWORD PTR [r8+r15*8],r12
 1001b8d:	inc    r15
 1001b90:	inc    rbx
 1001b93:	mov    r12,rcx
 1001b96:	jmp    10019e9 <run+0x49>
 1001b9b:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001ba0:	imul   rax,QWORD PTR [r9+r13*8-0x10]
 1001ba6:	mov    QWORD PTR [r9+r13*8-0x10],rax
 1001bab:	jmp    10019e0 <run+0x40>
 1001bb0:	movzx  ecx,BYTE PTR [r9+r13*8-0x8]
 1001bb6:	shl    QWORD PTR [r9+r13*8-0x10],cl
 1001bbb:	jmp    10019e0 <run+0x40>
 1001bc0:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 1001bc5:	xor    ecx,ecx
 1001bc7:	cmp    rax,QWORD PTR [r9+r13*8-0x8]
 1001bcc:	setb   cl
 1001bcf:	jmp    10019db <run+0x3b>
 1001bd4:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001bd9:	xor    QWORD PTR [r9+r13*8-0x10],rax
 1001bde:	jmp    10019e0 <run+0x40>
 1001be3:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 1001be8:	inc    r12
 1001beb:	cmp    rax,QWORD PTR [r9+r13*8-0x8]
 1001bf0:	lea    r13,[r13-0x2]
 1001bf4:	cmovb  r12,rcx
 1001bf8:	inc    rbx
 1001bfb:	jmp    10019e9 <run+0x49>
 1001c00:	mov    eax,DWORD PTR [r9+r13*8-0x8]
 1001c05:	and    eax,ecx
 1001c07:	mov    QWORD PTR [r9+r13*8-0x8],rax
 1001c0c:	jmp    10019e3 <run+0x43>
 1001c11:	shl    ecx,0x10
 1001c14:	or     rcx,rdx
 1001c17:	mov    QWORD PTR [r9+r13*8],rcx
 1001c1b:	inc    r13
 1001c1e:	jmp    10019e3 <run+0x43>
 1001c23:	vpshufd xmm0,XMMWORD PTR [r9+r13*8-0x10],0x4e
 1001c2b:	vmovups XMMWORD PTR [r9+r13*8-0x10],xmm0
 1001c32:	jmp    10019e3 <run+0x43>
 1001c37:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 1001c3c:	inc    r12
 1001c3f:	cmp    rax,QWORD PTR [r9+r13*8-0x8]
 1001c44:	lea    r13,[r13-0x2]
 1001c48:	cmove  r12,rcx
 1001c4c:	inc    rbx
 1001c4f:	jmp    10019e9 <run+0x49>
 1001c54:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 1001c59:	mov    rcx,QWORD PTR [r9+r13*8-0x8]
 1001c5e:	mov    rdx,rax
 1001c61:	or     rdx,rcx
 1001c64:	shr    rdx,0x20
 1001c68:	je     1001d08 <run+0x368>
 1001c6e:	xor    edx,edx
 1001c70:	div    rcx
 1001c73:	jmp    1001d0c <run+0x36c>
 1001c78:	xor    QWORD PTR [r9+r13*8-0x8],rcx
 1001c7d:	jmp    10019e3 <run+0x43>
 1001c82:	neg    QWORD PTR [r9+r13*8-0x8]
 1001c87:	jmp    10019e3 <run+0x43>
 1001c8c:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 1001c91:	mov    rdx,QWORD PTR [r9+r13*8-0x8]
 1001c96:	add    r13,0xfffffffffffffffe
 1001c9a:	lea    rax,[r10+rax*8]
 1001c9e:	mov    QWORD PTR [rax+rcx*8],rdx
 1001ca2:	jmp    10019e3 <run+0x43>
 1001ca7:	shr    QWORD PTR [r9+r13*8-0x8],cl
 1001cac:	jmp    10019e3 <run+0x43>
 1001cb1:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 1001cb6:	xor    ecx,ecx
 1001cb8:	cmp    rax,QWORD PTR [r9+r13*8-0x8]
 1001cbd:	sete   cl
 1001cc0:	jmp    10019db <run+0x3b>
 1001cc5:	mov    rax,QWORD PTR [r9+r13*8-0x10]
 1001cca:	xor    ecx,ecx
 1001ccc:	cmp    rax,QWORD PTR [r9+r13*8-0x8]
 1001cd1:	seta   cl
 1001cd4:	jmp    10019db <run+0x3b>
 1001cd9:	mov    r12,QWORD PTR [r8+r15*8-0x8]
 1001cde:	dec    r15
 1001ce1:	inc    rbx
 1001ce4:	jmp    10019e9 <run+0x49>
 1001ce9:	mov    rax,QWORD PTR [r9+r13*8-0x8]
 1001cee:	cmp    rax,QWORD PTR [r9+r13*8-0x10]
 1001cf3:	jb     1001d0c <run+0x36c>
 1001cf5:	jmp    1001d11 <run+0x371>
 1001cf7:	xor    edx,edx
 1001cf9:	div    ecx
 1001cfb:	mov    QWORD PTR [r9+r13*8-0x10],rdx
 1001d00:	dec    r13
 1001d03:	jmp    10019e3 <run+0x43>
 1001d08:	xor    edx,edx
 1001d0a:	div    ecx
 1001d0c:	mov    QWORD PTR [r9+r13*8-0x10],rax
 1001d11:	dec    r13
 1001d14:	jmp    10019e3 <run+0x43>
 1001d19:	mov    rax,rbx
 1001d1c:	add    rsp,0x8
 1001d20:	pop    rbx
 1001d21:	pop    r12
 1001d23:	pop    r13
 1001d25:	pop    r14
 1001d27:	pop    r15
 1001d29:	pop    rbp
 1001d2a:	ret
 1001d2b:	call   1001db0 <abort@plt>
