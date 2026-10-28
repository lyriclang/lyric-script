000000000101aa60 <lyr_p1_reg_main>:
 101aa60:	push   rbp
 101aa61:	mov    rbp,rsp
 101aa64:	push   r15
 101aa66:	push   r14
 101aa68:	push   r13
 101aa6a:	push   r12
 101aa6c:	push   rbx
 101aa6d:	sub    rsp,0xd8
 101aa74:	mov    rbx,rbp
 101aa77:	lea    rdi,[rbp-0x2720]
 101aa7e:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101aa87:	cmp    rdi,rax
 101aa8a:	jb     101c190 <lyr_p1_reg_main+0x1730>
 101aa90:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101aa99:	cmp    rax,rbx
 101aa9c:	ja     101c19a <lyr_p1_reg_main+0x173a>
 101aaa2:	mov    QWORD PTR [rbp-0x30],rbx
 101aaa6:	mov    ebx,DWORD PTR [rip+0x2bb2c]        # 10465d8 <config.llvm.5495021493128820629>
 101aaac:	mov    r14,QWORD PTR fs:0xffffffffffffffe8
 101aab5:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101aabe:	sub    rax,r14
 101aac1:	cmp    rax,0x10
 101aac5:	jb     101c161 <lyr_p1_reg_main+0x1701>
 101aacb:	lea    r15,[r14+0x10]
 101aacf:	mov    QWORD PTR fs:0xffffffffffffffe8,r15
 101aad8:	test   r14,r14
 101aadb:	je     101c161 <lyr_p1_reg_main+0x1701>
 101aae1:	mov    QWORD PTR [r14],0x10041c8
 101aae8:	mov    QWORD PTR [r14+0x8],0x0
 101aaf0:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101aaf9:	sub    rax,r15
 101aafc:	cmp    rax,0x30
 101ab00:	jb     101c17e <lyr_p1_reg_main+0x171e>
 101ab06:	lea    rax,[r15+0x30]
 101ab0a:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101ab13:	test   r15,r15
 101ab16:	je     101c17e <lyr_p1_reg_main+0x171e>
 101ab1c:	mov    QWORD PTR [r15],0x1003ae0
 101ab23:	lea    rax,[r15+0x8]
 101ab27:	mov    QWORD PTR [r15+0x8],r14
 101ab2b:	sub    rax,QWORD PTR [rip+0x23a46]        # 103e578 <lyr_gc_heap_base>
 101ab32:	cmp    rax,QWORD PTR [rip+0x23a47]        # 103e580 <lyr_gc_heap_span>
 101ab39:	jae    101ab4a <lyr_p1_reg_main+0xea>
 101ab3b:	mov    rcx,QWORD PTR [rip+0x23a46]        # 103e588 <lyr_gc_cards>
 101ab42:	shr    rax,0x8
 101ab46:	mov    BYTE PTR [rcx+rax*1],0x1
 101ab4a:	mov    eax,ebx
 101ab4c:	sar    eax,0x1f
 101ab4f:	andn   eax,eax,ebx
 101ab54:	mov    QWORD PTR [rbp-0xa8],rax
 101ab5b:	vpxor  xmm0,xmm0,xmm0
 101ab5f:	vmovdqu XMMWORD PTR [r15+0x10],xmm0
 101ab65:	mov    QWORD PTR [r15+0x20],0x0
 101ab6d:	mov    r13d,0x400
 101ab73:	xor    r12d,r12d
 101ab76:	mov    rbx,QWORD PTR [rbp-0x30]
 101ab7a:	mov    QWORD PTR [rbp-0x50],r15
 101ab7e:	dec    r13d
 101ab81:	jne    101abc0 <lyr_p1_reg_main+0x160>
 101ab83:	mov    eax,DWORD PTR [rip+0x23727]        # 103e2b0 <lyr_gc_stop_requested>
 101ab89:	mov    r13d,0x400
 101ab8f:	test   eax,eax
 101ab91:	je     101abc0 <lyr_p1_reg_main+0x160>
 101ab93:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101ab9c:	test   rdi,rdi
 101ab9f:	je     101abb0 <lyr_p1_reg_main+0x150>
 101aba1:	mov    eax,DWORD PTR [rip+0x23709]        # 103e2b0 <lyr_gc_stop_requested>
 101aba7:	test   eax,eax
 101aba9:	je     101abb0 <lyr_p1_reg_main+0x150>
 101abab:	call   101f270 <park_here.llvm.8023764427486792703>
 101abb0:	mov    rbx,QWORD PTR [rbp-0x30]
 101abb4:	mov    r15,QWORD PTR [rbp-0x50]
 101abb8:	nop    DWORD PTR [rax+rax*1+0x0]
 101abc0:	cmp    r12,QWORD PTR [rbp-0xa8]
 101abc7:	je     101b193 <lyr_p1_reg_main+0x733>
 101abcd:	mov    r14,QWORD PTR fs:0xffffffffffffffe8
 101abd6:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101abdf:	sub    rax,r14
 101abe2:	cmp    rax,0x10
 101abe6:	jb     101b0dc <lyr_p1_reg_main+0x67c>
 101abec:	lea    rax,[r14+0x10]
 101abf0:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101abf9:	test   r14,r14
 101abfc:	je     101b0dc <lyr_p1_reg_main+0x67c>
 101ac02:	mov    QWORD PTR [r14],0x1003b08
 101ac09:	mov    QWORD PTR [r14+0x8],r12
 101ac0d:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101ac16:	cmp    rax,rbx
 101ac19:	ja     101b0ee <lyr_p1_reg_main+0x68e>
 101ac1f:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101ac28:	cmp    rax,rbx
 101ac2b:	ja     101b0fb <lyr_p1_reg_main+0x69b>
 101ac31:	mov    QWORD PTR [rbp-0x48],r14
 101ac35:	mov    DWORD PTR [rbp-0x40],r13d
 101ac39:	mov    QWORD PTR [rbp-0x38],r12
 101ac3d:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101ac46:	cmp    rax,rbx
 101ac49:	ja     101b108 <lyr_p1_reg_main+0x6a8>
 101ac4f:	vpxor  xmm0,xmm0,xmm0
 101ac53:	vmovdqu YMMWORD PTR [rbp-0xe8],ymm0
 101ac5b:	vmovdqu YMMWORD PTR [rbp-0x100],ymm0
 101ac63:	vpxor  xmm0,xmm0,xmm0
 101ac67:	vmovdqa XMMWORD PTR [rbp-0xa0],xmm0
 101ac6f:	mov    r14d,0x200
 101ac75:	mov    ecx,0x400
 101ac7a:	nop    WORD PTR [rax+rax*1+0x0]
 101ac80:	dec    ecx
 101ac82:	je     101ad7d <lyr_p1_reg_main+0x31d>
 101ac88:	mov    DWORD PTR [rbp-0x58],ecx
 101ac8b:	mov    rsi,QWORD PTR fs:0xffffffffffffffe8
 101ac94:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101ac9d:	sub    rax,rsi
 101aca0:	cmp    rax,0x20
 101aca4:	jb     101ad68 <lyr_p1_reg_main+0x308>
 101acaa:	lea    rax,[rsi+0x20]
 101acae:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101acb7:	test   rsi,rsi
 101acba:	je     101ad68 <lyr_p1_reg_main+0x308>
 101acc0:	mov    QWORD PTR [rsi],0x1003bb0
 101acc7:	mov    QWORD PTR [rsi+0x8],0x1
 101accf:	mov    BYTE PTR [rsi+0x10],0x0
 101acd3:	mov    edi,0x1003bb0
 101acd8:	mov    rdx,r14
 101acdb:	vzeroupper
 101acde:	call   101df10 <lyr_arr_repeat>
 101ace3:	mov    r13,rax
 101ace6:	mov    r15,QWORD PTR [rax+0x8]
 101acea:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101acf3:	cmp    rax,rbx
 101acf6:	ja     101adbe <lyr_p1_reg_main+0x35e>
 101acfc:	mov    rax,QWORD PTR [rbp-0x48]
 101ad00:	mov    rax,QWORD PTR [rax+0x8]
 101ad04:	test   rax,rax
 101ad07:	js     101ae00 <lyr_p1_reg_main+0x3a0>
 101ad0d:	movsxd rcx,DWORD PTR [rip+0x2b8c4]        # 10465d8 <config.llvm.5495021493128820629>
 101ad14:	cmp    rax,rcx
 101ad17:	jge    101ae00 <lyr_p1_reg_main+0x3a0>
 101ad1d:	mov    rcx,QWORD PTR [rip+0x2b8bc]        # 10465e0 <config.llvm.5495021493128820629+0x8>
 101ad24:	mov    rbx,QWORD PTR [rcx+rax*8]
 101ad28:	mov    rdi,rbx
 101ad2b:	call   10373c0 <strlen@plt>
 101ad30:	mov    r12,rax
 101ad33:	cmp    rax,r15
 101ad36:	jg     101ad47 <lyr_p1_reg_main+0x2e7>
 101ad38:	lea    rdi,[r13+0x10]
 101ad3c:	mov    rsi,rbx
 101ad3f:	mov    rdx,r12
 101ad42:	call   1037520 <memcpy@plt>
 101ad47:	test   r12,r12
 101ad4a:	mov    rbx,QWORD PTR [rbp-0x30]
 101ad4e:	js     101ae0a <lyr_p1_reg_main+0x3aa>
 101ad54:	cmp    r12,r14
 101ad57:	mov    r14,r12
 101ad5a:	mov    ecx,DWORD PTR [rbp-0x58]
 101ad5d:	jg     101ac80 <lyr_p1_reg_main+0x220>
 101ad63:	jmp    101b050 <lyr_p1_reg_main+0x5f0>
 101ad68:	mov    edi,0x11
 101ad6d:	vzeroupper
 101ad70:	call   101e8e0 <allocate.llvm.8023764427486792703>
 101ad75:	mov    rsi,rax
 101ad78:	jmp    101acc0 <lyr_p1_reg_main+0x260>
 101ad7d:	mov    eax,DWORD PTR [rip+0x2352d]        # 103e2b0 <lyr_gc_stop_requested>
 101ad83:	mov    ecx,0x400
 101ad88:	test   eax,eax
 101ad8a:	je     101ac88 <lyr_p1_reg_main+0x228>
 101ad90:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101ad99:	test   rdi,rdi
 101ad9c:	je     101adf6 <lyr_p1_reg_main+0x396>
 101ad9e:	mov    eax,DWORD PTR [rip+0x2350c]        # 103e2b0 <lyr_gc_stop_requested>
 101ada4:	test   eax,eax
 101ada6:	je     101adf6 <lyr_p1_reg_main+0x396>
 101ada8:	vzeroupper
 101adab:	call   101f270 <park_here.llvm.8023764427486792703>
 101adb0:	mov    rbx,QWORD PTR [rbp-0x30]
 101adb4:	mov    ecx,0x400
 101adb9:	jmp    101ac88 <lyr_p1_reg_main+0x228>
 101adbe:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101adc7:	test   rdi,rdi
 101adca:	je     101c2da <lyr_p1_reg_main+0x187a>
 101add0:	mov    eax,DWORD PTR [rip+0x234da]        # 103e2b0 <lyr_gc_stop_requested>
 101add6:	test   eax,eax
 101add8:	je     101ade4 <lyr_p1_reg_main+0x384>
 101adda:	call   101f270 <park_here.llvm.8023764427486792703>
 101addf:	jmp    101acfc <lyr_p1_reg_main+0x29c>
 101ade4:	cmp    QWORD PTR [rdi+0xb0],rbx
 101adeb:	jbe    101acfc <lyr_p1_reg_main+0x29c>
 101adf1:	jmp    101c2da <lyr_p1_reg_main+0x187a>
 101adf6:	mov    rbx,QWORD PTR [rbp-0x30]
 101adfa:	jmp    101ac88 <lyr_p1_reg_main+0x228>
 101adff:	nop
 101ae00:	movabs r12,0xfffffffa00000000
 101ae0a:	neg    r12
 101ae0d:	mov    r13d,DWORD PTR [rbp-0x40]
 101ae11:	jo     101c147 <lyr_p1_reg_main+0x16e7>
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
 101ae3e:	vmovdqa XMMWORD PTR [rbp-0xc0],xmm0
 101ae46:	mov    QWORD PTR [rbp-0xb0],0x0
 101ae51:	mov    DWORD PTR [rbp-0x90],eax
 101ae57:	mov    DWORD PTR [rbp-0x8c],0x0
 101ae61:	mov    QWORD PTR [rbp-0x88],rdx
 101ae68:	mov    QWORD PTR [rbp-0x80],0x0
 101ae70:	mov    rcx,QWORD PTR [rip+0x23701]        # 103e578 <lyr_gc_heap_base>
 101ae77:	lea    rax,[rbp-0x80]
 101ae7b:	sub    rax,rcx
 101ae7e:	mov    rdx,QWORD PTR [rip+0x236fb]        # 103e580 <lyr_gc_heap_span>
 101ae85:	cmp    rax,rdx
 101ae88:	jae    101aea7 <lyr_p1_reg_main+0x447>
 101ae8a:	mov    rcx,QWORD PTR [rip+0x236f7]        # 103e588 <lyr_gc_cards>
 101ae91:	shr    rax,0x8
 101ae95:	mov    BYTE PTR [rcx+rax*1],0x1
 101ae99:	mov    rcx,QWORD PTR [rip+0x236d8]        # 103e578 <lyr_gc_heap_base>
 101aea0:	mov    rdx,QWORD PTR [rip+0x236d9]        # 103e580 <lyr_gc_heap_span>
 101aea7:	mov    QWORD PTR [rbp-0x78],0x1004148
 101aeaf:	lea    rax,[rbp-0x78]
 101aeb3:	sub    rax,rcx
 101aeb6:	cmp    rax,rdx
 101aeb9:	mov    r15,QWORD PTR [rbp-0x50]
 101aebd:	mov    r12,QWORD PTR [rbp-0x38]
 101aec1:	jae    101aee0 <lyr_p1_reg_main+0x480>
 101aec3:	mov    rcx,QWORD PTR [rip+0x236be]        # 103e588 <lyr_gc_cards>
 101aeca:	shr    rax,0x8
 101aece:	mov    BYTE PTR [rcx+rax*1],0x1
 101aed2:	mov    rcx,QWORD PTR [rip+0x2369f]        # 103e578 <lyr_gc_heap_base>
 101aed9:	mov    rdx,QWORD PTR [rip+0x236a0]        # 103e580 <lyr_gc_heap_span>
 101aee0:	mov    rax,QWORD PTR [rbp-0xb0]
 101aee7:	lea    rsi,[rbp-0x70]
 101aeeb:	mov    QWORD PTR [rsi+0x10],rax
 101aeef:	vmovdqa xmm0,XMMWORD PTR [rbp-0xc0]
 101aef7:	vmovdqu XMMWORD PTR [rsi],xmm0
 101aefb:	mov    rax,rsi
 101aefe:	sub    rax,rcx
 101af01:	cmp    rax,rdx
 101af04:	jae    101af90 <lyr_p1_reg_main+0x530>
 101af0a:	mov    rcx,rax
 101af0d:	shr    rcx,0x8
 101af11:	add    rax,0x17
 101af15:	shr    rax,0x8
 101af19:	mov    rdx,rax
 101af1c:	sub    rdx,rcx
 101af1f:	jb     101af90 <lyr_p1_reg_main+0x530>
 101af21:	inc    rax
 101af24:	mov    esi,eax
 101af26:	sub    esi,ecx
 101af28:	and    esi,0x3
 101af2b:	je     101af43 <lyr_p1_reg_main+0x4e3>
 101af2d:	neg    rsi
 101af30:	mov    rdi,QWORD PTR [rip+0x23651]        # 103e588 <lyr_gc_cards>
 101af37:	mov    BYTE PTR [rdi+rcx*1],0x1
 101af3b:	inc    rcx
 101af3e:	inc    rsi
 101af41:	jne    101af30 <lyr_p1_reg_main+0x4d0>
 101af43:	cmp    rdx,0x3
 101af47:	jb     101af90 <lyr_p1_reg_main+0x530>
 101af49:	nop    DWORD PTR [rax+0x0]
 101af50:	mov    rdx,QWORD PTR [rip+0x23631]        # 103e588 <lyr_gc_cards>
 101af57:	mov    BYTE PTR [rdx+rcx*1],0x1
 101af5b:	mov    rdx,QWORD PTR [rip+0x23626]        # 103e588 <lyr_gc_cards>
 101af62:	mov    BYTE PTR [rdx+rcx*1+0x1],0x1
 101af67:	mov    rdx,QWORD PTR [rip+0x2361a]        # 103e588 <lyr_gc_cards>
 101af6e:	mov    BYTE PTR [rdx+rcx*1+0x2],0x1
 101af73:	mov    rdx,QWORD PTR [rip+0x2360e]        # 103e588 <lyr_gc_cards>
 101af7a:	mov    BYTE PTR [rdx+rcx*1+0x3],0x1
 101af7f:	add    rcx,0x4
 101af83:	cmp    rax,rcx
 101af86:	jne    101af50 <lyr_p1_reg_main+0x4f0>
 101af88:	nop    DWORD PTR [rax+rax*1+0x0]
 101af90:	vmovups ymm0,YMMWORD PTR [rbp-0x90]
 101af98:	vmovups ymm1,YMMWORD PTR [rbp-0x78]
 101af9d:	vmovups YMMWORD PTR [rbp-0xe8],ymm1
 101afa5:	vmovups YMMWORD PTR [rbp-0x100],ymm0
 101afad:	mov    r14,QWORD PTR fs:0xffffffffffffffe8
 101afb6:	mov    rcx,QWORD PTR fs:0xfffffffffffffff0
 101afbf:	mov    rax,rcx
 101afc2:	sub    rax,r14
 101afc5:	cmp    rax,0x40
 101afc9:	jb     101b153 <lyr_p1_reg_main+0x6f3>
 101afcf:	lea    rax,[r14+0x40]
 101afd3:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101afdc:	test   r14,r14
 101afdf:	je     101b153 <lyr_p1_reg_main+0x6f3>
 101afe5:	mov    QWORD PTR [r14],0x1003c10
 101afec:	vmovdqu ymm0,YMMWORD PTR [rbp-0x100]
 101aff4:	vmovdqu ymm1,YMMWORD PTR [rbp-0xe8]
 101affc:	vmovdqu YMMWORD PTR [r14+0x20],ymm1
 101b002:	vmovdqu YMMWORD PTR [r14+0x8],ymm0
 101b008:	sub    rcx,rax
 101b00b:	cmp    rcx,0x30
 101b00f:	jb     101b181 <lyr_p1_reg_main+0x721>
 101b015:	lea    rcx,[rax+0x30]
 101b019:	mov    QWORD PTR fs:0xffffffffffffffe8,rcx
 101b022:	test   rax,rax
 101b025:	je     101b181 <lyr_p1_reg_main+0x721>
 101b02b:	mov    QWORD PTR [rax],0x10042c8
 101b032:	mov    QWORD PTR [rax+0x8],r14
 101b036:	mov    QWORD PTR [rax+0x10],0x1003c68
 101b03e:	xor    esi,esi
 101b040:	jmp    101b0af <lyr_p1_reg_main+0x64f>
 101b042:	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 101b050:	mov    QWORD PTR [rbp-0xa0],r13
 101b057:	lea    rax,[rbp-0xa0]
 101b05e:	sub    rax,QWORD PTR [rip+0x23513]        # 103e578 <lyr_gc_heap_base>
 101b065:	cmp    rax,QWORD PTR [rip+0x23514]        # 103e580 <lyr_gc_heap_span>
 101b06c:	jae    101b084 <lyr_p1_reg_main+0x624>
 101b06e:	mov    rcx,QWORD PTR [rip+0x23513]        # 103e588 <lyr_gc_cards>
 101b075:	shr    rax,0x8
 101b079:	mov    BYTE PTR [rcx+rax*1],0x1
 101b07d:	mov    r13,QWORD PTR [rbp-0xa0]
 101b084:	mov    rdx,QWORD PTR [r13+0x8]
 101b088:	cmp    r12,rdx
 101b08b:	ja     101c13d <lyr_p1_reg_main+0x16dd>
 101b091:	add    r13,0x10
 101b095:	mov    rdi,r13
 101b098:	mov    rsi,r12
 101b09b:	call   1024790 <lyr_str_from_utf8_lossy>
 101b0a0:	mov    rsi,rax
 101b0a3:	mov    r15,QWORD PTR [rbp-0x50]
 101b0a7:	mov    r12,QWORD PTR [rbp-0x38]
 101b0ab:	mov    r13d,DWORD PTR [rbp-0x40]
 101b0af:	test   rsi,rsi
 101b0b2:	mov    eax,0x1004130
 101b0b7:	cmove  rsi,rax
 101b0bb:	mov    rdi,r15
 101b0be:	vzeroupper
 101b0c1:	call   101cc20 <lyr_std_collections_List_string__push_0ca72eae>
 101b0c6:	dec    r13d
 101b0c9:	je     101b115 <lyr_p1_reg_main+0x6b5>
 101b0cb:	inc    r12
 101b0ce:	dec    r13d
 101b0d1:	jne    101abc0 <lyr_p1_reg_main+0x160>
 101b0d7:	jmp    101ab83 <lyr_p1_reg_main+0x123>
 101b0dc:	mov    edi,0x10
 101b0e1:	call   101e8e0 <allocate.llvm.8023764427486792703>
 101b0e6:	mov    r14,rax
 101b0e9:	jmp    101ac02 <lyr_p1_reg_main+0x1a2>
 101b0ee:	mov    rdi,rbx
 101b0f1:	call   101f2a0 <lyr_gc_stack_slow>
 101b0f6:	jmp    101ac1f <lyr_p1_reg_main+0x1bf>
 101b0fb:	mov    rdi,rbx
 101b0fe:	call   101f2a0 <lyr_gc_stack_slow>
 101b103:	jmp    101ac31 <lyr_p1_reg_main+0x1d1>
 101b108:	mov    rdi,rbx
 101b10b:	call   101f2a0 <lyr_gc_stack_slow>
 101b110:	jmp    101ac4f <lyr_p1_reg_main+0x1ef>
 101b115:	mov    eax,DWORD PTR [rip+0x23195]        # 103e2b0 <lyr_gc_stop_requested>
 101b11b:	mov    r13d,0x400
 101b121:	test   eax,eax
 101b123:	je     101b0cb <lyr_p1_reg_main+0x66b>
 101b125:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101b12e:	test   rdi,rdi
 101b131:	je     101b142 <lyr_p1_reg_main+0x6e2>
 101b133:	mov    eax,DWORD PTR [rip+0x23177]        # 103e2b0 <lyr_gc_stop_requested>
 101b139:	test   eax,eax
 101b13b:	je     101b142 <lyr_p1_reg_main+0x6e2>
 101b13d:	call   101f270 <park_here.llvm.8023764427486792703>
 101b142:	mov    rbx,QWORD PTR [rbp-0x30]
 101b146:	mov    r15,QWORD PTR [rbp-0x50]
 101b14a:	mov    r12,QWORD PTR [rbp-0x38]
 101b14e:	jmp    101b0cb <lyr_p1_reg_main+0x66b>
 101b153:	mov    edi,0x40
 101b158:	vzeroupper
 101b15b:	call   101e8e0 <allocate.llvm.8023764427486792703>
 101b160:	mov    r14,rax
 101b163:	mov    QWORD PTR [rax],0x1003c10
 101b16a:	mov    rax,QWORD PTR fs:0xffffffffffffffe8
 101b173:	mov    rcx,QWORD PTR fs:0xfffffffffffffff0
 101b17c:	jmp    101afec <lyr_p1_reg_main+0x58c>
 101b181:	mov    edi,0x28
 101b186:	vzeroupper
 101b189:	call   101e8e0 <allocate.llvm.8023764427486792703>
 101b18e:	jmp    101b02b <lyr_p1_reg_main+0x5cb>
 101b193:	mov    rdi,r15
 101b196:	call   101cf00 <lyr_std_collections_List_string__toArray_196324b0>
 101b19b:	mov    r12d,0x5f5e100
 101b1a1:	cmp    QWORD PTR [rax+0x8],0x2
 101b1a6:	jl     101b1ef <lyr_p1_reg_main+0x78f>
 101b1a8:	mov    rdi,QWORD PTR [rax+0x18]
 101b1ac:	mov    rsi,QWORD PTR [rdi+0x8]
 101b1b0:	add    rdi,0x10
 101b1b4:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101b1bd:	cmp    rax,rbx
 101b1c0:	ja     101c236 <lyr_p1_reg_main+0x17d6>
 101b1c6:	mov    QWORD PTR [rbp-0x90],0x0
 101b1d1:	lea    rcx,[rbp-0x90]
 101b1d8:	mov    edx,0xa
 101b1dd:	call   101d120 <lyr_std_core_parseInteger_int__340d5225>
 101b1e2:	cmp    QWORD PTR [rbp-0x90],0x0
 101b1ea:	jne    101b1ef <lyr_p1_reg_main+0x78f>
 101b1ec:	mov    r12,rax
 101b1ef:	mov    r15,QWORD PTR fs:0xffffffffffffffe8
 101b1f8:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101b201:	sub    rax,r15
 101b204:	cmp    rax,0x80
 101b20a:	jb     101c1a7 <lyr_p1_reg_main+0x1747>
 101b210:	lea    rax,[r15+0x80]
 101b217:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101b220:	test   r15,r15
 101b223:	je     101c1a7 <lyr_p1_reg_main+0x1747>
 101b229:	mov    QWORD PTR [r15],0x1003b30
 101b230:	mov    QWORD PTR [r15+0x8],0xe
 101b238:	mov    BYTE PTR [r15+0x10],0xb
 101b23d:	mov    DWORD PTR [r15+0x11],0x0
 101b245:	mov    DWORD PTR [r15+0x14],0x0
 101b24d:	vmovaps ymm0,YMMWORD PTR [rip+0xfffffffffffe864b]        # 10038a0 <.str.15.llvm.16766894347181747790+0x9cb>
 101b255:	vmovups YMMWORD PTR [r15+0x18],ymm0
 101b25b:	vmovaps ymm0,YMMWORD PTR [rip+0xfffffffffffe85fd]        # 1003860 <.str.15.llvm.16766894347181747790+0x98b>
 101b263:	vmovups YMMWORD PTR [r15+0x38],ymm0
 101b269:	vmovdqa ymm0,YMMWORD PTR [rip+0xfffffffffffe85cf]        # 1003840 <.str.15.llvm.16766894347181747790+0x96b>
 101b271:	vmovdqu YMMWORD PTR [r15+0x58],ymm0
 101b277:	mov    BYTE PTR [r15+0x78],0x8
 101b27c:	mov    DWORD PTR [r15+0x79],0x0
 101b284:	mov    DWORD PTR [r15+0x7c],0x0
 101b28c:	mov    rsi,QWORD PTR fs:0xffffffffffffffe8
 101b295:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101b29e:	sub    rax,rsi
 101b2a1:	cmp    rax,0x20
 101b2a5:	jb     101c1be <lyr_p1_reg_main+0x175e>
 101b2ab:	lea    rax,[rsi+0x20]
 101b2af:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101b2b8:	test   rsi,rsi
 101b2bb:	je     101c1be <lyr_p1_reg_main+0x175e>
 101b2c1:	mov    QWORD PTR [rsi],0x1003b58
 101b2c8:	mov    QWORD PTR [rsi+0x8],0x1
 101b2d0:	mov    QWORD PTR [rsi+0x10],0x0
 101b2d8:	mov    edi,0x1003b58
 101b2dd:	mov    edx,0x10
 101b2e2:	vzeroupper
 101b2e5:	call   101df10 <lyr_arr_repeat>
 101b2ea:	mov    QWORD PTR [rbp-0x48],rax
 101b2ee:	mov    rax,QWORD PTR fs:0xffffffffffffffe8
 101b2f7:	mov    rcx,QWORD PTR fs:0xfffffffffffffff0
 101b300:	sub    rcx,rax
 101b303:	cmp    rcx,0x30
 101b307:	jb     101c1d8 <lyr_p1_reg_main+0x1778>
 101b30d:	lea    rsi,[rax+0x30]
 101b311:	mov    QWORD PTR fs:0xffffffffffffffe8,rsi
 101b31a:	test   rax,rax
 101b31d:	je     101c1d8 <lyr_p1_reg_main+0x1778>
 101b323:	mov    QWORD PTR [rax],0x1003b58
 101b32a:	mov    QWORD PTR [rax+0x8],0x3
 101b332:	mov    QWORD PTR [rax+0x10],r12
 101b336:	mov    ecx,0x9e3779b9
 101b33b:	mov    QWORD PTR [rax+0x18],rcx
 101b33f:	movabs rcx,0x3fffffffffffffff
 101b349:	mov    QWORD PTR [rbp-0x30],rax
 101b34d:	mov    QWORD PTR [rax+0x20],rcx
 101b351:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101b35a:	sub    rax,rsi
 101b35d:	cmp    rax,0x20
 101b361:	jb     101c1f5 <lyr_p1_reg_main+0x1795>
 101b367:	lea    rax,[rsi+0x20]
 101b36b:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101b374:	test   rsi,rsi
 101b377:	je     101c1f5 <lyr_p1_reg_main+0x1795>
 101b37d:	mov    QWORD PTR [rsi],0x1003b58
 101b384:	mov    QWORD PTR [rsi+0x8],0x1
 101b38c:	mov    QWORD PTR [rsi+0x10],0x0
 101b394:	mov    edi,0x1003b58
 101b399:	mov    edx,0x400
 101b39e:	call   101df10 <lyr_arr_repeat>
 101b3a3:	mov    QWORD PTR [rbp-0x40],rax
 101b3a7:	mov    rsi,QWORD PTR fs:0xffffffffffffffe8
 101b3b0:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101b3b9:	sub    rax,rsi
 101b3bc:	cmp    rax,0x20
 101b3c0:	jb     101c20c <lyr_p1_reg_main+0x17ac>
 101b3c6:	lea    rax,[rsi+0x20]
 101b3ca:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101b3d3:	test   rsi,rsi
 101b3d6:	je     101c20c <lyr_p1_reg_main+0x17ac>
 101b3dc:	mov    QWORD PTR [rsi],0x1003b80
 101b3e3:	mov    QWORD PTR [rsi+0x8],0x1
 101b3eb:	mov    QWORD PTR [rsi+0x10],0x0
 101b3f3:	mov    edi,0x1003b80
 101b3f8:	mov    edx,0x100
 101b3fd:	call   101df10 <lyr_arr_repeat>
 101b402:	mov    r11,rax
 101b405:	add    rbx,0xffffffffffffad20
 101b40c:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101b415:	cmp    rbx,rax
 101b418:	jb     101c223 <lyr_p1_reg_main+0x17c3>
 101b41e:	mov    r8,QWORD PTR [rbp-0x48]
 101b422:	mov    r14,r8
 101b425:	add    r14,0x10
 101b429:	mov    r13d,0x400
 101b42f:	xor    ebx,ebx
 101b431:	mov    QWORD PTR [rbp-0x58],0x0
 101b439:	xor    r12d,r12d
 101b43c:	mov    r9,QWORD PTR [rbp-0x30]
 101b440:	mov    r10,QWORD PTR [rbp-0x40]
 101b444:	jmp    101b464 <lyr_p1_reg_main+0xa04>
 101b446:	mov    rcx,QWORD PTR [r14+rcx*8]
 101b44a:	add    rcx,QWORD PTR [r14+rax*8]
 101b44e:	mov    QWORD PTR [r14+rdi*8],rcx
 101b452:	inc    r12
 101b455:	jo     101c130 <lyr_p1_reg_main+0x16d0>
 101b45b:	dec    r13d
 101b45e:	je     101bc75 <lyr_p1_reg_main+0x1215>
 101b464:	dec    r13d
 101b467:	je     101bc2b <lyr_p1_reg_main+0x11cb>
 101b46d:	mov    rsi,QWORD PTR [r15+0x8]
 101b471:	cmp    r12,rsi
 101b474:	jae    101be6a <lyr_p1_reg_main+0x140a>
 101b47a:	inc    rbx
 101b47d:	jo     101c130 <lyr_p1_reg_main+0x16d0>
 101b483:	movzx  edx,BYTE PTR [r15+r12*8+0x10]
 101b489:	cmp    rdx,0x2f
 101b48d:	ja     101c2ce <lyr_p1_reg_main+0x186e>
 101b493:	movzx  edi,WORD PTR [r15+r12*8+0x12]
 101b499:	movzx  eax,WORD PTR [r15+r12*8+0x14]
 101b49f:	movzx  ecx,WORD PTR [r15+r12*8+0x16]
 101b4a5:	jmp    QWORD PTR [rdx*8+0x10038e0]
 101b4ac:	mov    rsi,QWORD PTR [r8+0x8]
 101b4b0:	cmp    rsi,rax
 101b4b3:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b4b9:	cmp    rsi,rcx
 101b4bc:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b4c2:	cmp    rsi,rdi
 101b4c5:	ja     101b446 <lyr_p1_reg_main+0x9e6>
 101b4cb:	jmp    101be6d <lyr_p1_reg_main+0x140d>
 101b4d0:	mov    rsi,QWORD PTR [r8+0x8]
 101b4d4:	cmp    rsi,rax
 101b4d7:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b4dd:	cmp    rsi,rcx
 101b4e0:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b4e6:	mov    rax,QWORD PTR [r14+rax*8]
 101b4ea:	mov    rcx,QWORD PTR [r14+rcx*8]
 101b4ee:	cmp    rax,rcx
 101b4f1:	jb     101bbff <lyr_p1_reg_main+0x119f>
 101b4f7:	jmp    101bbfc <lyr_p1_reg_main+0x119c>
 101b4fc:	mov    rsi,QWORD PTR [r8+0x8]
 101b500:	cmp    rsi,rdi
 101b503:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b509:	cmp    rsi,rax
 101b50c:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b512:	mov    rdx,QWORD PTR [r14+rdi*8]
 101b516:	cmp    rdx,QWORD PTR [r14+rax*8]
 101b51a:	je     101b452 <lyr_p1_reg_main+0x9f2>
 101b520:	jmp    101bb95 <lyr_p1_reg_main+0x1135>
 101b525:	mov    rsi,QWORD PTR [r8+0x8]
 101b529:	cmp    rsi,rax
 101b52c:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b532:	cmp    rsi,rdi
 101b535:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b53b:	mov    rax,QWORD PTR [r14+rax*8]
 101b53f:	xor    rax,rcx
 101b542:	mov    QWORD PTR [r14+rdi*8],rax
 101b546:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b54b:	mov    rsi,QWORD PTR [r8+0x8]
 101b54f:	cmp    rsi,rax
 101b552:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b558:	mov    rax,QWORD PTR [r14+rax*8]
 101b55c:	add    rax,rcx
 101b55f:	mov    rcx,QWORD PTR [r10+0x8]
 101b563:	cmp    rax,rcx
 101b566:	jae    101c156 <lyr_p1_reg_main+0x16f6>
 101b56c:	cmp    rsi,rdi
 101b56f:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b575:	mov    rax,QWORD PTR [r10+rax*8+0x10]
 101b57a:	jmp    101bbc7 <lyr_p1_reg_main+0x1167>
 101b57f:	mov    rsi,QWORD PTR [r8+0x8]
 101b583:	cmp    rsi,rax
 101b586:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b58c:	cmp    rsi,rdi
 101b58f:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b595:	mov    rax,QWORD PTR [r14+rax*8]
 101b599:	not    rax
 101b59c:	mov    QWORD PTR [r14+rdi*8],rax
 101b5a0:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b5a5:	mov    rsi,QWORD PTR [r8+0x8]
 101b5a9:	cmp    rsi,rdi
 101b5ac:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b5b2:	cmp    rsi,rax
 101b5b5:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b5bb:	mov    rdx,QWORD PTR [r14+rdi*8]
 101b5bf:	cmp    rdx,QWORD PTR [r14+rax*8]
 101b5c3:	jb     101b452 <lyr_p1_reg_main+0x9f2>
 101b5c9:	jmp    101bb95 <lyr_p1_reg_main+0x1135>
 101b5ce:	mov    rsi,QWORD PTR [r8+0x8]
 101b5d2:	cmp    rsi,rdi
 101b5d5:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b5db:	cmp    rsi,rax
 101b5de:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b5e4:	mov    rdx,QWORD PTR [r14+rdi*8]
 101b5e8:	cmp    rdx,QWORD PTR [r14+rax*8]
 101b5ec:	jne    101b452 <lyr_p1_reg_main+0x9f2>
 101b5f2:	jmp    101bb95 <lyr_p1_reg_main+0x1135>
 101b5f7:	mov    rsi,QWORD PTR [r8+0x8]
 101b5fb:	cmp    rsi,rax
 101b5fe:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b604:	cmp    rsi,rcx
 101b607:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b60d:	mov    rcx,QWORD PTR [r14+rcx*8]
 101b611:	test   rcx,rcx
 101b614:	je     101c151 <lyr_p1_reg_main+0x16f1>
 101b61a:	cmp    rsi,rdi
 101b61d:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b623:	mov    rax,QWORD PTR [r14+rax*8]
 101b627:	mov    rdx,rax
 101b62a:	or     rdx,rcx
 101b62d:	shr    rdx,0x20
 101b631:	je     101bc11 <lyr_p1_reg_main+0x11b1>
 101b637:	xor    edx,edx
 101b639:	div    rcx
 101b63c:	mov    QWORD PTR [r14+rdi*8],rdx
 101b640:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b645:	mov    rsi,QWORD PTR [r8+0x8]
 101b649:	cmp    rsi,rax
 101b64c:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b652:	cmp    rsi,rdi
 101b655:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b65b:	mov    rax,QWORD PTR [r14+rax*8]
 101b65f:	mov    QWORD PTR [r14+rdi*8],rax
 101b663:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b668:	mov    rsi,QWORD PTR [r8+0x8]
 101b66c:	cmp    rsi,rax
 101b66f:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b675:	cmp    rsi,rdi
 101b678:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b67e:	mov    rax,QWORD PTR [r14+rax*8]
 101b682:	add    rax,rcx
 101b685:	mov    rsi,QWORD PTR [r10+0x8]
 101b689:	cmp    rax,rsi
 101b68c:	jae    101be72 <lyr_p1_reg_main+0x1412>
 101b692:	mov    rcx,QWORD PTR [r14+rdi*8]
 101b696:	mov    QWORD PTR [r10+rax*8+0x10],rcx
 101b69b:	jmp    101bbcb <lyr_p1_reg_main+0x116b>
 101b6a0:	mov    rsi,QWORD PTR [r8+0x8]
 101b6a4:	cmp    rsi,rax
 101b6a7:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b6ad:	cmp    rsi,rdi
 101b6b0:	ja     101ba81 <lyr_p1_reg_main+0x1021>
 101b6b6:	jmp    101be6d <lyr_p1_reg_main+0x140d>
 101b6bb:	mov    rsi,QWORD PTR [r8+0x8]
 101b6bf:	cmp    rsi,rax
 101b6c2:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b6c8:	cmp    rsi,rcx
 101b6cb:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b6d1:	cmp    rsi,rdi
 101b6d4:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b6da:	mov    rcx,QWORD PTR [r14+rcx*8]
 101b6de:	xor    rcx,QWORD PTR [r14+rax*8]
 101b6e2:	jmp    101b44e <lyr_p1_reg_main+0x9ee>
 101b6e7:	mov    rsi,QWORD PTR [r8+0x8]
 101b6eb:	cmp    rsi,rax
 101b6ee:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b6f4:	cmp    rsi,rdi
 101b6f7:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b6fd:	imul   rcx,QWORD PTR [r14+rax*8]
 101b702:	jmp    101b44e <lyr_p1_reg_main+0x9ee>
 101b707:	mov    rsi,QWORD PTR [r8+0x8]
 101b70b:	cmp    rsi,rax
 101b70e:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b714:	cmp    rsi,rcx
 101b717:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b71d:	cmp    rsi,rdi
 101b720:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b726:	mov    rax,QWORD PTR [r14+rax*8]
 101b72a:	sub    rax,QWORD PTR [r14+rcx*8]
 101b72e:	mov    QWORD PTR [r14+rdi*8],rax
 101b732:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b737:	mov    rsi,QWORD PTR [r8+0x8]
 101b73b:	cmp    rsi,rax
 101b73e:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b744:	cmp    rsi,rdi
 101b747:	ja     101ba0c <lyr_p1_reg_main+0xfac>
 101b74d:	jmp    101be6d <lyr_p1_reg_main+0x140d>
 101b752:	mov    rsi,QWORD PTR [r8+0x8]
 101b756:	cmp    rsi,rax
 101b759:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b75f:	cmp    rsi,rcx
 101b762:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b768:	mov    rax,QWORD PTR [r14+rax*8]
 101b76c:	cmp    rax,QWORD PTR [r14+rcx*8]
 101b770:	jae    101b85e <lyr_p1_reg_main+0xdfe>
 101b776:	mov    eax,0x1
 101b77b:	jmp    101bbff <lyr_p1_reg_main+0x119f>
 101b780:	mov    rsi,QWORD PTR [r8+0x8]
 101b784:	cmp    rsi,rax
 101b787:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b78d:	cmp    rsi,rcx
 101b790:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b796:	cmp    rsi,rdi
 101b799:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b79f:	mov    rcx,QWORD PTR [r14+rcx*8]
 101b7a3:	imul   rcx,QWORD PTR [r14+rax*8]
 101b7a8:	jmp    101b44e <lyr_p1_reg_main+0x9ee>
 101b7ad:	mov    rsi,QWORD PTR [r8+0x8]
 101b7b1:	cmp    rsi,rax
 101b7b4:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b7ba:	cmp    rsi,rdi
 101b7bd:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b7c3:	mov    rax,QWORD PTR [r14+rax*8]
 101b7c7:	add    rax,rcx
 101b7ca:	mov    QWORD PTR [r14+rdi*8],rax
 101b7ce:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b7d3:	mov    rsi,QWORD PTR [r8+0x8]
 101b7d7:	cmp    rsi,rax
 101b7da:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b7e0:	cmp    rsi,rdi
 101b7e3:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b7e9:	xor    ecx,ecx
 101b7eb:	sub    rcx,QWORD PTR [r14+rax*8]
 101b7ef:	jmp    101b44e <lyr_p1_reg_main+0x9ee>
 101b7f4:	mov    rsi,QWORD PTR [r8+0x8]
 101b7f8:	cmp    rsi,rdi
 101b7fb:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b801:	cmp    QWORD PTR [r14+rdi*8],0x0
 101b806:	jne    101b452 <lyr_p1_reg_main+0x9f2>
 101b80c:	jmp    101bb95 <lyr_p1_reg_main+0x1135>
 101b811:	mov    rsi,QWORD PTR [r8+0x8]
 101b815:	cmp    rsi,rdi
 101b818:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b81e:	cmp    rsi,rax
 101b821:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b827:	mov    rdx,QWORD PTR [r14+rdi*8]
 101b82b:	cmp    rdx,QWORD PTR [r14+rax*8]
 101b82f:	ja     101b452 <lyr_p1_reg_main+0x9f2>
 101b835:	jmp    101bb95 <lyr_p1_reg_main+0x1135>
 101b83a:	mov    rsi,QWORD PTR [r8+0x8]
 101b83e:	cmp    rsi,rax
 101b841:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b847:	cmp    rsi,rcx
 101b84a:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b850:	mov    rax,QWORD PTR [r14+rax*8]
 101b854:	cmp    rax,QWORD PTR [r14+rcx*8]
 101b858:	jae    101b776 <lyr_p1_reg_main+0xd16>
 101b85e:	cmp    rsi,rdi
 101b861:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b867:	xor    eax,eax
 101b869:	mov    QWORD PTR [r14+rdi*8],rax
 101b86d:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b872:	mov    rsi,QWORD PTR [r8+0x8]
 101b876:	cmp    rsi,rax
 101b879:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b87f:	cmp    rsi,rcx
 101b882:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b888:	mov    rax,QWORD PTR [r14+rax*8]
 101b88c:	cmp    rax,QWORD PTR [r14+rcx*8]
 101b890:	je     101b776 <lyr_p1_reg_main+0xd16>
 101b896:	jmp    101b85e <lyr_p1_reg_main+0xdfe>
 101b898:	mov    rsi,QWORD PTR [r8+0x8]
 101b89c:	cmp    rsi,rax
 101b89f:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b8a5:	cmp    rsi,rcx
 101b8a8:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b8ae:	cmp    rsi,rdi
 101b8b1:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b8b7:	mov    rcx,QWORD PTR [r14+rcx*8]
 101b8bb:	and    rcx,QWORD PTR [r14+rax*8]
 101b8bf:	jmp    101b44e <lyr_p1_reg_main+0x9ee>
 101b8c4:	mov    rsi,QWORD PTR [r8+0x8]
 101b8c8:	cmp    rsi,rax
 101b8cb:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b8d1:	cmp    rsi,rcx
 101b8d4:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b8da:	mov    rcx,QWORD PTR [r14+rcx*8]
 101b8de:	test   rcx,rcx
 101b8e1:	je     101c151 <lyr_p1_reg_main+0x16f1>
 101b8e7:	cmp    rsi,rdi
 101b8ea:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b8f0:	mov    rax,QWORD PTR [r14+rax*8]
 101b8f4:	mov    rdx,rax
 101b8f7:	or     rdx,rcx
 101b8fa:	shr    rdx,0x20
 101b8fe:	je     101bc1e <lyr_p1_reg_main+0x11be>
 101b904:	xor    edx,edx
 101b906:	div    rcx
 101b909:	jmp    101bc08 <lyr_p1_reg_main+0x11a8>
 101b90e:	mov    rsi,QWORD PTR [r8+0x8]
 101b912:	cmp    rsi,rdi
 101b915:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b91b:	dec    QWORD PTR [r14+rdi*8]
 101b91f:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b924:	mov    rdi,QWORD PTR [rbp-0x58]
 101b928:	dec    rdi
 101b92b:	jo     101c147 <lyr_p1_reg_main+0x16e7>
 101b931:	mov    rsi,QWORD PTR [r11+0x8]
 101b935:	cmp    rdi,rsi
 101b938:	jae    101be6d <lyr_p1_reg_main+0x140d>
 101b93e:	mov    QWORD PTR [rbp-0x58],rdi
 101b942:	mov    r12,QWORD PTR [r11+rdi*8+0x10]
 101b947:	jmp    101b45b <lyr_p1_reg_main+0x9fb>
 101b94c:	mov    rsi,QWORD PTR [r8+0x8]
 101b950:	cmp    rsi,rax
 101b953:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b959:	cmp    rsi,rdi
 101b95c:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b962:	mov    eax,DWORD PTR [r14+rax*8]
 101b966:	and    eax,ecx
 101b968:	mov    QWORD PTR [r14+rdi*8],rax
 101b96c:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b971:	mov    rsi,QWORD PTR [r8+0x8]
 101b975:	cmp    rsi,rdi
 101b978:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b97e:	cmp    rsi,rax
 101b981:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b987:	mov    rdx,QWORD PTR [r14+rdi*8]
 101b98b:	cmp    rdx,QWORD PTR [r14+rax*8]
 101b98f:	jae    101b452 <lyr_p1_reg_main+0x9f2>
 101b995:	jmp    101bb95 <lyr_p1_reg_main+0x1135>
 101b99a:	mov    rsi,QWORD PTR [r8+0x8]
 101b99e:	cmp    rsi,rax
 101b9a1:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b9a7:	cmp    rsi,rdi
 101b9aa:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b9b0:	mov    rax,QWORD PTR [r14+rax*8]
 101b9b4:	sub    rax,rcx
 101b9b7:	mov    QWORD PTR [r14+rdi*8],rax
 101b9bb:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b9c0:	mov    rsi,QWORD PTR [r9+0x8]
 101b9c4:	cmp    rsi,rax
 101b9c7:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b9cd:	mov    rsi,QWORD PTR [r8+0x8]
 101b9d1:	cmp    rsi,rdi
 101b9d4:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101b9da:	mov    rax,QWORD PTR [r9+rax*8+0x10]
 101b9df:	mov    QWORD PTR [r14+rdi*8],rax
 101b9e3:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101b9e8:	mov    rsi,QWORD PTR [r8+0x8]
 101b9ec:	cmp    rsi,rax
 101b9ef:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101b9f5:	cmp    rsi,rcx
 101b9f8:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101b9fe:	cmp    rsi,rdi
 101ba01:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101ba07:	movzx  ecx,BYTE PTR [r14+rcx*8]
 101ba0c:	shlx   rax,QWORD PTR [r14+rax*8],rcx
 101ba12:	mov    QWORD PTR [r14+rdi*8],rax
 101ba16:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101ba1b:	mov    rsi,QWORD PTR [r8+0x8]
 101ba1f:	cmp    rsi,rax
 101ba22:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101ba28:	cmp    rsi,rcx
 101ba2b:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101ba31:	cmp    rsi,rdi
 101ba34:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101ba3a:	mov    rcx,QWORD PTR [r14+rcx*8]
 101ba3e:	or     rcx,QWORD PTR [r14+rax*8]
 101ba42:	jmp    101b44e <lyr_p1_reg_main+0x9ee>
 101ba47:	mov    rsi,QWORD PTR [r8+0x8]
 101ba4b:	cmp    rsi,rdi
 101ba4e:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101ba54:	inc    QWORD PTR [r14+rdi*8]
 101ba58:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101ba5d:	mov    rsi,QWORD PTR [r8+0x8]
 101ba61:	cmp    rsi,rax
 101ba64:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101ba6a:	cmp    rsi,rcx
 101ba6d:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101ba73:	cmp    rsi,rdi
 101ba76:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101ba7c:	movzx  ecx,BYTE PTR [r14+rcx*8]
 101ba81:	shrx   rax,QWORD PTR [r14+rax*8],rcx
 101ba87:	mov    QWORD PTR [r14+rdi*8],rax
 101ba8b:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101ba90:	mov    rsi,QWORD PTR [r8+0x8]
 101ba94:	cmp    rsi,rax
 101ba97:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101ba9d:	cmp    rsi,rcx
 101baa0:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101baa6:	mov    rax,QWORD PTR [r14+rax*8]
 101baaa:	cmp    rax,QWORD PTR [r14+rcx*8]
 101baae:	je     101b85e <lyr_p1_reg_main+0xdfe>
 101bab4:	jmp    101b776 <lyr_p1_reg_main+0xd16>
 101bab9:	mov    rsi,QWORD PTR [r8+0x8]
 101babd:	cmp    rsi,rax
 101bac0:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101bac6:	cmp    rsi,rdi
 101bac9:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101bacf:	mov    rax,QWORD PTR [r14+rax*8]
 101bad3:	or     rax,rcx
 101bad6:	mov    QWORD PTR [r14+rdi*8],rax
 101bada:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101badf:	inc    r12
 101bae2:	jo     101c130 <lyr_p1_reg_main+0x16d0>
 101bae8:	mov    rsi,QWORD PTR [r11+0x8]
 101baec:	mov    rdi,QWORD PTR [rbp-0x58]
 101baf0:	cmp    rdi,rsi
 101baf3:	jae    101be6d <lyr_p1_reg_main+0x140d>
 101baf9:	mov    QWORD PTR [r11+rdi*8+0x10],r12
 101bafe:	inc    rdi
 101bb01:	jo     101c130 <lyr_p1_reg_main+0x16d0>
 101bb07:	mov    QWORD PTR [rbp-0x58],rdi
 101bb0b:	mov    r12,rcx
 101bb0e:	jmp    101b45b <lyr_p1_reg_main+0x9fb>
 101bb13:	mov    rsi,QWORD PTR [r8+0x8]
 101bb17:	cmp    rsi,rdi
 101bb1a:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101bb20:	shl    ecx,0x10
 101bb23:	or     rcx,rax
 101bb26:	jmp    101b44e <lyr_p1_reg_main+0x9ee>
 101bb2b:	mov    rsi,QWORD PTR [r8+0x8]
 101bb2f:	cmp    rsi,rax
 101bb32:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101bb38:	cmp    rsi,rcx
 101bb3b:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101bb41:	mov    rax,QWORD PTR [r14+rax*8]
 101bb45:	cmp    rax,QWORD PTR [r14+rcx*8]
 101bb49:	ja     101b85e <lyr_p1_reg_main+0xdfe>
 101bb4f:	jmp    101b776 <lyr_p1_reg_main+0xd16>
 101bb54:	mov    rsi,QWORD PTR [r8+0x8]
 101bb58:	cmp    rsi,rax
 101bb5b:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101bb61:	cmp    rsi,rcx
 101bb64:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101bb6a:	mov    rax,QWORD PTR [r14+rax*8]
 101bb6e:	cmp    rax,QWORD PTR [r14+rcx*8]
 101bb72:	jbe    101b85e <lyr_p1_reg_main+0xdfe>
 101bb78:	jmp    101b776 <lyr_p1_reg_main+0xd16>
 101bb7d:	mov    rsi,QWORD PTR [r8+0x8]
 101bb81:	cmp    rsi,rdi
 101bb84:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101bb8a:	cmp    QWORD PTR [r14+rdi*8],0x0
 101bb8f:	je     101b452 <lyr_p1_reg_main+0x9f2>
 101bb95:	mov    r12,rcx
 101bb98:	jmp    101b45b <lyr_p1_reg_main+0x9fb>
 101bb9d:	mov    rsi,QWORD PTR [r8+0x8]
 101bba1:	cmp    rsi,rcx
 101bba4:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101bbaa:	cmp    QWORD PTR [r14+rcx*8],0x0
 101bbaf:	je     101bbcb <lyr_p1_reg_main+0x116b>
 101bbb1:	cmp    rsi,rax
 101bbb4:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101bbba:	cmp    rsi,rdi
 101bbbd:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101bbc3:	mov    rax,QWORD PTR [r14+rax*8]
 101bbc7:	mov    QWORD PTR [r14+rdi*8],rax
 101bbcb:	inc    r12
 101bbce:	jno    101b45b <lyr_p1_reg_main+0x9fb>
 101bbd4:	jmp    101c130 <lyr_p1_reg_main+0x16d0>
 101bbd9:	mov    rsi,QWORD PTR [r8+0x8]
 101bbdd:	cmp    rsi,rax
 101bbe0:	jbe    101be72 <lyr_p1_reg_main+0x1412>
 101bbe6:	cmp    rsi,rcx
 101bbe9:	jbe    101becb <lyr_p1_reg_main+0x146b>
 101bbef:	mov    rax,QWORD PTR [r14+rax*8]
 101bbf3:	mov    rcx,QWORD PTR [r14+rcx*8]
 101bbf7:	cmp    rax,rcx
 101bbfa:	ja     101bbff <lyr_p1_reg_main+0x119f>
 101bbfc:	mov    rax,rcx
 101bbff:	cmp    rsi,rdi
 101bc02:	jbe    101be6d <lyr_p1_reg_main+0x140d>
 101bc08:	mov    QWORD PTR [r14+rdi*8],rax
 101bc0c:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101bc11:	xor    edx,edx
 101bc13:	div    ecx
 101bc15:	mov    QWORD PTR [r14+rdi*8],rdx
 101bc19:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101bc1e:	xor    edx,edx
 101bc20:	div    ecx
 101bc22:	mov    QWORD PTR [r14+rdi*8],rax
 101bc26:	jmp    101b452 <lyr_p1_reg_main+0x9f2>
 101bc2b:	mov    eax,DWORD PTR [rip+0x2267f]        # 103e2b0 <lyr_gc_stop_requested>
 101bc31:	mov    r13d,0x400
 101bc37:	test   eax,eax
 101bc39:	je     101b46d <lyr_p1_reg_main+0xa0d>
 101bc3f:	mov    QWORD PTR [rbp-0x38],r11
 101bc43:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101bc4c:	test   rdi,rdi
 101bc4f:	je     101bc60 <lyr_p1_reg_main+0x1200>
 101bc51:	mov    eax,DWORD PTR [rip+0x22659]        # 103e2b0 <lyr_gc_stop_requested>
 101bc57:	test   eax,eax
 101bc59:	je     101bc60 <lyr_p1_reg_main+0x1200>
 101bc5b:	call   101f270 <park_here.llvm.8023764427486792703>
 101bc60:	mov    r8,QWORD PTR [rbp-0x48]
 101bc64:	mov    r9,QWORD PTR [rbp-0x30]
 101bc68:	mov    r10,QWORD PTR [rbp-0x40]
 101bc6c:	mov    r11,QWORD PTR [rbp-0x38]
 101bc70:	jmp    101b46d <lyr_p1_reg_main+0xa0d>
 101bc75:	mov    eax,DWORD PTR [rip+0x22635]        # 103e2b0 <lyr_gc_stop_requested>
 101bc7b:	mov    r13d,0x400
 101bc81:	test   eax,eax
 101bc83:	je     101b464 <lyr_p1_reg_main+0xa04>
 101bc89:	mov    QWORD PTR [rbp-0x38],r11
 101bc8d:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101bc96:	test   rdi,rdi
 101bc99:	je     101bcaa <lyr_p1_reg_main+0x124a>
 101bc9b:	mov    eax,DWORD PTR [rip+0x2260f]        # 103e2b0 <lyr_gc_stop_requested>
 101bca1:	test   eax,eax
 101bca3:	je     101bcaa <lyr_p1_reg_main+0x124a>
 101bca5:	call   101f270 <park_here.llvm.8023764427486792703>
 101bcaa:	mov    r8,QWORD PTR [rbp-0x48]
 101bcae:	mov    r9,QWORD PTR [rbp-0x30]
 101bcb2:	mov    r10,QWORD PTR [rbp-0x40]
 101bcb6:	mov    r11,QWORD PTR [rbp-0x38]
 101bcba:	jmp    101b464 <lyr_p1_reg_main+0xa04>
 101bcbf:	mov    rsi,QWORD PTR fs:0xffffffffffffffe8
 101bcc8:	mov    rax,QWORD PTR fs:0xfffffffffffffff0
 101bcd1:	sub    rax,rsi
 101bcd4:	cmp    rax,0x20
 101bcd8:	jb     101c254 <lyr_p1_reg_main+0x17f4>
 101bcde:	lea    rax,[rsi+0x20]
 101bce2:	mov    QWORD PTR fs:0xffffffffffffffe8,rax
 101bceb:	test   rsi,rsi
 101bcee:	je     101c254 <lyr_p1_reg_main+0x17f4>
 101bcf4:	mov    QWORD PTR [rsi],0x1003bb0
 101bcfb:	mov    QWORD PTR [rsi+0x8],0x1
 101bd03:	mov    BYTE PTR [rsi+0x10],0x0
 101bd07:	mov    edi,0x1003bb0
 101bd0c:	mov    edx,0x36
 101bd11:	call   101df10 <lyr_arr_repeat>
 101bd16:	mov    r15,QWORD PTR fs:0xffffffffffffffe8
 101bd1f:	mov    rcx,QWORD PTR fs:0xfffffffffffffff0
 101bd28:	sub    rcx,r15
 101bd2b:	cmp    rcx,0x20
 101bd2f:	jb     101c26b <lyr_p1_reg_main+0x180b>
 101bd35:	lea    rcx,[r15+0x20]
 101bd39:	mov    QWORD PTR fs:0xffffffffffffffe8,rcx
 101bd42:	test   r15,r15
 101bd45:	je     101c26b <lyr_p1_reg_main+0x180b>
 101bd4b:	mov    QWORD PTR [r15],0x1003a88
 101bd52:	lea    r12,[r15+0x8]
 101bd56:	mov    QWORD PTR [r15+0x8],rax
 101bd5a:	mov    rax,r12
 101bd5d:	sub    rax,QWORD PTR [rip+0x22814]        # 103e578 <lyr_gc_heap_base>
 101bd64:	cmp    rax,QWORD PTR [rip+0x22815]        # 103e580 <lyr_gc_heap_span>
 101bd6b:	jae    101bd7c <lyr_p1_reg_main+0x131c>
 101bd6d:	mov    rcx,QWORD PTR [rip+0x22814]        # 103e588 <lyr_gc_cards>
 101bd74:	shr    rax,0x8
 101bd78:	mov    BYTE PTR [rcx+rax*1],0x1
 101bd7c:	mov    QWORD PTR [r15+0x10],0x0
 101bd84:	mov    esi,0x1003da8
 101bd89:	mov    edx,0x4
 101bd8e:	mov    rdi,r15
 101bd91:	call   101c300 <lyr_std_core_StringBuilder_appendStr>
 101bd96:	mov    rax,QWORD PTR [rbp-0x48]
 101bd9a:	mov    rsi,QWORD PTR [rax+0x8]
 101bd9e:	cmp    rsi,0x2
 101bda2:	jbe    101c283 <lyr_p1_reg_main+0x1823>
 101bda8:	mov    rdi,QWORD PTR [r15+0x10]
 101bdac:	mov    rsi,rdi
 101bdaf:	add    rsi,0x14
 101bdb3:	jo     101c130 <lyr_p1_reg_main+0x16d0>
 101bdb9:	mov    r14,QWORD PTR [rax+0x20]
 101bdbd:	mov    rax,QWORD PTR [r12]
 101bdc1:	cmp    rsi,QWORD PTR [rax+0x8]
 101bdc5:	jle    101bdd7 <lyr_p1_reg_main+0x1377>
 101bdc7:	mov    rdi,r15
 101bdca:	call   101c3c0 <lyr_std_core_StringBuilder_grow>
 101bdcf:	mov    rax,QWORD PTR [r15+0x8]
 101bdd3:	mov    rdi,QWORD PTR [r15+0x10]
 101bdd7:	xor    ecx,ecx
 101bdd9:	cmp    r14,0x64
 101bddd:	jb     101be3b <lyr_p1_reg_main+0x13db>
 101bddf:	xor    ecx,ecx
 101bde1:	movabs rsi,0x28f5c28f5c28f5c3
 101bdeb:	nop    DWORD PTR [rax+rax*1+0x0]
 101bdf0:	mov    r8,r14
 101bdf3:	mov    rdx,r14
 101bdf6:	shr    rdx,0x2
 101bdfa:	mulx   r14,r14,rsi
 101bdff:	shr    r14,0x2
 101be03:	imul   edx,r14d,0x64
 101be07:	mov    r9d,r8d
 101be0a:	sub    r9d,edx
 101be0d:	add    r9d,r9d
 101be10:	movzx  edx,BYTE PTR [r9+0x1004351]
 101be18:	mov    BYTE PTR [rbp+rcx*1-0x90],dl
 101be1f:	movzx  edx,BYTE PTR [r9+0x1004350]
 101be27:	mov    BYTE PTR [rbp+rcx*1-0x8f],dl
 101be2e:	add    rcx,0x2
 101be32:	cmp    r8,0x270f
 101be39:	ja     101bdf0 <lyr_p1_reg_main+0x1390>
 101be3b:	mov    edx,ecx
 101be3d:	cmp    r14,0xa
 101be41:	jb     101be7a <lyr_p1_reg_main+0x141a>
 101be43:	movzx  esi,BYTE PTR [r14+r14*1+0x1004351]
 101be4c:	mov    BYTE PTR [rbp+rdx*1-0x90],sil
 101be54:	movzx  esi,BYTE PTR [r14+r14*1+0x1004350]
 101be5d:	add    ecx,0x2
 101be60:	mov    BYTE PTR [rbp+rdx*1-0x8f],sil
 101be68:	jmp    101be89 <lyr_p1_reg_main+0x1429>
 101be6a:	mov    rdi,r12
 101be6d:	call   102460c <lyr_panic_index>
 101be72:	mov    rdi,rax
 101be75:	call   102460c <lyr_panic_index>
 101be7a:	or     r14b,0x30
 101be7e:	or     ecx,0x1
 101be81:	mov    BYTE PTR [rbp+rdx*1-0x90],r14b
 101be89:	mov    rdx,QWORD PTR [rax+0x8]
 101be8d:	movsxd rsi,ecx
 101be90:	test   rdi,rdi
 101be93:	js     101c2df <lyr_p1_reg_main+0x187f>
 101be99:	mov    r8,rdx
 101be9c:	sub    r8,rsi
 101be9f:	cmp    rdi,r8
 101bea2:	jg     101c2df <lyr_p1_reg_main+0x187f>
 101bea8:	test   ecx,ecx
 101beaa:	jle    101c012 <lyr_p1_reg_main+0x15b2>
 101beb0:	cmp    ecx,0x10
 101beb3:	jae    101bebc <lyr_p1_reg_main+0x145c>
 101beb5:	xor    ecx,ecx
 101beb7:	jmp    101bfe2 <lyr_p1_reg_main+0x1582>
 101bebc:	cmp    ecx,0x80
 101bec2:	jae    101bed3 <lyr_p1_reg_main+0x1473>
 101bec4:	xor    ecx,ecx
 101bec6:	jmp    101bf8a <lyr_p1_reg_main+0x152a>
 101becb:	mov    rdi,rcx
 101bece:	call   102460c <lyr_panic_index>
 101bed3:	mov    ecx,esi
 101bed5:	and    ecx,0x7fffff80
 101bedb:	mov    rdx,rcx
 101bede:	neg    rdx
 101bee1:	lea    r8,[rdi+rax*1]
 101bee5:	add    r8,0x70
 101bee9:	lea    r9,[rbp-0x90]
 101bef0:	add    r9,rsi
 101bef3:	add    r9,0xffffffffffffffe0
 101bef7:	xor    r10d,r10d
 101befa:	vmovdqa ymm0,YMMWORD PTR [rip+0xfffffffffffe797e]        # 1003880 <.str.15.llvm.16766894347181747790+0x9ab>
 101bf02:	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 101bf10:	vmovdqu ymm1,YMMWORD PTR [r9+r10*1-0x60]
 101bf17:	vmovdqu ymm2,YMMWORD PTR [r9+r10*1-0x40]
 101bf1e:	vmovdqu ymm3,YMMWORD PTR [r9+r10*1-0x20]
 101bf25:	vmovdqu ymm4,YMMWORD PTR [r9+r10*1]
 101bf2b:	vpshufb ymm4,ymm4,ymm0
 101bf30:	vpermq ymm4,ymm4,0x4e
 101bf36:	vpshufb ymm3,ymm3,ymm0
 101bf3b:	vpermq ymm3,ymm3,0x4e
 101bf41:	vpshufb ymm2,ymm2,ymm0
 101bf46:	vpermq ymm2,ymm2,0x4e
 101bf4c:	vpshufb ymm1,ymm1,ymm0
 101bf51:	vpermq ymm1,ymm1,0x4e
 101bf57:	vmovdqu YMMWORD PTR [r8-0x60],ymm4
 101bf5d:	vmovdqu YMMWORD PTR [r8-0x40],ymm3
 101bf63:	vmovdqu YMMWORD PTR [r8-0x20],ymm2
 101bf69:	vmovdqu YMMWORD PTR [r8],ymm1
 101bf6e:	add    r10,0xffffffffffffff80
 101bf72:	sub    r8,0xffffffffffffff80
 101bf76:	cmp    rdx,r10
 101bf79:	jne    101bf10 <lyr_p1_reg_main+0x14b0>
 101bf7b:	cmp    rcx,rsi
 101bf7e:	je     101c012 <lyr_p1_reg_main+0x15b2>
 101bf84:	test   sil,0x70
 101bf88:	je     101bfe2 <lyr_p1_reg_main+0x1582>
 101bf8a:	mov    rdx,rcx
 101bf8d:	mov    ecx,esi
 101bf8f:	and    ecx,0x7ffffff0
 101bf95:	mov    r8,rcx
 101bf98:	neg    r8
 101bf9b:	lea    r9,[rdi+rdx*1]
 101bf9f:	neg    rdx
 101bfa2:	add    r9,rax
 101bfa5:	add    r9,0x10
 101bfa9:	lea    r10,[rbp-0x90]
 101bfb0:	add    r10,rsi
 101bfb3:	add    r10,0xfffffffffffffff0
 101bfb7:	vmovdqa xmm0,XMMWORD PTR [rip+0xfffffffffffe7911]        # 10038d0 <.str.15.llvm.16766894347181747790+0x9fb>
 101bfbf:	nop
 101bfc0:	vmovdqu xmm1,XMMWORD PTR [r10+rdx*1]
 101bfc6:	vpshufb xmm1,xmm1,xmm0
 101bfcb:	vmovdqu XMMWORD PTR [r9],xmm1
 101bfd0:	add    rdx,0xfffffffffffffff0
 101bfd4:	add    r9,0x10
 101bfd8:	cmp    r8,rdx
 101bfdb:	jne    101bfc0 <lyr_p1_reg_main+0x1560>
 101bfdd:	cmp    rcx,rsi
 101bfe0:	je     101c012 <lyr_p1_reg_main+0x15b2>
 101bfe2:	mov    rdx,rsi
 101bfe5:	sub    rdx,rcx
 101bfe8:	add    rcx,rdi
 101bfeb:	add    rax,rcx
 101bfee:	add    rax,0x10
 101bff2:	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 101c000:	movzx  ecx,BYTE PTR [rbp+rdx*1-0x91]
 101c008:	mov    BYTE PTR [rax],cl
 101c00a:	inc    rax
 101c00d:	dec    rdx
 101c010:	jne    101c000 <lyr_p1_reg_main+0x15a0>
 101c012:	add    rdi,rsi
 101c015:	jo     101c130 <lyr_p1_reg_main+0x16d0>
 101c01b:	mov    QWORD PTR [r15+0x10],rdi
 101c01f:	mov    esi,0x1003dc0
 101c024:	mov    edx,0xa
 101c029:	mov    rdi,r15
 101c02c:	vzeroupper
 101c02f:	call   101c300 <lyr_std_core_StringBuilder_appendStr>
 101c034:	mov    r14,QWORD PTR [r15+0x10]
 101c038:	mov    rsi,r14
 101c03b:	add    rsi,0x14
 101c03f:	jo     101c130 <lyr_p1_reg_main+0x16d0>
 101c045:	mov    rdi,QWORD PTR [r12]
 101c049:	cmp    rsi,QWORD PTR [rdi+0x8]
 101c04d:	jle    101c05f <lyr_p1_reg_main+0x15ff>
 101c04f:	mov    rdi,r15
 101c052:	call   101c3c0 <lyr_std_core_StringBuilder_grow>
 101c057:	mov    rdi,QWORD PTR [r15+0x8]
 101c05b:	mov    r14,QWORD PTR [r15+0x10]
 101c05f:	mov    rsi,r14
 101c062:	mov    rdx,rbx
 101c065:	call   1024d70 <lyr_bytes_put_int>
 101c06a:	add    rax,r14
 101c06d:	jo     101c130 <lyr_p1_reg_main+0x16d0>
 101c073:	mov    QWORD PTR [r15+0x10],rax
 101c077:	mov    rsi,QWORD PTR [r15+0x8]
 101c07b:	mov    rdx,QWORD PTR [rsi+0x8]
 101c07f:	js     101c2e7 <lyr_p1_reg_main+0x1887>
 101c085:	cmp    rax,rdx
 101c088:	jg     101c2e7 <lyr_p1_reg_main+0x1887>
 101c08e:	mov    rcx,rax
 101c091:	shr    rcx,0x28
 101c095:	jne    101c28d <lyr_p1_reg_main+0x182d>
 101c09b:	lea    rdx,[rax+0x20]
 101c09f:	movabs rcx,0x1fffffffff0
 101c0a9:	and    rcx,rdx
 101c0ac:	mov    rbx,QWORD PTR fs:0xffffffffffffffe8
 101c0b5:	mov    rdx,QWORD PTR fs:0xfffffffffffffff0
 101c0be:	sub    rdx,rbx
 101c0c1:	cmp    rcx,rdx
 101c0c4:	ja     101c2a9 <lyr_p1_reg_main+0x1849>
 101c0ca:	add    rcx,rbx
 101c0cd:	mov    QWORD PTR fs:0xffffffffffffffe8,rcx
 101c0d6:	test   rbx,rbx
 101c0d9:	je     101c2a9 <lyr_p1_reg_main+0x1849>
 101c0df:	mov    QWORD PTR [rbx],0x1004420
 101c0e6:	mov    QWORD PTR [rbx+0x8],rax
 101c0ea:	test   rax,rax
 101c0ed:	je     101c0ff <lyr_p1_reg_main+0x169f>
 101c0ef:	add    rsi,0x10
 101c0f3:	lea    rdi,[rbx+0x10]
 101c0f7:	mov    rdx,rax
 101c0fa:	call   1037520 <memcpy@plt>
 101c0ff:	mov    rsi,QWORD PTR [rbx+0x8]
 101c103:	add    rbx,0x10
 101c107:	mov    rdi,rbx
 101c10a:	call   101c580 <lyr_std_io_put>
 101c10f:	mov    edi,0x1003de0
 101c114:	mov    esi,0x1
 101c119:	call   101c580 <lyr_std_io_put>
 101c11e:	add    rsp,0xd8
 101c125:	pop    rbx
 101c126:	pop    r12
 101c128:	pop    r13
 101c12a:	pop    r14
 101c12c:	pop    r15
 101c12e:	pop    rbp
 101c12f:	ret
 101c130:	mov    edi,0x1002ed5
 101c135:	vzeroupper
 101c138:	call   1024645 <lyr_panic_overflow>
 101c13d:	xor    edi,edi
 101c13f:	mov    rsi,r12
 101c142:	call   1024627 <lyr_panic_range>
 101c147:	mov    edi,0x1002ed3
 101c14c:	call   1024645 <lyr_panic_overflow>
 101c151:	call   102465d <lyr_panic_division_by_zero>
 101c156:	mov    rdi,rax
 101c159:	mov    rsi,rcx
 101c15c:	call   102460c <lyr_panic_index>
 101c161:	mov    edi,0x10041c8
 101c166:	xor    esi,esi
 101c168:	call   101f190 <lyr_gc_alloc_array_slow>
 101c16d:	mov    r14,rax
 101c170:	mov    r15,QWORD PTR fs:0xffffffffffffffe8
 101c179:	jmp    101aaf0 <lyr_p1_reg_main+0x90>
 101c17e:	mov    edi,0x28
 101c183:	call   101e8e0 <allocate.llvm.8023764427486792703>
 101c188:	mov    r15,rax
 101c18b:	jmp    101ab1c <lyr_p1_reg_main+0xbc>
 101c190:	call   101f2a0 <lyr_gc_stack_slow>
 101c195:	jmp    101aa90 <lyr_p1_reg_main+0x30>
 101c19a:	mov    rdi,rbx
 101c19d:	call   101f2a0 <lyr_gc_stack_slow>
 101c1a2:	jmp    101aaa2 <lyr_p1_reg_main+0x42>
 101c1a7:	mov    edi,0x1003b30
 101c1ac:	mov    esi,0xe
 101c1b1:	call   101f190 <lyr_gc_alloc_array_slow>
 101c1b6:	mov    r15,rax
 101c1b9:	jmp    101b238 <lyr_p1_reg_main+0x7d8>
 101c1be:	mov    edi,0x1003b58
 101c1c3:	mov    esi,0x1
 101c1c8:	vzeroupper
 101c1cb:	call   101f190 <lyr_gc_alloc_array_slow>
 101c1d0:	mov    rsi,rax
 101c1d3:	jmp    101b2d0 <lyr_p1_reg_main+0x870>
 101c1d8:	mov    edi,0x1003b58
 101c1dd:	mov    esi,0x3
 101c1e2:	call   101f190 <lyr_gc_alloc_array_slow>
 101c1e7:	mov    rsi,QWORD PTR fs:0xffffffffffffffe8
 101c1f0:	jmp    101b332 <lyr_p1_reg_main+0x8d2>
 101c1f5:	mov    edi,0x1003b58
 101c1fa:	mov    esi,0x1
 101c1ff:	call   101f190 <lyr_gc_alloc_array_slow>
 101c204:	mov    rsi,rax
 101c207:	jmp    101b38c <lyr_p1_reg_main+0x92c>
 101c20c:	mov    edi,0x1003b80
 101c211:	mov    esi,0x1
 101c216:	call   101f190 <lyr_gc_alloc_array_slow>
 101c21b:	mov    rsi,rax
 101c21e:	jmp    101b3eb <lyr_p1_reg_main+0x98b>
 101c223:	mov    rdi,rbx
 101c226:	mov    rbx,r11
 101c229:	call   101f2a0 <lyr_gc_stack_slow>
 101c22e:	mov    r11,rbx
 101c231:	jmp    101b41e <lyr_p1_reg_main+0x9be>
 101c236:	mov    rbx,rdi
 101c239:	mov    rdi,QWORD PTR [rbp-0x30]
 101c23d:	mov    r14,rsi
 101c240:	call   101f2a0 <lyr_gc_stack_slow>
 101c245:	mov    rdi,rbx
 101c248:	mov    rbx,QWORD PTR [rbp-0x30]
 101c24c:	mov    rsi,r14
 101c24f:	jmp    101b1c6 <lyr_p1_reg_main+0x766>
 101c254:	mov    edi,0x1003bb0
 101c259:	mov    esi,0x1
 101c25e:	call   101f190 <lyr_gc_alloc_array_slow>
 101c263:	mov    rsi,rax
 101c266:	jmp    101bd03 <lyr_p1_reg_main+0x12a3>
 101c26b:	mov    edi,0x18
 101c270:	mov    r14,rax
 101c273:	call   101e8e0 <allocate.llvm.8023764427486792703>
 101c278:	mov    r15,rax
 101c27b:	mov    rax,r14
 101c27e:	jmp    101bd4b <lyr_p1_reg_main+0x12eb>
 101c283:	mov    edi,0x2
 101c288:	call   102460c <lyr_panic_index>
 101c28d:	mov    rdi,rax
 101c290:	mov    r14,rax
 101c293:	mov    rbx,rsi
 101c296:	call   101f210 <lyr_gc_alloc_string_slow>
 101c29b:	mov    rsi,rbx
 101c29e:	mov    rbx,rax
 101c2a1:	mov    rax,r14
 101c2a4:	jmp    101c0ef <lyr_p1_reg_main+0x168f>
 101c2a9:	mov    rdi,rax
 101c2ac:	mov    r14,rax
 101c2af:	mov    rbx,rsi
 101c2b2:	call   101f210 <lyr_gc_alloc_string_slow>
 101c2b7:	mov    rsi,rbx
 101c2ba:	mov    rbx,rax
 101c2bd:	mov    rax,r14
 101c2c0:	test   rax,rax
 101c2c3:	jne    101c0ef <lyr_p1_reg_main+0x168f>
 101c2c9:	jmp    101c0ff <lyr_p1_reg_main+0x169f>
 101c2ce:	mov    edi,0x1003d78
 101c2d3:	call   1024697 <lyr_panic_message>
 101c2d8:	ud2
 101c2da:	call   10246db <lyr_stack_overflow>
 101c2df:	add    rsi,rdi
 101c2e2:	call   1024627 <lyr_panic_range>
 101c2e7:	xor    edi,edi
 101c2e9:	mov    rsi,rax
 101c2ec:	call   1024627 <lyr_panic_range>
 101c2f1:	int3
 101c2f2:	int3
 101c2f3:	int3
 101c2f4:	int3
 101c2f5:	int3
 101c2f6:	int3
 101c2f7:	int3
 101c2f8:	int3
 101c2f9:	int3
 101c2fa:	int3
 101c2fb:	int3
 101c2fc:	int3
 101c2fd:	int3
 101c2fe:	int3
 101c2ff:	int3
