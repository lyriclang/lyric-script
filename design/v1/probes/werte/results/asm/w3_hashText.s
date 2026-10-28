000000000101edf0 <lyr_std_core_hashText_w3_map_Fx__be0ed00d>:
 101edf0:	push   rbp
 101edf1:	mov    rbp,rsp
 101edf4:	push   r15
 101edf6:	push   r14
 101edf8:	push   r13
 101edfa:	push   r12
 101edfc:	push   rbx
 101edfd:	push   rax
 101edfe:	mov    QWORD PTR [rbp-0x30],rdx
 101ee02:	mov    rbx,rsi
 101ee05:	mov    r15,rdi
 101ee08:	mov    rax,0xffffffffffffffe0
 101ee0f:	mov    rax,QWORD PTR fs:[rax+0x10]
 101ee14:	cmp    rax,rbp
 101ee17:	ja     101ef0d <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x11d>
 101ee1d:	mov    r13d,0x400
 101ee23:	xor    r14d,r14d
 101ee26:	dec    r13d
 101ee29:	je     101ee71 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x81>
 101ee2b:	nop    DWORD PTR [rax+rax*1+0x0]
 101ee30:	mov    r12,r14
 101ee33:	add    r12,0x8
 101ee37:	jo     101eef6 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x106>
 101ee3d:	cmp    r12,rbx
 101ee40:	jg     101eed0 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0xe0>
 101ee46:	cmp    r14,rbx
 101ee49:	jae    101ef02 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x112>
 101ee4f:	lea    rdi,[r14+0x7]
 101ee53:	cmp    rdi,rbx
 101ee56:	jae    101ef05 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x115>
 101ee5c:	mov    rsi,QWORD PTR [r15+r14*1]
 101ee60:	mov    rdi,QWORD PTR [rbp-0x30]
 101ee64:	call   101ac30 <lyr_w3_map_Fx_writeUint>
 101ee69:	mov    r14,r12
 101ee6c:	dec    r13d
 101ee6f:	jne    101ee30 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x40>
 101ee71:	lea    rax,[rip+0x256f0]        # 1044568 <lyr_gc_stop_requested>
 101ee78:	mov    eax,DWORD PTR [rax]
 101ee7a:	mov    r13d,0x400
 101ee80:	test   eax,eax
 101ee82:	je     101ee30 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x40>
 101ee84:	call   1020ce0 <lyr_gc_safepoint_slow>
 101ee89:	jmp    101ee30 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x40>
 101ee8b:	nop    DWORD PTR [rax+rax*1+0x0]
 101ee90:	jae    101ef02 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x112>
 101ee92:	movzx  esi,BYTE PTR [r15+r14*1]
 101ee97:	mov    rdi,QWORD PTR [rbp-0x30]
 101ee9b:	call   101ac00 <lyr_w3_map_Fx_writeByte>
 101eea0:	inc    r14
 101eea3:	jno    101eed0 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0xe0>
 101eea5:	jmp    101eef6 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x106>
 101eea7:	lea    rax,[rip+0x256ba]        # 1044568 <lyr_gc_stop_requested>
 101eeae:	mov    eax,DWORD PTR [rax]
 101eeb0:	mov    r13d,0x400
 101eeb6:	test   eax,eax
 101eeb8:	je     101eed5 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0xe5>
 101eeba:	call   1020ce0 <lyr_gc_safepoint_slow>
 101eebf:	jmp    101eed5 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0xe5>
 101eec1:	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 101eed0:	dec    r13d
 101eed3:	je     101eea7 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0xb7>
 101eed5:	cmp    r14,rbx
 101eed8:	jl     101ee90 <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0xa0>
 101eeda:	mov    rdi,QWORD PTR [rbp-0x30]
 101eede:	mov    esi,0xff
 101eee3:	add    rsp,0x8
 101eee7:	pop    rbx
 101eee8:	pop    r12
 101eeea:	pop    r13
 101eeec:	pop    r14
 101eeee:	pop    r15
 101eef0:	pop    rbp
 101eef1:	jmp    101ac00 <lyr_w3_map_Fx_writeByte>
 101eef6:	lea    rdi,[rip+0xfffffffffffe3b61]        # 1002a5e <lyr_refmap_ty_w3_map_TableMono+0x119e>
 101eefd:	call   1026ac9 <lyr_panic_overflow>
 101ef02:	mov    rdi,r14
 101ef05:	mov    rsi,rbx
 101ef08:	call   1026a88 <lyr_panic_index>
 101ef0d:	mov    rdi,rbp
 101ef10:	call   1020d50 <lyr_gc_stack_slow>
 101ef15:	jmp    101ee1d <lyr_std_core_hashText_w3_map_Fx__be0ed00d+0x2d>

