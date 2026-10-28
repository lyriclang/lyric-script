0000000001016f00 <lyr_w3_map_lookupMbox>:
 1016f00:	push   rbp
 1016f01:	mov    rbp,rsp
 1016f04:	push   r15
 1016f06:	push   r14
 1016f08:	push   r13
 1016f0a:	push   r12
 1016f0c:	push   rbx
 1016f0d:	push   rax
 1016f0e:	mov    r14,rsi
 1016f11:	mov    rbx,rdi
 1016f14:	mov    r15,0xffffffffffffffe0
 1016f1b:	mov    rax,QWORD PTR fs:[r15+0x10]
 1016f20:	cmp    rax,rbp
 1016f23:	ja     101705c <lyr_w3_map_lookupMbox+0x15c>
 1016f29:	mov    rdi,QWORD PTR [r14+0x8]
 1016f2d:	mov    rax,QWORD PTR fs:[r15+0x10]
 1016f32:	cmp    rax,rbp
 1016f35:	ja     1017069 <lyr_w3_map_lookupMbox+0x169>
 1016f3b:	mov    QWORD PTR [rbp-0x30],0x0
 1016f43:	mov    rsi,QWORD PTR [rdi+0x8]
 1016f47:	add    rdi,0x10
 1016f4b:	lea    rdx,[rbp-0x30]
 1016f4f:	call   101edf0 <lyr_std_core_hashText_w3_map_Fx__be0ed00d>
 1016f54:	mov    rax,QWORD PTR [rbp-0x30]
 1016f58:	mov    rcx,rax
 1016f5b:	shr    rcx,0x1d
 1016f5f:	xor    rcx,rax
 1016f62:	movabs rax,0xbf58476d1ce4e5b9
 1016f6c:	imul   rax,rcx
 1016f70:	mov    r12,rax
 1016f73:	shr    r12,0x20
 1016f77:	xor    r12,rax
 1016f7a:	or     r12,0x1
 1016f7e:	mov    r15,QWORD PTR [rbx+0x20]
 1016f82:	and    r15,r12
 1016f85:	mov    r13d,0x400
 1016f8b:	dec    r13d
 1016f8e:	je     1016fea <lyr_w3_map_lookupMbox+0xea>
 1016f90:	mov    rax,QWORD PTR [rbx+0x10]
 1016f94:	mov    rsi,QWORD PTR [rax+0x8]
 1016f98:	cmp    r15,rsi
 1016f9b:	jae    1017048 <lyr_w3_map_lookupMbox+0x148>
 1016fa1:	mov    rax,QWORD PTR [rax+r15*8+0x10]
 1016fa6:	test   rax,rax
 1016fa9:	je     101701e <lyr_w3_map_lookupMbox+0x11e>
 1016fab:	cmp    rax,r12
 1016fae:	jne    1016fd7 <lyr_w3_map_lookupMbox+0xd7>
 1016fb0:	mov    rax,QWORD PTR [rbx+0x8]
 1016fb4:	mov    rsi,QWORD PTR [rax+0x8]
 1016fb8:	cmp    r15,rsi
 1016fbb:	jae    1017048 <lyr_w3_map_lookupMbox+0x148>
 1016fc1:	mov    rax,QWORD PTR [rax+r15*8+0x10]
 1016fc6:	mov    rdi,QWORD PTR [rax+0x8]
 1016fca:	mov    rsi,QWORD PTR [r14+0x8]
 1016fce:	call   1026d90 <lyr_str_eq>
 1016fd3:	test   al,al
 1016fd5:	jne    1017027 <lyr_w3_map_lookupMbox+0x127>
 1016fd7:	dec    r13d
 1016fda:	je     1017004 <lyr_w3_map_lookupMbox+0x104>
 1016fdc:	inc    r15
 1016fdf:	jo     1017050 <lyr_w3_map_lookupMbox+0x150>
 1016fe1:	and    r15,QWORD PTR [rbx+0x20]
 1016fe5:	dec    r13d
 1016fe8:	jne    1016f90 <lyr_w3_map_lookupMbox+0x90>
 1016fea:	lea    rax,[rip+0x2d577]        # 1044568 <lyr_gc_stop_requested>
 1016ff1:	mov    eax,DWORD PTR [rax]
 1016ff3:	mov    r13d,0x400
 1016ff9:	test   eax,eax
 1016ffb:	je     1016f90 <lyr_w3_map_lookupMbox+0x90>
 1016ffd:	call   1020ce0 <lyr_gc_safepoint_slow>
 1017002:	jmp    1016f90 <lyr_w3_map_lookupMbox+0x90>
 1017004:	lea    rax,[rip+0x2d55d]        # 1044568 <lyr_gc_stop_requested>
 101700b:	mov    eax,DWORD PTR [rax]
 101700d:	mov    r13d,0x400
 1017013:	test   eax,eax
 1017015:	je     1016fdc <lyr_w3_map_lookupMbox+0xdc>
 1017017:	call   1020ce0 <lyr_gc_safepoint_slow>
 101701c:	jmp    1016fdc <lyr_w3_map_lookupMbox+0xdc>
 101701e:	mov    rax,0xffffffffffffffff
 1017025:	jmp    1017039 <lyr_w3_map_lookupMbox+0x139>
 1017027:	mov    rax,QWORD PTR [rbx+0x18]
 101702b:	mov    rsi,QWORD PTR [rax+0x8]
 101702f:	cmp    r15,rsi
 1017032:	jae    1017048 <lyr_w3_map_lookupMbox+0x148>
 1017034:	mov    rax,QWORD PTR [rax+r15*8+0x10]
 1017039:	add    rsp,0x8
 101703d:	pop    rbx
 101703e:	pop    r12
 1017040:	pop    r13
 1017042:	pop    r14
 1017044:	pop    r15
 1017046:	pop    rbp
 1017047:	ret
 1017048:	mov    rdi,r15
 101704b:	call   1026a88 <lyr_panic_index>
 1017050:	lea    rdi,[rip+0xfffffffffffeba07]        # 1002a5e <lyr_refmap_ty_w3_map_TableMono+0x119e>
 1017057:	call   1026ac9 <lyr_panic_overflow>
 101705c:	mov    rdi,rbp
 101705f:	call   1020d50 <lyr_gc_stack_slow>
 1017064:	jmp    1016f29 <lyr_w3_map_lookupMbox+0x29>
 1017069:	mov    r15,rdi
 101706c:	mov    rdi,rbp
 101706f:	call   1020d50 <lyr_gc_stack_slow>
 1017074:	mov    rdi,r15
 1017077:	jmp    1016f3b <lyr_w3_map_lookupMbox+0x3b>

