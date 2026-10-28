0000000001016e10 <lyr_w1_coerce_loopInt>:
 1016e10:	push   rbp
 1016e11:	mov    rbp,rsp
 1016e14:	push   r15
 1016e16:	push   r14
 1016e18:	push   r13
 1016e1a:	push   r12
 1016e1c:	push   rbx
 1016e1d:	sub    rsp,0x18
 1016e21:	lea    r14,[rdi+0x10]
 1016e25:	mov    rax,rsi
 1016e28:	sar    rax,0x3f
 1016e2c:	andn   r10,rax,rsi
 1016e31:	lea    r11,[rdi+0x1f]
 1016e35:	mov    r12d,0x400
 1016e3b:	xor    r13d,r13d
 1016e3e:	mov    rbx,0xffffffffffffffe0
 1016e45:	lea    r9,[rip+0x2544c]        # 103c298 <lyr_desc_box_ty_0_box_int__fd9dbe7f>
 1016e4c:	lea    r15,[rip+0x2b715]        # 1042568 <lyr_gc_cards>
 1016e53:	jmp    1016e63 <lyr_w1_coerce_loopInt+0x53>
 1016e55:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 1016e60:	inc    r13
 1016e63:	dec    r12d
 1016e66:	je     1016fad <lyr_w1_coerce_loopInt+0x19d>
 1016e6c:	cmp    r13,r10
 1016e6f:	je     101701e <lyr_w1_coerce_loopInt+0x20e>
 1016e75:	mov    rax,QWORD PTR fs:[rbx]
 1016e79:	mov    rcx,QWORD PTR fs:[rbx+0x8]
 1016e7e:	sub    rcx,rax
 1016e81:	cmp    rcx,0x10
 1016e85:	jb     1016fed <lyr_w1_coerce_loopInt+0x1dd>
 1016e8b:	lea    rcx,[rax+0x10]
 1016e8f:	mov    QWORD PTR fs:[rbx],rcx
 1016e93:	test   rax,rax
 1016e96:	je     1016fed <lyr_w1_coerce_loopInt+0x1dd>
 1016e9c:	mov    QWORD PTR [rax],r9
 1016e9f:	mov    ecx,r13d
 1016ea2:	and    ecx,0xf
 1016ea5:	mov    QWORD PTR [rax+0x8],r13
 1016ea9:	mov    rsi,QWORD PTR [rdi+0x8]
 1016ead:	cmp    rcx,rsi
 1016eb0:	jae    101702d <lyr_w1_coerce_loopInt+0x21d>
 1016eb6:	shl    ecx,0x4
 1016eb9:	lea    r8,[r14+rcx*1]
 1016ebd:	mov    QWORD PTR [r14+rcx*1],rax
 1016ec1:	lea    rax,[rip+0x25550]        # 103c418 <lyr_vt_17_w1_coerce_HeapRef_19_0_box_int__fd9dbe7f>
 1016ec8:	mov    QWORD PTR [r14+rcx*1+0x8],rax
 1016ecd:	lea    rax,[rip+0x2b6ac]        # 1042580 <lyr_gc_heap_base>
 1016ed4:	mov    rdx,QWORD PTR [rax]
 1016ed7:	sub    r8,rdx
 1016eda:	lea    rax,[rip+0x2b6a7]        # 1042588 <lyr_gc_heap_span>
 1016ee1:	cmp    r8,QWORD PTR [rax]
 1016ee4:	jae    1016e60 <lyr_w1_coerce_loopInt+0x50>
 1016eea:	mov    rax,r8
 1016eed:	shr    rax,0x8
 1016ef1:	add    r8,0xf
 1016ef5:	shr    r8,0x8
 1016ef9:	mov    rsi,r8
 1016efc:	sub    rsi,rax
 1016eff:	jb     1016e60 <lyr_w1_coerce_loopInt+0x50>
 1016f05:	mov    ecx,r13d
 1016f08:	and    ecx,0xf
 1016f0b:	shl    ecx,0x4
 1016f0e:	sub    r8d,eax
 1016f11:	inc    r8d
 1016f14:	test   r8b,0x3
 1016f18:	je     1016f60 <lyr_w1_coerce_loopInt+0x150>
 1016f1a:	lea    r8d,[r11+rcx*1]
 1016f1e:	sub    r8d,edx
 1016f21:	shr    r8d,0x8
 1016f25:	lea    r9d,[r14+rcx*1]
 1016f29:	sub    r9d,edx
 1016f2c:	shr    r9d,0x8
 1016f30:	sub    r8b,r9b
 1016f33:	inc    r8b
 1016f36:	movzx  r8d,r8b
 1016f3a:	and    r8d,0x3
 1016f3e:	neg    r8
 1016f41:	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 1016f50:	mov    r9,QWORD PTR [r15]
 1016f53:	mov    BYTE PTR [r9+rax*1],0x1
 1016f58:	inc    rax
 1016f5b:	inc    r8
 1016f5e:	jne    1016f50 <lyr_w1_coerce_loopInt+0x140>
 1016f60:	cmp    rsi,0x3
 1016f64:	lea    r9,[rip+0x2532d]        # 103c298 <lyr_desc_box_ty_0_box_int__fd9dbe7f>
 1016f6b:	jb     1016e60 <lyr_w1_coerce_loopInt+0x50>
 1016f71:	add    rcx,r11
 1016f74:	sub    rcx,rdx
 1016f77:	shr    rcx,0x8
 1016f7b:	inc    rcx
 1016f7e:	xchg   ax,ax
 1016f80:	mov    rdx,QWORD PTR [r15]
 1016f83:	mov    BYTE PTR [rdx+rax*1],0x1
 1016f87:	mov    rdx,QWORD PTR [r15]
 1016f8a:	mov    BYTE PTR [rdx+rax*1+0x1],0x1
 1016f8f:	mov    rdx,QWORD PTR [r15]
 1016f92:	mov    BYTE PTR [rdx+rax*1+0x2],0x1
 1016f97:	mov    rdx,QWORD PTR [r15]
 1016f9a:	mov    BYTE PTR [rdx+rax*1+0x3],0x1
 1016f9f:	add    rax,0x4
 1016fa3:	cmp    rcx,rax
 1016fa6:	jne    1016f80 <lyr_w1_coerce_loopInt+0x170>
 1016fa8:	jmp    1016e60 <lyr_w1_coerce_loopInt+0x50>
 1016fad:	lea    rax,[rip+0x2b594]        # 1042548 <lyr_gc_stop_requested>
 1016fb4:	mov    eax,DWORD PTR [rax]
 1016fb6:	mov    r12d,0x400
 1016fbc:	test   eax,eax
 1016fbe:	je     1016e6c <lyr_w1_coerce_loopInt+0x5c>
 1016fc4:	mov    QWORD PTR [rbp-0x40],rdi
 1016fc8:	mov    QWORD PTR [rbp-0x38],r10
 1016fcc:	mov    QWORD PTR [rbp-0x30],r11
 1016fd0:	call   101e9e0 <lyr_gc_safepoint_slow>
 1016fd5:	lea    r9,[rip+0x252bc]        # 103c298 <lyr_desc_box_ty_0_box_int__fd9dbe7f>
 1016fdc:	mov    r11,QWORD PTR [rbp-0x30]
 1016fe0:	mov    r10,QWORD PTR [rbp-0x38]
 1016fe4:	mov    rdi,QWORD PTR [rbp-0x40]
 1016fe8:	jmp    1016e6c <lyr_w1_coerce_loopInt+0x5c>
 1016fed:	mov    esi,0x10
 1016ff2:	mov    QWORD PTR [rbp-0x40],rdi
 1016ff6:	mov    rdi,r9
 1016ff9:	mov    QWORD PTR [rbp-0x38],r10
 1016ffd:	mov    QWORD PTR [rbp-0x30],r11
 1017001:	call   101df80 <lyr_gc_alloc_slow>
 1017006:	lea    r9,[rip+0x2528b]        # 103c298 <lyr_desc_box_ty_0_box_int__fd9dbe7f>
 101700d:	mov    r11,QWORD PTR [rbp-0x30]
 1017011:	mov    r10,QWORD PTR [rbp-0x38]
 1017015:	mov    rdi,QWORD PTR [rbp-0x40]
 1017019:	jmp    1016e9f <lyr_w1_coerce_loopInt+0x8f>
 101701e:	add    rsp,0x18
 1017022:	pop    rbx
 1017023:	pop    r12
 1017025:	pop    r13
 1017027:	pop    r14
 1017029:	pop    r15
 101702b:	pop    rbp
 101702c:	ret
 101702d:	mov    rdi,rcx
 1017030:	call   1024b88 <lyr_panic_index>

