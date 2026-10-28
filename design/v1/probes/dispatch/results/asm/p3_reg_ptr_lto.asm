000000000101aa60 <lyr_p3_reg_ptr_main>:
 101aa60:	push   rbp
 101aa61:	mov    rbp,rsp
 101aa64:	push   r15
 101aa66:	push   r14
 101aa68:	push   r13
 101aa6a:	push   r12
 101aa6c:	push   rbx
 101aa6d:	sub    rsp,0xf8
 101aa74:	mov    rbx,rbp
 101aa77:	lea    rdi,[rbp-0x2720]
 101aa7e:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101aa87:	cmp    rdi,rax
 101aa8a:	jb     101c9ac <lyr_p3_reg_ptr_main+0x1f4c>
 101aa90:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101aa99:	cmp    rax,rbx
 101aa9c:	ja     101c9b6 <lyr_p3_reg_ptr_main+0x1f56>
 101aaa2:	mov    QWORD PTR [rbp-0x50],rbx
 101aaa6:	mov    ebx,DWORD PTR [rip+0x2c33c]        # 1046de8 <config.llvm.5495021493128820629>
 101aaac:	mov    r14,QWORD PTR fs:0xffffffffffffffe8
 101aab5:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101aabe:	sub    rax,r14
 101aac1:	cmp    rax,0x10
 101aac5:	jb     101c97d <lyr_p3_reg_ptr_main+0x1f1d>
 101aacb:	lea    r15,[r14+0x10]
 101aacf:	mov    QWORD PTR fs:0xffffffffffffffe8,r15
 101aad8:	test   r14,r14
 101aadb:	je     101c97d <lyr_p3_reg_ptr_main+0x1f1d>
 101aae1:	mov    QWORD PTR [r14],0x10041c8
 101aae8:	mov    QWORD PTR [r14+0x8],0x0
 101aaf0:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101aaf9:	sub    rax,r15
 101aafc:	cmp    rax,0x30
 101ab00:	jb     101c99a <lyr_p3_reg_ptr_main+0x1f3a>
 101ab06:	lea    rax,[r15+0x30]
 101ab0a:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101ab13:	test   r15,r15
 101ab16:	je     101c99a <lyr_p3_reg_ptr_main+0x1f3a>
 101ab1c:	mov    QWORD PTR [r15],0x1003ad8
 101ab23:	lea    rax,[r15+0x8]
 101ab27:	mov    QWORD PTR [r15+0x8],r14
 101ab2b:	sub    rax,QWORD PTR [rip+0x24256]        # 103ed88 <lyr_gc_heap_base>
 101ab32:	cmp    rax,QWORD PTR [rip+0x24257]        # 103ed90 <lyr_gc_heap_span>
 101ab39:	jae    101ab4a <lyr_p3_reg_ptr_main+0xea>
 101ab3b:	mov    rcx,QWORD PTR [rip+0x24256]        # 103ed98 <lyr_gc_cards>
 101ab42:	shr    rax,0x8
 101ab46:	mov    BYTE PTR [rcx+rax*1],0x1
 101ab4a:	mov    eax,ebx
 101ab4c:	sar    eax,0x1f
 101ab4f:	andn   eax,eax,ebx
 101ab54:	mov    QWORD PTR [rbp-0x40],rax
 101ab58:	vpxor  xmm0,xmm0,xmm0
 101ab5c:	vmovdqu XMMWORD PTR [r15+0x10],xmm0
 101ab62:	mov    QWORD PTR [r15+0x20],0x0
 101ab6a:	mov    r13d,0x400
 101ab70:	xor    r12d,r12d
 101ab73:	mov    rbx,QWORD PTR [rbp-0x50]
 101ab77:	mov    QWORD PTR [rbp-0x48],r15
 101ab7b:	dec    r13d
 101ab7e:	jne    101abc0 <lyr_p3_reg_ptr_main+0x160>
 101ab80:	mov    eax,DWORD PTR [rip+0x23f3a]        # 103eac0 <lyr_gc_stop_requested>
 101ab86:	mov    r13d,0x400
 101ab8c:	test   eax,eax
 101ab8e:	je     101abc0 <lyr_p3_reg_ptr_main+0x160>
 101ab90:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101ab99:	test   rdi,rdi
 101ab9c:	je     101abad <lyr_p3_reg_ptr_main+0x14d>
 101ab9e:	mov    eax,DWORD PTR [rip+0x23f1c]        # 103eac0 <lyr_gc_stop_requested>
 101aba4:	test   eax,eax
 101aba6:	je     101abad <lyr_p3_reg_ptr_main+0x14d>
 101aba8:	call   101fa80 <park_here.llvm.8023764427486792703>
 101abad:	mov    rbx,QWORD PTR [rbp-0x50]
 101abb1:	mov    r15,QWORD PTR [rbp-0x48]
 101abb5:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 101abc0:	cmp    r12,QWORD PTR [rbp-0x40]
 101abc4:	je     101b1a3 <lyr_p3_reg_ptr_main+0x743>
 101abca:	mov    r14,QWORD PTR fs:0xffffffffffffffe8
 101abd3:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101abdc:	sub    rax,r14
 101abdf:	cmp    rax,0x10
 101abe3:	jb     101b0ec <lyr_p3_reg_ptr_main+0x68c>
 101abe9:	lea    rax,[r14+0x10]
 101abed:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101abf6:	test   r14,r14
 101abf9:	je     101b0ec <lyr_p3_reg_ptr_main+0x68c>
 101abff:	mov    QWORD PTR [r14],0x1003b00
 101ac06:	mov    QWORD PTR [r14+0x8],r12
 101ac0a:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101ac13:	cmp    rax,rbx
 101ac16:	ja     101b0fe <lyr_p3_reg_ptr_main+0x69e>
 101ac1c:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101ac25:	cmp    rax,rbx
 101ac28:	ja     101b10b <lyr_p3_reg_ptr_main+0x6ab>
 101ac2e:	mov    QWORD PTR [rbp-0x68],r14
 101ac32:	mov    DWORD PTR [rbp-0x38],r13d
 101ac36:	mov    QWORD PTR [rbp-0x58],r12
 101ac3a:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101ac43:	cmp    rax,rbx
 101ac46:	ja     101b118 <lyr_p3_reg_ptr_main+0x6b8>
 101ac4c:	vpxor  xmm0,xmm0,xmm0
 101ac50:	vmovdqu YMMWORD PTR [rbp-0x108],ymm0
 101ac58:	vmovdqu YMMWORD PTR [rbp-0x120],ymm0
 101ac60:	vpxor  xmm0,xmm0,xmm0
 101ac64:	vmovdqa XMMWORD PTR [rbp-0xc0],xmm0
 101ac6c:	mov    r14d,0x200
 101ac72:	mov    ecx,0x400
 101ac77:	nop    WORD PTR [rax+rax*1+0x0]
 101ac80:	dec    ecx
 101ac82:	je     101ad7d <lyr_p3_reg_ptr_main+0x31d>
 101ac88:	mov    DWORD PTR [rbp-0x30],ecx
 101ac8b:	mov    rsi,QWORD PTR fs:0xffffffffffffffe8
 101ac94:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101ac9d:	sub    rax,rsi
 101aca0:	cmp    rax,0x20
 101aca4:	jb     101ad68 <lyr_p3_reg_ptr_main+0x308>
 101acaa:	lea    rax,[rsi+0x20]
 101acae:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101acb7:	test   rsi,rsi
 101acba:	je     101ad68 <lyr_p3_reg_ptr_main+0x308>
 101acc0:	mov    QWORD PTR [rsi],0x1003ba8
 101acc7:	mov    QWORD PTR [rsi+0x8],0x1
 101accf:	mov    BYTE PTR [rsi+0x10],0x0
 101acd3:	mov    edi,0x1003ba8
 101acd8:	mov    rdx,r14
 101acdb:	vzeroupper
 101acde:	call   101e720 <lyr_arr_repeat>
 101ace3:	mov    r13,rax
 101ace6:	mov    r15,QWORD PTR [rax+0x8]
 101acea:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101acf3:	cmp    rax,rbx
 101acf6:	ja     101adbe <lyr_p3_reg_ptr_main+0x35e>
 101acfc:	mov    rax,QWORD PTR [rbp-0x68]
 101ad00:	mov    rax,QWORD PTR [rax+0x8]
 101ad04:	test   rax,rax
 101ad07:	js     101ae00 <lyr_p3_reg_ptr_main+0x3a0>
 101ad0d:	movsxd rcx,DWORD PTR [rip+0x2c0d4]        # 1046de8 <config.llvm.5495021493128820629>
 101ad14:	cmp    rax,rcx
 101ad17:	jge    101ae00 <lyr_p3_reg_ptr_main+0x3a0>
 101ad1d:	mov    rcx,QWORD PTR [rip+0x2c0cc]        # 1046df0 <config.llvm.5495021493128820629+0x8>
 101ad24:	mov    rbx,QWORD PTR [rcx+rax*8]
 101ad28:	mov    rdi,rbx
 101ad2b:	call   1037bd0 <strlen@plt>
 101ad30:	mov    r12,rax
 101ad33:	cmp    rax,r15
 101ad36:	jg     101ad47 <lyr_p3_reg_ptr_main+0x2e7>
 101ad38:	lea    rdi,[r13+0x10]
 101ad3c:	mov    rsi,rbx
 101ad3f:	mov    rdx,r12
 101ad42:	call   1037d30 <memcpy@plt>
 101ad47:	test   r12,r12
 101ad4a:	mov    rbx,QWORD PTR [rbp-0x50]
 101ad4e:	js     101ae0a <lyr_p3_reg_ptr_main+0x3aa>
 101ad54:	cmp    r12,r14
 101ad57:	mov    r14,r12
 101ad5a:	mov    ecx,DWORD PTR [rbp-0x30]
 101ad5d:	jg     101ac80 <lyr_p3_reg_ptr_main+0x220>
 101ad63:	jmp    101b060 <lyr_p3_reg_ptr_main+0x600>
 101ad68:	mov    edi,0x11
 101ad6d:	vzeroupper
 101ad70:	call   101f0f0 <allocate.llvm.8023764427486792703>
 101ad75:	mov    rsi,rax
 101ad78:	jmp    101acc0 <lyr_p3_reg_ptr_main+0x260>
 101ad7d:	mov    eax,DWORD PTR [rip+0x23d3d]        # 103eac0 <lyr_gc_stop_requested>
 101ad83:	mov    ecx,0x400
 101ad88:	test   eax,eax
 101ad8a:	je     101ac88 <lyr_p3_reg_ptr_main+0x228>
 101ad90:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101ad99:	test   rdi,rdi
 101ad9c:	je     101adf6 <lyr_p3_reg_ptr_main+0x396>
 101ad9e:	mov    eax,DWORD PTR [rip+0x23d1c]        # 103eac0 <lyr_gc_stop_requested>
 101ada4:	test   eax,eax
 101ada6:	je     101adf6 <lyr_p3_reg_ptr_main+0x396>
 101ada8:	vzeroupper
 101adab:	call   101fa80 <park_here.llvm.8023764427486792703>
 101adb0:	mov    rbx,QWORD PTR [rbp-0x50]
 101adb4:	mov    ecx,0x400
 101adb9:	jmp    101ac88 <lyr_p3_reg_ptr_main+0x228>
 101adbe:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101adc7:	test   rdi,rdi
 101adca:	je     101caf7 <lyr_p3_reg_ptr_main+0x2097>
 101add0:	mov    eax,DWORD PTR [rip+0x23cea]        # 103eac0 <lyr_gc_stop_requested>
 101add6:	test   eax,eax
 101add8:	je     101ade4 <lyr_p3_reg_ptr_main+0x384>
 101adda:	call   101fa80 <park_here.llvm.8023764427486792703>
 101addf:	jmp    101acfc <lyr_p3_reg_ptr_main+0x29c>
 101ade4:	cmp    QWORD PTR [rdi+0xb0],rbx
 101adeb:	jbe    101acfc <lyr_p3_reg_ptr_main+0x29c>
 101adf1:	jmp    101caf7 <lyr_p3_reg_ptr_main+0x2097>
 101adf6:	mov    rbx,QWORD PTR [rbp-0x50]
 101adfa:	jmp    101ac88 <lyr_p3_reg_ptr_main+0x228>
 101adff:	nop
 101ae00:	movabs r12,0xfffffffa00000000
 101ae0a:	neg    r12
 101ae0d:	mov    r13d,DWORD PTR [rbp-0x38]
 101ae11:	jo     101c966 <lyr_p3_reg_ptr_main+0x1f06>
 101ae17:	mov    rax,r12
 101ae1a:	sar    rax,0x20
 101ae1e:	dec    rax
 101ae21:	cmp    rax,0xf
 101ae25:	mov    ecx,0xf
 101ae2a:	cmovae rax,rcx
 101ae2e:	mov    ecx,r12d
 101ae31:	mov    edx,0x0
 101ae36:	cmovae rdx,rcx
 101ae3a:	vpxor  xmm0,xmm0,xmm0
 101ae3e:	vmovdqa XMMWORD PTR [rbp-0xe0],xmm0
 101ae46:	mov    QWORD PTR [rbp-0xd0],0x0
 101ae51:	mov    DWORD PTR [rbp-0xb0],eax
 101ae57:	mov    DWORD PTR [rbp-0xac],0x0
 101ae61:	mov    QWORD PTR [rbp-0xa8],rdx
 101ae68:	mov    QWORD PTR [rbp-0xa0],0x0
 101ae73:	mov    rcx,QWORD PTR [rip+0x23f0e]        # 103ed88 <lyr_gc_heap_base>
 101ae7a:	lea    rax,[rbp-0xa0]
 101ae81:	sub    rax,rcx
 101ae84:	mov    rdx,QWORD PTR [rip+0x23f05]        # 103ed90 <lyr_gc_heap_span>
 101ae8b:	cmp    rax,rdx
 101ae8e:	jae    101aead <lyr_p3_reg_ptr_main+0x44d>
 101ae90:	mov    rcx,QWORD PTR [rip+0x23f01]        # 103ed98 <lyr_gc_cards>
 101ae97:	shr    rax,0x8
 101ae9b:	mov    BYTE PTR [rcx+rax*1],0x1
 101ae9f:	mov    rcx,QWORD PTR [rip+0x23ee2]        # 103ed88 <lyr_gc_heap_base>
 101aea6:	mov    rdx,QWORD PTR [rip+0x23ee3]        # 103ed90 <lyr_gc_heap_span>
 101aead:	mov    QWORD PTR [rbp-0x98],0x1004148
 101aeb8:	lea    rax,[rbp-0x98]
 101aebf:	sub    rax,rcx
 101aec2:	cmp    rax,rdx
 101aec5:	mov    r15,QWORD PTR [rbp-0x48]
 101aec9:	mov    r12,QWORD PTR [rbp-0x58]
 101aecd:	jae    101aeec <lyr_p3_reg_ptr_main+0x48c>
 101aecf:	mov    rcx,QWORD PTR [rip+0x23ec2]        # 103ed98 <lyr_gc_cards>
 101aed6:	shr    rax,0x8
 101aeda:	mov    BYTE PTR [rcx+rax*1],0x1
 101aede:	mov    rcx,QWORD PTR [rip+0x23ea3]        # 103ed88 <lyr_gc_heap_base>
 101aee5:	mov    rdx,QWORD PTR [rip+0x23ea4]        # 103ed90 <lyr_gc_heap_span>
 101aeec:	mov    rax,QWORD PTR [rbp-0xd0]
 101aef3:	lea    rsi,[rbp-0x90]
 101aefa:	mov    QWORD PTR [rsi+0x10],rax
 101aefe:	vmovdqa xmm0,XMMWORD PTR [rbp-0xe0]
 101af06:	vmovdqu XMMWORD PTR [rsi],xmm0
 101af0a:	mov    rax,rsi
 101af0d:	sub    rax,rcx
 101af10:	cmp    rax,rdx
 101af13:	jae    101afa0 <lyr_p3_reg_ptr_main+0x540>
 101af19:	mov    rcx,rax
 101af1c:	shr    rcx,0x8
 101af20:	add    rax,0x17
 101af24:	shr    rax,0x8
 101af28:	mov    rdx,rax
 101af2b:	sub    rdx,rcx
 101af2e:	jb     101afa0 <lyr_p3_reg_ptr_main+0x540>
 101af30:	inc    rax
 101af33:	mov    esi,eax
 101af35:	sub    esi,ecx
 101af37:	and    esi,0x3
 101af3a:	je     101af53 <lyr_p3_reg_ptr_main+0x4f3>
 101af3c:	neg    rsi
 101af3f:	nop
 101af40:	mov    rdi,QWORD PTR [rip+0x23e51]        # 103ed98 <lyr_gc_cards>
 101af47:	mov    BYTE PTR [rdi+rcx*1],0x1
 101af4b:	inc    rcx
 101af4e:	inc    rsi
 101af51:	jne    101af40 <lyr_p3_reg_ptr_main+0x4e0>
 101af53:	cmp    rdx,0x3
 101af57:	jb     101afa0 <lyr_p3_reg_ptr_main+0x540>
 101af59:	nop    DWORD PTR [rax+0x0]
 101af60:	mov    rdx,QWORD PTR [rip+0x23e31]        # 103ed98 <lyr_gc_cards>
 101af67:	mov    BYTE PTR [rdx+rcx*1],0x1
 101af6b:	mov    rdx,QWORD PTR [rip+0x23e26]        # 103ed98 <lyr_gc_cards>
 101af72:	mov    BYTE PTR [rdx+rcx*1+0x1],0x1
 101af77:	mov    rdx,QWORD PTR [rip+0x23e1a]        # 103ed98 <lyr_gc_cards>
 101af7e:	mov    BYTE PTR [rdx+rcx*1+0x2],0x1
 101af83:	mov    rdx,QWORD PTR [rip+0x23e0e]        # 103ed98 <lyr_gc_cards>
 101af8a:	mov    BYTE PTR [rdx+rcx*1+0x3],0x1
 101af8f:	add    rcx,0x4
 101af93:	cmp    rax,rcx
 101af96:	jne    101af60 <lyr_p3_reg_ptr_main+0x500>
 101af98:	nop    DWORD PTR [rax+rax*1+0x0]
 101afa0:	vmovups ymm0,YMMWORD PTR [rbp-0xb0]
 101afa8:	vmovups ymm1,YMMWORD PTR [rbp-0x98]
 101afb0:	vmovups YMMWORD PTR [rbp-0x108],ymm1
 101afb8:	vmovups YMMWORD PTR [rbp-0x120],ymm0
 101afc0:	mov    r14,QWORD PTR fs:0xffffffffffffffe8
 101afc9:	mov    rcx,QWORD PTR fs:0xfffffffffffffff0
 101afd2:	mov    rax,rcx
 101afd5:	sub    rax,r14
 101afd8:	cmp    rax,0x40
 101afdc:	jb     101b163 <lyr_p3_reg_ptr_main+0x703>
 101afe2:	lea    rax,[r14+0x40]
 101afe6:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101afef:	test   r14,r14
 101aff2:	je     101b163 <lyr_p3_reg_ptr_main+0x703>
 101aff8:	mov    QWORD PTR [r14],0x1003c08
 101afff:	vmovdqu ymm0,YMMWORD PTR [rbp-0x120]
 101b007:	vmovdqu ymm1,YMMWORD PTR [rbp-0x108]
 101b00f:	vmovdqu YMMWORD PTR [r14+0x20],ymm1
 101b015:	vmovdqu YMMWORD PTR [r14+0x8],ymm0
 101b01b:	sub    rcx,rax
 101b01e:	cmp    rcx,0x30
 101b022:	jb     101b191 <lyr_p3_reg_ptr_main+0x731>
 101b028:	lea    rcx,[rax+0x30]
 101b02c:	mov    QWORD PTR fs:0xffffffffffffffe8,rcx
 101b035:	test   rax,rax
 101b038:	je     101b191 <lyr_p3_reg_ptr_main+0x731>
 101b03e:	mov    QWORD PTR [rax],0x10042c8
 101b045:	mov    QWORD PTR [rax+0x8],r14
 101b049:	mov    QWORD PTR [rax+0x10],0x1003c60
 101b051:	xor    esi,esi
 101b053:	jmp    101b0bf <lyr_p3_reg_ptr_main+0x65f>
 101b055:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 101b060:	mov    QWORD PTR [rbp-0xc0],r13
 101b067:	lea    rax,[rbp-0xc0]
 101b06e:	sub    rax,QWORD PTR [rip+0x23d13]        # 103ed88 <lyr_gc_heap_base>
 101b075:	cmp    rax,QWORD PTR [rip+0x23d14]        # 103ed90 <lyr_gc_heap_span>
 101b07c:	jae    101b094 <lyr_p3_reg_ptr_main+0x634>
 101b07e:	mov    rcx,QWORD PTR [rip+0x23d13]        # 103ed98 <lyr_gc_cards>
 101b085:	shr    rax,0x8
 101b089:	mov    BYTE PTR [rcx+rax*1],0x1
 101b08d:	mov    r13,QWORD PTR [rbp-0xc0]
 101b094:	mov    rdx,QWORD PTR [r13+0x8]
 101b098:	cmp    r12,rdx
 101b09b:	ja     101c95c <lyr_p3_reg_ptr_main+0x1efc>
 101b0a1:	add    r13,0x10
 101b0a5:	mov    rdi,r13
 101b0a8:	mov    rsi,r12
 101b0ab:	call   1024fa0 <lyr_str_from_utf8_lossy>
 101b0b0:	mov    rsi,rax
 101b0b3:	mov    r15,QWORD PTR [rbp-0x48]
 101b0b7:	mov    r12,QWORD PTR [rbp-0x58]
 101b0bb:	mov    r13d,DWORD PTR [rbp-0x38]
 101b0bf:	test   rsi,rsi
 101b0c2:	mov    eax,0x1004130
 101b0c7:	cmove  rsi,rax
 101b0cb:	mov    rdi,r15
 101b0ce:	vzeroupper
 101b0d1:	call   101d430 <lyr_std_collections_List_string__push_0ca72eae>
 101b0d6:	dec    r13d
 101b0d9:	je     101b125 <lyr_p3_reg_ptr_main+0x6c5>
 101b0db:	inc    r12
 101b0de:	dec    r13d
 101b0e1:	jne    101abc0 <lyr_p3_reg_ptr_main+0x160>
 101b0e7:	jmp    101ab80 <lyr_p3_reg_ptr_main+0x120>
 101b0ec:	mov    edi,0x10
 101b0f1:	call   101f0f0 <allocate.llvm.8023764427486792703>
 101b0f6:	mov    r14,rax
 101b0f9:	jmp    101abff <lyr_p3_reg_ptr_main+0x19f>
 101b0fe:	mov    rdi,rbx
 101b101:	call   101fab0 <lyr_gc_stack_slow>
 101b106:	jmp    101ac1c <lyr_p3_reg_ptr_main+0x1bc>
 101b10b:	mov    rdi,rbx
 101b10e:	call   101fab0 <lyr_gc_stack_slow>
 101b113:	jmp    101ac2e <lyr_p3_reg_ptr_main+0x1ce>
 101b118:	mov    rdi,rbx
 101b11b:	call   101fab0 <lyr_gc_stack_slow>
 101b120:	jmp    101ac4c <lyr_p3_reg_ptr_main+0x1ec>
 101b125:	mov    eax,DWORD PTR [rip+0x23995]        # 103eac0 <lyr_gc_stop_requested>
 101b12b:	mov    r13d,0x400
 101b131:	test   eax,eax
 101b133:	je     101b0db <lyr_p3_reg_ptr_main+0x67b>
 101b135:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101b13e:	test   rdi,rdi
 101b141:	je     101b152 <lyr_p3_reg_ptr_main+0x6f2>
 101b143:	mov    eax,DWORD PTR [rip+0x23977]        # 103eac0 <lyr_gc_stop_requested>
 101b149:	test   eax,eax
 101b14b:	je     101b152 <lyr_p3_reg_ptr_main+0x6f2>
 101b14d:	call   101fa80 <park_here.llvm.8023764427486792703>
 101b152:	mov    rbx,QWORD PTR [rbp-0x50]
 101b156:	mov    r15,QWORD PTR [rbp-0x48]
 101b15a:	mov    r12,QWORD PTR [rbp-0x58]
 101b15e:	jmp    101b0db <lyr_p3_reg_ptr_main+0x67b>
 101b163:	mov    edi,0x40
 101b168:	vzeroupper
 101b16b:	call   101f0f0 <allocate.llvm.8023764427486792703>
 101b170:	mov    r14,rax
 101b173:	mov    QWORD PTR [rax],0x1003c08
 101b17a:	mov    rax,QWORD PTR fs:0xffffffffffffffe8
 101b183:	mov    rcx,QWORD PTR fs:0xfffffffffffffff0
 101b18c:	jmp    101afff <lyr_p3_reg_ptr_main+0x59f>
 101b191:	mov    edi,0x28
 101b196:	vzeroupper
 101b199:	call   101f0f0 <allocate.llvm.8023764427486792703>
 101b19e:	jmp    101b03e <lyr_p3_reg_ptr_main+0x5de>
 101b1a3:	mov    rdi,r15
 101b1a6:	call   101d710 <lyr_std_collections_List_string__toArray_196324b0>
 101b1ab:	mov    r14d,0x5f5e100
 101b1b1:	cmp    QWORD PTR [rax+0x8],0x2
 101b1b6:	jl     101b203 <lyr_p3_reg_ptr_main+0x7a3>
 101b1b8:	mov    rdi,QWORD PTR [rax+0x18]
 101b1bc:	mov    rsi,QWORD PTR [rdi+0x8]
 101b1c0:	add    rdi,0x10
 101b1c4:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101b1cd:	cmp    rax,rbx
 101b1d0:	ja     101ca4c <lyr_p3_reg_ptr_main+0x1fec>
 101b1d6:	mov    QWORD PTR [rbp-0xb0],0x0
 101b1e1:	lea    rcx,[rbp-0xb0]
 101b1e8:	mov    edx,0xa
 101b1ed:	call   101d930 <lyr_std_core_parseInteger_int__340d5225>
 101b1f2:	cmp    QWORD PTR [rbp-0xb0],0x0
 101b1fa:	jne    101ca66 <lyr_p3_reg_ptr_main+0x2006>
 101b200:	mov    r14,rax
 101b203:	mov    rax,QWORD PTR fs:0xffffffffffffffe8
 101b20c:	mov    rcx,QWORD PTR fs:0xfffffffffffffff0
 101b215:	sub    rcx,rax
 101b218:	cmp    rcx,0x80
 101b21f:	jb     101c9c3 <lyr_p3_reg_ptr_main+0x1f63>
 101b225:	lea    rcx,[rax+0x80]
 101b22c:	mov    QWORD PTR fs:0xffffffffffffffe8,rcx
 101b235:	test   rax,rax
 101b238:	je     101c9c3 <lyr_p3_reg_ptr_main+0x1f63>
 101b23e:	mov    QWORD PTR [rax],0x1003b28
 101b245:	mov    QWORD PTR [rax+0x8],0xe
 101b24d:	mov    BYTE PTR [rax+0x10],0xb
 101b251:	mov    DWORD PTR [rax+0x11],0x0
 101b258:	mov    DWORD PTR [rax+0x14],0x0
 101b25f:	vmovaps ymm0,YMMWORD PTR [rip+0xfffffffffffe8639]        # 10038a0 <.str.1.llvm.15148601353198032147+0x9c7>
 101b267:	vmovups YMMWORD PTR [rax+0x18],ymm0
 101b26c:	vmovaps ymm0,YMMWORD PTR [rip+0xfffffffffffe85ec]        # 1003860 <.str.1.llvm.15148601353198032147+0x987>
 101b274:	vmovups YMMWORD PTR [rax+0x38],ymm0
 101b279:	vmovdqa ymm0,YMMWORD PTR [rip+0xfffffffffffe85bf]        # 1003840 <.str.1.llvm.15148601353198032147+0x967>
 101b281:	vmovdqu YMMWORD PTR [rax+0x58],ymm0
 101b286:	mov    BYTE PTR [rax+0x78],0x8
 101b28a:	mov    DWORD PTR [rax+0x79],0x0
 101b291:	mov    r15,rax
 101b294:	mov    DWORD PTR [rax+0x7c],0x0
 101b29b:	mov    rsi,QWORD PTR fs:0xffffffffffffffe8
 101b2a4:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101b2ad:	sub    rax,rsi
 101b2b0:	cmp    rax,0x20
 101b2b4:	jb     101c9d7 <lyr_p3_reg_ptr_main+0x1f77>
 101b2ba:	lea    rax,[rsi+0x20]
 101b2be:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101b2c7:	test   rsi,rsi
 101b2ca:	je     101c9d7 <lyr_p3_reg_ptr_main+0x1f77>
 101b2d0:	mov    QWORD PTR [rsi],0x1003b50
 101b2d7:	mov    QWORD PTR [rsi+0x8],0x1
 101b2df:	mov    QWORD PTR [rsi+0x10],0x0
 101b2e7:	mov    edi,0x1003b50
 101b2ec:	mov    edx,0x10
 101b2f1:	vzeroupper
 101b2f4:	call   101e720 <lyr_arr_repeat>
 101b2f9:	mov    rbx,rax
 101b2fc:	mov    rax,QWORD PTR fs:0xffffffffffffffe8
 101b305:	mov    rcx,QWORD PTR fs:0xfffffffffffffff0
 101b30e:	sub    rcx,rax
 101b311:	cmp    rcx,0x30
 101b315:	jb     101c9f1 <lyr_p3_reg_ptr_main+0x1f91>
 101b31b:	lea    rsi,[rax+0x30]
 101b31f:	mov    QWORD PTR fs:0xffffffffffffffe8,rsi
 101b328:	test   rax,rax
 101b32b:	je     101c9f1 <lyr_p3_reg_ptr_main+0x1f91>
 101b331:	mov    QWORD PTR [rax],0x1003b50
 101b338:	mov    QWORD PTR [rax+0x8],0x3
 101b340:	mov    QWORD PTR [rax+0x10],r14
 101b344:	mov    ecx,0x9e3779b9
 101b349:	mov    QWORD PTR [rax+0x18],rcx
 101b34d:	movabs rcx,0x3fffffffffffffff
 101b357:	mov    QWORD PTR [rbp-0x38],rax
 101b35b:	mov    QWORD PTR [rax+0x20],rcx
 101b35f:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101b368:	sub    rax,rsi
 101b36b:	cmp    rax,0x20
 101b36f:	jb     101ca0e <lyr_p3_reg_ptr_main+0x1fae>
 101b375:	lea    rax,[rsi+0x20]
 101b379:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101b382:	test   rsi,rsi
 101b385:	je     101ca0e <lyr_p3_reg_ptr_main+0x1fae>
 101b38b:	mov    QWORD PTR [rsi],0x1003b50
 101b392:	mov    QWORD PTR [rsi+0x8],0x1
 101b39a:	mov    QWORD PTR [rsi+0x10],0x0
 101b3a2:	mov    edi,0x1003b50
 101b3a7:	mov    edx,0x400
 101b3ac:	call   101e720 <lyr_arr_repeat>
 101b3b1:	mov    QWORD PTR [rbp-0x58],rax
 101b3b5:	mov    rsi,QWORD PTR fs:0xffffffffffffffe8
 101b3be:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101b3c7:	sub    rax,rsi
 101b3ca:	cmp    rax,0x20
 101b3ce:	jb     101ca25 <lyr_p3_reg_ptr_main+0x1fc5>
 101b3d4:	lea    rax,[rsi+0x20]
 101b3d8:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101b3e1:	test   rsi,rsi
 101b3e4:	je     101ca25 <lyr_p3_reg_ptr_main+0x1fc5>
 101b3ea:	mov    QWORD PTR [rsi],0x1003b78
 101b3f1:	mov    QWORD PTR [rsi+0x8],0x1
 101b3f9:	mov    QWORD PTR [rsi+0x10],0x0
 101b401:	mov    edi,0x1003b78
 101b406:	mov    edx,0x100
 101b40b:	call   101e720 <lyr_arr_repeat>
 101b410:	mov    r11,rax
 101b413:	mov    rdi,QWORD PTR [rbp-0x50]
 101b417:	add    rdi,0xffffffffffff3bc0
 101b41e:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101b427:	cmp    rdi,rax
 101b42a:	jb     101ca3c <lyr_p3_reg_ptr_main+0x1fdc>
 101b430:	mov    r9,r15
 101b433:	add    r9,0x10
 101b437:	mov    QWORD PTR [rbp-0xb0],0x0
 101b442:	mov    QWORD PTR [rbp-0x120],0x0
 101b44d:	mov    QWORD PTR [rbp-0xe0],0x0
 101b458:	mov    QWORD PTR [rbp-0xc0],0x0
 101b463:	mov    QWORD PTR [rbp-0x50],rbx
 101b467:	mov    rsi,rbx
 101b46a:	add    rsi,0x10
 101b46e:	mov    r12d,0x400
 101b474:	xor    r8d,r8d
 101b477:	mov    QWORD PTR [rbp-0x68],0x0
 101b47f:	xor    r15d,r15d
 101b482:	mov    r10,QWORD PTR [rbp-0x38]
 101b486:	mov    QWORD PTR [rbp-0x30],rsi
 101b48a:	jmp    101b4af <lyr_p3_reg_ptr_main+0xa4f>
 101b48c:	mov    QWORD PTR [rcx],r14
 101b48f:	mov    rcx,QWORD PTR [r14]
 101b492:	mov    QWORD PTR [rax],rcx
 101b495:	dec    r12d
 101b498:	je     101bad5 <lyr_p3_reg_ptr_main+0x1075>
 101b49e:	xchg   ax,ax
 101b4a0:	inc    r13
 101b4a3:	mov    r15,r13
 101b4a6:	dec    r12d
 101b4a9:	je     101c0bb <lyr_p3_reg_ptr_main+0x165b>
 101b4af:	mov    r13,r15
 101b4b2:	dec    r12d
 101b4b5:	je     101c06b <lyr_p3_reg_ptr_main+0x160b>
 101b4bb:	movabs rax,0xf000000000000000
 101b4c5:	add    rax,r13
 101b4c8:	shr    rax,0x3d
 101b4cc:	cmp    eax,0x7
 101b4cf:	jb     101c69a <lyr_p3_reg_ptr_main+0x1c3a>
 101b4d5:	lea    rax,[r13*8+0x0]
 101b4dd:	add    rax,r9
 101b4e0:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b4e6:	inc    r8
 101b4e9:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b4ef:	movzx  edx,WORD PTR [rax+0x2]
 101b4f3:	movzx  r14d,WORD PTR [rax+0x4]
 101b4f8:	movzx  r15d,WORD PTR [rax+0x6]
 101b4fd:	movzx  ebx,BYTE PTR [rax]
 101b500:	dec    r12d
 101b503:	test   ebx,ebx
 101b505:	je     101b570 <lyr_p3_reg_ptr_main+0xb10>
 101b507:	test   r12d,r12d
 101b50a:	je     101c10b <lyr_p3_reg_ptr_main+0x16ab>
 101b510:	lea    eax,[rbx-0x1]
 101b513:	cmp    eax,0x1f
 101b516:	ja     101baa0 <lyr_p3_reg_ptr_main+0x1040>
 101b51c:	jmp    QWORD PTR [rax*8+0x10038e0]
 101b523:	lea    eax,[rdx*8+0x0]
 101b52a:	add    rax,rsi
 101b52d:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b533:	lea    ecx,[r14*8+0x0]
 101b53b:	add    rcx,rsi
 101b53e:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b544:	lea    edx,[r15*8+0x0]
 101b54c:	add    rdx,rsi
 101b54f:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101b555:	mov    rcx,QWORD PTR [rcx]
 101b558:	sub    rcx,QWORD PTR [rdx]
 101b55b:	mov    QWORD PTR [rax],rcx
 101b55e:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b563:	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 101b570:	test   r12d,r12d
 101b573:	je     101c169 <lyr_p3_reg_ptr_main+0x1709>
 101b579:	lea    eax,[rdx*8+0x0]
 101b580:	add    rax,rsi
 101b583:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b589:	lea    ecx,[r14*8+0x0]
 101b591:	add    rcx,rsi
 101b594:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b59a:	lea    edx,[r15*8+0x0]
 101b5a2:	add    rdx,rsi
 101b5a5:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101b5ab:	mov    rdx,QWORD PTR [rdx]
 101b5ae:	add    rdx,QWORD PTR [rcx]
 101b5b1:	mov    QWORD PTR [rax],rdx
 101b5b4:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b5b9:	lea    eax,[rdx*8+0x0]
 101b5c0:	add    rax,rsi
 101b5c3:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b5c9:	lea    ecx,[r14*8+0x0]
 101b5d1:	add    rcx,rsi
 101b5d4:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b5da:	mov    rcx,QWORD PTR [rcx]
 101b5dd:	xor    rcx,r15
 101b5e0:	mov    QWORD PTR [rax],rcx
 101b5e3:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b5e8:	lea    eax,[rdx*8+0x0]
 101b5ef:	add    rax,rsi
 101b5f2:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b5f8:	lea    ecx,[r14*8+0x0]
 101b600:	add    rcx,rsi
 101b603:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b609:	mov    rcx,QWORD PTR [rcx]
 101b60c:	not    rcx
 101b60f:	mov    QWORD PTR [rax],rcx
 101b612:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b617:	lea    ecx,[rdx*8+0x0]
 101b61e:	add    rcx,rsi
 101b621:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b627:	lea    eax,[r14*8+0x0]
 101b62f:	add    rax,rsi
 101b632:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b638:	lea    edx,[r15*8+0x0]
 101b640:	add    rdx,rsi
 101b643:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101b649:	mov    rsi,QWORD PTR [rdx]
 101b64c:	test   rsi,rsi
 101b64f:	je     101c970 <lyr_p3_reg_ptr_main+0x1f10>
 101b655:	mov    rax,QWORD PTR [rax]
 101b658:	mov    rdx,rax
 101b65b:	or     rdx,rsi
 101b65e:	shr    rdx,0x20
 101b662:	je     101bd03 <lyr_p3_reg_ptr_main+0x12a3>
 101b668:	xor    edx,edx
 101b66a:	div    rsi
 101b66d:	mov    QWORD PTR [rcx],rdx
 101b670:	jmp    101bd13 <lyr_p3_reg_ptr_main+0x12b3>
 101b675:	lea    eax,[rdx*8+0x0]
 101b67c:	add    rax,rsi
 101b67f:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b685:	shl    r15d,0x10
 101b689:	or     r15,r14
 101b68c:	mov    QWORD PTR [rax],r15
 101b68f:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b694:	lea    eax,[rdx*8+0x0]
 101b69b:	add    rax,rsi
 101b69e:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b6a4:	lea    ecx,[r14*8+0x0]
 101b6ac:	add    rcx,rsi
 101b6af:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b6b5:	mov    rcx,QWORD PTR [rcx]
 101b6b8:	mov    QWORD PTR [rax],rcx
 101b6bb:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b6c0:	lea    eax,[rdx*8+0x0]
 101b6c7:	add    rax,rsi
 101b6ca:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b6d0:	lea    ecx,[r14*8+0x0]
 101b6d8:	add    rcx,rsi
 101b6db:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b6e1:	lea    edx,[r15*8+0x0]
 101b6e9:	add    rdx,rsi
 101b6ec:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101b6f2:	mov    rdx,QWORD PTR [rdx]
 101b6f5:	xor    rdx,QWORD PTR [rcx]
 101b6f8:	mov    QWORD PTR [rax],rdx
 101b6fb:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b700:	lea    eax,[rdx*8+0x0]
 101b707:	add    rax,rsi
 101b70a:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b710:	lea    ecx,[r14*8+0x0]
 101b718:	add    rcx,rsi
 101b71b:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b721:	shrx   rcx,QWORD PTR [rcx],r15
 101b726:	mov    QWORD PTR [rax],rcx
 101b729:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b72e:	lea    eax,[rdx*8+0x0]
 101b735:	add    rax,rsi
 101b738:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b73e:	lea    ecx,[r14*8+0x0]
 101b746:	add    rcx,rsi
 101b749:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b74f:	mov    rcx,QWORD PTR [rcx]
 101b752:	imul   rcx,r15
 101b756:	mov    QWORD PTR [rax],rcx
 101b759:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b75e:	lea    eax,[rdx*8+0x0]
 101b765:	add    rax,rsi
 101b768:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b76e:	lea    ecx,[r14*8+0x0]
 101b776:	add    rcx,rsi
 101b779:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b77f:	lea    edx,[r15*8+0x0]
 101b787:	add    rdx,rsi
 101b78a:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101b790:	mov    rdx,QWORD PTR [rdx]
 101b793:	imul   rdx,QWORD PTR [rcx]
 101b797:	mov    QWORD PTR [rax],rdx
 101b79a:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b79f:	lea    eax,[rdx*8+0x0]
 101b7a6:	add    rax,rsi
 101b7a9:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b7af:	lea    ecx,[r14*8+0x0]
 101b7b7:	add    rcx,rsi
 101b7ba:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b7c0:	mov    rcx,QWORD PTR [rcx]
 101b7c3:	add    rcx,r15
 101b7c6:	mov    QWORD PTR [rax],rcx
 101b7c9:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b7ce:	lea    eax,[rdx*8+0x0]
 101b7d5:	add    rax,rsi
 101b7d8:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b7de:	lea    ecx,[r14*8+0x0]
 101b7e6:	add    rcx,rsi
 101b7e9:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b7ef:	shlx   rcx,QWORD PTR [rcx],r15
 101b7f4:	mov    QWORD PTR [rax],rcx
 101b7f7:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b7fc:	lea    eax,[r14*8+0x0]
 101b804:	add    rax,rsi
 101b807:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b80d:	lea    ecx,[r15*8+0x0]
 101b815:	add    rcx,rsi
 101b818:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101b81e:	mov    rax,QWORD PTR [rax]
 101b821:	dec    r12d
 101b824:	cmp    rax,QWORD PTR [rcx]
 101b827:	jae    101b9f6 <lyr_p3_reg_ptr_main+0xf96>
 101b82d:	test   r12d,r12d
 101b830:	je     101c1c5 <lyr_p3_reg_ptr_main+0x1765>
 101b836:	lea    eax,[rdx*8+0x0]
 101b83d:	add    rax,rsi
 101b840:	mov    ecx,0x1
 101b845:	jno    101b492 <lyr_p3_reg_ptr_main+0xa32>
 101b84b:	jmp    101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b850:	lea    eax,[rdx*8+0x0]
 101b857:	add    rax,rsi
 101b85a:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b860:	lea    ecx,[r14*8+0x0]
 101b868:	add    rcx,rsi
 101b86b:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b871:	xor    edx,edx
 101b873:	sub    rdx,QWORD PTR [rcx]
 101b876:	mov    QWORD PTR [rax],rdx
 101b879:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b87e:	lea    eax,[rdx*8+0x0]
 101b885:	add    rax,rsi
 101b888:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b88e:	lea    ecx,[r14*8+0x0]
 101b896:	add    rcx,rsi
 101b899:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b89f:	lea    edx,[r15*8+0x0]
 101b8a7:	add    rdx,rsi
 101b8aa:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101b8b0:	mov    rdx,QWORD PTR [rdx]
 101b8b3:	and    rdx,QWORD PTR [rcx]
 101b8b6:	mov    QWORD PTR [rax],rdx
 101b8b9:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b8be:	shl    r14d,0x3
 101b8c2:	add    r14,rsi
 101b8c5:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b8cb:	lea    eax,[r15*8+0x0]
 101b8d3:	add    rax,rsi
 101b8d6:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101b8dc:	mov    rcx,QWORD PTR [r14]
 101b8df:	dec    r12d
 101b8e2:	cmp    rcx,QWORD PTR [rax]
 101b8e5:	jae    101bce1 <lyr_p3_reg_ptr_main+0x1281>
 101b8eb:	test   r12d,r12d
 101b8ee:	je     101c275 <lyr_p3_reg_ptr_main+0x1815>
 101b8f4:	lea    edx,[rdx*8+0x0]
 101b8fb:	add    rdx,rsi
 101b8fe:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b904:	xor    eax,eax
 101b906:	mov    QWORD PTR [rdx],rax
 101b909:	jmp    101b495 <lyr_p3_reg_ptr_main+0xa35>
 101b90e:	lea    eax,[rdx*8+0x0]
 101b915:	add    rax,rsi
 101b918:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b91e:	lea    ecx,[r14*8+0x0]
 101b926:	add    rcx,rsi
 101b929:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b92f:	mov    ecx,DWORD PTR [rcx]
 101b931:	and    ecx,r15d
 101b934:	mov    QWORD PTR [rax],rcx
 101b937:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101b93c:	lea    eax,[rdx*8+0x0]
 101b943:	add    rax,rsi
 101b946:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b94c:	lea    ecx,[r14*8+0x0]
 101b954:	add    rcx,rsi
 101b957:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101b95d:	mov    rax,QWORD PTR [rax]
 101b960:	dec    r12d
 101b963:	cmp    rax,QWORD PTR [rcx]
 101b966:	jae    101bacc <lyr_p3_reg_ptr_main+0x106c>
 101b96c:	test   r12d,r12d
 101b96f:	jne    101b4a6 <lyr_p3_reg_ptr_main+0xa46>
 101b975:	mov    eax,DWORD PTR [rip+0x23145]        # 103eac0 <lyr_gc_stop_requested>
 101b97b:	mov    r12d,0x400
 101b981:	test   eax,eax
 101b983:	je     101b4a6 <lyr_p3_reg_ptr_main+0xa46>
 101b989:	mov    r13,r11
 101b98c:	mov    r14,r9
 101b98f:	mov    rbx,r8
 101b992:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101b99b:	test   rdi,rdi
 101b99e:	je     101b9af <lyr_p3_reg_ptr_main+0xf4f>
 101b9a0:	mov    eax,DWORD PTR [rip+0x2311a]        # 103eac0 <lyr_gc_stop_requested>
 101b9a6:	test   eax,eax
 101b9a8:	je     101b9af <lyr_p3_reg_ptr_main+0xf4f>
 101b9aa:	call   101fa80 <park_here.llvm.8023764427486792703>
 101b9af:	mov    r8,rbx
 101b9b2:	mov    r9,r14
 101b9b5:	mov    r10,QWORD PTR [rbp-0x38]
 101b9b9:	mov    r11,r13
 101b9bc:	mov    rsi,QWORD PTR [rbp-0x30]
 101b9c0:	jmp    101b4a6 <lyr_p3_reg_ptr_main+0xa46>
 101b9c5:	lea    eax,[r14*8+0x0]
 101b9cd:	add    rax,rsi
 101b9d0:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101b9d6:	lea    ecx,[r15*8+0x0]
 101b9de:	add    rcx,rsi
 101b9e1:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101b9e7:	mov    rax,QWORD PTR [rax]
 101b9ea:	dec    r12d
 101b9ed:	cmp    rax,QWORD PTR [rcx]
 101b9f0:	je     101b82d <lyr_p3_reg_ptr_main+0xdcd>
 101b9f6:	test   r12d,r12d
 101b9f9:	je     101c21d <lyr_p3_reg_ptr_main+0x17bd>
 101b9ff:	lea    eax,[rdx*8+0x0]
 101ba06:	add    rax,rsi
 101ba09:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101ba0f:	xor    ecx,ecx
 101ba11:	jmp    101b492 <lyr_p3_reg_ptr_main+0xa32>
 101ba16:	lea    ecx,[rdx*8+0x0]
 101ba1d:	add    rcx,rsi
 101ba20:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101ba26:	lea    eax,[r14*8+0x0]
 101ba2e:	add    rax,rsi
 101ba31:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101ba37:	lea    edx,[r15*8+0x0]
 101ba3f:	add    rdx,rsi
 101ba42:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101ba48:	mov    rsi,QWORD PTR [rdx]
 101ba4b:	test   rsi,rsi
 101ba4e:	je     101c970 <lyr_p3_reg_ptr_main+0x1f10>
 101ba54:	mov    rax,QWORD PTR [rax]
 101ba57:	mov    rdx,rax
 101ba5a:	or     rdx,rsi
 101ba5d:	shr    rdx,0x20
 101ba61:	je     101bd0c <lyr_p3_reg_ptr_main+0x12ac>
 101ba67:	xor    edx,edx
 101ba69:	div    rsi
 101ba6c:	jmp    101bd10 <lyr_p3_reg_ptr_main+0x12b0>
 101ba71:	lea    eax,[rdx*8+0x0]
 101ba78:	add    rax,rsi
 101ba7b:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101ba81:	lea    ecx,[r14*8+0x0]
 101ba89:	add    rcx,rsi
 101ba8c:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101ba92:	mov    rcx,QWORD PTR [rcx]
 101ba95:	sub    rcx,r15
 101ba98:	mov    QWORD PTR [rax],rcx
 101ba9b:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101baa0:	add    ebx,0xffffffdf
 101baa3:	cmp    ebx,0xe
 101baa6:	ja     101caeb <lyr_p3_reg_ptr_main+0x208b>
 101baac:	jmp    QWORD PTR [rbx*8+0x10039e0]
 101bab3:	shl    edx,0x3
 101bab6:	add    rdx,rsi
 101bab9:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101babf:	dec    r12d
 101bac2:	cmp    QWORD PTR [rdx],0x0
 101bac6:	je     101b96c <lyr_p3_reg_ptr_main+0xf0c>
 101bacc:	test   r12d,r12d
 101bacf:	jne    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101bad5:	mov    eax,DWORD PTR [rip+0x22fe5]        # 103eac0 <lyr_gc_stop_requested>
 101badb:	mov    r12d,0x400
 101bae1:	test   eax,eax
 101bae3:	je     101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101bae9:	mov    r15,r11
 101baec:	mov    r14,r9
 101baef:	mov    rbx,r8
 101baf2:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101bafb:	test   rdi,rdi
 101bafe:	je     101bb0f <lyr_p3_reg_ptr_main+0x10af>
 101bb00:	mov    eax,DWORD PTR [rip+0x22fba]        # 103eac0 <lyr_gc_stop_requested>
 101bb06:	test   eax,eax
 101bb08:	je     101bb0f <lyr_p3_reg_ptr_main+0x10af>
 101bb0a:	call   101fa80 <park_here.llvm.8023764427486792703>
 101bb0f:	mov    r8,rbx
 101bb12:	mov    r9,r14
 101bb15:	mov    r10,QWORD PTR [rbp-0x38]
 101bb19:	mov    r11,r15
 101bb1c:	mov    rsi,QWORD PTR [rbp-0x30]
 101bb20:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101bb25:	lea    eax,[rdx*8+0x0]
 101bb2c:	add    rax,rsi
 101bb2f:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bb35:	mov    rsi,QWORD PTR [r10+0x8]
 101bb39:	cmp    rsi,r14
 101bb3c:	jbe    101c975 <lyr_p3_reg_ptr_main+0x1f15>
 101bb42:	mov    rcx,QWORD PTR [r10+r14*8+0x10]
 101bb47:	mov    QWORD PTR [rax],rcx
 101bb4a:	jmp    101bd13 <lyr_p3_reg_ptr_main+0x12b3>
 101bb4f:	lea    eax,[rdx*8+0x0]
 101bb56:	add    rax,rsi
 101bb59:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bb5f:	lea    ecx,[r14*8+0x0]
 101bb67:	add    rcx,rsi
 101bb6a:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bb70:	lea    edx,[r15*8+0x0]
 101bb78:	add    rdx,rsi
 101bb7b:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bb81:	movzx  edx,BYTE PTR [rdx]
 101bb84:	shlx   rcx,QWORD PTR [rcx],rdx
 101bb89:	mov    QWORD PTR [rax],rcx
 101bb8c:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101bb91:	lea    eax,[rdx*8+0x0]
 101bb98:	add    rax,rsi
 101bb9b:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bba1:	lea    ecx,[r14*8+0x0]
 101bba9:	add    rcx,rsi
 101bbac:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bbb2:	lea    edx,[r15*8+0x0]
 101bbba:	add    rdx,rsi
 101bbbd:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bbc3:	mov    rdx,QWORD PTR [rdx]
 101bbc6:	or     rdx,QWORD PTR [rcx]
 101bbc9:	mov    QWORD PTR [rax],rdx
 101bbcc:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101bbd1:	lea    eax,[rdx*8+0x0]
 101bbd8:	add    rax,rsi
 101bbdb:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bbe1:	lea    ecx,[r14*8+0x0]
 101bbe9:	add    rcx,rsi
 101bbec:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bbf2:	shl    r15d,0x3
 101bbf6:	add    r15,rsi
 101bbf9:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bbff:	movzx  edx,BYTE PTR [r15]
 101bc03:	shrx   rcx,QWORD PTR [rcx],rdx
 101bc08:	mov    QWORD PTR [rax],rcx
 101bc0b:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101bc10:	lea    eax,[r14*8+0x0]
 101bc18:	add    rax,rsi
 101bc1b:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bc21:	lea    ecx,[r15*8+0x0]
 101bc29:	add    rcx,rsi
 101bc2c:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bc32:	mov    rax,QWORD PTR [rax]
 101bc35:	dec    r12d
 101bc38:	cmp    rax,QWORD PTR [rcx]
 101bc3b:	jne    101b82d <lyr_p3_reg_ptr_main+0xdcd>
 101bc41:	jmp    101b9f6 <lyr_p3_reg_ptr_main+0xf96>
 101bc46:	lea    eax,[rdx*8+0x0]
 101bc4d:	add    rax,rsi
 101bc50:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bc56:	lea    ecx,[r14*8+0x0]
 101bc5e:	add    rcx,rsi
 101bc61:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bc67:	mov    rcx,QWORD PTR [rcx]
 101bc6a:	or     rcx,r15
 101bc6d:	mov    QWORD PTR [rax],rcx
 101bc70:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101bc75:	lea    eax,[r14*8+0x0]
 101bc7d:	add    rax,rsi
 101bc80:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bc86:	lea    ecx,[r15*8+0x0]
 101bc8e:	add    rcx,rsi
 101bc91:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bc97:	mov    rax,QWORD PTR [rax]
 101bc9a:	dec    r12d
 101bc9d:	cmp    rax,QWORD PTR [rcx]
 101bca0:	jbe    101b82d <lyr_p3_reg_ptr_main+0xdcd>
 101bca6:	jmp    101b9f6 <lyr_p3_reg_ptr_main+0xf96>
 101bcab:	lea    eax,[r14*8+0x0]
 101bcb3:	add    rax,rsi
 101bcb6:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bcbc:	lea    ecx,[r15*8+0x0]
 101bcc4:	add    rcx,rsi
 101bcc7:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bccd:	mov    rax,QWORD PTR [rax]
 101bcd0:	dec    r12d
 101bcd3:	cmp    rax,QWORD PTR [rcx]
 101bcd6:	ja     101b82d <lyr_p3_reg_ptr_main+0xdcd>
 101bcdc:	jmp    101b9f6 <lyr_p3_reg_ptr_main+0xf96>
 101bce1:	test   r12d,r12d
 101bce4:	je     101c2cd <lyr_p3_reg_ptr_main+0x186d>
 101bcea:	shl    edx,0x3
 101bced:	add    rdx,rsi
 101bcf0:	mov    eax,0x1
 101bcf5:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bcfb:	mov    QWORD PTR [rdx],rax
 101bcfe:	jmp    101b495 <lyr_p3_reg_ptr_main+0xa35>
 101bd03:	xor    edx,edx
 101bd05:	div    esi
 101bd07:	mov    QWORD PTR [rcx],rdx
 101bd0a:	jmp    101bd13 <lyr_p3_reg_ptr_main+0x12b3>
 101bd0c:	xor    edx,edx
 101bd0e:	div    esi
 101bd10:	mov    QWORD PTR [rcx],rax
 101bd13:	inc    r13
 101bd16:	mov    r15,r13
 101bd19:	mov    rsi,QWORD PTR [rbp-0x30]
 101bd1d:	jmp    101b4a6 <lyr_p3_reg_ptr_main+0xa46>
 101bd22:	lea    eax,[r15*8+0x0]
 101bd2a:	add    rax,rsi
 101bd2d:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bd33:	cmp    QWORD PTR [rax],0x0
 101bd37:	je     101b495 <lyr_p3_reg_ptr_main+0xa35>
 101bd3d:	dec    r12d
 101bd40:	je     101c325 <lyr_p3_reg_ptr_main+0x18c5>
 101bd46:	lea    eax,[rdx*8+0x0]
 101bd4d:	add    rax,rsi
 101bd50:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bd56:	lea    ecx,[r14*8+0x0]
 101bd5e:	add    rcx,rsi
 101bd61:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bd67:	mov    rcx,QWORD PTR [rcx]
 101bd6a:	jmp    101b492 <lyr_p3_reg_ptr_main+0xa32>
 101bd6f:	lea    eax,[r14*8+0x0]
 101bd77:	add    rax,rsi
 101bd7a:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bd80:	lea    ecx,[rdx*8+0x0]
 101bd87:	add    rcx,rsi
 101bd8a:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bd90:	mov    rdx,r11
 101bd93:	mov    rdi,QWORD PTR [rax]
 101bd96:	add    rdi,r15
 101bd99:	mov    r11,QWORD PTR [rbp-0x58]
 101bd9d:	mov    rsi,QWORD PTR [r11+0x8]
 101bda1:	cmp    rdi,rsi
 101bda4:	jae    101c978 <lyr_p3_reg_ptr_main+0x1f18>
 101bdaa:	mov    rax,QWORD PTR [rcx]
 101bdad:	mov    QWORD PTR [r11+rdi*8+0x10],rax
 101bdb2:	inc    r13
 101bdb5:	mov    r15,r13
 101bdb8:	mov    r11,rdx
 101bdbb:	mov    rsi,QWORD PTR [rbp-0x30]
 101bdbf:	jmp    101b4a6 <lyr_p3_reg_ptr_main+0xa46>
 101bdc4:	lea    eax,[rdx*8+0x0]
 101bdcb:	add    rax,rsi
 101bdce:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bdd4:	lea    ecx,[r14*8+0x0]
 101bddc:	add    rcx,rsi
 101bddf:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bde5:	mov    rax,QWORD PTR [rax]
 101bde8:	dec    r12d
 101bdeb:	cmp    rax,QWORD PTR [rcx]
 101bdee:	jbe    101b96c <lyr_p3_reg_ptr_main+0xf0c>
 101bdf4:	jmp    101bacc <lyr_p3_reg_ptr_main+0x106c>
 101bdf9:	mov    rsi,QWORD PTR [r11+0x8]
 101bdfd:	mov    rdi,QWORD PTR [rbp-0x68]
 101be01:	cmp    rdi,rsi
 101be04:	jae    101c978 <lyr_p3_reg_ptr_main+0x1f18>
 101be0a:	inc    r13
 101be0d:	mov    QWORD PTR [r11+rdi*8+0x10],r13
 101be12:	inc    rdi
 101be15:	mov    QWORD PTR [rbp-0x68],rdi
 101be19:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101be1f:	mov    rsi,QWORD PTR [rbp-0x30]
 101be23:	jmp    101b4a6 <lyr_p3_reg_ptr_main+0xa46>
 101be28:	shl    r14d,0x3
 101be2c:	add    r14,rsi
 101be2f:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101be35:	lea    ebx,[r15*8+0x0]
 101be3d:	add    rbx,rsi
 101be40:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101be46:	mov    rax,QWORD PTR [r14]
 101be49:	dec    r12d
 101be4c:	cmp    rax,QWORD PTR [rbx]
 101be4f:	jbe    101c01b <lyr_p3_reg_ptr_main+0x15bb>
 101be55:	test   r12d,r12d
 101be58:	je     101c37f <lyr_p3_reg_ptr_main+0x191f>
 101be5e:	lea    eax,[rdx*8+0x0]
 101be65:	add    rax,rsi
 101be68:	lea    rcx,[rbp-0xe0]
 101be6f:	jno    101b48c <lyr_p3_reg_ptr_main+0xa2c>
 101be75:	jmp    101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101be7a:	lea    eax,[rdx*8+0x0]
 101be81:	add    rax,rsi
 101be84:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101be8a:	shl    r14d,0x3
 101be8e:	add    r14,rsi
 101be91:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101be97:	mov    rax,QWORD PTR [rax]
 101be9a:	dec    r12d
 101be9d:	cmp    rax,QWORD PTR [r14]
 101bea0:	je     101b96c <lyr_p3_reg_ptr_main+0xf0c>
 101bea6:	jmp    101bacc <lyr_p3_reg_ptr_main+0x106c>
 101beab:	lea    eax,[rdx*8+0x0]
 101beb2:	add    rax,rsi
 101beb5:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bebb:	shl    r14d,0x3
 101bebf:	add    r14,rsi
 101bec2:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bec8:	mov    rax,QWORD PTR [rax]
 101becb:	dec    r12d
 101bece:	cmp    rax,QWORD PTR [r14]
 101bed1:	jne    101b96c <lyr_p3_reg_ptr_main+0xf0c>
 101bed7:	jmp    101bacc <lyr_p3_reg_ptr_main+0x106c>
 101bedc:	shl    edx,0x3
 101bedf:	add    rdx,rsi
 101bee2:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bee8:	dec    QWORD PTR [rdx]
 101beeb:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101bef0:	shl    edx,0x3
 101bef3:	add    rdx,rsi
 101bef6:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101befc:	dec    r12d
 101beff:	cmp    QWORD PTR [rdx],0x0
 101bf03:	jne    101b96c <lyr_p3_reg_ptr_main+0xf0c>
 101bf09:	jmp    101bacc <lyr_p3_reg_ptr_main+0x106c>
 101bf0e:	lea    eax,[rdx*8+0x0]
 101bf15:	add    rax,rsi
 101bf18:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bf1e:	lea    ecx,[r14*8+0x0]
 101bf26:	add    rcx,rsi
 101bf29:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bf2f:	mov    rax,QWORD PTR [rax]
 101bf32:	dec    r12d
 101bf35:	cmp    rax,QWORD PTR [rcx]
 101bf38:	jae    101b96c <lyr_p3_reg_ptr_main+0xf0c>
 101bf3e:	jmp    101bacc <lyr_p3_reg_ptr_main+0x106c>
 101bf43:	mov    rdi,QWORD PTR [rbp-0x68]
 101bf47:	dec    rdi
 101bf4a:	jo     101c966 <lyr_p3_reg_ptr_main+0x1f06>
 101bf50:	mov    rsi,QWORD PTR [r11+0x8]
 101bf54:	cmp    rdi,rsi
 101bf57:	jae    101c978 <lyr_p3_reg_ptr_main+0x1f18>
 101bf5d:	mov    QWORD PTR [rbp-0x68],rdi
 101bf61:	mov    r15,QWORD PTR [r11+rdi*8+0x10]
 101bf66:	mov    rsi,QWORD PTR [rbp-0x30]
 101bf6a:	jmp    101b4a6 <lyr_p3_reg_ptr_main+0xa46>
 101bf6f:	lea    eax,[rdx*8+0x0]
 101bf76:	add    rax,rsi
 101bf79:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bf7f:	inc    QWORD PTR [rax]
 101bf82:	jmp    101b4a0 <lyr_p3_reg_ptr_main+0xa40>
 101bf87:	lea    eax,[rdx*8+0x0]
 101bf8e:	add    rax,rsi
 101bf91:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bf97:	lea    ecx,[r14*8+0x0]
 101bf9f:	add    rcx,rsi
 101bfa2:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bfa8:	mov    rdi,QWORD PTR [rcx]
 101bfab:	add    rdi,r15
 101bfae:	mov    rcx,QWORD PTR [rbp-0x58]
 101bfb2:	mov    rsi,QWORD PTR [rcx+0x8]
 101bfb6:	cmp    rdi,rsi
 101bfb9:	jae    101c978 <lyr_p3_reg_ptr_main+0x1f18>
 101bfbf:	mov    rcx,QWORD PTR [rcx+rdi*8+0x10]
 101bfc4:	jmp    101bb47 <lyr_p3_reg_ptr_main+0x10e7>
 101bfc9:	lea    r14d,[r14*8+0x0]
 101bfd1:	add    r14,rsi
 101bfd4:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101bfda:	lea    ebx,[r15*8+0x0]
 101bfe2:	add    rbx,rsi
 101bfe5:	jo     101c6a4 <lyr_p3_reg_ptr_main+0x1c44>
 101bfeb:	mov    rax,QWORD PTR [r14]
 101bfee:	dec    r12d
 101bff1:	cmp    rax,QWORD PTR [rbx]
 101bff4:	jae    101c043 <lyr_p3_reg_ptr_main+0x15e3>
 101bff6:	test   r12d,r12d
 101bff9:	je     101c433 <lyr_p3_reg_ptr_main+0x19d3>
 101bfff:	lea    eax,[rdx*8+0x0]
 101c006:	add    rax,rsi
 101c009:	lea    rcx,[rbp-0xb0]
 101c010:	jno    101b48c <lyr_p3_reg_ptr_main+0xa2c>
 101c016:	jmp    101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101c01b:	test   r12d,r12d
 101c01e:	je     101c3d9 <lyr_p3_reg_ptr_main+0x1979>
 101c024:	lea    eax,[rdx*8+0x0]
 101c02b:	add    rax,rsi
 101c02e:	mov    r14,rbx
 101c031:	lea    rcx,[rbp-0xc0]
 101c038:	jno    101b48c <lyr_p3_reg_ptr_main+0xa2c>
 101c03e:	jmp    101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101c043:	test   r12d,r12d
 101c046:	je     101c48d <lyr_p3_reg_ptr_main+0x1a2d>
 101c04c:	lea    eax,[rdx*8+0x0]
 101c053:	add    rax,rsi
 101c056:	mov    r14,rbx
 101c059:	lea    rcx,[rbp-0x120]
 101c060:	jno    101b48c <lyr_p3_reg_ptr_main+0xa2c>
 101c066:	jmp    101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101c06b:	mov    eax,DWORD PTR [rip+0x22a4f]        # 103eac0 <lyr_gc_stop_requested>
 101c071:	mov    r12d,0x400
 101c077:	test   eax,eax
 101c079:	je     101b4bb <lyr_p3_reg_ptr_main+0xa5b>
 101c07f:	mov    r15,r11
 101c082:	mov    r14,r9
 101c085:	mov    rbx,r8
 101c088:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c091:	test   rdi,rdi
 101c094:	je     101c0a5 <lyr_p3_reg_ptr_main+0x1645>
 101c096:	mov    eax,DWORD PTR [rip+0x22a24]        # 103eac0 <lyr_gc_stop_requested>
 101c09c:	test   eax,eax
 101c09e:	je     101c0a5 <lyr_p3_reg_ptr_main+0x1645>
 101c0a0:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c0a5:	mov    r8,rbx
 101c0a8:	mov    r9,r14
 101c0ab:	mov    r10,QWORD PTR [rbp-0x38]
 101c0af:	mov    r11,r15
 101c0b2:	mov    rsi,QWORD PTR [rbp-0x30]
 101c0b6:	jmp    101b4bb <lyr_p3_reg_ptr_main+0xa5b>
 101c0bb:	mov    eax,DWORD PTR [rip+0x229ff]        # 103eac0 <lyr_gc_stop_requested>
 101c0c1:	mov    r12d,0x400
 101c0c7:	test   eax,eax
 101c0c9:	je     101b4af <lyr_p3_reg_ptr_main+0xa4f>
 101c0cf:	mov    r13,r11
 101c0d2:	mov    r14,r9
 101c0d5:	mov    rbx,r8
 101c0d8:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c0e1:	test   rdi,rdi
 101c0e4:	je     101c0f5 <lyr_p3_reg_ptr_main+0x1695>
 101c0e6:	mov    eax,DWORD PTR [rip+0x229d4]        # 103eac0 <lyr_gc_stop_requested>
 101c0ec:	test   eax,eax
 101c0ee:	je     101c0f5 <lyr_p3_reg_ptr_main+0x1695>
 101c0f0:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c0f5:	mov    r8,rbx
 101c0f8:	mov    r9,r14
 101c0fb:	mov    r10,QWORD PTR [rbp-0x38]
 101c0ff:	mov    r11,r13
 101c102:	mov    rsi,QWORD PTR [rbp-0x30]
 101c106:	jmp    101b4af <lyr_p3_reg_ptr_main+0xa4f>
 101c10b:	mov    eax,DWORD PTR [rip+0x229af]        # 103eac0 <lyr_gc_stop_requested>
 101c111:	mov    r12d,0x400
 101c117:	test   eax,eax
 101c119:	je     101b510 <lyr_p3_reg_ptr_main+0xab0>
 101c11f:	mov    QWORD PTR [rbp-0x40],rdx
 101c123:	mov    QWORD PTR [rbp-0x48],r11
 101c127:	mov    QWORD PTR [rbp-0x60],r9
 101c12b:	mov    QWORD PTR [rbp-0x70],r8
 101c12f:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c138:	test   rdi,rdi
 101c13b:	je     101c14c <lyr_p3_reg_ptr_main+0x16ec>
 101c13d:	mov    eax,DWORD PTR [rip+0x2297d]        # 103eac0 <lyr_gc_stop_requested>
 101c143:	test   eax,eax
 101c145:	je     101c14c <lyr_p3_reg_ptr_main+0x16ec>
 101c147:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c14c:	mov    r8,QWORD PTR [rbp-0x70]
 101c150:	mov    r9,QWORD PTR [rbp-0x60]
 101c154:	mov    r10,QWORD PTR [rbp-0x38]
 101c158:	mov    r11,QWORD PTR [rbp-0x48]
 101c15c:	mov    rsi,QWORD PTR [rbp-0x30]
 101c160:	mov    rdx,QWORD PTR [rbp-0x40]
 101c164:	jmp    101b510 <lyr_p3_reg_ptr_main+0xab0>
 101c169:	mov    eax,DWORD PTR [rip+0x22951]        # 103eac0 <lyr_gc_stop_requested>
 101c16f:	mov    r12d,0x400
 101c175:	test   eax,eax
 101c177:	je     101b579 <lyr_p3_reg_ptr_main+0xb19>
 101c17d:	mov    QWORD PTR [rbp-0x40],rdx
 101c181:	mov    QWORD PTR [rbp-0x48],r11
 101c185:	mov    QWORD PTR [rbp-0x60],r9
 101c189:	mov    rbx,r8
 101c18c:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c195:	test   rdi,rdi
 101c198:	je     101c1a9 <lyr_p3_reg_ptr_main+0x1749>
 101c19a:	mov    eax,DWORD PTR [rip+0x22920]        # 103eac0 <lyr_gc_stop_requested>
 101c1a0:	test   eax,eax
 101c1a2:	je     101c1a9 <lyr_p3_reg_ptr_main+0x1749>
 101c1a4:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c1a9:	mov    r8,rbx
 101c1ac:	mov    r9,QWORD PTR [rbp-0x60]
 101c1b0:	mov    r10,QWORD PTR [rbp-0x38]
 101c1b4:	mov    r11,QWORD PTR [rbp-0x48]
 101c1b8:	mov    rsi,QWORD PTR [rbp-0x30]
 101c1bc:	mov    rdx,QWORD PTR [rbp-0x40]
 101c1c0:	jmp    101b579 <lyr_p3_reg_ptr_main+0xb19>
 101c1c5:	mov    eax,DWORD PTR [rip+0x228f5]        # 103eac0 <lyr_gc_stop_requested>
 101c1cb:	mov    r12d,0x400
 101c1d1:	test   eax,eax
 101c1d3:	je     101b836 <lyr_p3_reg_ptr_main+0xdd6>
 101c1d9:	mov    QWORD PTR [rbp-0x40],rdx
 101c1dd:	mov    r15,r11
 101c1e0:	mov    r14,r9
 101c1e3:	mov    rbx,r8
 101c1e6:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c1ef:	test   rdi,rdi
 101c1f2:	je     101c203 <lyr_p3_reg_ptr_main+0x17a3>
 101c1f4:	mov    eax,DWORD PTR [rip+0x228c6]        # 103eac0 <lyr_gc_stop_requested>
 101c1fa:	test   eax,eax
 101c1fc:	je     101c203 <lyr_p3_reg_ptr_main+0x17a3>
 101c1fe:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c203:	mov    r8,rbx
 101c206:	mov    r9,r14
 101c209:	mov    r10,QWORD PTR [rbp-0x38]
 101c20d:	mov    r11,r15
 101c210:	mov    rsi,QWORD PTR [rbp-0x30]
 101c214:	mov    rdx,QWORD PTR [rbp-0x40]
 101c218:	jmp    101b836 <lyr_p3_reg_ptr_main+0xdd6>
 101c21d:	mov    eax,DWORD PTR [rip+0x2289d]        # 103eac0 <lyr_gc_stop_requested>
 101c223:	mov    r12d,0x400
 101c229:	test   eax,eax
 101c22b:	je     101b9ff <lyr_p3_reg_ptr_main+0xf9f>
 101c231:	mov    QWORD PTR [rbp-0x40],rdx
 101c235:	mov    r15,r11
 101c238:	mov    r14,r9
 101c23b:	mov    rbx,r8
 101c23e:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c247:	test   rdi,rdi
 101c24a:	je     101c25b <lyr_p3_reg_ptr_main+0x17fb>
 101c24c:	mov    eax,DWORD PTR [rip+0x2286e]        # 103eac0 <lyr_gc_stop_requested>
 101c252:	test   eax,eax
 101c254:	je     101c25b <lyr_p3_reg_ptr_main+0x17fb>
 101c256:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c25b:	mov    r8,rbx
 101c25e:	mov    r9,r14
 101c261:	mov    r10,QWORD PTR [rbp-0x38]
 101c265:	mov    r11,r15
 101c268:	mov    rsi,QWORD PTR [rbp-0x30]
 101c26c:	mov    rdx,QWORD PTR [rbp-0x40]
 101c270:	jmp    101b9ff <lyr_p3_reg_ptr_main+0xf9f>
 101c275:	mov    eax,DWORD PTR [rip+0x22845]        # 103eac0 <lyr_gc_stop_requested>
 101c27b:	mov    r12d,0x400
 101c281:	test   eax,eax
 101c283:	je     101b8f4 <lyr_p3_reg_ptr_main+0xe94>
 101c289:	mov    QWORD PTR [rbp-0x40],rdx
 101c28d:	mov    r15,r11
 101c290:	mov    r14,r9
 101c293:	mov    rbx,r8
 101c296:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c29f:	test   rdi,rdi
 101c2a2:	je     101c2b3 <lyr_p3_reg_ptr_main+0x1853>
 101c2a4:	mov    eax,DWORD PTR [rip+0x22816]        # 103eac0 <lyr_gc_stop_requested>
 101c2aa:	test   eax,eax
 101c2ac:	je     101c2b3 <lyr_p3_reg_ptr_main+0x1853>
 101c2ae:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c2b3:	mov    r8,rbx
 101c2b6:	mov    r9,r14
 101c2b9:	mov    r10,QWORD PTR [rbp-0x38]
 101c2bd:	mov    r11,r15
 101c2c0:	mov    rsi,QWORD PTR [rbp-0x30]
 101c2c4:	mov    rdx,QWORD PTR [rbp-0x40]
 101c2c8:	jmp    101b8f4 <lyr_p3_reg_ptr_main+0xe94>
 101c2cd:	mov    eax,DWORD PTR [rip+0x227ed]        # 103eac0 <lyr_gc_stop_requested>
 101c2d3:	mov    r12d,0x400
 101c2d9:	test   eax,eax
 101c2db:	je     101bcea <lyr_p3_reg_ptr_main+0x128a>
 101c2e1:	mov    QWORD PTR [rbp-0x40],rdx
 101c2e5:	mov    r15,r11
 101c2e8:	mov    r14,r9
 101c2eb:	mov    rbx,r8
 101c2ee:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c2f7:	test   rdi,rdi
 101c2fa:	je     101c30b <lyr_p3_reg_ptr_main+0x18ab>
 101c2fc:	mov    eax,DWORD PTR [rip+0x227be]        # 103eac0 <lyr_gc_stop_requested>
 101c302:	test   eax,eax
 101c304:	je     101c30b <lyr_p3_reg_ptr_main+0x18ab>
 101c306:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c30b:	mov    r8,rbx
 101c30e:	mov    r9,r14
 101c311:	mov    r10,QWORD PTR [rbp-0x38]
 101c315:	mov    r11,r15
 101c318:	mov    rsi,QWORD PTR [rbp-0x30]
 101c31c:	mov    rdx,QWORD PTR [rbp-0x40]
 101c320:	jmp    101bcea <lyr_p3_reg_ptr_main+0x128a>
 101c325:	mov    eax,DWORD PTR [rip+0x22795]        # 103eac0 <lyr_gc_stop_requested>
 101c32b:	mov    r12d,0x400
 101c331:	test   eax,eax
 101c333:	je     101bd46 <lyr_p3_reg_ptr_main+0x12e6>
 101c339:	mov    QWORD PTR [rbp-0x40],rdx
 101c33d:	mov    QWORD PTR [rbp-0x48],r11
 101c341:	mov    r15,r9
 101c344:	mov    rbx,r8
 101c347:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c350:	test   rdi,rdi
 101c353:	je     101c364 <lyr_p3_reg_ptr_main+0x1904>
 101c355:	mov    eax,DWORD PTR [rip+0x22765]        # 103eac0 <lyr_gc_stop_requested>
 101c35b:	test   eax,eax
 101c35d:	je     101c364 <lyr_p3_reg_ptr_main+0x1904>
 101c35f:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c364:	mov    r8,rbx
 101c367:	mov    r9,r15
 101c36a:	mov    r10,QWORD PTR [rbp-0x38]
 101c36e:	mov    r11,QWORD PTR [rbp-0x48]
 101c372:	mov    rsi,QWORD PTR [rbp-0x30]
 101c376:	mov    rdx,QWORD PTR [rbp-0x40]
 101c37a:	jmp    101bd46 <lyr_p3_reg_ptr_main+0x12e6>
 101c37f:	mov    eax,DWORD PTR [rip+0x2273b]        # 103eac0 <lyr_gc_stop_requested>
 101c385:	mov    r12d,0x400
 101c38b:	test   eax,eax
 101c38d:	je     101be5e <lyr_p3_reg_ptr_main+0x13fe>
 101c393:	mov    QWORD PTR [rbp-0x40],rdx
 101c397:	mov    QWORD PTR [rbp-0x48],r11
 101c39b:	mov    r15,r9
 101c39e:	mov    rbx,r8
 101c3a1:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c3aa:	test   rdi,rdi
 101c3ad:	je     101c3be <lyr_p3_reg_ptr_main+0x195e>
 101c3af:	mov    eax,DWORD PTR [rip+0x2270b]        # 103eac0 <lyr_gc_stop_requested>
 101c3b5:	test   eax,eax
 101c3b7:	je     101c3be <lyr_p3_reg_ptr_main+0x195e>
 101c3b9:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c3be:	mov    r8,rbx
 101c3c1:	mov    r9,r15
 101c3c4:	mov    r10,QWORD PTR [rbp-0x38]
 101c3c8:	mov    r11,QWORD PTR [rbp-0x48]
 101c3cc:	mov    rsi,QWORD PTR [rbp-0x30]
 101c3d0:	mov    rdx,QWORD PTR [rbp-0x40]
 101c3d4:	jmp    101be5e <lyr_p3_reg_ptr_main+0x13fe>
 101c3d9:	mov    eax,DWORD PTR [rip+0x226e1]        # 103eac0 <lyr_gc_stop_requested>
 101c3df:	mov    r12d,0x400
 101c3e5:	test   eax,eax
 101c3e7:	je     101c024 <lyr_p3_reg_ptr_main+0x15c4>
 101c3ed:	mov    QWORD PTR [rbp-0x40],rdx
 101c3f1:	mov    QWORD PTR [rbp-0x48],r11
 101c3f5:	mov    r15,r9
 101c3f8:	mov    r14,r8
 101c3fb:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c404:	test   rdi,rdi
 101c407:	je     101c418 <lyr_p3_reg_ptr_main+0x19b8>
 101c409:	mov    eax,DWORD PTR [rip+0x226b1]        # 103eac0 <lyr_gc_stop_requested>
 101c40f:	test   eax,eax
 101c411:	je     101c418 <lyr_p3_reg_ptr_main+0x19b8>
 101c413:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c418:	mov    r8,r14
 101c41b:	mov    r9,r15
 101c41e:	mov    r10,QWORD PTR [rbp-0x38]
 101c422:	mov    r11,QWORD PTR [rbp-0x48]
 101c426:	mov    rsi,QWORD PTR [rbp-0x30]
 101c42a:	mov    rdx,QWORD PTR [rbp-0x40]
 101c42e:	jmp    101c024 <lyr_p3_reg_ptr_main+0x15c4>
 101c433:	mov    eax,DWORD PTR [rip+0x22687]        # 103eac0 <lyr_gc_stop_requested>
 101c439:	mov    r12d,0x400
 101c43f:	test   eax,eax
 101c441:	je     101bfff <lyr_p3_reg_ptr_main+0x159f>
 101c447:	mov    QWORD PTR [rbp-0x40],rdx
 101c44b:	mov    QWORD PTR [rbp-0x48],r11
 101c44f:	mov    r15,r9
 101c452:	mov    rbx,r8
 101c455:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c45e:	test   rdi,rdi
 101c461:	je     101c472 <lyr_p3_reg_ptr_main+0x1a12>
 101c463:	mov    eax,DWORD PTR [rip+0x22657]        # 103eac0 <lyr_gc_stop_requested>
 101c469:	test   eax,eax
 101c46b:	je     101c472 <lyr_p3_reg_ptr_main+0x1a12>
 101c46d:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c472:	mov    r8,rbx
 101c475:	mov    r9,r15
 101c478:	mov    r10,QWORD PTR [rbp-0x38]
 101c47c:	mov    r11,QWORD PTR [rbp-0x48]
 101c480:	mov    rsi,QWORD PTR [rbp-0x30]
 101c484:	mov    rdx,QWORD PTR [rbp-0x40]
 101c488:	jmp    101bfff <lyr_p3_reg_ptr_main+0x159f>
 101c48d:	mov    eax,DWORD PTR [rip+0x2262d]        # 103eac0 <lyr_gc_stop_requested>
 101c493:	mov    r12d,0x400
 101c499:	test   eax,eax
 101c49b:	je     101c04c <lyr_p3_reg_ptr_main+0x15ec>
 101c4a1:	mov    QWORD PTR [rbp-0x40],rdx
 101c4a5:	mov    QWORD PTR [rbp-0x48],r11
 101c4a9:	mov    r15,r9
 101c4ac:	mov    r14,r8
 101c4af:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101c4b8:	test   rdi,rdi
 101c4bb:	je     101c4cc <lyr_p3_reg_ptr_main+0x1a6c>
 101c4bd:	mov    eax,DWORD PTR [rip+0x225fd]        # 103eac0 <lyr_gc_stop_requested>
 101c4c3:	test   eax,eax
 101c4c5:	je     101c4cc <lyr_p3_reg_ptr_main+0x1a6c>
 101c4c7:	call   101fa80 <park_here.llvm.8023764427486792703>
 101c4cc:	mov    r8,r14
 101c4cf:	mov    r9,r15
 101c4d2:	mov    r10,QWORD PTR [rbp-0x38]
 101c4d6:	mov    r11,QWORD PTR [rbp-0x48]
 101c4da:	mov    rsi,QWORD PTR [rbp-0x30]
 101c4de:	mov    rdx,QWORD PTR [rbp-0x40]
 101c4e2:	jmp    101c04c <lyr_p3_reg_ptr_main+0x15ec>
 101c4e7:	mov    r12,r8
 101c4ea:	mov    rsi,QWORD PTR fs:0xffffffffffffffe8
 101c4f3:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101c4fc:	sub    rax,rsi
 101c4ff:	cmp    rax,0x20
 101c503:	jb     101ca71 <lyr_p3_reg_ptr_main+0x2011>
 101c509:	lea    rax,[rsi+0x20]
 101c50d:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101c516:	test   rsi,rsi
 101c519:	je     101ca71 <lyr_p3_reg_ptr_main+0x2011>
 101c51f:	mov    QWORD PTR [rsi],0x1003ba8
 101c526:	mov    QWORD PTR [rsi+0x8],0x1
 101c52e:	mov    r15,QWORD PTR [rbp-0x50]
 101c532:	mov    BYTE PTR [rsi+0x10],0x0
 101c536:	mov    edi,0x1003ba8
 101c53b:	mov    edx,0x36
 101c540:	call   101e720 <lyr_arr_repeat>
 101c545:	mov    r14,QWORD PTR fs:0xffffffffffffffe8
 101c54e:	mov    rcx,QWORD PTR fs:0xfffffffffffffff0
 101c557:	sub    rcx,r14
 101c55a:	cmp    rcx,0x20
 101c55e:	jb     101ca88 <lyr_p3_reg_ptr_main+0x2028>
 101c564:	lea    rcx,[r14+0x20]
 101c568:	mov    QWORD PTR fs:0xffffffffffffffe8,rcx
 101c571:	test   r14,r14
 101c574:	je     101ca88 <lyr_p3_reg_ptr_main+0x2028>
 101c57a:	mov    QWORD PTR [r14],0x1003a80
 101c581:	lea    rbx,[r14+0x8]
 101c585:	mov    QWORD PTR [r14+0x8],rax
 101c589:	mov    rax,rbx
 101c58c:	sub    rax,QWORD PTR [rip+0x227f5]        # 103ed88 <lyr_gc_heap_base>
 101c593:	cmp    rax,QWORD PTR [rip+0x227f6]        # 103ed90 <lyr_gc_heap_span>
 101c59a:	jae    101c5ab <lyr_p3_reg_ptr_main+0x1b4b>
 101c59c:	mov    rcx,QWORD PTR [rip+0x227f5]        # 103ed98 <lyr_gc_cards>
 101c5a3:	shr    rax,0x8
 101c5a7:	mov    BYTE PTR [rcx+rax*1],0x1
 101c5ab:	mov    QWORD PTR [r14+0x10],0x0
 101c5b3:	mov    esi,0x1003da8
 101c5b8:	mov    edx,0x4
 101c5bd:	mov    rdi,r14
 101c5c0:	call   101cb10 <lyr_std_core_StringBuilder_appendStr>
 101c5c5:	mov    rsi,QWORD PTR [r15+0x8]
 101c5c9:	cmp    rsi,0x2
 101c5cd:	jbe    101caa0 <lyr_p3_reg_ptr_main+0x2040>
 101c5d3:	mov    rdi,QWORD PTR [r14+0x10]
 101c5d7:	mov    rsi,rdi
 101c5da:	add    rsi,0x14
 101c5de:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101c5e4:	mov    r15,QWORD PTR [r15+0x20]
 101c5e8:	mov    rax,QWORD PTR [rbx]
 101c5eb:	cmp    rsi,QWORD PTR [rax+0x8]
 101c5ef:	jle    101c601 <lyr_p3_reg_ptr_main+0x1ba1>
 101c5f1:	mov    rdi,r14
 101c5f4:	call   101cbd0 <lyr_std_core_StringBuilder_grow>
 101c5f9:	mov    rax,QWORD PTR [r14+0x8]
 101c5fd:	mov    rdi,QWORD PTR [r14+0x10]
 101c601:	xor    ecx,ecx
 101c603:	cmp    r15,0x64
 101c607:	jb     101c66b <lyr_p3_reg_ptr_main+0x1c0b>
 101c609:	xor    ecx,ecx
 101c60b:	movabs rsi,0x28f5c28f5c28f5c3
 101c615:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 101c620:	mov    r8,r15
 101c623:	mov    rdx,r15
 101c626:	shr    rdx,0x2
 101c62a:	mulx   r15,r15,rsi
 101c62f:	shr    r15,0x2
 101c633:	imul   edx,r15d,0x64
 101c637:	mov    r9d,r8d
 101c63a:	sub    r9d,edx
 101c63d:	add    r9d,r9d
 101c640:	movzx  edx,BYTE PTR [r9+0x1004351]
 101c648:	mov    BYTE PTR [rbp+rcx*1-0xb0],dl
 101c64f:	movzx  edx,BYTE PTR [r9+0x1004350]
 101c657:	mov    BYTE PTR [rbp+rcx*1-0xaf],dl
 101c65e:	add    rcx,0x2
 101c662:	cmp    r8,0x270f
 101c669:	ja     101c620 <lyr_p3_reg_ptr_main+0x1bc0>
 101c66b:	mov    edx,ecx
 101c66d:	cmp    r15,0xa
 101c671:	jb     101c6ae <lyr_p3_reg_ptr_main+0x1c4e>
 101c673:	movzx  esi,BYTE PTR [r15+r15*1+0x1004351]
 101c67c:	mov    BYTE PTR [rbp+rdx*1-0xb0],sil
 101c684:	movzx  esi,BYTE PTR [r15+r15*1+0x1004350]
 101c68d:	add    ecx,0x2
 101c690:	mov    BYTE PTR [rbp+rdx*1-0xaf],sil
 101c698:	jmp    101c6bd <lyr_p3_reg_ptr_main+0x1c5d>
 101c69a:	mov    edi,0x1002edb
 101c69f:	call   1024e55 <lyr_panic_overflow>
 101c6a4:	mov    edi,0x1002ed9
 101c6a9:	call   1024e55 <lyr_panic_overflow>
 101c6ae:	or     r15b,0x30
 101c6b2:	or     ecx,0x1
 101c6b5:	mov    BYTE PTR [rbp+rdx*1-0xb0],r15b
 101c6bd:	mov    rdx,QWORD PTR [rax+0x8]
 101c6c1:	movsxd rsi,ecx
 101c6c4:	test   rdi,rdi
 101c6c7:	js     101cafc <lyr_p3_reg_ptr_main+0x209c>
 101c6cd:	mov    r8,rdx
 101c6d0:	sub    r8,rsi
 101c6d3:	cmp    rdi,r8
 101c6d6:	jg     101cafc <lyr_p3_reg_ptr_main+0x209c>
 101c6dc:	test   ecx,ecx
 101c6de:	jle    101c832 <lyr_p3_reg_ptr_main+0x1dd2>
 101c6e4:	cmp    ecx,0x10
 101c6e7:	jae    101c6f0 <lyr_p3_reg_ptr_main+0x1c90>
 101c6e9:	xor    ecx,ecx
 101c6eb:	jmp    101c802 <lyr_p3_reg_ptr_main+0x1da2>
 101c6f0:	cmp    ecx,0x80
 101c6f6:	jae    101c6ff <lyr_p3_reg_ptr_main+0x1c9f>
 101c6f8:	xor    ecx,ecx
 101c6fa:	jmp    101c7aa <lyr_p3_reg_ptr_main+0x1d4a>
 101c6ff:	mov    ecx,esi
 101c701:	and    ecx,0x7fffff80
 101c707:	mov    rdx,rcx
 101c70a:	neg    rdx
 101c70d:	lea    r8,[rdi+rax*1]
 101c711:	add    r8,0x70
 101c715:	lea    r9,[rbp-0xb0]
 101c71c:	add    r9,rsi
 101c71f:	add    r9,0xffffffffffffffe0
 101c723:	xor    r10d,r10d
 101c726:	vmovdqa ymm0,YMMWORD PTR [rip+0xfffffffffffe7152]        # 1003880 <.str.1.llvm.15148601353198032147+0x9a7>
 101c72e:	xchg   ax,ax
 101c730:	vmovdqu ymm1,YMMWORD PTR [r9+r10*1-0x60]
 101c737:	vmovdqu ymm2,YMMWORD PTR [r9+r10*1-0x40]
 101c73e:	vmovdqu ymm3,YMMWORD PTR [r9+r10*1-0x20]
 101c745:	vmovdqu ymm4,YMMWORD PTR [r9+r10*1]
 101c74b:	vpshufb ymm4,ymm4,ymm0
 101c750:	vpermq ymm4,ymm4,0x4e
 101c756:	vpshufb ymm3,ymm3,ymm0
 101c75b:	vpermq ymm3,ymm3,0x4e
 101c761:	vpshufb ymm2,ymm2,ymm0
 101c766:	vpermq ymm2,ymm2,0x4e
 101c76c:	vpshufb ymm1,ymm1,ymm0
 101c771:	vpermq ymm1,ymm1,0x4e
 101c777:	vmovdqu YMMWORD PTR [r8-0x60],ymm4
 101c77d:	vmovdqu YMMWORD PTR [r8-0x40],ymm3
 101c783:	vmovdqu YMMWORD PTR [r8-0x20],ymm2
 101c789:	vmovdqu YMMWORD PTR [r8],ymm1
 101c78e:	add    r10,0xffffffffffffff80
 101c792:	sub    r8,0xffffffffffffff80
 101c796:	cmp    rdx,r10
 101c799:	jne    101c730 <lyr_p3_reg_ptr_main+0x1cd0>
 101c79b:	cmp    rcx,rsi
 101c79e:	je     101c832 <lyr_p3_reg_ptr_main+0x1dd2>
 101c7a4:	test   sil,0x70
 101c7a8:	je     101c802 <lyr_p3_reg_ptr_main+0x1da2>
 101c7aa:	mov    rdx,rcx
 101c7ad:	mov    ecx,esi
 101c7af:	and    ecx,0x7ffffff0
 101c7b5:	mov    r8,rcx
 101c7b8:	neg    r8
 101c7bb:	lea    r9,[rdi+rdx*1]
 101c7bf:	neg    rdx
 101c7c2:	add    r9,rax
 101c7c5:	add    r9,0x10
 101c7c9:	lea    r10,[rbp-0xb0]
 101c7d0:	add    r10,rsi
 101c7d3:	add    r10,0xfffffffffffffff0
 101c7d7:	vmovdqa xmm0,XMMWORD PTR [rip+0xfffffffffffe70f1]        # 10038d0 <.str.1.llvm.15148601353198032147+0x9f7>
 101c7df:	nop
 101c7e0:	vmovdqu xmm1,XMMWORD PTR [r10+rdx*1]
 101c7e6:	vpshufb xmm1,xmm1,xmm0
 101c7eb:	vmovdqu XMMWORD PTR [r9],xmm1
 101c7f0:	add    rdx,0xfffffffffffffff0
 101c7f4:	add    r9,0x10
 101c7f8:	cmp    r8,rdx
 101c7fb:	jne    101c7e0 <lyr_p3_reg_ptr_main+0x1d80>
 101c7fd:	cmp    rcx,rsi
 101c800:	je     101c832 <lyr_p3_reg_ptr_main+0x1dd2>
 101c802:	mov    rdx,rsi
 101c805:	sub    rdx,rcx
 101c808:	add    rcx,rdi
 101c80b:	add    rax,rcx
 101c80e:	add    rax,0x10
 101c812:	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 101c820:	movzx  ecx,BYTE PTR [rbp+rdx*1-0xb1]
 101c828:	mov    BYTE PTR [rax],cl
 101c82a:	inc    rax
 101c82d:	dec    rdx
 101c830:	jne    101c820 <lyr_p3_reg_ptr_main+0x1dc0>
 101c832:	add    rdi,rsi
 101c835:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101c83b:	mov    QWORD PTR [r14+0x10],rdi
 101c83f:	mov    esi,0x1003dc0
 101c844:	mov    edx,0xa
 101c849:	mov    rdi,r14
 101c84c:	vzeroupper
 101c84f:	call   101cb10 <lyr_std_core_StringBuilder_appendStr>
 101c854:	mov    r15,QWORD PTR [r14+0x10]
 101c858:	mov    rsi,r15
 101c85b:	add    rsi,0x14
 101c85f:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101c865:	mov    rdi,QWORD PTR [rbx]
 101c868:	cmp    rsi,QWORD PTR [rdi+0x8]
 101c86c:	jle    101c87e <lyr_p3_reg_ptr_main+0x1e1e>
 101c86e:	mov    rdi,r14
 101c871:	call   101cbd0 <lyr_std_core_StringBuilder_grow>
 101c876:	mov    rdi,QWORD PTR [r14+0x8]
 101c87a:	mov    r15,QWORD PTR [r14+0x10]
 101c87e:	mov    rsi,r15
 101c881:	mov    rdx,r12
 101c884:	call   1025580 <lyr_bytes_put_int>
 101c889:	add    rax,r15
 101c88c:	jo     101c94f <lyr_p3_reg_ptr_main+0x1eef>
 101c892:	mov    QWORD PTR [r14+0x10],rax
 101c896:	mov    rsi,QWORD PTR [r14+0x8]
 101c89a:	mov    rdx,QWORD PTR [rsi+0x8]
 101c89e:	js     101cb04 <lyr_p3_reg_ptr_main+0x20a4>
 101c8a4:	cmp    rax,rdx
 101c8a7:	jg     101cb04 <lyr_p3_reg_ptr_main+0x20a4>
 101c8ad:	mov    rcx,rax
 101c8b0:	shr    rcx,0x28
 101c8b4:	jne    101caaa <lyr_p3_reg_ptr_main+0x204a>
 101c8ba:	lea    rdx,[rax+0x20]
 101c8be:	movabs rcx,0x1fffffffff0
 101c8c8:	and    rcx,rdx
 101c8cb:	mov    rbx,QWORD PTR fs:0xffffffffffffffe8
 101c8d4:	mov    rdx,QWORD PTR fs:0xfffffffffffffff0
 101c8dd:	sub    rdx,rbx
 101c8e0:	cmp    rcx,rdx
 101c8e3:	ja     101cac6 <lyr_p3_reg_ptr_main+0x2066>
 101c8e9:	add    rcx,rbx
 101c8ec:	mov    QWORD PTR fs:0xffffffffffffffe8,rcx
 101c8f5:	test   rbx,rbx
 101c8f8:	je     101cac6 <lyr_p3_reg_ptr_main+0x2066>
 101c8fe:	mov    QWORD PTR [rbx],0x1004420
 101c905:	mov    QWORD PTR [rbx+0x8],rax
 101c909:	test   rax,rax
 101c90c:	je     101c91e <lyr_p3_reg_ptr_main+0x1ebe>
 101c90e:	add    rsi,0x10
 101c912:	lea    rdi,[rbx+0x10]
 101c916:	mov    rdx,rax
 101c919:	call   1037d30 <memcpy@plt>
 101c91e:	mov    rsi,QWORD PTR [rbx+0x8]
 101c922:	add    rbx,0x10
 101c926:	mov    rdi,rbx
 101c929:	call   101cd90 <lyr_std_io_put>
 101c92e:	mov    edi,0x1003de0
 101c933:	mov    esi,0x1
 101c938:	call   101cd90 <lyr_std_io_put>
 101c93d:	add    rsp,0xf8
 101c944:	pop    rbx
 101c945:	pop    r12
 101c947:	pop    r13
 101c949:	pop    r14
 101c94b:	pop    r15
 101c94d:	pop    rbp
 101c94e:	ret
 101c94f:	mov    edi,0x1002ed9
 101c954:	vzeroupper
 101c957:	call   1024e55 <lyr_panic_overflow>
 101c95c:	xor    edi,edi
 101c95e:	mov    rsi,r12
 101c961:	call   1024e37 <lyr_panic_range>
 101c966:	mov    edi,0x1002ed7
 101c96b:	call   1024e55 <lyr_panic_overflow>
 101c970:	call   1024e6d <lyr_panic_division_by_zero>
 101c975:	mov    rdi,r14
 101c978:	call   1024e1c <lyr_panic_index>
 101c97d:	mov    edi,0x10041c8
 101c982:	xor    esi,esi
 101c984:	call   101f9a0 <lyr_gc_alloc_array_slow>
 101c989:	mov    r14,rax
 101c98c:	mov    r15,QWORD PTR fs:0xffffffffffffffe8
 101c995:	jmp    101aaf0 <lyr_p3_reg_ptr_main+0x90>
 101c99a:	mov    edi,0x28
 101c99f:	call   101f0f0 <allocate.llvm.8023764427486792703>
 101c9a4:	mov    r15,rax
 101c9a7:	jmp    101ab1c <lyr_p3_reg_ptr_main+0xbc>
 101c9ac:	call   101fab0 <lyr_gc_stack_slow>
 101c9b1:	jmp    101aa90 <lyr_p3_reg_ptr_main+0x30>
 101c9b6:	mov    rdi,rbx
 101c9b9:	call   101fab0 <lyr_gc_stack_slow>
 101c9be:	jmp    101aaa2 <lyr_p3_reg_ptr_main+0x42>
 101c9c3:	mov    edi,0x1003b28
 101c9c8:	mov    esi,0xe
 101c9cd:	call   101f9a0 <lyr_gc_alloc_array_slow>
 101c9d2:	jmp    101b24d <lyr_p3_reg_ptr_main+0x7ed>
 101c9d7:	mov    edi,0x1003b50
 101c9dc:	mov    esi,0x1
 101c9e1:	vzeroupper
 101c9e4:	call   101f9a0 <lyr_gc_alloc_array_slow>
 101c9e9:	mov    rsi,rax
 101c9ec:	jmp    101b2df <lyr_p3_reg_ptr_main+0x87f>
 101c9f1:	mov    edi,0x1003b50
 101c9f6:	mov    esi,0x3
 101c9fb:	call   101f9a0 <lyr_gc_alloc_array_slow>
 101ca00:	mov    rsi,QWORD PTR fs:0xffffffffffffffe8
 101ca09:	jmp    101b340 <lyr_p3_reg_ptr_main+0x8e0>
 101ca0e:	mov    edi,0x1003b50
 101ca13:	mov    esi,0x1
 101ca18:	call   101f9a0 <lyr_gc_alloc_array_slow>
 101ca1d:	mov    rsi,rax
 101ca20:	jmp    101b39a <lyr_p3_reg_ptr_main+0x93a>
 101ca25:	mov    edi,0x1003b78
 101ca2a:	mov    esi,0x1
 101ca2f:	call   101f9a0 <lyr_gc_alloc_array_slow>
 101ca34:	mov    rsi,rax
 101ca37:	jmp    101b3f9 <lyr_p3_reg_ptr_main+0x999>
 101ca3c:	mov    r14,r11
 101ca3f:	call   101fab0 <lyr_gc_stack_slow>
 101ca44:	mov    r11,r14
 101ca47:	jmp    101b430 <lyr_p3_reg_ptr_main+0x9d0>
 101ca4c:	mov    rbx,rdi
 101ca4f:	mov    rdi,QWORD PTR [rbp-0x50]
 101ca53:	mov    r14,rsi
 101ca56:	call   101fab0 <lyr_gc_stack_slow>
 101ca5b:	mov    rdi,rbx
 101ca5e:	mov    rsi,r14
 101ca61:	jmp    101b1d6 <lyr_p3_reg_ptr_main+0x776>
 101ca66:	mov    r14d,0x5f5e100
 101ca6c:	jmp    101b203 <lyr_p3_reg_ptr_main+0x7a3>
 101ca71:	mov    edi,0x1003ba8
 101ca76:	mov    esi,0x1
 101ca7b:	call   101f9a0 <lyr_gc_alloc_array_slow>
 101ca80:	mov    rsi,rax
 101ca83:	jmp    101c52e <lyr_p3_reg_ptr_main+0x1ace>
 101ca88:	mov    edi,0x18
 101ca8d:	mov    rbx,rax
 101ca90:	call   101f0f0 <allocate.llvm.8023764427486792703>
 101ca95:	mov    r14,rax
 101ca98:	mov    rax,rbx
 101ca9b:	jmp    101c57a <lyr_p3_reg_ptr_main+0x1b1a>
 101caa0:	mov    edi,0x2
 101caa5:	call   1024e1c <lyr_panic_index>
 101caaa:	mov    rdi,rax
 101caad:	mov    r14,rax
 101cab0:	mov    rbx,rsi
 101cab3:	call   101fa20 <lyr_gc_alloc_string_slow>
 101cab8:	mov    rsi,rbx
 101cabb:	mov    rbx,rax
 101cabe:	mov    rax,r14
 101cac1:	jmp    101c90e <lyr_p3_reg_ptr_main+0x1eae>
 101cac6:	mov    rdi,rax
 101cac9:	mov    r14,rax
 101cacc:	mov    rbx,rsi
 101cacf:	call   101fa20 <lyr_gc_alloc_string_slow>
 101cad4:	mov    rsi,rbx
 101cad7:	mov    rbx,rax
 101cada:	mov    rax,r14
 101cadd:	test   rax,rax
 101cae0:	jne    101c90e <lyr_p3_reg_ptr_main+0x1eae>
 101cae6:	jmp    101c91e <lyr_p3_reg_ptr_main+0x1ebe>
 101caeb:	mov    edi,0x1003d78
 101caf0:	call   1024ea7 <lyr_panic_message>
 101caf5:	ud2
 101caf7:	call   1024eeb <lyr_stack_overflow>
 101cafc:	add    rsi,rdi
 101caff:	call   1024e37 <lyr_panic_range>
 101cb04:	xor    edi,edi
 101cb06:	mov    rsi,rax
 101cb09:	call   1024e37 <lyr_panic_range>
 101cb0e:	int3
 101cb0f:	int3
