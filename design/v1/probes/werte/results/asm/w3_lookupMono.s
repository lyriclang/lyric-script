0000000001016ad0 <lyr_w3_map_lookupMono>:
 1016ad0:	push   rbp
 1016ad1:	mov    rbp,rsp
 1016ad4:	push   r15
 1016ad6:	push   r14
 1016ad8:	push   r13
 1016ada:	push   r12
 1016adc:	push   rbx
 1016add:	push   rax
 1016ade:	mov    r14,rsi
 1016ae1:	mov    rbx,rdi
 1016ae4:	mov    r15,0xffffffffffffffe0
 1016aeb:	mov    rax,QWORD PTR fs:[r15+0x10]
 1016af0:	cmp    rax,rbp
 1016af3:	ja     1016c27 <lyr_w3_map_lookupMono+0x157>
 1016af9:	mov    rax,QWORD PTR fs:[r15+0x10]
 1016afe:	cmp    rax,rbp
 1016b01:	ja     1016c34 <lyr_w3_map_lookupMono+0x164>
 1016b07:	mov    QWORD PTR [rbp-0x30],0x0
 1016b0f:	mov    rsi,QWORD PTR [r14+0x8]
 1016b13:	lea    rdi,[r14+0x10]
 1016b17:	lea    rdx,[rbp-0x30]
 1016b1b:	call   101edf0 <lyr_std_core_hashText_w3_map_Fx__be0ed00d>
 1016b20:	mov    rax,QWORD PTR [rbp-0x30]
 1016b24:	mov    rcx,rax
 1016b27:	shr    rcx,0x1d
 1016b2b:	xor    rcx,rax
 1016b2e:	movabs rax,0xbf58476d1ce4e5b9
 1016b38:	imul   rax,rcx
 1016b3c:	mov    r12,rax
 1016b3f:	shr    r12,0x20
 1016b43:	xor    r12,rax
 1016b46:	or     r12,0x1
 1016b4a:	mov    r15,QWORD PTR [rbx+0x20]
 1016b4e:	and    r15,r12
 1016b51:	mov    r13d,0x400
 1016b57:	dec    r13d
 1016b5a:	je     1016bb5 <lyr_w3_map_lookupMono+0xe5>
 1016b5c:	nop    DWORD PTR [rax+0x0]
 1016b60:	mov    rax,QWORD PTR [rbx+0x10]
 1016b64:	mov    rsi,QWORD PTR [rax+0x8]
 1016b68:	cmp    r15,rsi
 1016b6b:	jae    1016c13 <lyr_w3_map_lookupMono+0x143>
 1016b71:	mov    rax,QWORD PTR [rax+r15*8+0x10]
 1016b76:	test   rax,rax
 1016b79:	je     1016be9 <lyr_w3_map_lookupMono+0x119>
 1016b7b:	cmp    rax,r12
 1016b7e:	jne    1016ba2 <lyr_w3_map_lookupMono+0xd2>
 1016b80:	mov    rax,QWORD PTR [rbx+0x8]
 1016b84:	mov    rsi,QWORD PTR [rax+0x8]
 1016b88:	cmp    r15,rsi
 1016b8b:	jae    1016c13 <lyr_w3_map_lookupMono+0x143>
 1016b91:	mov    rdi,QWORD PTR [rax+r15*8+0x10]
 1016b96:	mov    rsi,r14
 1016b99:	call   1026d90 <lyr_str_eq>
 1016b9e:	test   al,al
 1016ba0:	jne    1016bf2 <lyr_w3_map_lookupMono+0x122>
 1016ba2:	dec    r13d
 1016ba5:	je     1016bcf <lyr_w3_map_lookupMono+0xff>
 1016ba7:	inc    r15
 1016baa:	jo     1016c1b <lyr_w3_map_lookupMono+0x14b>
 1016bac:	and    r15,QWORD PTR [rbx+0x20]
 1016bb0:	dec    r13d
 1016bb3:	jne    1016b60 <lyr_w3_map_lookupMono+0x90>
 1016bb5:	lea    rax,[rip+0x2d9ac]        # 1044568 <lyr_gc_stop_requested>
 1016bbc:	mov    eax,DWORD PTR [rax]
 1016bbe:	mov    r13d,0x400
 1016bc4:	test   eax,eax
 1016bc6:	je     1016b60 <lyr_w3_map_lookupMono+0x90>
 1016bc8:	call   1020ce0 <lyr_gc_safepoint_slow>
 1016bcd:	jmp    1016b60 <lyr_w3_map_lookupMono+0x90>
 1016bcf:	lea    rax,[rip+0x2d992]        # 1044568 <lyr_gc_stop_requested>
 1016bd6:	mov    eax,DWORD PTR [rax]
 1016bd8:	mov    r13d,0x400
 1016bde:	test   eax,eax
 1016be0:	je     1016ba7 <lyr_w3_map_lookupMono+0xd7>
 1016be2:	call   1020ce0 <lyr_gc_safepoint_slow>
 1016be7:	jmp    1016ba7 <lyr_w3_map_lookupMono+0xd7>
 1016be9:	mov    rax,0xffffffffffffffff
 1016bf0:	jmp    1016c04 <lyr_w3_map_lookupMono+0x134>
 1016bf2:	mov    rax,QWORD PTR [rbx+0x18]
 1016bf6:	mov    rsi,QWORD PTR [rax+0x8]
 1016bfa:	cmp    r15,rsi
 1016bfd:	jae    1016c13 <lyr_w3_map_lookupMono+0x143>
 1016bff:	mov    rax,QWORD PTR [rax+r15*8+0x10]
 1016c04:	add    rsp,0x8
 1016c08:	pop    rbx
 1016c09:	pop    r12
 1016c0b:	pop    r13
 1016c0d:	pop    r14
 1016c0f:	pop    r15
 1016c11:	pop    rbp
 1016c12:	ret
 1016c13:	mov    rdi,r15
 1016c16:	call   1026a88 <lyr_panic_index>
 1016c1b:	lea    rdi,[rip+0xfffffffffffebe3c]        # 1002a5e <lyr_refmap_ty_w3_map_TableMono+0x119e>
 1016c22:	call   1026ac9 <lyr_panic_overflow>
 1016c27:	mov    rdi,rbp
 1016c2a:	call   1020d50 <lyr_gc_stack_slow>
 1016c2f:	jmp    1016af9 <lyr_w3_map_lookupMono+0x29>
 1016c34:	mov    rdi,rbp
 1016c37:	call   1020d50 <lyr_gc_stack_slow>
 1016c3c:	jmp    1016b07 <lyr_w3_map_lookupMono+0x37>

