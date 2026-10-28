0000000001015900 <lyr_w2_o_run>:
 1015900:	push   rbp
 1015901:	mov    rbp,rsp
 1015904:	push   r15
 1015906:	push   r14
 1015908:	push   r13
 101590a:	push   r12
 101590c:	push   rbx
 101590d:	sub    rsp,0x58
 1015911:	mov    r11,rcx
 1015914:	mov    r10,rdx
 1015917:	mov    r9,rsi
 101591a:	mov    r13,rdi
 101591d:	mov    rdi,rbp
 1015920:	add    rdi,0xffffffffffff8d70
 1015927:	mov    rax,0xffffffffffffffe0
 101592e:	mov    rax,QWORD PTR fs:[rax+0x10]
 1015933:	cmp    rdi,rax
 1015936:	mov    QWORD PTR [rbp-0x50],r8
 101593a:	mov    QWORD PTR [rbp-0x48],rcx
 101593e:	mov    QWORD PTR [rbp-0x38],rdx
 1015942:	mov    QWORD PTR [rbp-0x40],rsi
 1015946:	jb     1016828 <lyr_w2_o_run+0xf28>
 101594c:	vxorps xmm0,xmm0,xmm0
 1015950:	vmovups YMMWORD PTR [rbp-0x80],ymm0
 1015955:	lea    rdx,[r9+0x10]
 1015959:	lea    rax,[r11+0x10]
 101595d:	mov    QWORD PTR [rbp-0x60],rax
 1015961:	mov    r12d,0x400
 1015967:	xor    r14d,r14d
 101596a:	mov    QWORD PTR [rbp-0x58],0x0
 1015972:	xor    ebx,ebx
 1015974:	mov    QWORD PTR [rbp-0x30],rdx
 1015978:	jmp    101599f <lyr_w2_o_run+0x9f>
 101597a:	xor    edx,edx
 101597c:	div    rcx
 101597f:	shl    r15d,0x5
 1015983:	mov    rdx,QWORD PTR [rbp-0x30]
 1015987:	add    r15,rdx
 101598a:	mov    QWORD PTR [r15],rax
 101598d:	inc    rbx
 1015990:	jo     10167be <lyr_w2_o_run+0xebe>
 1015996:	dec    r12d
 1015999:	je     1016786 <lyr_w2_o_run+0xe86>
 101599f:	dec    r12d
 10159a2:	je     101674e <lyr_w2_o_run+0xe4e>
 10159a8:	mov    rsi,QWORD PTR [r13+0x8]
 10159ac:	cmp    rbx,rsi
 10159af:	jae    10167e2 <lyr_w2_o_run+0xee2>
 10159b5:	inc    r14
 10159b8:	jo     10167be <lyr_w2_o_run+0xebe>
 10159be:	movzx  ecx,BYTE PTR [r13+rbx*8+0x10]
 10159c4:	cmp    rcx,0x2f
 10159c8:	ja     1016864 <lyr_w2_o_run+0xf64>
 10159ce:	movzx  r15d,WORD PTR [r13+rbx*8+0x12]
 10159d4:	movzx  edi,WORD PTR [r13+rbx*8+0x14]
 10159da:	movzx  eax,WORD PTR [r13+rbx*8+0x16]
 10159e0:	lea    rsi,[rip+0xfffffffffffebdf9]        # 10017e0 <__abi_tag+0x14e4>
 10159e7:	movsxd rcx,DWORD PTR [rsi+rcx*4]
 10159eb:	add    rcx,rsi
 10159ee:	jmp    rcx
 10159f0:	mov    rsi,QWORD PTR [r9+0x8]
 10159f4:	cmp    rsi,r15
 10159f7:	jbe    10167ed <lyr_w2_o_run+0xeed>
 10159fd:	cmp    rsi,rdi
 1015a00:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015a06:	cmp    rsi,rax
 1015a09:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1015a0f:	shl    r15d,0x5
 1015a13:	add    r15,rdx
 1015a16:	shl    edi,0x5
 1015a19:	shl    eax,0x5
 1015a1c:	mov    rax,QWORD PTR [rdx+rax*1]
 1015a20:	add    rax,QWORD PTR [rdx+rdi*1]
 1015a24:	jmp    101598a <lyr_w2_o_run+0x8a>
 1015a29:	mov    rsi,QWORD PTR [r9+0x8]
 1015a2d:	cmp    rsi,rdi
 1015a30:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015a36:	shl    edi,0x5
 1015a39:	cmp    BYTE PTR [rdx+rdi*1+0x18],0x0
 1015a3e:	je     1016842 <lyr_w2_o_run+0xf42>
 1015a44:	mov    rcx,QWORD PTR [rdx+rdi*1+0x10]
 1015a49:	mov    rcx,QWORD PTR [rcx]
 1015a4c:	cmp    rcx,0x1038940
 1015a53:	jne    1016853 <lyr_w2_o_run+0xf53>
 1015a59:	mov    rcx,QWORD PTR [rdx+rdi*1+0x8]
 1015a5e:	mov    rdx,QWORD PTR [rcx+0x8]
 1015a62:	mov    rcx,QWORD PTR [rdx+0x8]
 1015a66:	cmp    rcx,rax
 1015a69:	jbe    1016803 <lyr_w2_o_run+0xf03>
 1015a6f:	cmp    rsi,r15
 1015a72:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015a78:	shl    eax,0x5
 1015a7b:	shl    r15d,0x5
 1015a7f:	mov    rcx,QWORD PTR [rbp-0x30]
 1015a83:	mov    rcx,QWORD PTR [rcx+r15*1]
 1015a87:	mov    QWORD PTR [rdx+rax*1+0x10],rcx
 1015a8c:	inc    rbx
 1015a8f:	jno    10166e8 <lyr_w2_o_run+0xde8>
 1015a95:	jmp    10167be <lyr_w2_o_run+0xebe>
 1015a9a:	mov    rsi,QWORD PTR [r9+0x8]
 1015a9e:	cmp    rsi,r15
 1015aa1:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015aa7:	cmp    rsi,rdi
 1015aaa:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015ab0:	shl    r15d,0x5
 1015ab4:	mov    rcx,QWORD PTR [rdx+r15*1]
 1015ab8:	shl    edi,0x5
 1015abb:	cmp    rcx,QWORD PTR [rdx+rdi*1]
 1015abf:	je     101598d <lyr_w2_o_run+0x8d>
 1015ac5:	jmp    10165b0 <lyr_w2_o_run+0xcb0>
 1015aca:	mov    rsi,QWORD PTR [r9+0x8]
 1015ace:	cmp    rsi,r15
 1015ad1:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015ad7:	cmp    rsi,rdi
 1015ada:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015ae0:	shl    r15d,0x5
 1015ae4:	shl    edi,0x5
 1015ae7:	mov    rcx,QWORD PTR [rdx+rdi*1]
 1015aeb:	sub    rcx,rax
 1015aee:	mov    QWORD PTR [rdx+r15*1],rcx
 1015af2:	jmp    101598d <lyr_w2_o_run+0x8d>
 1015af7:	mov    rsi,QWORD PTR [r9+0x8]
 1015afb:	cmp    rsi,rdi
 1015afe:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015b04:	shl    edi,0x5
 1015b07:	cmp    BYTE PTR [rdx+rdi*1+0x18],0x0
 1015b0c:	je     1016842 <lyr_w2_o_run+0xf42>
 1015b12:	mov    rcx,QWORD PTR [rdx+rdi*1+0x10]
 1015b17:	mov    rcx,QWORD PTR [rcx]
 1015b1a:	cmp    rcx,0x1038940
 1015b21:	jne    1016853 <lyr_w2_o_run+0xf53>
 1015b27:	cmp    rsi,r15
 1015b2a:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015b30:	mov    rcx,QWORD PTR [rdx+rdi*1+0x8]
 1015b35:	mov    rdi,rdx
 1015b38:	mov    rdx,QWORD PTR [rcx+0x8]
 1015b3c:	mov    rsi,QWORD PTR [rdx+0x8]
 1015b40:	cmp    rsi,rax
 1015b43:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1015b49:	shl    r15d,0x5
 1015b4d:	shl    eax,0x5
 1015b50:	lea    rcx,[rdx+rax*1]
 1015b54:	add    rcx,0x10
 1015b58:	vmovups ymm0,YMMWORD PTR [rdi+r15*1]
 1015b5e:	vmovups YMMWORD PTR [rdx+rax*1+0x10],ymm0
 1015b64:	lea    rax,[rip+0x28dd5]        # 103e940 <lyr_gc_heap_base>
 1015b6b:	sub    rcx,QWORD PTR [rax]
 1015b6e:	lea    rax,[rip+0x28dd3]        # 103e948 <lyr_gc_heap_span>
 1015b75:	cmp    rcx,QWORD PTR [rax]
 1015b78:	jae    10166df <lyr_w2_o_run+0xddf>
 1015b7e:	mov    rax,rcx
 1015b81:	shr    rax,0x8
 1015b85:	add    rcx,0x1f
 1015b89:	shr    rcx,0x8
 1015b8d:	mov    rdx,rcx
 1015b90:	sub    rdx,rax
 1015b93:	jb     10166df <lyr_w2_o_run+0xddf>
 1015b99:	inc    rcx
 1015b9c:	mov    esi,ecx
 1015b9e:	sub    esi,eax
 1015ba0:	and    esi,0x3
 1015ba3:	je     1015bc6 <lyr_w2_o_run+0x2c6>
 1015ba5:	neg    rsi
 1015ba8:	nop    DWORD PTR [rax+rax*1+0x0]
 1015bb0:	lea    rdi,[rip+0x28d71]        # 103e928 <lyr_gc_cards>
 1015bb7:	mov    rdi,QWORD PTR [rdi]
 1015bba:	mov    BYTE PTR [rdi+rax*1],0x1
 1015bbe:	inc    rax
 1015bc1:	inc    rsi
 1015bc4:	jne    1015bb0 <lyr_w2_o_run+0x2b0>
 1015bc6:	cmp    rdx,0x3
 1015bca:	jb     10166df <lyr_w2_o_run+0xddf>
 1015bd0:	lea    rdx,[rip+0x28d51]        # 103e928 <lyr_gc_cards>
 1015bd7:	mov    rsi,QWORD PTR [rdx]
 1015bda:	mov    BYTE PTR [rsi+rax*1],0x1
 1015bde:	mov    rsi,QWORD PTR [rdx]
 1015be1:	mov    BYTE PTR [rsi+rax*1+0x1],0x1
 1015be6:	mov    rsi,QWORD PTR [rdx]
 1015be9:	mov    BYTE PTR [rsi+rax*1+0x2],0x1
 1015bee:	mov    rdx,QWORD PTR [rdx]
 1015bf1:	mov    BYTE PTR [rdx+rax*1+0x3],0x1
 1015bf6:	add    rax,0x4
 1015bfa:	cmp    rcx,rax
 1015bfd:	jne    1015bd0 <lyr_w2_o_run+0x2d0>
 1015bff:	jmp    10166df <lyr_w2_o_run+0xddf>
 1015c04:	mov    rsi,QWORD PTR [r9+0x8]
 1015c08:	cmp    rsi,r15
 1015c0b:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015c11:	cmp    rsi,rdi
 1015c14:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015c1a:	cmp    rsi,rax
 1015c1d:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1015c23:	shl    r15d,0x5
 1015c27:	add    r15,rdx
 1015c2a:	shl    edi,0x5
 1015c2d:	shl    eax,0x5
 1015c30:	movzx  eax,BYTE PTR [rdx+rax*1]
 1015c34:	shlx   rax,QWORD PTR [rdx+rdi*1],rax
 1015c3a:	jmp    101598a <lyr_w2_o_run+0x8a>
 1015c3f:	mov    rsi,QWORD PTR [r9+0x8]
 1015c43:	cmp    rsi,r15
 1015c46:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015c4c:	shl    r15d,0x5
 1015c50:	dec    QWORD PTR [rdx+r15*1]
 1015c54:	jmp    101598d <lyr_w2_o_run+0x8d>
 1015c59:	mov    rsi,QWORD PTR [r9+0x8]
 1015c5d:	cmp    rsi,r15
 1015c60:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015c66:	cmp    rsi,rdi
 1015c69:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015c6f:	shl    r15d,0x5
 1015c73:	mov    rcx,QWORD PTR [rdx+r15*1]
 1015c77:	shl    edi,0x5
 1015c7a:	cmp    rcx,QWORD PTR [rdx+rdi*1]
 1015c7e:	jne    101598d <lyr_w2_o_run+0x8d>
 1015c84:	jmp    10165b0 <lyr_w2_o_run+0xcb0>
 1015c89:	mov    rsi,QWORD PTR [r9+0x8]
 1015c8d:	cmp    rsi,r15
 1015c90:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015c96:	mov    rsi,QWORD PTR [r10+0x8]
 1015c9a:	cmp    rsi,rdi
 1015c9d:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015ca3:	shl    r15d,0x5
 1015ca7:	mov    rax,QWORD PTR [r10+rdi*8+0x10]
 1015cac:	mov    QWORD PTR [rdx+r15*1],rax
 1015cb0:	jmp    101598d <lyr_w2_o_run+0x8d>
 1015cb5:	mov    rsi,QWORD PTR [r9+0x8]
 1015cb9:	cmp    rsi,rdi
 1015cbc:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015cc2:	shl    edi,0x5
 1015cc5:	cmp    BYTE PTR [r9+rdi*1+0x28],0x0
 1015ccb:	je     10166f1 <lyr_w2_o_run+0xdf1>
 1015cd1:	cmp    rsi,r15
 1015cd4:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015cda:	xor    eax,eax
 1015cdc:	jmp    10166ff <lyr_w2_o_run+0xdff>
 1015ce1:	mov    rsi,QWORD PTR [r9+0x8]
 1015ce5:	cmp    rsi,r15
 1015ce8:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015cee:	cmp    rsi,rdi
 1015cf1:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015cf7:	shl    r15d,0x5
 1015cfb:	shl    edi,0x5
 1015cfe:	or     rax,QWORD PTR [rdx+rdi*1]
 1015d02:	mov    QWORD PTR [rdx+r15*1],rax
 1015d06:	jmp    101598d <lyr_w2_o_run+0x8d>
 1015d0b:	mov    rsi,QWORD PTR [r9+0x8]
 1015d0f:	cmp    rsi,r15
 1015d12:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015d18:	cmp    rsi,rdi
 1015d1b:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015d21:	shl    r15d,0x5
 1015d25:	shl    edi,0x5
 1015d28:	xor    eax,eax
 1015d2a:	sub    rax,QWORD PTR [rdx+rdi*1]
 1015d2e:	mov    QWORD PTR [rdx+r15*1],rax
 1015d32:	jmp    101598d <lyr_w2_o_run+0x8d>
 1015d37:	mov    rsi,QWORD PTR [r9+0x8]
 1015d3b:	cmp    rsi,r15
 1015d3e:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015d44:	cmp    rsi,rdi
 1015d47:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015d4d:	cmp    rsi,rax
 1015d50:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1015d56:	shl    r15d,0x5
 1015d5a:	add    r15,rdx
 1015d5d:	shl    edi,0x5
 1015d60:	shl    eax,0x5
 1015d63:	mov    rax,QWORD PTR [rdx+rax*1]
 1015d67:	xor    rax,QWORD PTR [rdx+rdi*1]
 1015d6b:	jmp    101598a <lyr_w2_o_run+0x8a>
 1015d70:	mov    rsi,QWORD PTR [r9+0x8]
 1015d74:	cmp    rsi,rdi
 1015d77:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015d7d:	cmp    rsi,r15
 1015d80:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015d86:	shl    edi,0x5
 1015d89:	shl    r15d,0x5
 1015d8d:	lea    rax,[rdx+r15*1]
 1015d91:	vmovups ymm0,YMMWORD PTR [rdx+rdi*1]
 1015d96:	vmovups YMMWORD PTR [rdx+r15*1],ymm0
 1015d9c:	lea    rcx,[rip+0x28b9d]        # 103e940 <lyr_gc_heap_base>
 1015da3:	sub    rax,QWORD PTR [rcx]
 1015da6:	lea    rcx,[rip+0x28b9b]        # 103e948 <lyr_gc_heap_span>
 1015dad:	cmp    rax,QWORD PTR [rcx]
 1015db0:	jae    10166df <lyr_w2_o_run+0xddf>
 1015db6:	mov    rcx,rax
 1015db9:	shr    rcx,0x8
 1015dbd:	add    rax,0x1f
 1015dc1:	shr    rax,0x8
 1015dc5:	mov    rdx,rax
 1015dc8:	sub    rdx,rcx
 1015dcb:	jb     10166df <lyr_w2_o_run+0xddf>
 1015dd1:	inc    rax
 1015dd4:	mov    esi,eax
 1015dd6:	sub    esi,ecx
 1015dd8:	and    esi,0x3
 1015ddb:	je     1015df6 <lyr_w2_o_run+0x4f6>
 1015ddd:	neg    rsi
 1015de0:	lea    rdi,[rip+0x28b41]        # 103e928 <lyr_gc_cards>
 1015de7:	mov    rdi,QWORD PTR [rdi]
 1015dea:	mov    BYTE PTR [rdi+rcx*1],0x1
 1015dee:	inc    rcx
 1015df1:	inc    rsi
 1015df4:	jne    1015de0 <lyr_w2_o_run+0x4e0>
 1015df6:	cmp    rdx,0x3
 1015dfa:	jb     10166df <lyr_w2_o_run+0xddf>
 1015e00:	lea    rdx,[rip+0x28b21]        # 103e928 <lyr_gc_cards>
 1015e07:	mov    rsi,QWORD PTR [rdx]
 1015e0a:	mov    BYTE PTR [rsi+rcx*1],0x1
 1015e0e:	mov    rsi,QWORD PTR [rdx]
 1015e11:	mov    BYTE PTR [rsi+rcx*1+0x1],0x1
 1015e16:	mov    rsi,QWORD PTR [rdx]
 1015e19:	mov    BYTE PTR [rsi+rcx*1+0x2],0x1
 1015e1e:	mov    rdx,QWORD PTR [rdx]
 1015e21:	mov    BYTE PTR [rdx+rcx*1+0x3],0x1
 1015e26:	add    rcx,0x4
 1015e2a:	cmp    rax,rcx
 1015e2d:	jne    1015e00 <lyr_w2_o_run+0x500>
 1015e2f:	jmp    10166df <lyr_w2_o_run+0xddf>
 1015e34:	mov    rsi,QWORD PTR [r9+0x8]
 1015e38:	cmp    rsi,r15
 1015e3b:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015e41:	cmp    rsi,rdi
 1015e44:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015e4a:	cmp    rsi,rax
 1015e4d:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1015e53:	shl    r15d,0x5
 1015e57:	add    r15,rdx
 1015e5a:	shl    edi,0x5
 1015e5d:	mov    rcx,QWORD PTR [rdx+rdi*1]
 1015e61:	shl    eax,0x5
 1015e64:	sub    rcx,QWORD PTR [rdx+rax*1]
 1015e68:	mov    QWORD PTR [r15],rcx
 1015e6b:	jmp    101598d <lyr_w2_o_run+0x8d>
 1015e70:	mov    rsi,QWORD PTR [r9+0x8]
 1015e74:	cmp    rsi,r15
 1015e77:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015e7d:	cmp    rsi,rdi
 1015e80:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015e86:	shl    r15d,0x5
 1015e8a:	shl    edi,0x5
 1015e8d:	imul   rax,QWORD PTR [rdx+rdi*1]
 1015e92:	mov    QWORD PTR [rdx+r15*1],rax
 1015e96:	jmp    101598d <lyr_w2_o_run+0x8d>
 1015e9b:	mov    rsi,QWORD PTR [r9+0x8]
 1015e9f:	cmp    rsi,rdi
 1015ea2:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015ea8:	cmp    rsi,rax
 1015eab:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1015eb1:	shl    edi,0x5
 1015eb4:	mov    rcx,QWORD PTR [rdx+rdi*1]
 1015eb8:	shl    eax,0x5
 1015ebb:	cmp    rcx,QWORD PTR [rdx+rax*1]
 1015ebf:	jne    1015fda <lyr_w2_o_run+0x6da>
 1015ec5:	cmp    rsi,r15
 1015ec8:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015ece:	xor    eax,eax
 1015ed0:	jmp    1015fe8 <lyr_w2_o_run+0x6e8>
 1015ed5:	mov    rsi,QWORD PTR [r9+0x8]
 1015ed9:	cmp    rsi,r15
 1015edc:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015ee2:	cmp    rsi,rdi
 1015ee5:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015eeb:	cmp    rsi,rax
 1015eee:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1015ef4:	shl    r15d,0x5
 1015ef8:	add    r15,rdx
 1015efb:	shl    edi,0x5
 1015efe:	shl    eax,0x5
 1015f01:	mov    rax,QWORD PTR [rdx+rax*1]
 1015f05:	or     rax,QWORD PTR [rdx+rdi*1]
 1015f09:	jmp    101598a <lyr_w2_o_run+0x8a>
 1015f0e:	mov    rsi,QWORD PTR [r9+0x8]
 1015f12:	cmp    rsi,r15
 1015f15:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015f1b:	cmp    rsi,rdi
 1015f1e:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015f24:	cmp    rsi,rax
 1015f27:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1015f2d:	shl    r15d,0x5
 1015f31:	add    r15,rdx
 1015f34:	shl    edi,0x5
 1015f37:	shl    eax,0x5
 1015f3a:	mov    rax,QWORD PTR [rdx+rax*1]
 1015f3e:	imul   rax,QWORD PTR [rdx+rdi*1]
 1015f43:	jmp    101598a <lyr_w2_o_run+0x8a>
 1015f48:	mov    rsi,QWORD PTR [r9+0x8]
 1015f4c:	cmp    rsi,r15
 1015f4f:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015f55:	shl    r15d,0x5
 1015f59:	cmp    QWORD PTR [rdx+r15*1],0x0
 1015f5e:	jne    101598d <lyr_w2_o_run+0x8d>
 1015f64:	jmp    10165b0 <lyr_w2_o_run+0xcb0>
 1015f69:	mov    rsi,QWORD PTR [r9+0x8]
 1015f6d:	cmp    rsi,r15
 1015f70:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015f76:	cmp    rsi,rdi
 1015f79:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015f7f:	shl    r15d,0x5
 1015f83:	shl    edi,0x5
 1015f86:	mov    rcx,QWORD PTR [rdx+rdi*1]
 1015f8a:	add    rcx,rax
 1015f8d:	mov    QWORD PTR [rdx+r15*1],rcx
 1015f91:	jmp    101598d <lyr_w2_o_run+0x8d>
 1015f96:	mov    rsi,QWORD PTR [r9+0x8]
 1015f9a:	cmp    rsi,r15
 1015f9d:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015fa3:	shl    r15d,0x5
 1015fa7:	inc    QWORD PTR [rdx+r15*1]
 1015fab:	jmp    101598d <lyr_w2_o_run+0x8d>
 1015fb0:	mov    rsi,QWORD PTR [r9+0x8]
 1015fb4:	cmp    rsi,rdi
 1015fb7:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1015fbd:	cmp    rsi,rax
 1015fc0:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1015fc6:	shl    edi,0x5
 1015fc9:	mov    rcx,QWORD PTR [rdx+rdi*1]
 1015fcd:	shl    eax,0x5
 1015fd0:	cmp    rcx,QWORD PTR [rdx+rax*1]
 1015fd4:	jbe    1015ec5 <lyr_w2_o_run+0x5c5>
 1015fda:	mov    eax,0x1
 1015fdf:	cmp    rsi,r15
 1015fe2:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1015fe8:	shl    r15d,0x5
 1015fec:	mov    QWORD PTR [rdx+r15*1],rax
 1015ff0:	jmp    101598d <lyr_w2_o_run+0x8d>
 1015ff5:	mov    rsi,QWORD PTR [r9+0x8]
 1015ff9:	cmp    rsi,r15
 1015ffc:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1016002:	cmp    rsi,rdi
 1016005:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 101600b:	shl    r15d,0x5
 101600f:	shl    edi,0x5
 1016012:	mov    rcx,QWORD PTR [rdx+rdi*1]
 1016016:	xor    rcx,rax
 1016019:	mov    QWORD PTR [rdx+r15*1],rcx
 101601d:	jmp    101598d <lyr_w2_o_run+0x8d>
 1016022:	mov    rsi,QWORD PTR [r9+0x8]
 1016026:	cmp    rsi,r15
 1016029:	jbe    10167ed <lyr_w2_o_run+0xeed>
 101602f:	shl    r15d,0x5
 1016033:	shl    eax,0x10
 1016036:	or     rax,rdi
 1016039:	mov    QWORD PTR [rdx+r15*1],rax
 101603d:	jmp    101598d <lyr_w2_o_run+0x8d>
 1016042:	mov    rsi,QWORD PTR [r9+0x8]
 1016046:	cmp    rsi,rdi
 1016049:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 101604f:	cmp    rsi,rax
 1016052:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1016058:	shl    edi,0x5
 101605b:	mov    rcx,QWORD PTR [rdx+rdi*1]
 101605f:	shl    eax,0x5
 1016062:	mov    rax,QWORD PTR [rdx+rax*1]
 1016066:	cmp    rcx,rax
 1016069:	ja     101606e <lyr_w2_o_run+0x76e>
 101606b:	mov    rcx,rax
 101606e:	cmp    rsi,r15
 1016071:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1016077:	shl    r15d,0x5
 101607b:	mov    QWORD PTR [rdx+r15*1],rcx
 101607f:	jmp    101598d <lyr_w2_o_run+0x8d>
 1016084:	inc    rbx
 1016087:	jo     10167be <lyr_w2_o_run+0xebe>
 101608d:	mov    rsi,QWORD PTR [r8+0x8]
 1016091:	mov    rdi,QWORD PTR [rbp-0x58]
 1016095:	cmp    rdi,rsi
 1016098:	jae    10167f0 <lyr_w2_o_run+0xef0>
 101609e:	mov    QWORD PTR [r8+rdi*8+0x10],rbx
 10160a3:	inc    rdi
 10160a6:	jo     10167be <lyr_w2_o_run+0xebe>
 10160ac:	mov    QWORD PTR [rbp-0x58],rdi
 10160b0:	mov    rbx,rax
 10160b3:	jmp    1015996 <lyr_w2_o_run+0x96>
 10160b8:	mov    rsi,QWORD PTR [r9+0x8]
 10160bc:	cmp    rsi,r15
 10160bf:	jbe    10167ed <lyr_w2_o_run+0xeed>
 10160c5:	cmp    rsi,rdi
 10160c8:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 10160ce:	cmp    rsi,rax
 10160d1:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 10160d7:	shl    r15d,0x5
 10160db:	add    r15,rdx
 10160de:	shl    edi,0x5
 10160e1:	shl    eax,0x5
 10160e4:	mov    rax,QWORD PTR [rdx+rax*1]
 10160e8:	and    rax,QWORD PTR [rdx+rdi*1]
 10160ec:	jmp    101598a <lyr_w2_o_run+0x8a>
 10160f1:	mov    rsi,QWORD PTR [r9+0x8]
 10160f5:	cmp    rsi,r15
 10160f8:	jbe    10167ed <lyr_w2_o_run+0xeed>
 10160fe:	cmp    rsi,rdi
 1016101:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1016107:	cmp    rsi,rax
 101610a:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1016110:	shl    r15d,0x5
 1016114:	add    r15,rdx
 1016117:	shl    edi,0x5
 101611a:	shl    eax,0x5
 101611d:	movzx  eax,BYTE PTR [rdx+rax*1]
 1016121:	shrx   rax,QWORD PTR [rdx+rdi*1],rax
 1016127:	jmp    101598a <lyr_w2_o_run+0x8a>
 101612c:	mov    rsi,QWORD PTR [r9+0x8]
 1016130:	cmp    rsi,r15
 1016133:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1016139:	cmp    rsi,rdi
 101613c:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1016142:	shl    r15d,0x5
 1016146:	shl    edi,0x5
 1016149:	mov    ecx,DWORD PTR [rdx+rdi*1]
 101614c:	and    ecx,eax
 101614e:	mov    QWORD PTR [rdx+r15*1],rcx
 1016152:	jmp    101598d <lyr_w2_o_run+0x8d>
 1016157:	mov    rsi,QWORD PTR [r9+0x8]
 101615b:	cmp    rsi,rdi
 101615e:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1016164:	shl    edi,0x5
 1016167:	cmp    BYTE PTR [rdx+rdi*1+0x18],0x0
 101616c:	je     1016842 <lyr_w2_o_run+0xf42>
 1016172:	mov    rcx,QWORD PTR [rdx+rdi*1+0x10]
 1016177:	mov    rcx,QWORD PTR [rcx]
 101617a:	cmp    rcx,0x1038940
 1016181:	jne    1016853 <lyr_w2_o_run+0xf53>
 1016187:	cmp    rsi,r15
 101618a:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1016190:	mov    rcx,QWORD PTR [rdx+rdi*1+0x8]
 1016195:	mov    rcx,QWORD PTR [rcx+0x8]
 1016199:	mov    rsi,QWORD PTR [rcx+0x8]
 101619d:	cmp    rsi,rax
 10161a0:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 10161a6:	shl    r15d,0x5
 10161aa:	shl    eax,0x5
 10161ad:	mov    rax,QWORD PTR [rcx+rax*1+0x10]
 10161b2:	mov    QWORD PTR [rdx+r15*1],rax
 10161b6:	jmp    101598d <lyr_w2_o_run+0x8d>
 10161bb:	mov    rsi,QWORD PTR [r9+0x8]
 10161bf:	cmp    rsi,r15
 10161c2:	jbe    10167ed <lyr_w2_o_run+0xeed>
 10161c8:	cmp    rsi,rdi
 10161cb:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 10161d1:	shl    r15d,0x5
 10161d5:	mov    rcx,QWORD PTR [rdx+r15*1]
 10161d9:	shl    edi,0x5
 10161dc:	cmp    rcx,QWORD PTR [rdx+rdi*1]
 10161e0:	jae    101598d <lyr_w2_o_run+0x8d>
 10161e6:	jmp    10165b0 <lyr_w2_o_run+0xcb0>
 10161eb:	mov    rsi,QWORD PTR [r9+0x8]
 10161ef:	cmp    rsi,r15
 10161f2:	jbe    10167ed <lyr_w2_o_run+0xeed>
 10161f8:	cmp    rsi,rdi
 10161fb:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1016201:	shl    r15d,0x5
 1016205:	shl    edi,0x5
 1016208:	mov    rax,QWORD PTR [rdx+rdi*1]
 101620c:	mov    QWORD PTR [rdx+r15*1],rax
 1016210:	jmp    101598d <lyr_w2_o_run+0x8d>
 1016215:	mov    rsi,QWORD PTR [r9+0x8]
 1016219:	cmp    rsi,r15
 101621c:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1016222:	cmp    rsi,rdi
 1016225:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 101622b:	cmp    rsi,rax
 101622e:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1016234:	shl    eax,0x5
 1016237:	mov    rcx,QWORD PTR [rdx+rax*1]
 101623b:	test   rcx,rcx
 101623e:	je     1016811 <lyr_w2_o_run+0xf11>
 1016244:	shl    edi,0x5
 1016247:	mov    rax,QWORD PTR [rdx+rdi*1]
 101624b:	mov    rdx,rax
 101624e:	or     rdx,rcx
 1016251:	shr    rdx,0x20
 1016255:	jne    101597a <lyr_w2_o_run+0x7a>
 101625b:	xor    edx,edx
 101625d:	div    ecx
 101625f:	jmp    101597f <lyr_w2_o_run+0x7f>
 1016264:	mov    rsi,QWORD PTR [r11+0x8]
 1016268:	cmp    rsi,rdi
 101626b:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1016271:	shl    edi,0x4
 1016274:	mov    QWORD PTR [rbp-0x80],0x0
 101627c:	mov    rax,QWORD PTR [rbp-0x60]
 1016280:	vmovups xmm0,XMMWORD PTR [rax+rdi*1]
 1016285:	lea    rcx,[rbp-0x78]
 1016289:	vmovups XMMWORD PTR [rcx],xmm0
 101628d:	mov    BYTE PTR [rbp-0x68],0x1
 1016291:	mov    DWORD PTR [rcx+0x14],0x0
 1016298:	lea    rax,[rip+0x286a1]        # 103e940 <lyr_gc_heap_base>
 101629f:	mov    rdx,rcx
 10162a2:	sub    rdx,QWORD PTR [rax]
 10162a5:	mov    DWORD PTR [rcx+0x11],0x0
 10162ac:	lea    rcx,[rip+0x28695]        # 103e948 <lyr_gc_heap_span>
 10162b3:	cmp    rdx,QWORD PTR [rcx]
 10162b6:	jae    1016352 <lyr_w2_o_run+0xa52>
 10162bc:	mov    rsi,rdx
 10162bf:	shr    rsi,0x8
 10162c3:	add    rdx,0x17
 10162c7:	shr    rdx,0x8
 10162cb:	mov    rdi,rdx
 10162ce:	sub    rdi,rsi
 10162d1:	jb     1016352 <lyr_w2_o_run+0xa52>
 10162d3:	inc    rdx
 10162d6:	mov    r10d,edx
 10162d9:	sub    r10d,esi
 10162dc:	and    r10d,0x3
 10162e0:	je     1016307 <lyr_w2_o_run+0xa07>
 10162e2:	neg    r10
 10162e5:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 10162f0:	lea    r9,[rip+0x28631]        # 103e928 <lyr_gc_cards>
 10162f7:	mov    r9,QWORD PTR [r9]
 10162fa:	mov    BYTE PTR [r9+rsi*1],0x1
 10162ff:	inc    rsi
 1016302:	inc    r10
 1016305:	jne    10162f0 <lyr_w2_o_run+0x9f0>
 1016307:	cmp    rdi,0x3
 101630b:	mov    r10,QWORD PTR [rbp-0x38]
 101630f:	jb     1016352 <lyr_w2_o_run+0xa52>
 1016311:	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 1016320:	lea    rdi,[rip+0x28601]        # 103e928 <lyr_gc_cards>
 1016327:	mov    r9,QWORD PTR [rdi]
 101632a:	mov    BYTE PTR [r9+rsi*1],0x1
 101632f:	mov    r9,QWORD PTR [rdi]
 1016332:	mov    BYTE PTR [r9+rsi*1+0x1],0x1
 1016338:	mov    r9,QWORD PTR [rdi]
 101633b:	mov    BYTE PTR [r9+rsi*1+0x2],0x1
 1016341:	mov    rdi,QWORD PTR [rdi]
 1016344:	mov    BYTE PTR [rdi+rsi*1+0x3],0x1
 1016349:	add    rsi,0x4
 101634d:	cmp    rdx,rsi
 1016350:	jne    1016320 <lyr_w2_o_run+0xa20>
 1016352:	mov    r9,QWORD PTR [rbp-0x40]
 1016356:	mov    rsi,QWORD PTR [r9+0x8]
 101635a:	cmp    rsi,r15
 101635d:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1016363:	shl    r15d,0x5
 1016367:	mov    rsi,QWORD PTR [rbp-0x30]
 101636b:	lea    rdx,[rsi+r15*1]
 101636f:	vmovups ymm0,YMMWORD PTR [rbp-0x80]
 1016374:	vmovups YMMWORD PTR [rsi+r15*1],ymm0
 101637a:	sub    rdx,QWORD PTR [rax]
 101637d:	cmp    rdx,QWORD PTR [rcx]
 1016380:	jae    10166df <lyr_w2_o_run+0xddf>
 1016386:	mov    rax,rdx
 1016389:	shr    rax,0x8
 101638d:	add    rdx,0x1f
 1016391:	shr    rdx,0x8
 1016395:	mov    rcx,rdx
 1016398:	sub    rcx,rax
 101639b:	jb     10166df <lyr_w2_o_run+0xddf>
 10163a1:	inc    rdx
 10163a4:	mov    esi,edx
 10163a6:	sub    esi,eax
 10163a8:	and    esi,0x3
 10163ab:	je     10163c6 <lyr_w2_o_run+0xac6>
 10163ad:	neg    rsi
 10163b0:	lea    rdi,[rip+0x28571]        # 103e928 <lyr_gc_cards>
 10163b7:	mov    rdi,QWORD PTR [rdi]
 10163ba:	mov    BYTE PTR [rdi+rax*1],0x1
 10163be:	inc    rax
 10163c1:	inc    rsi
 10163c4:	jne    10163b0 <lyr_w2_o_run+0xab0>
 10163c6:	cmp    rcx,0x3
 10163ca:	jb     10166df <lyr_w2_o_run+0xddf>
 10163d0:	lea    rcx,[rip+0x28551]        # 103e928 <lyr_gc_cards>
 10163d7:	mov    rsi,QWORD PTR [rcx]
 10163da:	mov    BYTE PTR [rsi+rax*1],0x1
 10163de:	mov    rsi,QWORD PTR [rcx]
 10163e1:	mov    BYTE PTR [rsi+rax*1+0x1],0x1
 10163e6:	mov    rsi,QWORD PTR [rcx]
 10163e9:	mov    BYTE PTR [rsi+rax*1+0x2],0x1
 10163ee:	mov    rcx,QWORD PTR [rcx]
 10163f1:	mov    BYTE PTR [rcx+rax*1+0x3],0x1
 10163f6:	add    rax,0x4
 10163fa:	cmp    rdx,rax
 10163fd:	jne    10163d0 <lyr_w2_o_run+0xad0>
 10163ff:	jmp    10166df <lyr_w2_o_run+0xddf>
 1016404:	mov    rsi,QWORD PTR [r9+0x8]
 1016408:	cmp    rsi,rdi
 101640b:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1016411:	cmp    rsi,rax
 1016414:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 101641a:	shl    edi,0x5
 101641d:	mov    rcx,QWORD PTR [rdx+rdi*1]
 1016421:	shl    eax,0x5
 1016424:	mov    rax,QWORD PTR [rdx+rax*1]
 1016428:	cmp    rcx,rax
 101642b:	jb     101606e <lyr_w2_o_run+0x76e>
 1016431:	jmp    101606b <lyr_w2_o_run+0x76b>
 1016436:	mov    rsi,QWORD PTR [r9+0x8]
 101643a:	cmp    rsi,r15
 101643d:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1016443:	cmp    rsi,rdi
 1016446:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 101644c:	cmp    rsi,rax
 101644f:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 1016455:	shl    eax,0x5
 1016458:	mov    rcx,QWORD PTR [rdx+rax*1]
 101645c:	test   rcx,rcx
 101645f:	je     1016811 <lyr_w2_o_run+0xf11>
 1016465:	shl    edi,0x5
 1016468:	mov    rax,QWORD PTR [rdx+rdi*1]
 101646c:	mov    rdx,rax
 101646f:	or     rdx,rcx
 1016472:	shr    rdx,0x20
 1016476:	je     1016738 <lyr_w2_o_run+0xe38>
 101647c:	xor    edx,edx
 101647e:	div    rcx
 1016481:	jmp    101673c <lyr_w2_o_run+0xe3c>
 1016486:	mov    rsi,QWORD PTR [r9+0x8]
 101648a:	cmp    rsi,rdi
 101648d:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1016493:	cmp    rsi,rax
 1016496:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 101649c:	shl    edi,0x5
 101649f:	mov    rcx,QWORD PTR [rdx+rdi*1]
 10164a3:	shl    eax,0x5
 10164a6:	cmp    rcx,QWORD PTR [rdx+rax*1]
 10164aa:	jne    1015ec5 <lyr_w2_o_run+0x5c5>
 10164b0:	jmp    1015fda <lyr_w2_o_run+0x6da>
 10164b5:	mov    rsi,QWORD PTR [r9+0x8]
 10164b9:	cmp    rsi,r15
 10164bc:	jbe    10167ed <lyr_w2_o_run+0xeed>
 10164c2:	cmp    rsi,rdi
 10164c5:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 10164cb:	shl    r15d,0x5
 10164cf:	shl    edi,0x5
 10164d2:	mov    rax,QWORD PTR [rdx+rdi*1]
 10164d6:	not    rax
 10164d9:	mov    QWORD PTR [rdx+r15*1],rax
 10164dd:	jmp    101598d <lyr_w2_o_run+0x8d>
 10164e2:	mov    rsi,QWORD PTR [r9+0x8]
 10164e6:	cmp    rsi,rdi
 10164e9:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 10164ef:	shl    edi,0x5
 10164f2:	cmp    BYTE PTR [rdx+rdi*1+0x18],0x0
 10164f7:	je     1016715 <lyr_w2_o_run+0xe15>
 10164fd:	cmp    rsi,r15
 1016500:	jbe    10167ed <lyr_w2_o_run+0xeed>
 1016506:	mov    rax,QWORD PTR [rdx+rdi*1+0x8]
 101650b:	mov    rsi,QWORD PTR [rdx+rdi*1+0x10]
 1016510:	shl    r15d,0x5
 1016514:	mov    rdi,rax
 1016517:	vzeroupper
 101651a:	call   QWORD PTR [rsi+0x8]
 101651d:	mov    rdx,QWORD PTR [rbp-0x30]
 1016521:	mov    r9,QWORD PTR [rbp-0x40]
 1016525:	mov    r10,QWORD PTR [rbp-0x38]
 1016529:	mov    r11,QWORD PTR [rbp-0x48]
 101652d:	mov    r8,QWORD PTR [rbp-0x50]
 1016531:	jmp    1016703 <lyr_w2_o_run+0xe03>
 1016536:	mov    rsi,QWORD PTR [r9+0x8]
 101653a:	cmp    rsi,rdi
 101653d:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1016543:	cmp    rsi,rax
 1016546:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 101654c:	shl    edi,0x5
 101654f:	mov    rcx,QWORD PTR [rdx+rdi*1]
 1016553:	shl    eax,0x5
 1016556:	cmp    rcx,QWORD PTR [rdx+rax*1]
 101655a:	jae    1015ec5 <lyr_w2_o_run+0x5c5>
 1016560:	jmp    1015fda <lyr_w2_o_run+0x6da>
 1016565:	mov    rsi,QWORD PTR [r9+0x8]
 1016569:	cmp    rsi,rdi
 101656c:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 1016572:	cmp    rsi,rax
 1016575:	jbe    10167f8 <lyr_w2_o_run+0xef8>
 101657b:	shl    edi,0x5
 101657e:	mov    rcx,QWORD PTR [rdx+rdi*1]
 1016582:	shl    eax,0x5
 1016585:	cmp    rcx,QWORD PTR [rdx+rax*1]
 1016589:	ja     1015ec5 <lyr_w2_o_run+0x5c5>
 101658f:	jmp    1015fda <lyr_w2_o_run+0x6da>
 1016594:	mov    rsi,QWORD PTR [r9+0x8]
 1016598:	cmp    rsi,r15
 101659b:	jbe    10167ed <lyr_w2_o_run+0xeed>
 10165a1:	shl    r15d,0x5
 10165a5:	cmp    QWORD PTR [rdx+r15*1],0x0
 10165aa:	je     101598d <lyr_w2_o_run+0x8d>
 10165b0:	mov    rbx,rax
 10165b3:	jmp    1015996 <lyr_w2_o_run+0x96>
 10165b8:	mov    rdi,QWORD PTR [rbp-0x58]
 10165bc:	dec    rdi
 10165bf:	jo     1016819 <lyr_w2_o_run+0xf19>
 10165c5:	mov    rsi,QWORD PTR [r8+0x8]
 10165c9:	cmp    rdi,rsi
 10165cc:	jae    10167f0 <lyr_w2_o_run+0xef0>
 10165d2:	mov    QWORD PTR [rbp-0x58],rdi
 10165d6:	mov    rbx,QWORD PTR [r8+rdi*8+0x10]
 10165db:	jmp    1015996 <lyr_w2_o_run+0x96>
 10165e0:	mov    rsi,QWORD PTR [r9+0x8]
 10165e4:	cmp    rsi,rdi
 10165e7:	jbe    10167f0 <lyr_w2_o_run+0xef0>
 10165ed:	shl    edi,0x5
 10165f0:	cmp    BYTE PTR [rdx+rdi*1+0x18],0x0
 10165f5:	je     1016842 <lyr_w2_o_run+0xf42>
 10165fb:	mov    rcx,QWORD PTR [rdx+rdi*1+0x10]
 1016600:	mov    rcx,QWORD PTR [rcx]
 1016603:	cmp    rcx,0x1038940
 101660a:	jne    1016853 <lyr_w2_o_run+0xf53>
 1016610:	mov    rcx,QWORD PTR [rdx+rdi*1+0x8]
 1016615:	mov    rdx,QWORD PTR [rcx+0x8]
 1016619:	mov    rcx,QWORD PTR [rdx+0x8]
 101661d:	cmp    rcx,rax
 1016620:	jbe    1016803 <lyr_w2_o_run+0xf03>
 1016626:	cmp    rsi,r15
 1016629:	jbe    10167ed <lyr_w2_o_run+0xeed>
 101662f:	shl    eax,0x5
 1016632:	shl    r15d,0x5
 1016636:	mov    rsi,QWORD PTR [rbp-0x30]
 101663a:	lea    rcx,[rsi+r15*1]
 101663e:	vmovups ymm0,YMMWORD PTR [rdx+rax*1+0x10]
 1016644:	vmovups YMMWORD PTR [rsi+r15*1],ymm0
 101664a:	lea    rax,[rip+0x282ef]        # 103e940 <lyr_gc_heap_base>
 1016651:	sub    rcx,QWORD PTR [rax]
 1016654:	lea    rax,[rip+0x282ed]        # 103e948 <lyr_gc_heap_span>
 101665b:	cmp    rcx,QWORD PTR [rax]
 101665e:	jae    10166df <lyr_w2_o_run+0xddf>
 1016660:	mov    rax,rcx
 1016663:	shr    rax,0x8
 1016667:	add    rcx,0x1f
 101666b:	shr    rcx,0x8
 101666f:	mov    rdx,rcx
 1016672:	sub    rdx,rax
 1016675:	jb     10166df <lyr_w2_o_run+0xddf>
 1016677:	inc    rcx
 101667a:	mov    esi,ecx
 101667c:	sub    esi,eax
 101667e:	and    esi,0x3
 1016681:	je     10166a6 <lyr_w2_o_run+0xda6>
 1016683:	neg    rsi
 1016686:	cs nop WORD PTR [rax+rax*1+0x0]
 1016690:	lea    rdi,[rip+0x28291]        # 103e928 <lyr_gc_cards>
 1016697:	mov    rdi,QWORD PTR [rdi]
 101669a:	mov    BYTE PTR [rdi+rax*1],0x1
 101669e:	inc    rax
 10166a1:	inc    rsi
 10166a4:	jne    1016690 <lyr_w2_o_run+0xd90>
 10166a6:	cmp    rdx,0x3
 10166aa:	jb     10166df <lyr_w2_o_run+0xddf>
 10166ac:	nop    DWORD PTR [rax+0x0]
 10166b0:	lea    rdx,[rip+0x28271]        # 103e928 <lyr_gc_cards>
 10166b7:	mov    rsi,QWORD PTR [rdx]
 10166ba:	mov    BYTE PTR [rsi+rax*1],0x1
 10166be:	mov    rsi,QWORD PTR [rdx]
 10166c1:	mov    BYTE PTR [rsi+rax*1+0x1],0x1
 10166c6:	mov    rsi,QWORD PTR [rdx]
 10166c9:	mov    BYTE PTR [rsi+rax*1+0x2],0x1
 10166ce:	mov    rdx,QWORD PTR [rdx]
 10166d1:	mov    BYTE PTR [rdx+rax*1+0x3],0x1
 10166d6:	add    rax,0x4
 10166da:	cmp    rcx,rax
 10166dd:	jne    10166b0 <lyr_w2_o_run+0xdb0>
 10166df:	inc    rbx
 10166e2:	jo     10167be <lyr_w2_o_run+0xebe>
 10166e8:	mov    rdx,QWORD PTR [rbp-0x30]
 10166ec:	jmp    1015996 <lyr_w2_o_run+0x96>
 10166f1:	mov    eax,0x1
 10166f6:	cmp    rsi,r15
 10166f9:	jbe    10167ed <lyr_w2_o_run+0xeed>
 10166ff:	shl    r15d,0x5
 1016703:	mov    QWORD PTR [rdx+r15*1],rax
 1016707:	inc    rbx
 101670a:	jno    1015996 <lyr_w2_o_run+0x96>
 1016710:	jmp    10167be <lyr_w2_o_run+0xebe>
 1016715:	cmp    rsi,r15
 1016718:	jbe    10167ed <lyr_w2_o_run+0xeed>
 101671e:	shl    r15d,0x5
 1016722:	mov    QWORD PTR [rdx+r15*1],0x0
 101672a:	inc    rbx
 101672d:	jno    1015996 <lyr_w2_o_run+0x96>
 1016733:	jmp    10167be <lyr_w2_o_run+0xebe>
 1016738:	xor    edx,edx
 101673a:	div    ecx
 101673c:	shl    r15d,0x5
 1016740:	add    r15,QWORD PTR [rbp-0x30]
 1016744:	mov    QWORD PTR [r15],rdx
 1016747:	inc    rbx
 101674a:	jno    10166e8 <lyr_w2_o_run+0xde8>
 101674c:	jmp    10167be <lyr_w2_o_run+0xebe>
 101674e:	lea    rax,[rip+0x281b3]        # 103e908 <lyr_gc_stop_requested>
 1016755:	mov    eax,DWORD PTR [rax]
 1016757:	mov    r12d,0x400
 101675d:	test   eax,eax
 101675f:	je     10159a8 <lyr_w2_o_run+0xa8>
 1016765:	vzeroupper
 1016768:	call   101b5b0 <lyr_gc_safepoint_slow>
 101676d:	mov    rdx,QWORD PTR [rbp-0x30]
 1016771:	mov    r9,QWORD PTR [rbp-0x40]
 1016775:	mov    r10,QWORD PTR [rbp-0x38]
 1016779:	mov    r11,QWORD PTR [rbp-0x48]
 101677d:	mov    r8,QWORD PTR [rbp-0x50]
 1016781:	jmp    10159a8 <lyr_w2_o_run+0xa8>
 1016786:	lea    rax,[rip+0x2817b]        # 103e908 <lyr_gc_stop_requested>
 101678d:	mov    eax,DWORD PTR [rax]
 101678f:	mov    r12d,0x400
 1016795:	test   eax,eax
 1016797:	je     101599f <lyr_w2_o_run+0x9f>
 101679d:	vzeroupper
 10167a0:	call   101b5b0 <lyr_gc_safepoint_slow>
 10167a5:	mov    rdx,QWORD PTR [rbp-0x30]
 10167a9:	mov    r9,QWORD PTR [rbp-0x40]
 10167ad:	mov    r10,QWORD PTR [rbp-0x38]
 10167b1:	mov    r11,QWORD PTR [rbp-0x48]
 10167b5:	mov    r8,QWORD PTR [rbp-0x50]
 10167b9:	jmp    101599f <lyr_w2_o_run+0x9f>
 10167be:	lea    rdi,[rip+0xfffffffffffec2fe]        # 1002ac3 <lyr_refmap_ty_w2_o_ScriptObject+0x10cb>
 10167c5:	vzeroupper
 10167c8:	call   1021409 <lyr_panic_overflow>
 10167cd:	mov    rax,r14
 10167d0:	add    rsp,0x58
 10167d4:	pop    rbx
 10167d5:	pop    r12
 10167d7:	pop    r13
 10167d9:	pop    r14
 10167db:	pop    r15
 10167dd:	pop    rbp
 10167de:	vzeroupper
 10167e1:	ret
 10167e2:	mov    rdi,rbx
 10167e5:	vzeroupper
 10167e8:	call   10213c8 <lyr_panic_index>
 10167ed:	mov    rdi,r15
 10167f0:	vzeroupper
 10167f3:	call   10213c8 <lyr_panic_index>
 10167f8:	mov    rdi,rax
 10167fb:	vzeroupper
 10167fe:	call   10213c8 <lyr_panic_index>
 1016803:	mov    rdi,rax
 1016806:	mov    rsi,rcx
 1016809:	vzeroupper
 101680c:	call   10213c8 <lyr_panic_index>
 1016811:	vzeroupper
 1016814:	call   1021425 <lyr_panic_division_by_zero>
 1016819:	lea    rdi,[rip+0xfffffffffffec2a1]        # 1002ac1 <lyr_refmap_ty_w2_o_ScriptObject+0x10c9>
 1016820:	vzeroupper
 1016823:	call   1021409 <lyr_panic_overflow>
 1016828:	call   101b620 <lyr_gc_stack_slow>
 101682d:	mov    r9,QWORD PTR [rbp-0x40]
 1016831:	mov    r10,QWORD PTR [rbp-0x38]
 1016835:	mov    r11,QWORD PTR [rbp-0x48]
 1016839:	mov    r8,QWORD PTR [rbp-0x50]
 101683d:	jmp    101594c <lyr_w2_o_run+0x4c>
 1016842:	lea    rdi,[rip+0x22537]        # 1038d80 <lyr_lit0>
 1016849:	vzeroupper
 101684c:	call   102145b <lyr_panic_message>
 1016851:	ud2
 1016853:	lea    rdi,[rip+0x22546]        # 1038da0 <lyr_lit1>
 101685a:	vzeroupper
 101685d:	call   102145b <lyr_panic_message>
 1016862:	ud2
 1016864:	lea    rdi,[rip+0x22555]        # 1038dc0 <lyr_lit2>
 101686b:	vzeroupper
 101686e:	call   102145b <lyr_panic_message>
 1016873:	ud2

