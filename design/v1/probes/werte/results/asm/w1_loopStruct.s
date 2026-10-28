0000000001016be0 <lyr_w1_coerce_loopStruct>:
 1016be0:	push   rbp
 1016be1:	mov    rbp,rsp
 1016be4:	push   r15
 1016be6:	push   r14
 1016be8:	push   r13
 1016bea:	push   r12
 1016bec:	push   rbx
 1016bed:	sub    rsp,0x18
 1016bf1:	lea    r14,[rdi+0x10]
 1016bf5:	mov    rax,rsi
 1016bf8:	sar    rax,0x3f
 1016bfc:	andn   r10,rax,rsi
 1016c01:	lea    r11,[rdi+0x1f]
 1016c05:	mov    r12d,0x400
 1016c0b:	xor    r13d,r13d
 1016c0e:	mov    rbx,0xffffffffffffffe0
 1016c15:	lea    r9,[rip+0x25654]        # 103c270 <lyr_desc_box_ty_w1_coerce_Small>
 1016c1c:	lea    r15,[rip+0x2b945]        # 1042568 <lyr_gc_cards>
 1016c23:	jmp    1016c33 <lyr_w1_coerce_loopStruct+0x53>
 1016c25:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 1016c30:	inc    r13
 1016c33:	dec    r12d
 1016c36:	je     1016d7d <lyr_w1_coerce_loopStruct+0x19d>
 1016c3c:	cmp    r13,r10
 1016c3f:	je     1016dee <lyr_w1_coerce_loopStruct+0x20e>
 1016c45:	mov    rax,QWORD PTR fs:[rbx]
 1016c49:	mov    rcx,QWORD PTR fs:[rbx+0x8]
 1016c4e:	sub    rcx,rax
 1016c51:	cmp    rcx,0x20
 1016c55:	jb     1016dbd <lyr_w1_coerce_loopStruct+0x1dd>
 1016c5b:	lea    rcx,[rax+0x20]
 1016c5f:	mov    QWORD PTR fs:[rbx],rcx
 1016c63:	test   rax,rax
 1016c66:	je     1016dbd <lyr_w1_coerce_loopStruct+0x1dd>
 1016c6c:	mov    QWORD PTR [rax],r9
 1016c6f:	mov    ecx,r13d
 1016c72:	and    ecx,0xf
 1016c75:	mov    QWORD PTR [rax+0x8],r13
 1016c79:	mov    QWORD PTR [rax+0x10],r13
 1016c7d:	mov    rsi,QWORD PTR [rdi+0x8]
 1016c81:	cmp    rcx,rsi
 1016c84:	jae    1016dfd <lyr_w1_coerce_loopStruct+0x21d>
 1016c8a:	shl    ecx,0x4
 1016c8d:	lea    r8,[r14+rcx*1]
 1016c91:	mov    QWORD PTR [r14+rcx*1],rax
 1016c95:	lea    rax,[rip+0x2569c]        # 103c338 <lyr_vt_17_w1_coerce_HeapRef_15_w1_coerce_Small>
 1016c9c:	mov    QWORD PTR [r14+rcx*1+0x8],rax
 1016ca1:	lea    rax,[rip+0x2b8d8]        # 1042580 <lyr_gc_heap_base>
 1016ca8:	mov    rdx,QWORD PTR [rax]
 1016cab:	sub    r8,rdx
 1016cae:	lea    rax,[rip+0x2b8d3]        # 1042588 <lyr_gc_heap_span>
 1016cb5:	cmp    r8,QWORD PTR [rax]
 1016cb8:	jae    1016c30 <lyr_w1_coerce_loopStruct+0x50>
 1016cbe:	mov    rax,r8
 1016cc1:	shr    rax,0x8
 1016cc5:	add    r8,0xf
 1016cc9:	shr    r8,0x8
 1016ccd:	mov    rsi,r8
 1016cd0:	sub    rsi,rax
 1016cd3:	jb     1016c30 <lyr_w1_coerce_loopStruct+0x50>
 1016cd9:	mov    ecx,r13d
 1016cdc:	and    ecx,0xf
 1016cdf:	shl    ecx,0x4
 1016ce2:	sub    r8d,eax
 1016ce5:	inc    r8d
 1016ce8:	test   r8b,0x3
 1016cec:	je     1016d30 <lyr_w1_coerce_loopStruct+0x150>
 1016cee:	lea    r8d,[r11+rcx*1]
 1016cf2:	sub    r8d,edx
 1016cf5:	shr    r8d,0x8
 1016cf9:	lea    r9d,[r14+rcx*1]
 1016cfd:	sub    r9d,edx
 1016d00:	shr    r9d,0x8
 1016d04:	sub    r8b,r9b
 1016d07:	inc    r8b
 1016d0a:	movzx  r8d,r8b
 1016d0e:	and    r8d,0x3
 1016d12:	neg    r8
 1016d15:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 1016d20:	mov    r9,QWORD PTR [r15]
 1016d23:	mov    BYTE PTR [r9+rax*1],0x1
 1016d28:	inc    rax
 1016d2b:	inc    r8
 1016d2e:	jne    1016d20 <lyr_w1_coerce_loopStruct+0x140>
 1016d30:	cmp    rsi,0x3
 1016d34:	lea    r9,[rip+0x25535]        # 103c270 <lyr_desc_box_ty_w1_coerce_Small>
 1016d3b:	jb     1016c30 <lyr_w1_coerce_loopStruct+0x50>
 1016d41:	add    rcx,r11
 1016d44:	sub    rcx,rdx
 1016d47:	shr    rcx,0x8
 1016d4b:	inc    rcx
 1016d4e:	xchg   ax,ax
 1016d50:	mov    rdx,QWORD PTR [r15]
 1016d53:	mov    BYTE PTR [rdx+rax*1],0x1
 1016d57:	mov    rdx,QWORD PTR [r15]
 1016d5a:	mov    BYTE PTR [rdx+rax*1+0x1],0x1
 1016d5f:	mov    rdx,QWORD PTR [r15]
 1016d62:	mov    BYTE PTR [rdx+rax*1+0x2],0x1
 1016d67:	mov    rdx,QWORD PTR [r15]
 1016d6a:	mov    BYTE PTR [rdx+rax*1+0x3],0x1
 1016d6f:	add    rax,0x4
 1016d73:	cmp    rcx,rax
 1016d76:	jne    1016d50 <lyr_w1_coerce_loopStruct+0x170>
 1016d78:	jmp    1016c30 <lyr_w1_coerce_loopStruct+0x50>
 1016d7d:	lea    rax,[rip+0x2b7c4]        # 1042548 <lyr_gc_stop_requested>
 1016d84:	mov    eax,DWORD PTR [rax]
 1016d86:	mov    r12d,0x400
 1016d8c:	test   eax,eax
 1016d8e:	je     1016c3c <lyr_w1_coerce_loopStruct+0x5c>
 1016d94:	mov    QWORD PTR [rbp-0x40],rdi
 1016d98:	mov    QWORD PTR [rbp-0x38],r10
 1016d9c:	mov    QWORD PTR [rbp-0x30],r11
 1016da0:	call   101e9e0 <lyr_gc_safepoint_slow>
 1016da5:	lea    r9,[rip+0x254c4]        # 103c270 <lyr_desc_box_ty_w1_coerce_Small>
 1016dac:	mov    r11,QWORD PTR [rbp-0x30]
 1016db0:	mov    r10,QWORD PTR [rbp-0x38]
 1016db4:	mov    rdi,QWORD PTR [rbp-0x40]
 1016db8:	jmp    1016c3c <lyr_w1_coerce_loopStruct+0x5c>
 1016dbd:	mov    esi,0x18
 1016dc2:	mov    QWORD PTR [rbp-0x40],rdi
 1016dc6:	mov    rdi,r9
 1016dc9:	mov    QWORD PTR [rbp-0x38],r10
 1016dcd:	mov    QWORD PTR [rbp-0x30],r11
 1016dd1:	call   101df80 <lyr_gc_alloc_slow>
 1016dd6:	lea    r9,[rip+0x25493]        # 103c270 <lyr_desc_box_ty_w1_coerce_Small>
 1016ddd:	mov    r11,QWORD PTR [rbp-0x30]
 1016de1:	mov    r10,QWORD PTR [rbp-0x38]
 1016de5:	mov    rdi,QWORD PTR [rbp-0x40]
 1016de9:	jmp    1016c6f <lyr_w1_coerce_loopStruct+0x8f>
 1016dee:	add    rsp,0x18
 1016df2:	pop    rbx
 1016df3:	pop    r12
 1016df5:	pop    r13
 1016df7:	pop    r14
 1016df9:	pop    r15
 1016dfb:	pop    rbp
 1016dfc:	ret
 1016dfd:	mov    rdi,rcx
 1016e00:	call   1024b88 <lyr_panic_index>

