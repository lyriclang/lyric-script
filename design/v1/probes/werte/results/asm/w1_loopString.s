0000000001016940 <lyr_w1_coerce_loopString>:
 1016940:	push   rbp
 1016941:	mov    rbp,rsp
 1016944:	push   r15
 1016946:	push   r14
 1016948:	push   r13
 101694a:	push   r12
 101694c:	push   rbx
 101694d:	sub    rsp,0x28
 1016951:	lea    r14,[rdi+0x10]
 1016955:	mov    rax,rdx
 1016958:	sar    rax,0x3f
 101695c:	andn   r11,rax,rdx
 1016961:	lea    rax,[rdi+0x1f]
 1016965:	mov    QWORD PTR [rbp-0x40],rax
 1016969:	mov    r12d,0x400
 101696f:	xor    r13d,r13d
 1016972:	mov    r10,0xffffffffffffffe0
 1016979:	lea    r15,[rip+0x2bbe8]        # 1042568 <lyr_gc_cards>
 1016980:	jmp    1016993 <lyr_w1_coerce_loopString+0x53>
 1016982:	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 1016990:	inc    r13
 1016993:	dec    r12d
 1016996:	je     1016afd <lyr_w1_coerce_loopString+0x1bd>
 101699c:	cmp    r13,r11
 101699f:	je     1016b70 <lyr_w1_coerce_loopString+0x230>
 10169a5:	mov    eax,r13d
 10169a8:	and    eax,0x7
 10169ab:	mov    rcx,QWORD PTR [rsi+0x8]
 10169af:	cmp    rax,rcx
 10169b2:	jae    1016b7f <lyr_w1_coerce_loopString+0x23f>
 10169b8:	mov    rbx,QWORD PTR [rsi+rax*8+0x10]
 10169bd:	mov    rax,QWORD PTR fs:[r10]
 10169c1:	mov    rcx,QWORD PTR fs:[r10+0x8]
 10169c6:	sub    rcx,rax
 10169c9:	cmp    rcx,0x10
 10169cd:	jb     1016b3b <lyr_w1_coerce_loopString+0x1fb>
 10169d3:	lea    rcx,[rax+0x10]
 10169d7:	mov    QWORD PTR fs:[r10],rcx
 10169db:	test   rax,rax
 10169de:	je     1016b3b <lyr_w1_coerce_loopString+0x1fb>
 10169e4:	lea    rcx,[rip+0x2585d]        # 103c248 <lyr_desc_box_ty_0_box_string__1067cdbf>
 10169eb:	mov    QWORD PTR [rax],rcx
 10169ee:	mov    ecx,r13d
 10169f1:	and    ecx,0xf
 10169f4:	mov    QWORD PTR [rax+0x8],rbx
 10169f8:	mov    rdx,QWORD PTR [rdi+0x8]
 10169fc:	cmp    rcx,rdx
 10169ff:	jae    1016b8a <lyr_w1_coerce_loopString+0x24a>
 1016a05:	shl    ecx,0x4
 1016a08:	lea    r9,[r14+rcx*1]
 1016a0c:	mov    QWORD PTR [r14+rcx*1],rax
 1016a10:	lea    rax,[rip+0x25991]        # 103c3a8 <lyr_vt_17_w1_coerce_HeapRef_22_0_box_string__1067cdbf>
 1016a17:	mov    QWORD PTR [r14+rcx*1+0x8],rax
 1016a1c:	lea    rax,[rip+0x2bb5d]        # 1042580 <lyr_gc_heap_base>
 1016a23:	mov    rdx,QWORD PTR [rax]
 1016a26:	sub    r9,rdx
 1016a29:	lea    rax,[rip+0x2bb58]        # 1042588 <lyr_gc_heap_span>
 1016a30:	cmp    r9,QWORD PTR [rax]
 1016a33:	jae    1016990 <lyr_w1_coerce_loopString+0x50>
 1016a39:	mov    rax,r9
 1016a3c:	shr    rax,0x8
 1016a40:	add    r9,0xf
 1016a44:	shr    r9,0x8
 1016a48:	mov    r8,r9
 1016a4b:	sub    r8,rax
 1016a4e:	jb     1016990 <lyr_w1_coerce_loopString+0x50>
 1016a54:	mov    ecx,r13d
 1016a57:	and    ecx,0xf
 1016a5a:	shl    ecx,0x4
 1016a5d:	sub    r9d,eax
 1016a60:	inc    r9d
 1016a63:	test   r9b,0x3
 1016a67:	je     1016ab0 <lyr_w1_coerce_loopString+0x170>
 1016a69:	mov    r9,QWORD PTR [rbp-0x40]
 1016a6d:	add    r9d,ecx
 1016a70:	sub    r9d,edx
 1016a73:	shr    r9d,0x8
 1016a77:	lea    r10d,[r14+rcx*1]
 1016a7b:	sub    r10d,edx
 1016a7e:	shr    r10d,0x8
 1016a82:	sub    r9b,r10b
 1016a85:	inc    r9b
 1016a88:	movzx  r9d,r9b
 1016a8c:	and    r9d,0x3
 1016a90:	neg    r9
 1016a93:	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 1016aa0:	mov    r10,QWORD PTR [r15]
 1016aa3:	mov    BYTE PTR [r10+rax*1],0x1
 1016aa8:	inc    rax
 1016aab:	inc    r9
 1016aae:	jne    1016aa0 <lyr_w1_coerce_loopString+0x160>
 1016ab0:	cmp    r8,0x3
 1016ab4:	mov    r10,0xffffffffffffffe0
 1016abb:	jb     1016990 <lyr_w1_coerce_loopString+0x50>
 1016ac1:	add    rcx,QWORD PTR [rbp-0x40]
 1016ac5:	sub    rcx,rdx
 1016ac8:	shr    rcx,0x8
 1016acc:	inc    rcx
 1016acf:	nop
 1016ad0:	mov    rdx,QWORD PTR [r15]
 1016ad3:	mov    BYTE PTR [rdx+rax*1],0x1
 1016ad7:	mov    rdx,QWORD PTR [r15]
 1016ada:	mov    BYTE PTR [rdx+rax*1+0x1],0x1
 1016adf:	mov    rdx,QWORD PTR [r15]
 1016ae2:	mov    BYTE PTR [rdx+rax*1+0x2],0x1
 1016ae7:	mov    rdx,QWORD PTR [r15]
 1016aea:	mov    BYTE PTR [rdx+rax*1+0x3],0x1
 1016aef:	add    rax,0x4
 1016af3:	cmp    rcx,rax
 1016af6:	jne    1016ad0 <lyr_w1_coerce_loopString+0x190>
 1016af8:	jmp    1016990 <lyr_w1_coerce_loopString+0x50>
 1016afd:	lea    rax,[rip+0x2ba44]        # 1042548 <lyr_gc_stop_requested>
 1016b04:	mov    eax,DWORD PTR [rax]
 1016b06:	mov    r12d,0x400
 1016b0c:	test   eax,eax
 1016b0e:	je     101699c <lyr_w1_coerce_loopString+0x5c>
 1016b14:	mov    QWORD PTR [rbp-0x38],rsi
 1016b18:	mov    rbx,rdi
 1016b1b:	mov    QWORD PTR [rbp-0x30],r11
 1016b1f:	call   101e9e0 <lyr_gc_safepoint_slow>
 1016b24:	mov    r10,0xffffffffffffffe0
 1016b2b:	mov    r11,QWORD PTR [rbp-0x30]
 1016b2f:	mov    rdi,rbx
 1016b32:	mov    rsi,QWORD PTR [rbp-0x38]
 1016b36:	jmp    101699c <lyr_w1_coerce_loopString+0x5c>
 1016b3b:	mov    QWORD PTR [rbp-0x38],rsi
 1016b3f:	mov    esi,0x10
 1016b44:	mov    QWORD PTR [rbp-0x48],rdi
 1016b48:	lea    rdi,[rip+0x256f9]        # 103c248 <lyr_desc_box_ty_0_box_string__1067cdbf>
 1016b4f:	mov    QWORD PTR [rbp-0x30],r11
 1016b53:	call   101df80 <lyr_gc_alloc_slow>
 1016b58:	mov    r10,0xffffffffffffffe0
 1016b5f:	mov    r11,QWORD PTR [rbp-0x30]
 1016b63:	mov    rdi,QWORD PTR [rbp-0x48]
 1016b67:	mov    rsi,QWORD PTR [rbp-0x38]
 1016b6b:	jmp    10169ee <lyr_w1_coerce_loopString+0xae>
 1016b70:	add    rsp,0x28
 1016b74:	pop    rbx
 1016b75:	pop    r12
 1016b77:	pop    r13
 1016b79:	pop    r14
 1016b7b:	pop    r15
 1016b7d:	pop    rbp
 1016b7e:	ret
 1016b7f:	mov    rdi,rax
 1016b82:	mov    rsi,rcx
 1016b85:	call   1024b88 <lyr_panic_index>
 1016b8a:	mov    rdi,rcx
 1016b8d:	mov    rsi,rdx
 1016b90:	call   1024b88 <lyr_panic_index>

