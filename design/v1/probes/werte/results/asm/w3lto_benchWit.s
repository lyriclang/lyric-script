000000000101dd80 <lyr_w3_map_benchWit>:
 101dd80:	push   rbp
 101dd81:	mov    rbp,rsp
 101dd84:	push   r15
 101dd86:	push   r14
 101dd88:	push   r13
 101dd8a:	push   r12
 101dd8c:	push   rbx
 101dd8d:	sub    rsp,0x48
 101dd91:	mov    r15,rsi
 101dd94:	mov    r14,rdi
 101dd97:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101dda0:	cmp    rax,rbp
 101dda3:	ja     101e03e <lyr_w3_map_benchWit+0x2be>
 101dda9:	mov    rax,QWORD PTR [r15+0x8]
 101ddad:	dec    rax
 101ddb0:	mov    QWORD PTR [rbp-0x60],rax
 101ddb4:	jo     101e051 <lyr_w3_map_benchWit+0x2d1>
 101ddba:	lea    rax,[r15+0x10]
 101ddbe:	mov    QWORD PTR [rbp-0x58],rax
 101ddc2:	mov    rax,rdx
 101ddc5:	sar    rax,0x3f
 101ddc9:	andn   rax,rax,rdx
 101ddce:	mov    QWORD PTR [rbp-0x68],rax
 101ddd2:	mov    edx,0x400
 101ddd7:	xor    ecx,ecx
 101ddd9:	mov    QWORD PTR [rbp-0x48],0x0
 101dde1:	mov    QWORD PTR [rbp-0x50],0x0
 101dde9:	mov    QWORD PTR [rbp-0x38],r15
 101dded:	jmp    101ddfe <lyr_w3_map_benchWit+0x7e>
 101ddef:	nop
 101ddf0:	mov    r15,QWORD PTR [rbp-0x38]
 101ddf4:	mov    rcx,QWORD PTR [rbp-0x40]
 101ddf8:	mov    edx,DWORD PTR [rbp-0x2c]
 101ddfb:	inc    rcx
 101ddfe:	dec    edx
 101de00:	je     101dfa3 <lyr_w3_map_benchWit+0x223>
 101de06:	cmp    rcx,QWORD PTR [rbp-0x68]
 101de0a:	je     101e004 <lyr_w3_map_benchWit+0x284>
 101de10:	mov    rdi,rcx
 101de13:	and    rdi,QWORD PTR [rbp-0x60]
 101de17:	mov    rsi,QWORD PTR [r15+0x8]
 101de1b:	cmp    rdi,rsi
 101de1e:	jae    101e02f <lyr_w3_map_benchWit+0x2af>
 101de24:	mov    DWORD PTR [rbp-0x2c],edx
 101de27:	mov    QWORD PTR [rbp-0x40],rcx
 101de2b:	shl    rdi,0x4
 101de2f:	mov    rax,QWORD PTR [rbp-0x58]
 101de33:	mov    rdx,QWORD PTR [rax+rdi*1]
 101de37:	mov    rcx,QWORD PTR [rax+rdi*1+0x8]
 101de3c:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101de45:	cmp    rax,rbp
 101de48:	ja     101dfe3 <lyr_w3_map_benchWit+0x263>
 101de4e:	mov    rdi,QWORD PTR [r14+0x28]
 101de52:	mov    rsi,QWORD PTR [r14+0x30]
 101de56:	mov    QWORD PTR [rbp-0x70],rdx
 101de5a:	mov    r13,rcx
 101de5d:	call   QWORD PTR [rsi+0x8]
 101de60:	mov    r15,rax
 101de63:	or     r15,0x1
 101de67:	mov    rbx,QWORD PTR [r14+0x20]
 101de6b:	and    rbx,r15
 101de6e:	mov    r12d,0x400
 101de74:	dec    r12d
 101de77:	jne    101deb0 <lyr_w3_map_benchWit+0x130>
 101de79:	mov    eax,DWORD PTR [rip+0x27a41]        # 10458c0 <lyr_gc_stop_requested>
 101de7f:	mov    r12d,0x400
 101de85:	test   eax,eax
 101de87:	je     101deb0 <lyr_w3_map_benchWit+0x130>
 101de89:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101de92:	test   rdi,rdi
 101de95:	je     101deb0 <lyr_w3_map_benchWit+0x130>
 101de97:	mov    eax,DWORD PTR [rip+0x27a23]        # 10458c0 <lyr_gc_stop_requested>
 101de9d:	test   eax,eax
 101de9f:	je     101deb0 <lyr_w3_map_benchWit+0x130>
 101dea1:	call   1026760 <park_here.llvm.8023764427486792703>
 101dea6:	cs nop WORD PTR [rax+rax*1+0x0]
 101deb0:	mov    rax,QWORD PTR [r14+0x10]
 101deb4:	mov    rsi,QWORD PTR [rax+0x8]
 101deb8:	cmp    rbx,rsi
 101debb:	jae    101e02c <lyr_w3_map_benchWit+0x2ac>
 101dec1:	mov    rax,QWORD PTR [rax+rbx*8+0x10]
 101dec6:	test   rax,rax
 101dec9:	je     101ddf0 <lyr_w3_map_benchWit+0x70>
 101decf:	cmp    rax,r15
 101ded2:	jne    101df0c <lyr_w3_map_benchWit+0x18c>
 101ded4:	mov    rax,QWORD PTR [r14+0x8]
 101ded8:	mov    rsi,QWORD PTR [rax+0x8]
 101dedc:	cmp    rbx,rsi
 101dedf:	jae    101e02c <lyr_w3_map_benchWit+0x2ac>
 101dee5:	mov    rdi,QWORD PTR [r14+0x28]
 101dee9:	mov    rsi,QWORD PTR [r14+0x30]
 101deed:	mov    rcx,rbx
 101def0:	shl    rcx,0x4
 101def4:	mov    rdx,QWORD PTR [rax+rcx*1+0x10]
 101def9:	mov    rcx,QWORD PTR [rax+rcx*1+0x18]
 101defe:	mov    r8,QWORD PTR [rbp-0x70]
 101df02:	mov    r9,r13
 101df05:	call   QWORD PTR [rsi+0x10]
 101df08:	test   al,al
 101df0a:	jne    101df60 <lyr_w3_map_benchWit+0x1e0>
 101df0c:	dec    r12d
 101df0f:	je     101df28 <lyr_w3_map_benchWit+0x1a8>
 101df11:	inc    rbx
 101df14:	jo     101e034 <lyr_w3_map_benchWit+0x2b4>
 101df1a:	and    rbx,QWORD PTR [r14+0x20]
 101df1e:	dec    r12d
 101df21:	jne    101deb0 <lyr_w3_map_benchWit+0x130>
 101df23:	jmp    101de79 <lyr_w3_map_benchWit+0xf9>
 101df28:	mov    eax,DWORD PTR [rip+0x27992]        # 10458c0 <lyr_gc_stop_requested>
 101df2e:	mov    r12d,0x400
 101df34:	test   eax,eax
 101df36:	je     101df11 <lyr_w3_map_benchWit+0x191>
 101df38:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101df41:	test   rdi,rdi
 101df44:	je     101df11 <lyr_w3_map_benchWit+0x191>
 101df46:	mov    eax,DWORD PTR [rip+0x27974]        # 10458c0 <lyr_gc_stop_requested>
 101df4c:	test   eax,eax
 101df4e:	je     101df11 <lyr_w3_map_benchWit+0x191>
 101df50:	call   1026760 <park_here.llvm.8023764427486792703>
 101df55:	jmp    101df11 <lyr_w3_map_benchWit+0x191>
 101df57:	nop    WORD PTR [rax+rax*1+0x0]
 101df60:	mov    rax,QWORD PTR [r14+0x18]
 101df64:	mov    rsi,QWORD PTR [rax+0x8]
 101df68:	cmp    rbx,rsi
 101df6b:	jae    101e02c <lyr_w3_map_benchWit+0x2ac>
 101df71:	mov    rax,QWORD PTR [rax+rbx*8+0x10]
 101df76:	test   rax,rax
 101df79:	js     101ddf0 <lyr_w3_map_benchWit+0x70>
 101df7f:	add    QWORD PTR [rbp-0x50],rax
 101df83:	mov    r15,QWORD PTR [rbp-0x38]
 101df87:	mov    rcx,QWORD PTR [rbp-0x40]
 101df8b:	mov    edx,DWORD PTR [rbp-0x2c]
 101df8e:	jo     101e034 <lyr_w3_map_benchWit+0x2b4>
 101df94:	inc    QWORD PTR [rbp-0x48]
 101df98:	jno    101ddfb <lyr_w3_map_benchWit+0x7b>
 101df9e:	jmp    101e034 <lyr_w3_map_benchWit+0x2b4>
 101dfa3:	mov    eax,DWORD PTR [rip+0x27917]        # 10458c0 <lyr_gc_stop_requested>
 101dfa9:	mov    edx,0x400
 101dfae:	test   eax,eax
 101dfb0:	je     101de06 <lyr_w3_map_benchWit+0x86>
 101dfb6:	mov    rbx,rcx
 101dfb9:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101dfc2:	test   rdi,rdi
 101dfc5:	je     101dffc <lyr_w3_map_benchWit+0x27c>
 101dfc7:	mov    eax,DWORD PTR [rip+0x278f3]        # 10458c0 <lyr_gc_stop_requested>
 101dfcd:	test   eax,eax
 101dfcf:	je     101dffc <lyr_w3_map_benchWit+0x27c>
 101dfd1:	call   1026760 <park_here.llvm.8023764427486792703>
 101dfd6:	mov    rcx,rbx
 101dfd9:	mov    edx,0x400
 101dfde:	jmp    101de06 <lyr_w3_map_benchWit+0x86>
 101dfe3:	mov    rdi,rbp
 101dfe6:	mov    rbx,rdx
 101dfe9:	mov    r15,rcx
 101dfec:	call   1026790 <lyr_gc_stack_slow>
 101dff1:	mov    rcx,r15
 101dff4:	mov    rdx,rbx
 101dff7:	jmp    101de4e <lyr_w3_map_benchWit+0xce>
 101dffc:	mov    rcx,rbx
 101dfff:	jmp    101de06 <lyr_w3_map_benchWit+0x86>
 101e004:	mov    rcx,QWORD PTR [rbp-0x48]
 101e008:	movsxd rax,ecx
 101e00b:	cmp    rax,rcx
 101e00e:	jne    101e05b <lyr_w3_map_benchWit+0x2db>
 101e010:	shl    rcx,0x20
 101e014:	mov    rax,QWORD PTR [rbp-0x50]
 101e018:	add    rax,rcx
 101e01b:	jo     101e034 <lyr_w3_map_benchWit+0x2b4>
 101e01d:	add    rsp,0x48
 101e021:	pop    rbx
 101e022:	pop    r12
 101e024:	pop    r13
 101e026:	pop    r14
 101e028:	pop    r15
 101e02a:	pop    rbp
 101e02b:	ret
 101e02c:	mov    rdi,rbx
 101e02f:	call   102bafc <lyr_panic_index>
 101e034:	mov    edi,0x1002fe0
 101e039:	call   102bb35 <lyr_panic_overflow>
 101e03e:	mov    rdi,rbp
 101e041:	mov    rbx,rdx
 101e044:	call   1026790 <lyr_gc_stack_slow>
 101e049:	mov    rdx,rbx
 101e04c:	jmp    101dda9 <lyr_w3_map_benchWit+0x29>
 101e051:	mov    edi,0x1002fde
 101e056:	call   102bb35 <lyr_panic_overflow>
 101e05b:	mov    edi,0x1002fe2
 101e060:	call   102bb35 <lyr_panic_overflow>

