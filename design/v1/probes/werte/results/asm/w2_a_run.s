0000000001015920 <lyr_w2_a_run>:
 1015920:	push   rbp
 1015921:	mov    rbp,rsp
 1015924:	push   r15
 1015926:	push   r14
 1015928:	push   r13
 101592a:	push   r12
 101592c:	push   rbx
 101592d:	sub    rsp,0x48
 1015931:	mov    r11,rdx
 1015934:	mov    rdx,rsi
 1015937:	mov    r14,rdi
 101593a:	mov    rdi,rbp
 101593d:	add    rdi,0xffffffffffffacc0
 1015944:	mov    rax,0xffffffffffffffe0
 101594b:	mov    rax,QWORD PTR fs:[rax+0x10]
 1015950:	cmp    rdi,rax
 1015953:	mov    QWORD PTR [rbp-0x58],r9
 1015957:	mov    QWORD PTR [rbp-0x68],r8
 101595b:	mov    rsi,rcx
 101595e:	mov    QWORD PTR [rbp-0x50],rcx
 1015962:	mov    QWORD PTR [rbp-0x48],r11
 1015966:	mov    QWORD PTR [rbp-0x38],rdx
 101596a:	jb     10166d8 <lyr_w2_a_run+0xdb8>
 1015970:	lea    rax,[r11+0x10]
 1015974:	mov    QWORD PTR [rbp-0x40],rax
 1015978:	lea    rax,[rdx+0x10]
 101597c:	mov    QWORD PTR [rbp-0x30],rax
 1015980:	lea    rax,[r8+0x10]
 1015984:	mov    QWORD PTR [rbp-0x70],rax
 1015988:	mov    r13d,0x400
 101598e:	xor    r15d,r15d
 1015991:	lea    r10,[rip+0xfffffffffffebe48]        # 10017e0 <__abi_tag+0x14e4>
 1015998:	mov    QWORD PTR [rbp-0x60],0x0
 10159a0:	xor    r12d,r12d
 10159a3:	mov    r8,rsi
 10159a6:	jmp    10159c6 <lyr_w2_a_run+0xa6>
 10159a8:	mov    rcx,QWORD PTR [rbp-0x30]
 10159ac:	mov    rax,QWORD PTR [rcx+rdi*8]
 10159b0:	mov    QWORD PTR [rcx+rbx*8],rax
 10159b4:	inc    r12
 10159b7:	jo     1016686 <lyr_w2_a_run+0xd66>
 10159bd:	dec    r13d
 10159c0:	je     101664e <lyr_w2_a_run+0xd2e>
 10159c6:	dec    r13d
 10159c9:	je     1016616 <lyr_w2_a_run+0xcf6>
 10159cf:	mov    rsi,QWORD PTR [r14+0x8]
 10159d3:	cmp    r12,rsi
 10159d6:	jae    10166a4 <lyr_w2_a_run+0xd84>
 10159dc:	inc    r15
 10159df:	jo     1016686 <lyr_w2_a_run+0xd66>
 10159e5:	movzx  ecx,BYTE PTR [r14+r12*8+0x10]
 10159eb:	cmp    rcx,0x2f
 10159ef:	ja     1016704 <lyr_w2_a_run+0xde4>
 10159f5:	movzx  ebx,WORD PTR [r14+r12*8+0x12]
 10159fb:	movzx  edi,WORD PTR [r14+r12*8+0x14]
 1015a01:	movzx  eax,WORD PTR [r14+r12*8+0x16]
 1015a07:	movsxd rcx,DWORD PTR [r10+rcx*4]
 1015a0b:	add    rcx,r10
 1015a0e:	jmp    rcx
 1015a10:	mov    rsi,QWORD PTR [rdx+0x8]
 1015a14:	cmp    rsi,rdi
 1015a17:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015a1d:	cmp    rsi,rax
 1015a20:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1015a26:	cmp    rsi,rbx
 1015a29:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015a2f:	mov    rcx,QWORD PTR [rbp-0x30]
 1015a33:	mov    rax,QWORD PTR [rcx+rax*8]
 1015a37:	add    rax,QWORD PTR [rcx+rdi*8]
 1015a3b:	jmp    10159b0 <lyr_w2_a_run+0x90>
 1015a40:	mov    rsi,QWORD PTR [r11+0x8]
 1015a44:	cmp    rsi,rdi
 1015a47:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015a4d:	shl    edi,0x4
 1015a50:	mov    rcx,QWORD PTR [rbp-0x40]
 1015a54:	mov    rcx,QWORD PTR [rcx+rdi*1+0x8]
 1015a59:	mov    rcx,QWORD PTR [rcx]
 1015a5c:	cmp    rcx,0x1038b10
 1015a63:	jne    10166f6 <lyr_w2_a_run+0xdd6>
 1015a69:	mov    rsi,QWORD PTR [rdx+0x8]
 1015a6d:	cmp    rsi,rbx
 1015a70:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015a76:	add    rdi,QWORD PTR [rbp-0x40]
 1015a7a:	mov    rcx,QWORD PTR [rdi]
 1015a7d:	mov    rcx,QWORD PTR [rcx+0x8]
 1015a81:	mov    rsi,QWORD PTR [rcx+0x8]
 1015a85:	cmp    rsi,rax
 1015a88:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1015a8e:	mov    rdx,QWORD PTR [rbp-0x30]
 1015a92:	mov    rdx,QWORD PTR [rdx+rbx*8]
 1015a96:	mov    QWORD PTR [rcx+rax*8+0x10],rdx
 1015a9b:	inc    r12
 1015a9e:	jno    10165b8 <lyr_w2_a_run+0xc98>
 1015aa4:	jmp    1016686 <lyr_w2_a_run+0xd66>
 1015aa9:	mov    rsi,QWORD PTR [rdx+0x8]
 1015aad:	cmp    rsi,rbx
 1015ab0:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015ab6:	cmp    rsi,rdi
 1015ab9:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015abf:	mov    rsi,QWORD PTR [rbp-0x30]
 1015ac3:	mov    rcx,QWORD PTR [rsi+rbx*8]
 1015ac7:	cmp    rcx,QWORD PTR [rsi+rdi*8]
 1015acb:	je     10159b4 <lyr_w2_a_run+0x94>
 1015ad1:	jmp    101648c <lyr_w2_a_run+0xb6c>
 1015ad6:	mov    rsi,QWORD PTR [rdx+0x8]
 1015ada:	cmp    rsi,rdi
 1015add:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015ae3:	cmp    rsi,rbx
 1015ae6:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015aec:	mov    rsi,QWORD PTR [rbp-0x30]
 1015af0:	mov    rcx,QWORD PTR [rsi+rdi*8]
 1015af4:	sub    rcx,rax
 1015af7:	mov    QWORD PTR [rsi+rbx*8],rcx
 1015afb:	jmp    10159b4 <lyr_w2_a_run+0x94>
 1015b00:	mov    rsi,QWORD PTR [r11+0x8]
 1015b04:	cmp    rsi,rdi
 1015b07:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015b0d:	shl    edi,0x4
 1015b10:	mov    rdx,QWORD PTR [rbp-0x40]
 1015b14:	mov    rcx,QWORD PTR [rdx+rdi*1+0x8]
 1015b19:	mov    rcx,QWORD PTR [rcx]
 1015b1c:	cmp    rcx,0x1038b10
 1015b23:	jne    10166f6 <lyr_w2_a_run+0xdd6>
 1015b29:	cmp    rsi,rbx
 1015b2c:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015b32:	add    rdi,rdx
 1015b35:	mov    rcx,QWORD PTR [rdi]
 1015b38:	mov    rdi,rdx
 1015b3b:	mov    rdx,QWORD PTR [rcx+0x10]
 1015b3f:	mov    rsi,QWORD PTR [rdx+0x8]
 1015b43:	cmp    rsi,rax
 1015b46:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1015b4c:	shl    ebx,0x4
 1015b4f:	shl    eax,0x4
 1015b52:	lea    rcx,[rdx+rax*1]
 1015b56:	add    rcx,0x10
 1015b5a:	vmovaps xmm0,XMMWORD PTR [rdi+rbx*1]
 1015b5f:	vmovaps XMMWORD PTR [rdx+rax*1+0x10],xmm0
 1015b65:	lea    rax,[rip+0x28fa4]        # 103eb10 <lyr_gc_heap_base>
 1015b6c:	sub    rcx,QWORD PTR [rax]
 1015b6f:	lea    rax,[rip+0x28fa2]        # 103eb18 <lyr_gc_heap_span>
 1015b76:	cmp    rcx,QWORD PTR [rax]
 1015b79:	jae    10165af <lyr_w2_a_run+0xc8f>
 1015b7f:	mov    rax,rcx
 1015b82:	shr    rax,0x8
 1015b86:	add    rcx,0xf
 1015b8a:	shr    rcx,0x8
 1015b8e:	mov    rdx,rcx
 1015b91:	sub    rdx,rax
 1015b94:	jb     10165af <lyr_w2_a_run+0xc8f>
 1015b9a:	inc    rcx
 1015b9d:	mov    esi,ecx
 1015b9f:	sub    esi,eax
 1015ba1:	and    esi,0x3
 1015ba4:	je     1015bc6 <lyr_w2_a_run+0x2a6>
 1015ba6:	neg    rsi
 1015ba9:	nop    DWORD PTR [rax+0x0]
 1015bb0:	lea    rdi,[rip+0x28f41]        # 103eaf8 <lyr_gc_cards>
 1015bb7:	mov    rdi,QWORD PTR [rdi]
 1015bba:	mov    BYTE PTR [rdi+rax*1],0x1
 1015bbe:	inc    rax
 1015bc1:	inc    rsi
 1015bc4:	jne    1015bb0 <lyr_w2_a_run+0x290>
 1015bc6:	cmp    rdx,0x3
 1015bca:	jb     10165af <lyr_w2_a_run+0xc8f>
 1015bd0:	lea    rdx,[rip+0x28f21]        # 103eaf8 <lyr_gc_cards>
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
 1015bfd:	jne    1015bd0 <lyr_w2_a_run+0x2b0>
 1015bff:	jmp    10165af <lyr_w2_a_run+0xc8f>
 1015c04:	mov    rsi,QWORD PTR [rdx+0x8]
 1015c08:	cmp    rsi,rdi
 1015c0b:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015c11:	cmp    rsi,rax
 1015c14:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1015c1a:	cmp    rsi,rbx
 1015c1d:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015c23:	mov    rcx,QWORD PTR [rbp-0x30]
 1015c27:	movzx  eax,BYTE PTR [rcx+rax*8]
 1015c2b:	shlx   rax,QWORD PTR [rcx+rdi*8],rax
 1015c31:	jmp    10159b0 <lyr_w2_a_run+0x90>
 1015c36:	mov    rsi,QWORD PTR [rdx+0x8]
 1015c3a:	cmp    rsi,rbx
 1015c3d:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015c43:	mov    rax,QWORD PTR [rbp-0x30]
 1015c47:	dec    QWORD PTR [rax+rbx*8]
 1015c4b:	jmp    10159b4 <lyr_w2_a_run+0x94>
 1015c50:	mov    rsi,QWORD PTR [rdx+0x8]
 1015c54:	cmp    rsi,rbx
 1015c57:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015c5d:	cmp    rsi,rdi
 1015c60:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015c66:	mov    rsi,QWORD PTR [rbp-0x30]
 1015c6a:	mov    rcx,QWORD PTR [rsi+rbx*8]
 1015c6e:	cmp    rcx,QWORD PTR [rsi+rdi*8]
 1015c72:	jne    10159b4 <lyr_w2_a_run+0x94>
 1015c78:	jmp    101648c <lyr_w2_a_run+0xb6c>
 1015c7d:	mov    rsi,QWORD PTR [r8+0x8]
 1015c81:	cmp    rsi,rdi
 1015c84:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015c8a:	mov    rsi,QWORD PTR [rdx+0x8]
 1015c8e:	cmp    rsi,rbx
 1015c91:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015c97:	mov    rax,QWORD PTR [r8+rdi*8+0x10]
 1015c9c:	mov    rcx,QWORD PTR [rbp-0x30]
 1015ca0:	jmp    10159b0 <lyr_w2_a_run+0x90>
 1015ca5:	mov    rsi,QWORD PTR [r11+0x8]
 1015ca9:	cmp    rsi,rdi
 1015cac:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015cb2:	shl    edi,0x4
 1015cb5:	mov    rax,QWORD PTR [r11+rdi*1+0x18]
 1015cba:	mov    rax,QWORD PTR [rax]
 1015cbd:	mov    rsi,QWORD PTR [rdx+0x8]
 1015cc1:	cmp    rax,0x1038b60
 1015cc8:	je     10165c1 <lyr_w2_a_run+0xca1>
 1015cce:	cmp    rsi,rbx
 1015cd1:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015cd7:	xor    eax,eax
 1015cd9:	jmp    10165cf <lyr_w2_a_run+0xcaf>
 1015cde:	mov    rsi,QWORD PTR [rdx+0x8]
 1015ce2:	cmp    rsi,rdi
 1015ce5:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015ceb:	cmp    rsi,rbx
 1015cee:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015cf4:	mov    rcx,QWORD PTR [rbp-0x30]
 1015cf8:	or     rax,QWORD PTR [rcx+rdi*8]
 1015cfc:	jmp    10159b0 <lyr_w2_a_run+0x90>
 1015d01:	mov    rsi,QWORD PTR [rdx+0x8]
 1015d05:	cmp    rsi,rdi
 1015d08:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015d0e:	cmp    rsi,rbx
 1015d11:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015d17:	xor    eax,eax
 1015d19:	mov    rcx,QWORD PTR [rbp-0x30]
 1015d1d:	sub    rax,QWORD PTR [rcx+rdi*8]
 1015d21:	jmp    10159b0 <lyr_w2_a_run+0x90>
 1015d26:	mov    rsi,QWORD PTR [rdx+0x8]
 1015d2a:	cmp    rsi,rdi
 1015d2d:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015d33:	cmp    rsi,rax
 1015d36:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1015d3c:	cmp    rsi,rbx
 1015d3f:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015d45:	mov    rcx,QWORD PTR [rbp-0x30]
 1015d49:	mov    rax,QWORD PTR [rcx+rax*8]
 1015d4d:	xor    rax,QWORD PTR [rcx+rdi*8]
 1015d51:	jmp    10159b0 <lyr_w2_a_run+0x90>
 1015d56:	mov    rsi,QWORD PTR [r11+0x8]
 1015d5a:	cmp    rsi,rdi
 1015d5d:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015d63:	cmp    rsi,rbx
 1015d66:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015d6c:	shl    edi,0x4
 1015d6f:	shl    ebx,0x4
 1015d72:	mov    rcx,QWORD PTR [rbp-0x40]
 1015d76:	lea    rax,[rcx+rbx*1]
 1015d7a:	vmovaps xmm0,XMMWORD PTR [rcx+rdi*1]
 1015d7f:	vmovaps XMMWORD PTR [rcx+rbx*1],xmm0
 1015d84:	lea    rcx,[rip+0x28d85]        # 103eb10 <lyr_gc_heap_base>
 1015d8b:	sub    rax,QWORD PTR [rcx]
 1015d8e:	lea    rcx,[rip+0x28d83]        # 103eb18 <lyr_gc_heap_span>
 1015d95:	cmp    rax,QWORD PTR [rcx]
 1015d98:	jae    10165af <lyr_w2_a_run+0xc8f>
 1015d9e:	mov    rcx,rax
 1015da1:	shr    rcx,0x8
 1015da5:	add    rax,0xf
 1015da9:	shr    rax,0x8
 1015dad:	mov    rdx,rax
 1015db0:	sub    rdx,rcx
 1015db3:	jb     10165af <lyr_w2_a_run+0xc8f>
 1015db9:	inc    rax
 1015dbc:	mov    esi,eax
 1015dbe:	sub    esi,ecx
 1015dc0:	and    esi,0x3
 1015dc3:	je     1015de6 <lyr_w2_a_run+0x4c6>
 1015dc5:	neg    rsi
 1015dc8:	nop    DWORD PTR [rax+rax*1+0x0]
 1015dd0:	lea    rdi,[rip+0x28d21]        # 103eaf8 <lyr_gc_cards>
 1015dd7:	mov    rdi,QWORD PTR [rdi]
 1015dda:	mov    BYTE PTR [rdi+rcx*1],0x1
 1015dde:	inc    rcx
 1015de1:	inc    rsi
 1015de4:	jne    1015dd0 <lyr_w2_a_run+0x4b0>
 1015de6:	cmp    rdx,0x3
 1015dea:	jb     10165af <lyr_w2_a_run+0xc8f>
 1015df0:	lea    rdx,[rip+0x28d01]        # 103eaf8 <lyr_gc_cards>
 1015df7:	mov    rsi,QWORD PTR [rdx]
 1015dfa:	mov    BYTE PTR [rsi+rcx*1],0x1
 1015dfe:	mov    rsi,QWORD PTR [rdx]
 1015e01:	mov    BYTE PTR [rsi+rcx*1+0x1],0x1
 1015e06:	mov    rsi,QWORD PTR [rdx]
 1015e09:	mov    BYTE PTR [rsi+rcx*1+0x2],0x1
 1015e0e:	mov    rdx,QWORD PTR [rdx]
 1015e11:	mov    BYTE PTR [rdx+rcx*1+0x3],0x1
 1015e16:	add    rcx,0x4
 1015e1a:	cmp    rax,rcx
 1015e1d:	jne    1015df0 <lyr_w2_a_run+0x4d0>
 1015e1f:	jmp    10165af <lyr_w2_a_run+0xc8f>
 1015e24:	mov    rsi,QWORD PTR [rdx+0x8]
 1015e28:	cmp    rsi,rdi
 1015e2b:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015e31:	cmp    rsi,rax
 1015e34:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1015e3a:	cmp    rsi,rbx
 1015e3d:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015e43:	mov    rsi,QWORD PTR [rbp-0x30]
 1015e47:	mov    rcx,QWORD PTR [rsi+rdi*8]
 1015e4b:	sub    rcx,QWORD PTR [rsi+rax*8]
 1015e4f:	mov    QWORD PTR [rsi+rbx*8],rcx
 1015e53:	jmp    10159b4 <lyr_w2_a_run+0x94>
 1015e58:	mov    rsi,QWORD PTR [rdx+0x8]
 1015e5c:	cmp    rsi,rdi
 1015e5f:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015e65:	cmp    rsi,rbx
 1015e68:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015e6e:	mov    rcx,QWORD PTR [rbp-0x30]
 1015e72:	imul   rax,QWORD PTR [rcx+rdi*8]
 1015e77:	jmp    10159b0 <lyr_w2_a_run+0x90>
 1015e7c:	mov    rsi,QWORD PTR [rdx+0x8]
 1015e80:	cmp    rsi,rdi
 1015e83:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015e89:	cmp    rsi,rax
 1015e8c:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1015e92:	mov    r10,QWORD PTR [rbp-0x30]
 1015e96:	mov    rcx,QWORD PTR [r10+rdi*8]
 1015e9a:	cmp    rcx,QWORD PTR [r10+rax*8]
 1015e9e:	jne    1015fa2 <lyr_w2_a_run+0x682>
 1015ea4:	cmp    rsi,rbx
 1015ea7:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015ead:	xor    eax,eax
 1015eaf:	jmp    1015fb0 <lyr_w2_a_run+0x690>
 1015eb4:	mov    rsi,QWORD PTR [rdx+0x8]
 1015eb8:	cmp    rsi,rdi
 1015ebb:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015ec1:	cmp    rsi,rax
 1015ec4:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1015eca:	cmp    rsi,rbx
 1015ecd:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015ed3:	mov    rcx,QWORD PTR [rbp-0x30]
 1015ed7:	mov    rax,QWORD PTR [rcx+rax*8]
 1015edb:	or     rax,QWORD PTR [rcx+rdi*8]
 1015edf:	jmp    10159b0 <lyr_w2_a_run+0x90>
 1015ee4:	mov    rsi,QWORD PTR [rdx+0x8]
 1015ee8:	cmp    rsi,rdi
 1015eeb:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015ef1:	cmp    rsi,rax
 1015ef4:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1015efa:	cmp    rsi,rbx
 1015efd:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015f03:	mov    rcx,QWORD PTR [rbp-0x30]
 1015f07:	mov    rax,QWORD PTR [rcx+rax*8]
 1015f0b:	imul   rax,QWORD PTR [rcx+rdi*8]
 1015f10:	jmp    10159b0 <lyr_w2_a_run+0x90>
 1015f15:	mov    rsi,QWORD PTR [rdx+0x8]
 1015f19:	cmp    rsi,rbx
 1015f1c:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015f22:	mov    rcx,QWORD PTR [rbp-0x30]
 1015f26:	cmp    QWORD PTR [rcx+rbx*8],0x0
 1015f2b:	jne    10159b4 <lyr_w2_a_run+0x94>
 1015f31:	jmp    101648c <lyr_w2_a_run+0xb6c>
 1015f36:	mov    rsi,QWORD PTR [rdx+0x8]
 1015f3a:	cmp    rsi,rdi
 1015f3d:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015f43:	cmp    rsi,rbx
 1015f46:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015f4c:	mov    rsi,QWORD PTR [rbp-0x30]
 1015f50:	mov    rcx,QWORD PTR [rsi+rdi*8]
 1015f54:	add    rcx,rax
 1015f57:	mov    QWORD PTR [rsi+rbx*8],rcx
 1015f5b:	jmp    10159b4 <lyr_w2_a_run+0x94>
 1015f60:	mov    rsi,QWORD PTR [rdx+0x8]
 1015f64:	cmp    rsi,rbx
 1015f67:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015f6d:	mov    rax,QWORD PTR [rbp-0x30]
 1015f71:	inc    QWORD PTR [rax+rbx*8]
 1015f75:	jmp    10159b4 <lyr_w2_a_run+0x94>
 1015f7a:	mov    rsi,QWORD PTR [rdx+0x8]
 1015f7e:	cmp    rsi,rdi
 1015f81:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015f87:	cmp    rsi,rax
 1015f8a:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1015f90:	mov    r10,QWORD PTR [rbp-0x30]
 1015f94:	mov    rcx,QWORD PTR [r10+rdi*8]
 1015f98:	cmp    rcx,QWORD PTR [r10+rax*8]
 1015f9c:	jbe    1015ea4 <lyr_w2_a_run+0x584>
 1015fa2:	mov    eax,0x1
 1015fa7:	cmp    rsi,rbx
 1015faa:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015fb0:	mov    rcx,QWORD PTR [rbp-0x30]
 1015fb4:	mov    QWORD PTR [rcx+rbx*8],rax
 1015fb8:	inc    r12
 1015fbb:	jno    1016050 <lyr_w2_a_run+0x730>
 1015fc1:	jmp    1016686 <lyr_w2_a_run+0xd66>
 1015fc6:	mov    rsi,QWORD PTR [rdx+0x8]
 1015fca:	cmp    rsi,rdi
 1015fcd:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1015fd3:	cmp    rsi,rbx
 1015fd6:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015fdc:	mov    rsi,QWORD PTR [rbp-0x30]
 1015fe0:	mov    rcx,QWORD PTR [rsi+rdi*8]
 1015fe4:	xor    rcx,rax
 1015fe7:	mov    QWORD PTR [rsi+rbx*8],rcx
 1015feb:	jmp    10159b4 <lyr_w2_a_run+0x94>
 1015ff0:	mov    rsi,QWORD PTR [rdx+0x8]
 1015ff4:	cmp    rsi,rbx
 1015ff7:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1015ffd:	shl    eax,0x10
 1016000:	or     rax,rdi
 1016003:	mov    rcx,QWORD PTR [rbp-0x30]
 1016007:	jmp    10159b0 <lyr_w2_a_run+0x90>
 101600c:	mov    rsi,QWORD PTR [rdx+0x8]
 1016010:	cmp    rsi,rdi
 1016013:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1016019:	cmp    rsi,rax
 101601c:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1016022:	mov    r10,QWORD PTR [rbp-0x30]
 1016026:	mov    rcx,QWORD PTR [r10+rdi*8]
 101602a:	mov    rax,QWORD PTR [r10+rax*8]
 101602e:	cmp    rcx,rax
 1016031:	ja     1016036 <lyr_w2_a_run+0x716>
 1016033:	mov    rcx,rax
 1016036:	cmp    rsi,rbx
 1016039:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 101603f:	mov    rax,QWORD PTR [rbp-0x30]
 1016043:	mov    QWORD PTR [rax+rbx*8],rcx
 1016047:	inc    r12
 101604a:	jo     1016686 <lyr_w2_a_run+0xd66>
 1016050:	lea    r10,[rip+0xfffffffffffeb789]        # 10017e0 <__abi_tag+0x14e4>
 1016057:	jmp    10159bd <lyr_w2_a_run+0x9d>
 101605c:	inc    r12
 101605f:	jo     1016686 <lyr_w2_a_run+0xd66>
 1016065:	mov    rsi,QWORD PTR [r9+0x8]
 1016069:	mov    rdi,QWORD PTR [rbp-0x60]
 101606d:	cmp    rdi,rsi
 1016070:	jae    10166af <lyr_w2_a_run+0xd8f>
 1016076:	mov    QWORD PTR [r9+rdi*8+0x10],r12
 101607b:	inc    rdi
 101607e:	jo     1016686 <lyr_w2_a_run+0xd66>
 1016084:	mov    QWORD PTR [rbp-0x60],rdi
 1016088:	mov    r12,rax
 101608b:	jmp    10159bd <lyr_w2_a_run+0x9d>
 1016090:	mov    rsi,QWORD PTR [rdx+0x8]
 1016094:	cmp    rsi,rdi
 1016097:	jbe    10166af <lyr_w2_a_run+0xd8f>
 101609d:	cmp    rsi,rax
 10160a0:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 10160a6:	cmp    rsi,rbx
 10160a9:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 10160af:	mov    rcx,QWORD PTR [rbp-0x30]
 10160b3:	mov    rax,QWORD PTR [rcx+rax*8]
 10160b7:	and    rax,QWORD PTR [rcx+rdi*8]
 10160bb:	jmp    10159b0 <lyr_w2_a_run+0x90>
 10160c0:	mov    rsi,QWORD PTR [rdx+0x8]
 10160c4:	cmp    rsi,rdi
 10160c7:	jbe    10166af <lyr_w2_a_run+0xd8f>
 10160cd:	cmp    rsi,rax
 10160d0:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 10160d6:	cmp    rsi,rbx
 10160d9:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 10160df:	mov    rcx,QWORD PTR [rbp-0x30]
 10160e3:	movzx  eax,BYTE PTR [rcx+rax*8]
 10160e7:	shrx   rax,QWORD PTR [rcx+rdi*8],rax
 10160ed:	jmp    10159b0 <lyr_w2_a_run+0x90>
 10160f2:	mov    rsi,QWORD PTR [rdx+0x8]
 10160f6:	cmp    rsi,rdi
 10160f9:	jbe    10166af <lyr_w2_a_run+0xd8f>
 10160ff:	cmp    rsi,rbx
 1016102:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1016108:	mov    rsi,QWORD PTR [rbp-0x30]
 101610c:	mov    ecx,DWORD PTR [rsi+rdi*8]
 101610f:	and    ecx,eax
 1016111:	mov    QWORD PTR [rsi+rbx*8],rcx
 1016115:	jmp    10159b4 <lyr_w2_a_run+0x94>
 101611a:	mov    rsi,QWORD PTR [r11+0x8]
 101611e:	cmp    rsi,rdi
 1016121:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1016127:	shl    edi,0x4
 101612a:	mov    rsi,QWORD PTR [rbp-0x40]
 101612e:	mov    rcx,QWORD PTR [rsi+rdi*1+0x8]
 1016133:	mov    rcx,QWORD PTR [rcx]
 1016136:	cmp    rcx,0x1038b10
 101613d:	jne    10166f6 <lyr_w2_a_run+0xdd6>
 1016143:	add    rdi,rsi
 1016146:	mov    rcx,QWORD PTR [rdi]
 1016149:	mov    rcx,QWORD PTR [rcx+0x8]
 101614d:	mov    rsi,QWORD PTR [rcx+0x8]
 1016151:	cmp    rsi,rax
 1016154:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 101615a:	mov    rsi,QWORD PTR [rdx+0x8]
 101615e:	cmp    rsi,rbx
 1016161:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1016167:	mov    rax,QWORD PTR [rcx+rax*8+0x10]
 101616c:	mov    rcx,QWORD PTR [rbp-0x30]
 1016170:	jmp    10159b0 <lyr_w2_a_run+0x90>
 1016175:	mov    rsi,QWORD PTR [rdx+0x8]
 1016179:	cmp    rsi,rbx
 101617c:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1016182:	cmp    rsi,rdi
 1016185:	jbe    10166af <lyr_w2_a_run+0xd8f>
 101618b:	mov    rsi,QWORD PTR [rbp-0x30]
 101618f:	mov    rcx,QWORD PTR [rsi+rbx*8]
 1016193:	cmp    rcx,QWORD PTR [rsi+rdi*8]
 1016197:	jae    10159b4 <lyr_w2_a_run+0x94>
 101619d:	jmp    101648c <lyr_w2_a_run+0xb6c>
 10161a2:	mov    rsi,QWORD PTR [rdx+0x8]
 10161a6:	cmp    rsi,rdi
 10161a9:	jbe    10166af <lyr_w2_a_run+0xd8f>
 10161af:	cmp    rsi,rbx
 10161b2:	ja     10159a8 <lyr_w2_a_run+0x88>
 10161b8:	jmp    10166ac <lyr_w2_a_run+0xd8c>
 10161bd:	mov    rsi,QWORD PTR [rdx+0x8]
 10161c1:	cmp    rsi,rdi
 10161c4:	jbe    10166af <lyr_w2_a_run+0xd8f>
 10161ca:	cmp    rsi,rax
 10161cd:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 10161d3:	mov    rcx,QWORD PTR [rbp-0x30]
 10161d7:	mov    rcx,QWORD PTR [rcx+rax*8]
 10161db:	test   rcx,rcx
 10161de:	je     10166bc <lyr_w2_a_run+0xd9c>
 10161e4:	cmp    rsi,rbx
 10161e7:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 10161ed:	mov    rax,QWORD PTR [rbp-0x30]
 10161f1:	mov    rax,QWORD PTR [rax+rdi*8]
 10161f5:	mov    rdx,rax
 10161f8:	or     rdx,rcx
 10161fb:	shr    rdx,0x20
 10161ff:	je     10165e5 <lyr_w2_a_run+0xcc5>
 1016205:	xor    edx,edx
 1016207:	div    rcx
 101620a:	jmp    10165e9 <lyr_w2_a_run+0xcc9>
 101620f:	mov    rax,QWORD PTR [rbp-0x68]
 1016213:	mov    rsi,QWORD PTR [rax+0x8]
 1016217:	cmp    rsi,rdi
 101621a:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1016220:	mov    rsi,QWORD PTR [r11+0x8]
 1016224:	cmp    rsi,rbx
 1016227:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 101622d:	shl    edi,0x4
 1016230:	shl    ebx,0x4
 1016233:	mov    rcx,QWORD PTR [rbp-0x40]
 1016237:	lea    rax,[rcx+rbx*1]
 101623b:	mov    rdx,QWORD PTR [rbp-0x70]
 101623f:	vmovaps xmm0,XMMWORD PTR [rdx+rdi*1]
 1016244:	vmovaps XMMWORD PTR [rcx+rbx*1],xmm0
 1016249:	lea    rcx,[rip+0x288c0]        # 103eb10 <lyr_gc_heap_base>
 1016250:	sub    rax,QWORD PTR [rcx]
 1016253:	lea    rcx,[rip+0x288be]        # 103eb18 <lyr_gc_heap_span>
 101625a:	cmp    rax,QWORD PTR [rcx]
 101625d:	jae    10165af <lyr_w2_a_run+0xc8f>
 1016263:	mov    rcx,rax
 1016266:	shr    rcx,0x8
 101626a:	add    rax,0xf
 101626e:	shr    rax,0x8
 1016272:	mov    rdx,rax
 1016275:	sub    rdx,rcx
 1016278:	jb     10165af <lyr_w2_a_run+0xc8f>
 101627e:	inc    rax
 1016281:	mov    esi,eax
 1016283:	sub    esi,ecx
 1016285:	and    esi,0x3
 1016288:	je     10162a6 <lyr_w2_a_run+0x986>
 101628a:	neg    rsi
 101628d:	nop    DWORD PTR [rax]
 1016290:	lea    rdi,[rip+0x28861]        # 103eaf8 <lyr_gc_cards>
 1016297:	mov    rdi,QWORD PTR [rdi]
 101629a:	mov    BYTE PTR [rdi+rcx*1],0x1
 101629e:	inc    rcx
 10162a1:	inc    rsi
 10162a4:	jne    1016290 <lyr_w2_a_run+0x970>
 10162a6:	cmp    rdx,0x3
 10162aa:	jb     10165af <lyr_w2_a_run+0xc8f>
 10162b0:	lea    rdx,[rip+0x28841]        # 103eaf8 <lyr_gc_cards>
 10162b7:	mov    rsi,QWORD PTR [rdx]
 10162ba:	mov    BYTE PTR [rsi+rcx*1],0x1
 10162be:	mov    rsi,QWORD PTR [rdx]
 10162c1:	mov    BYTE PTR [rsi+rcx*1+0x1],0x1
 10162c6:	mov    rsi,QWORD PTR [rdx]
 10162c9:	mov    BYTE PTR [rsi+rcx*1+0x2],0x1
 10162ce:	mov    rdx,QWORD PTR [rdx]
 10162d1:	mov    BYTE PTR [rdx+rcx*1+0x3],0x1
 10162d6:	add    rcx,0x4
 10162da:	cmp    rax,rcx
 10162dd:	jne    10162b0 <lyr_w2_a_run+0x990>
 10162df:	jmp    10165af <lyr_w2_a_run+0xc8f>
 10162e4:	mov    rsi,QWORD PTR [rdx+0x8]
 10162e8:	cmp    rsi,rdi
 10162eb:	jbe    10166af <lyr_w2_a_run+0xd8f>
 10162f1:	cmp    rsi,rax
 10162f4:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 10162fa:	mov    r10,QWORD PTR [rbp-0x30]
 10162fe:	mov    rcx,QWORD PTR [r10+rdi*8]
 1016302:	mov    rax,QWORD PTR [r10+rax*8]
 1016306:	cmp    rcx,rax
 1016309:	jae    1016033 <lyr_w2_a_run+0x713>
 101630f:	jmp    1016036 <lyr_w2_a_run+0x716>
 1016314:	mov    rsi,QWORD PTR [rdx+0x8]
 1016318:	cmp    rsi,rdi
 101631b:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1016321:	cmp    rsi,rax
 1016324:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 101632a:	mov    rcx,QWORD PTR [rbp-0x30]
 101632e:	mov    rcx,QWORD PTR [rcx+rax*8]
 1016332:	test   rcx,rcx
 1016335:	je     10166bc <lyr_w2_a_run+0xd9c>
 101633b:	cmp    rsi,rbx
 101633e:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1016344:	mov    rax,QWORD PTR [rbp-0x30]
 1016348:	mov    rax,QWORD PTR [rax+rdi*8]
 101634c:	mov    rdx,rax
 101634f:	or     rdx,rcx
 1016352:	shr    rdx,0x20
 1016356:	je     1016603 <lyr_w2_a_run+0xce3>
 101635c:	xor    edx,edx
 101635e:	div    rcx
 1016361:	jmp    1016607 <lyr_w2_a_run+0xce7>
 1016366:	mov    rsi,QWORD PTR [rdx+0x8]
 101636a:	cmp    rsi,rdi
 101636d:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1016373:	cmp    rsi,rax
 1016376:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 101637c:	mov    r10,QWORD PTR [rbp-0x30]
 1016380:	mov    rcx,QWORD PTR [r10+rdi*8]
 1016384:	cmp    rcx,QWORD PTR [r10+rax*8]
 1016388:	jne    1015ea4 <lyr_w2_a_run+0x584>
 101638e:	jmp    1015fa2 <lyr_w2_a_run+0x682>
 1016393:	mov    rsi,QWORD PTR [rdx+0x8]
 1016397:	cmp    rsi,rdi
 101639a:	jbe    10166af <lyr_w2_a_run+0xd8f>
 10163a0:	cmp    rsi,rbx
 10163a3:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 10163a9:	mov    rcx,QWORD PTR [rbp-0x30]
 10163ad:	mov    rax,QWORD PTR [rcx+rdi*8]
 10163b1:	not    rax
 10163b4:	jmp    10159b0 <lyr_w2_a_run+0x90>
 10163b9:	mov    rsi,QWORD PTR [r11+0x8]
 10163bd:	cmp    rsi,rdi
 10163c0:	jbe    10166af <lyr_w2_a_run+0xd8f>
 10163c6:	shl    edi,0x4
 10163c9:	mov    rcx,QWORD PTR [rbp-0x40]
 10163cd:	mov    rax,QWORD PTR [rcx+rdi*1]
 10163d1:	mov    rsi,QWORD PTR [rcx+rdi*1+0x8]
 10163d6:	mov    rdi,rax
 10163d9:	call   QWORD PTR [rsi+0x8]
 10163dc:	mov    rdx,QWORD PTR [rbp-0x38]
 10163e0:	mov    rsi,QWORD PTR [rdx+0x8]
 10163e4:	cmp    rsi,rbx
 10163e7:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 10163ed:	mov    rcx,QWORD PTR [rbp-0x30]
 10163f1:	mov    QWORD PTR [rcx+rbx*8],rax
 10163f5:	inc    r12
 10163f8:	jo     1016686 <lyr_w2_a_run+0xd66>
 10163fe:	mov    r9,QWORD PTR [rbp-0x58]
 1016402:	mov    r8,QWORD PTR [rbp-0x50]
 1016406:	mov    r11,QWORD PTR [rbp-0x48]
 101640a:	lea    r10,[rip+0xfffffffffffeb3cf]        # 10017e0 <__abi_tag+0x14e4>
 1016411:	jmp    10159bd <lyr_w2_a_run+0x9d>
 1016416:	mov    rsi,QWORD PTR [rdx+0x8]
 101641a:	cmp    rsi,rdi
 101641d:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1016423:	cmp    rsi,rax
 1016426:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 101642c:	mov    r10,QWORD PTR [rbp-0x30]
 1016430:	mov    rcx,QWORD PTR [r10+rdi*8]
 1016434:	cmp    rcx,QWORD PTR [r10+rax*8]
 1016438:	jae    1015ea4 <lyr_w2_a_run+0x584>
 101643e:	jmp    1015fa2 <lyr_w2_a_run+0x682>
 1016443:	mov    rsi,QWORD PTR [rdx+0x8]
 1016447:	cmp    rsi,rdi
 101644a:	jbe    10166af <lyr_w2_a_run+0xd8f>
 1016450:	cmp    rsi,rax
 1016453:	jbe    10166b4 <lyr_w2_a_run+0xd94>
 1016459:	mov    r10,QWORD PTR [rbp-0x30]
 101645d:	mov    rcx,QWORD PTR [r10+rdi*8]
 1016461:	cmp    rcx,QWORD PTR [r10+rax*8]
 1016465:	ja     1015ea4 <lyr_w2_a_run+0x584>
 101646b:	jmp    1015fa2 <lyr_w2_a_run+0x682>
 1016470:	mov    rsi,QWORD PTR [rdx+0x8]
 1016474:	cmp    rsi,rbx
 1016477:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 101647d:	mov    rcx,QWORD PTR [rbp-0x30]
 1016481:	cmp    QWORD PTR [rcx+rbx*8],0x0
 1016486:	je     10159b4 <lyr_w2_a_run+0x94>
 101648c:	mov    r12,rax
 101648f:	jmp    10159bd <lyr_w2_a_run+0x9d>
 1016494:	mov    rdi,QWORD PTR [rbp-0x60]
 1016498:	dec    rdi
 101649b:	jo     10166c1 <lyr_w2_a_run+0xda1>
 10164a1:	mov    rsi,QWORD PTR [r9+0x8]
 10164a5:	cmp    rdi,rsi
 10164a8:	jae    10166af <lyr_w2_a_run+0xd8f>
 10164ae:	mov    QWORD PTR [rbp-0x60],rdi
 10164b2:	mov    r12,QWORD PTR [r9+rdi*8+0x10]
 10164b7:	jmp    10159bd <lyr_w2_a_run+0x9d>
 10164bc:	mov    rsi,QWORD PTR [r11+0x8]
 10164c0:	cmp    rsi,rdi
 10164c3:	jbe    10166af <lyr_w2_a_run+0xd8f>
 10164c9:	shl    edi,0x4
 10164cc:	mov    rdx,QWORD PTR [rbp-0x40]
 10164d0:	mov    rcx,QWORD PTR [rdx+rdi*1+0x8]
 10164d5:	mov    rcx,QWORD PTR [rcx]
 10164d8:	cmp    rcx,0x1038b10
 10164df:	jne    10166f6 <lyr_w2_a_run+0xdd6>
 10164e5:	add    rdi,rdx
 10164e8:	mov    rcx,QWORD PTR [rdi]
 10164eb:	mov    rdx,QWORD PTR [rcx+0x10]
 10164ef:	mov    rcx,QWORD PTR [rdx+0x8]
 10164f3:	cmp    rcx,rax
 10164f6:	jbe    10166cd <lyr_w2_a_run+0xdad>
 10164fc:	cmp    rsi,rbx
 10164ff:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 1016505:	shl    eax,0x4
 1016508:	shl    ebx,0x4
 101650b:	mov    rsi,QWORD PTR [rbp-0x40]
 101650f:	lea    rcx,[rsi+rbx*1]
 1016513:	vmovaps xmm0,XMMWORD PTR [rdx+rax*1+0x10]
 1016519:	vmovaps XMMWORD PTR [rsi+rbx*1],xmm0
 101651e:	lea    rax,[rip+0x285eb]        # 103eb10 <lyr_gc_heap_base>
 1016525:	sub    rcx,QWORD PTR [rax]
 1016528:	lea    rax,[rip+0x285e9]        # 103eb18 <lyr_gc_heap_span>
 101652f:	cmp    rcx,QWORD PTR [rax]
 1016532:	jae    10165af <lyr_w2_a_run+0xc8f>
 1016538:	mov    rax,rcx
 101653b:	shr    rax,0x8
 101653f:	add    rcx,0xf
 1016543:	shr    rcx,0x8
 1016547:	mov    rdx,rcx
 101654a:	sub    rdx,rax
 101654d:	jb     10165af <lyr_w2_a_run+0xc8f>
 101654f:	inc    rcx
 1016552:	mov    esi,ecx
 1016554:	sub    esi,eax
 1016556:	and    esi,0x3
 1016559:	je     1016576 <lyr_w2_a_run+0xc56>
 101655b:	neg    rsi
 101655e:	xchg   ax,ax
 1016560:	lea    rdi,[rip+0x28591]        # 103eaf8 <lyr_gc_cards>
 1016567:	mov    rdi,QWORD PTR [rdi]
 101656a:	mov    BYTE PTR [rdi+rax*1],0x1
 101656e:	inc    rax
 1016571:	inc    rsi
 1016574:	jne    1016560 <lyr_w2_a_run+0xc40>
 1016576:	cmp    rdx,0x3
 101657a:	jb     10165af <lyr_w2_a_run+0xc8f>
 101657c:	nop    DWORD PTR [rax+0x0]
 1016580:	lea    rdx,[rip+0x28571]        # 103eaf8 <lyr_gc_cards>
 1016587:	mov    rsi,QWORD PTR [rdx]
 101658a:	mov    BYTE PTR [rsi+rax*1],0x1
 101658e:	mov    rsi,QWORD PTR [rdx]
 1016591:	mov    BYTE PTR [rsi+rax*1+0x1],0x1
 1016596:	mov    rsi,QWORD PTR [rdx]
 1016599:	mov    BYTE PTR [rsi+rax*1+0x2],0x1
 101659e:	mov    rdx,QWORD PTR [rdx]
 10165a1:	mov    BYTE PTR [rdx+rax*1+0x3],0x1
 10165a6:	add    rax,0x4
 10165aa:	cmp    rcx,rax
 10165ad:	jne    1016580 <lyr_w2_a_run+0xc60>
 10165af:	inc    r12
 10165b2:	jo     1016686 <lyr_w2_a_run+0xd66>
 10165b8:	mov    rdx,QWORD PTR [rbp-0x38]
 10165bc:	jmp    10159bd <lyr_w2_a_run+0x9d>
 10165c1:	mov    eax,0x1
 10165c6:	cmp    rsi,rbx
 10165c9:	jbe    10166ac <lyr_w2_a_run+0xd8c>
 10165cf:	mov    rcx,QWORD PTR [rbp-0x30]
 10165d3:	mov    QWORD PTR [rcx+rbx*8],rax
 10165d7:	inc    r12
 10165da:	jno    10159bd <lyr_w2_a_run+0x9d>
 10165e0:	jmp    1016686 <lyr_w2_a_run+0xd66>
 10165e5:	xor    edx,edx
 10165e7:	div    ecx
 10165e9:	mov    rcx,QWORD PTR [rbp-0x30]
 10165ed:	mov    QWORD PTR [rcx+rbx*8],rax
 10165f1:	inc    r12
 10165f4:	mov    rdx,QWORD PTR [rbp-0x38]
 10165f8:	jno    10159bd <lyr_w2_a_run+0x9d>
 10165fe:	jmp    1016686 <lyr_w2_a_run+0xd66>
 1016603:	xor    edx,edx
 1016605:	div    ecx
 1016607:	mov    rax,QWORD PTR [rbp-0x30]
 101660b:	mov    QWORD PTR [rax+rbx*8],rdx
 101660f:	inc    r12
 1016612:	jno    10165b8 <lyr_w2_a_run+0xc98>
 1016614:	jmp    1016686 <lyr_w2_a_run+0xd66>
 1016616:	lea    rax,[rip+0x284bb]        # 103ead8 <lyr_gc_stop_requested>
 101661d:	mov    eax,DWORD PTR [rax]
 101661f:	mov    r13d,0x400
 1016625:	test   eax,eax
 1016627:	je     10159cf <lyr_w2_a_run+0xaf>
 101662d:	call   101b780 <lyr_gc_safepoint_slow>
 1016632:	lea    r10,[rip+0xfffffffffffeb1a7]        # 10017e0 <__abi_tag+0x14e4>
 1016639:	mov    rdx,QWORD PTR [rbp-0x38]
 101663d:	mov    r11,QWORD PTR [rbp-0x48]
 1016641:	mov    r8,QWORD PTR [rbp-0x50]
 1016645:	mov    r9,QWORD PTR [rbp-0x58]
 1016649:	jmp    10159cf <lyr_w2_a_run+0xaf>
 101664e:	lea    rax,[rip+0x28483]        # 103ead8 <lyr_gc_stop_requested>
 1016655:	mov    eax,DWORD PTR [rax]
 1016657:	mov    r13d,0x400
 101665d:	test   eax,eax
 101665f:	je     10159c6 <lyr_w2_a_run+0xa6>
 1016665:	call   101b780 <lyr_gc_safepoint_slow>
 101666a:	lea    r10,[rip+0xfffffffffffeb16f]        # 10017e0 <__abi_tag+0x14e4>
 1016671:	mov    rdx,QWORD PTR [rbp-0x38]
 1016675:	mov    r11,QWORD PTR [rbp-0x48]
 1016679:	mov    r8,QWORD PTR [rbp-0x50]
 101667d:	mov    r9,QWORD PTR [rbp-0x58]
 1016681:	jmp    10159c6 <lyr_w2_a_run+0xa6>
 1016686:	lea    rdi,[rip+0xfffffffffffec44d]        # 1002ada <lyr_refmap_ty_w2_a_ScriptObject+0x10e2>
 101668d:	call   10215d9 <lyr_panic_overflow>
 1016692:	mov    rax,r15
 1016695:	add    rsp,0x48
 1016699:	pop    rbx
 101669a:	pop    r12
 101669c:	pop    r13
 101669e:	pop    r14
 10166a0:	pop    r15
 10166a2:	pop    rbp
 10166a3:	ret
 10166a4:	mov    rdi,r12
 10166a7:	call   1021598 <lyr_panic_index>
 10166ac:	mov    rdi,rbx
 10166af:	call   1021598 <lyr_panic_index>
 10166b4:	mov    rdi,rax
 10166b7:	call   1021598 <lyr_panic_index>
 10166bc:	call   10215f5 <lyr_panic_division_by_zero>
 10166c1:	lea    rdi,[rip+0xfffffffffffec410]        # 1002ad8 <lyr_refmap_ty_w2_a_ScriptObject+0x10e0>
 10166c8:	call   10215d9 <lyr_panic_overflow>
 10166cd:	mov    rdi,rax
 10166d0:	mov    rsi,rcx
 10166d3:	call   1021598 <lyr_panic_index>
 10166d8:	call   101b7f0 <lyr_gc_stack_slow>
 10166dd:	mov    rdx,QWORD PTR [rbp-0x38]
 10166e1:	mov    r11,QWORD PTR [rbp-0x48]
 10166e5:	mov    rsi,QWORD PTR [rbp-0x50]
 10166e9:	mov    r8,QWORD PTR [rbp-0x68]
 10166ed:	mov    r9,QWORD PTR [rbp-0x58]
 10166f1:	jmp    1015970 <lyr_w2_a_run+0x50>
 10166f6:	lea    rdi,[rip+0x22873]        # 1038f70 <lyr_lit0>
 10166fd:	call   102162b <lyr_panic_message>
 1016702:	ud2
 1016704:	lea    rdi,[rip+0x22885]        # 1038f90 <lyr_lit1>
 101670b:	call   102162b <lyr_panic_message>
 1016710:	ud2

