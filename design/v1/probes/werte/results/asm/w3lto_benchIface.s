000000000101dab0 <lyr_w3_map_benchIface>:
 101dab0:	push   rbp
 101dab1:	mov    rbp,rsp
 101dab4:	push   r15
 101dab6:	push   r14
 101dab8:	push   r13
 101daba:	push   r12
 101dabc:	push   rbx
 101dabd:	sub    rsp,0x48
 101dac1:	mov    r15,rsi
 101dac4:	mov    r14,rdi
 101dac7:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101dad0:	cmp    rax,rbp
 101dad3:	ja     101dd52 <lyr_w3_map_benchIface+0x2a2>
 101dad9:	mov    rax,QWORD PTR [r15+0x8]
 101dadd:	dec    rax
 101dae0:	mov    QWORD PTR [rbp-0x60],rax
 101dae4:	jo     101dd65 <lyr_w3_map_benchIface+0x2b5>
 101daea:	lea    rax,[r15+0x10]
 101daee:	mov    QWORD PTR [rbp-0x58],rax
 101daf2:	mov    rax,rdx
 101daf5:	sar    rax,0x3f
 101daf9:	andn   rax,rax,rdx
 101dafe:	mov    QWORD PTR [rbp-0x68],rax
 101db02:	mov    edx,0x400
 101db07:	xor    ecx,ecx
 101db09:	mov    QWORD PTR [rbp-0x48],0x0
 101db11:	mov    QWORD PTR [rbp-0x50],0x0
 101db19:	mov    QWORD PTR [rbp-0x38],r15
 101db1d:	jmp    101db2e <lyr_w3_map_benchIface+0x7e>
 101db1f:	nop
 101db20:	mov    r15,QWORD PTR [rbp-0x38]
 101db24:	mov    rcx,QWORD PTR [rbp-0x40]
 101db28:	mov    edx,DWORD PTR [rbp-0x2c]
 101db2b:	inc    rcx
 101db2e:	dec    edx
 101db30:	je     101dcc3 <lyr_w3_map_benchIface+0x213>
 101db36:	cmp    rcx,QWORD PTR [rbp-0x68]
 101db3a:	je     101dd18 <lyr_w3_map_benchIface+0x268>
 101db40:	mov    rdi,rcx
 101db43:	and    rdi,QWORD PTR [rbp-0x60]
 101db47:	mov    rsi,QWORD PTR [r15+0x8]
 101db4b:	cmp    rdi,rsi
 101db4e:	jae    101dd43 <lyr_w3_map_benchIface+0x293>
 101db54:	mov    DWORD PTR [rbp-0x2c],edx
 101db57:	mov    QWORD PTR [rbp-0x40],rcx
 101db5b:	shl    rdi,0x4
 101db5f:	mov    rax,QWORD PTR [rbp-0x58]
 101db63:	mov    rbx,QWORD PTR [rax+rdi*1]
 101db67:	mov    r13,QWORD PTR [rax+rdi*1+0x8]
 101db6c:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101db75:	cmp    rax,rbp
 101db78:	ja     101dd03 <lyr_w3_map_benchIface+0x253>
 101db7e:	mov    QWORD PTR [rbp-0x70],rbx
 101db82:	mov    rdi,rbx
 101db85:	mov    rsi,r13
 101db88:	call   QWORD PTR [r13+0x8]
 101db8c:	mov    r15,rax
 101db8f:	or     r15,0x1
 101db93:	mov    rbx,QWORD PTR [r14+0x20]
 101db97:	and    rbx,r15
 101db9a:	mov    r12d,0x400
 101dba0:	dec    r12d
 101dba3:	jne    101dbe0 <lyr_w3_map_benchIface+0x130>
 101dba5:	mov    eax,DWORD PTR [rip+0x27d15]        # 10458c0 <lyr_gc_stop_requested>
 101dbab:	mov    r12d,0x400
 101dbb1:	test   eax,eax
 101dbb3:	je     101dbe0 <lyr_w3_map_benchIface+0x130>
 101dbb5:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101dbbe:	test   rdi,rdi
 101dbc1:	je     101dbe0 <lyr_w3_map_benchIface+0x130>
 101dbc3:	mov    eax,DWORD PTR [rip+0x27cf7]        # 10458c0 <lyr_gc_stop_requested>
 101dbc9:	test   eax,eax
 101dbcb:	je     101dbe0 <lyr_w3_map_benchIface+0x130>
 101dbcd:	call   1026760 <park_here.llvm.8023764427486792703>
 101dbd2:	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 101dbe0:	mov    rax,QWORD PTR [r14+0x10]
 101dbe4:	mov    rsi,QWORD PTR [rax+0x8]
 101dbe8:	cmp    rbx,rsi
 101dbeb:	jae    101dd40 <lyr_w3_map_benchIface+0x290>
 101dbf1:	mov    rax,QWORD PTR [rax+rbx*8+0x10]
 101dbf6:	test   rax,rax
 101dbf9:	je     101db20 <lyr_w3_map_benchIface+0x70>
 101dbff:	cmp    rax,r15
 101dc02:	jne    101dc34 <lyr_w3_map_benchIface+0x184>
 101dc04:	mov    rax,QWORD PTR [r14+0x8]
 101dc08:	mov    rsi,QWORD PTR [rax+0x8]
 101dc0c:	cmp    rbx,rsi
 101dc0f:	jae    101dd40 <lyr_w3_map_benchIface+0x290>
 101dc15:	mov    rcx,rbx
 101dc18:	shl    rcx,0x4
 101dc1c:	mov    rdi,QWORD PTR [rax+rcx*1+0x10]
 101dc21:	mov    rsi,QWORD PTR [rax+rcx*1+0x18]
 101dc26:	mov    rdx,QWORD PTR [rbp-0x70]
 101dc2a:	mov    rcx,r13
 101dc2d:	call   QWORD PTR [rsi+0x10]
 101dc30:	test   al,al
 101dc32:	jne    101dc80 <lyr_w3_map_benchIface+0x1d0>
 101dc34:	dec    r12d
 101dc37:	je     101dc50 <lyr_w3_map_benchIface+0x1a0>
 101dc39:	inc    rbx
 101dc3c:	jo     101dd48 <lyr_w3_map_benchIface+0x298>
 101dc42:	and    rbx,QWORD PTR [r14+0x20]
 101dc46:	dec    r12d
 101dc49:	jne    101dbe0 <lyr_w3_map_benchIface+0x130>
 101dc4b:	jmp    101dba5 <lyr_w3_map_benchIface+0xf5>
 101dc50:	mov    eax,DWORD PTR [rip+0x27c6a]        # 10458c0 <lyr_gc_stop_requested>
 101dc56:	mov    r12d,0x400
 101dc5c:	test   eax,eax
 101dc5e:	je     101dc39 <lyr_w3_map_benchIface+0x189>
 101dc60:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101dc69:	test   rdi,rdi
 101dc6c:	je     101dc39 <lyr_w3_map_benchIface+0x189>
 101dc6e:	mov    eax,DWORD PTR [rip+0x27c4c]        # 10458c0 <lyr_gc_stop_requested>
 101dc74:	test   eax,eax
 101dc76:	je     101dc39 <lyr_w3_map_benchIface+0x189>
 101dc78:	call   1026760 <park_here.llvm.8023764427486792703>
 101dc7d:	jmp    101dc39 <lyr_w3_map_benchIface+0x189>
 101dc7f:	nop
 101dc80:	mov    rax,QWORD PTR [r14+0x18]
 101dc84:	mov    rsi,QWORD PTR [rax+0x8]
 101dc88:	cmp    rbx,rsi
 101dc8b:	jae    101dd40 <lyr_w3_map_benchIface+0x290>
 101dc91:	mov    rax,QWORD PTR [rax+rbx*8+0x10]
 101dc96:	test   rax,rax
 101dc99:	js     101db20 <lyr_w3_map_benchIface+0x70>
 101dc9f:	add    QWORD PTR [rbp-0x50],rax
 101dca3:	mov    r15,QWORD PTR [rbp-0x38]
 101dca7:	mov    rcx,QWORD PTR [rbp-0x40]
 101dcab:	mov    edx,DWORD PTR [rbp-0x2c]
 101dcae:	jo     101dd48 <lyr_w3_map_benchIface+0x298>
 101dcb4:	inc    QWORD PTR [rbp-0x48]
 101dcb8:	jno    101db2b <lyr_w3_map_benchIface+0x7b>
 101dcbe:	jmp    101dd48 <lyr_w3_map_benchIface+0x298>
 101dcc3:	mov    eax,DWORD PTR [rip+0x27bf7]        # 10458c0 <lyr_gc_stop_requested>
 101dcc9:	mov    edx,0x400
 101dcce:	test   eax,eax
 101dcd0:	je     101db36 <lyr_w3_map_benchIface+0x86>
 101dcd6:	mov    rbx,rcx
 101dcd9:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101dce2:	test   rdi,rdi
 101dce5:	je     101dd10 <lyr_w3_map_benchIface+0x260>
 101dce7:	mov    eax,DWORD PTR [rip+0x27bd3]        # 10458c0 <lyr_gc_stop_requested>
 101dced:	test   eax,eax
 101dcef:	je     101dd10 <lyr_w3_map_benchIface+0x260>
 101dcf1:	call   1026760 <park_here.llvm.8023764427486792703>
 101dcf6:	mov    rcx,rbx
 101dcf9:	mov    edx,0x400
 101dcfe:	jmp    101db36 <lyr_w3_map_benchIface+0x86>
 101dd03:	mov    rdi,rbp
 101dd06:	call   1026790 <lyr_gc_stack_slow>
 101dd0b:	jmp    101db7e <lyr_w3_map_benchIface+0xce>
 101dd10:	mov    rcx,rbx
 101dd13:	jmp    101db36 <lyr_w3_map_benchIface+0x86>
 101dd18:	mov    rcx,QWORD PTR [rbp-0x48]
 101dd1c:	movsxd rax,ecx
 101dd1f:	cmp    rax,rcx
 101dd22:	jne    101dd6f <lyr_w3_map_benchIface+0x2bf>
 101dd24:	shl    rcx,0x20
 101dd28:	mov    rax,QWORD PTR [rbp-0x50]
 101dd2c:	add    rax,rcx
 101dd2f:	jo     101dd48 <lyr_w3_map_benchIface+0x298>
 101dd31:	add    rsp,0x48
 101dd35:	pop    rbx
 101dd36:	pop    r12
 101dd38:	pop    r13
 101dd3a:	pop    r14
 101dd3c:	pop    r15
 101dd3e:	pop    rbp
 101dd3f:	ret
 101dd40:	mov    rdi,rbx
 101dd43:	call   102bafc <lyr_panic_index>
 101dd48:	mov    edi,0x1002fe0
 101dd4d:	call   102bb35 <lyr_panic_overflow>
 101dd52:	mov    rdi,rbp
 101dd55:	mov    rbx,rdx
 101dd58:	call   1026790 <lyr_gc_stack_slow>
 101dd5d:	mov    rdx,rbx
 101dd60:	jmp    101dad9 <lyr_w3_map_benchIface+0x29>
 101dd65:	mov    edi,0x1002fde
 101dd6a:	call   102bb35 <lyr_panic_overflow>
 101dd6f:	mov    edi,0x1002fe2
 101dd74:	call   102bb35 <lyr_panic_overflow>

