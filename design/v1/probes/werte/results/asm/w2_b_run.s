0000000001015930 <lyr_w2_b_run>:
 1015930:	push   rbp
 1015931:	mov    rbp,rsp
 1015934:	push   r15
 1015936:	push   r14
 1015938:	push   r13
 101593a:	push   r12
 101593c:	push   rbx
 101593d:	sub    rsp,0x58
 1015941:	mov    r15,r8
 1015944:	mov    r11,rcx
 1015947:	mov    r10,rdx
 101594a:	mov    r8,rsi
 101594d:	mov    r13,rdi
 1015950:	mov    rdi,rbp
 1015953:	add    rdi,0xffffffffffff97c0
 101595a:	mov    rax,0xffffffffffffffe0
 1015961:	mov    rax,QWORD PTR fs:[rax+0x10]
 1015966:	cmp    rdi,rax
 1015969:	mov    QWORD PTR [rbp-0x40],rcx
 101596d:	mov    QWORD PTR [rbp-0x30],rdx
 1015971:	mov    QWORD PTR [rbp-0x38],rsi
 1015975:	jb     101685c <lyr_w2_b_run+0xf2c>
 101597b:	vxorps xmm0,xmm0,xmm0
 101597f:	vmovaps XMMWORD PTR [rbp-0x70],xmm0
 1015984:	mov    QWORD PTR [rbp-0x60],0x0
 101598c:	lea    r9,[r8+0x10]
 1015990:	lea    rax,[r11+0x10]
 1015994:	mov    QWORD PTR [rbp-0x78],rax
 1015998:	mov    r12d,0x400
 101599e:	xor    r14d,r14d
 10159a1:	mov    QWORD PTR [rbp-0x50],0x0
 10159a9:	xor    ebx,ebx
 10159ab:	mov    QWORD PTR [rbp-0x48],r9
 10159af:	jmp    10159e2 <lyr_w2_b_run+0xb2>
 10159b1:	lea    rdx,[rdi+rdi*2]
 10159b5:	lea    rdx,[r9+rdx*8]
 10159b9:	lea    rcx,[rcx+rcx*2]
 10159bd:	lea    rax,[rax+rax*2]
 10159c1:	mov    rax,QWORD PTR [r9+rax*8]
 10159c5:	or     rax,QWORD PTR [r9+rcx*8]
 10159c9:	mov    QWORD PTR [rdx],rax
 10159cc:	nop    DWORD PTR [rax+0x0]
 10159d0:	inc    rbx
 10159d3:	jo     1016802 <lyr_w2_b_run+0xed2>
 10159d9:	dec    r12d
 10159dc:	je     10167d1 <lyr_w2_b_run+0xea1>
 10159e2:	dec    r12d
 10159e5:	je     10167a0 <lyr_w2_b_run+0xe70>
 10159eb:	mov    rsi,QWORD PTR [r13+0x8]
 10159ef:	cmp    rbx,rsi
 10159f2:	jae    1016820 <lyr_w2_b_run+0xef0>
 10159f8:	inc    r14
 10159fb:	jo     1016802 <lyr_w2_b_run+0xed2>
 1015a01:	movzx  edx,BYTE PTR [r13+rbx*8+0x10]
 1015a07:	cmp    rdx,0x2f
 1015a0b:	ja     1016880 <lyr_w2_b_run+0xf50>
 1015a11:	movzx  edi,WORD PTR [r13+rbx*8+0x12]
 1015a17:	movzx  ecx,WORD PTR [r13+rbx*8+0x14]
 1015a1d:	movzx  eax,WORD PTR [r13+rbx*8+0x16]
 1015a23:	lea    rsi,[rip+0xfffffffffffebdb6]        # 10017e0 <__abi_tag+0x14e4>
 1015a2a:	movsxd rdx,DWORD PTR [rsi+rdx*4]
 1015a2e:	add    rdx,rsi
 1015a31:	jmp    rdx
 1015a33:	mov    rsi,QWORD PTR [r8+0x8]
 1015a37:	cmp    rsi,rdi
 1015a3a:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015a40:	cmp    rsi,rcx
 1015a43:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015a49:	cmp    rsi,rax
 1015a4c:	jbe    1016830 <lyr_w2_b_run+0xf00>
 1015a52:	lea    rdx,[rdi+rdi*2]
 1015a56:	lea    rdx,[r9+rdx*8]
 1015a5a:	lea    rcx,[rcx+rcx*2]
 1015a5e:	lea    rax,[rax+rax*2]
 1015a62:	mov    rax,QWORD PTR [r9+rax*8]
 1015a66:	add    rax,QWORD PTR [r9+rcx*8]
 1015a6a:	jmp    10159c9 <lyr_w2_b_run+0x99>
 1015a6f:	mov    rsi,QWORD PTR [r8+0x8]
 1015a73:	cmp    rsi,rcx
 1015a76:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015a7c:	lea    ecx,[rcx*8+0x0]
 1015a83:	lea    rcx,[rcx+rcx*2]
 1015a87:	mov    rdx,QWORD PTR [r9+rcx*1+0x10]
 1015a8c:	mov    rdx,QWORD PTR [rdx]
 1015a8f:	cmp    rdx,0x1038c40
 1015a96:	jne    1016872 <lyr_w2_b_run+0xf42>
 1015a9c:	mov    rcx,QWORD PTR [r9+rcx*1+0x8]
 1015aa1:	mov    rdx,QWORD PTR [rcx+0x8]
 1015aa5:	mov    rcx,QWORD PTR [rdx+0x8]
 1015aa9:	cmp    rcx,rax
 1015aac:	jbe    1016840 <lyr_w2_b_run+0xf10>
 1015ab2:	cmp    rsi,rdi
 1015ab5:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015abb:	lea    rax,[rax+rax*2]
 1015abf:	lea    rcx,[rdi+rdi*2]
 1015ac3:	mov    rcx,QWORD PTR [r9+rcx*8]
 1015ac7:	mov    QWORD PTR [rdx+rax*8+0x10],rcx
 1015acc:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015ad1:	mov    rsi,QWORD PTR [r8+0x8]
 1015ad5:	cmp    rsi,rdi
 1015ad8:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015ade:	cmp    rsi,rcx
 1015ae1:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015ae7:	lea    rdx,[rdi+rdi*2]
 1015aeb:	mov    rdx,QWORD PTR [r9+rdx*8]
 1015aef:	lea    rcx,[rcx+rcx*2]
 1015af3:	cmp    rdx,QWORD PTR [r9+rcx*8]
 1015af7:	je     10159d0 <lyr_w2_b_run+0xa0>
 1015afd:	jmp    101661c <lyr_w2_b_run+0xcec>
 1015b02:	mov    rsi,QWORD PTR [r8+0x8]
 1015b06:	cmp    rsi,rdi
 1015b09:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015b0f:	cmp    rsi,rcx
 1015b12:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015b18:	lea    rdx,[rdi+rdi*2]
 1015b1c:	lea    rcx,[rcx+rcx*2]
 1015b20:	mov    rcx,QWORD PTR [r9+rcx*8]
 1015b24:	sub    rcx,rax
 1015b27:	mov    QWORD PTR [r9+rdx*8],rcx
 1015b2b:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015b30:	mov    rsi,QWORD PTR [r8+0x8]
 1015b34:	cmp    rsi,rcx
 1015b37:	jbe    1016838 <lyr_w2_b_run+0xf08>
 1015b3d:	lea    ecx,[rcx*8+0x0]
 1015b44:	lea    rcx,[rcx+rcx*2]
 1015b48:	mov    rdx,QWORD PTR [r9+rcx*1+0x10]
 1015b4d:	mov    rdx,QWORD PTR [rdx]
 1015b50:	cmp    rdx,0x1038c40
 1015b57:	jne    1016872 <lyr_w2_b_run+0xf42>
 1015b5d:	cmp    rsi,rdi
 1015b60:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015b66:	mov    rcx,QWORD PTR [r9+rcx*1+0x8]
 1015b6b:	mov    rcx,QWORD PTR [rcx+0x8]
 1015b6f:	mov    rsi,QWORD PTR [rcx+0x8]
 1015b73:	cmp    rsi,rax
 1015b76:	jbe    1016830 <lyr_w2_b_run+0xf00>
 1015b7c:	lea    rdx,[rdi+rdi*2]
 1015b80:	lea    rsi,[rax+rax*2]
 1015b84:	lea    rax,[rcx+rsi*8]
 1015b88:	add    rax,0x10
 1015b8c:	vmovups xmm0,XMMWORD PTR [r9+rdx*8]
 1015b92:	mov    rdx,QWORD PTR [r9+rdx*8+0x10]
 1015b97:	mov    QWORD PTR [rcx+rsi*8+0x20],rdx
 1015b9c:	vmovups XMMWORD PTR [rcx+rsi*8+0x10],xmm0
 1015ba2:	lea    rcx,[rip+0x290c7]        # 103ec70 <lyr_gc_heap_base>
 1015ba9:	sub    rax,QWORD PTR [rcx]
 1015bac:	lea    rcx,[rip+0x290c5]        # 103ec78 <lyr_gc_heap_span>
 1015bb3:	cmp    rax,QWORD PTR [rcx]
 1015bb6:	jae    10159d0 <lyr_w2_b_run+0xa0>
 1015bbc:	mov    rcx,rax
 1015bbf:	shr    rcx,0x8
 1015bc3:	add    rax,0x17
 1015bc7:	shr    rax,0x8
 1015bcb:	mov    rdx,rax
 1015bce:	sub    rdx,rcx
 1015bd1:	jb     10159d0 <lyr_w2_b_run+0xa0>
 1015bd7:	inc    rax
 1015bda:	mov    esi,eax
 1015bdc:	sub    esi,ecx
 1015bde:	and    esi,0x3
 1015be1:	je     1015c06 <lyr_w2_b_run+0x2d6>
 1015be3:	neg    rsi
 1015be6:	cs nop WORD PTR [rax+rax*1+0x0]
 1015bf0:	lea    rdi,[rip+0x29061]        # 103ec58 <lyr_gc_cards>
 1015bf7:	mov    rdi,QWORD PTR [rdi]
 1015bfa:	mov    BYTE PTR [rdi+rcx*1],0x1
 1015bfe:	inc    rcx
 1015c01:	inc    rsi
 1015c04:	jne    1015bf0 <lyr_w2_b_run+0x2c0>
 1015c06:	cmp    rdx,0x3
 1015c0a:	jb     10159d0 <lyr_w2_b_run+0xa0>
 1015c10:	lea    rdx,[rip+0x29041]        # 103ec58 <lyr_gc_cards>
 1015c17:	mov    rsi,QWORD PTR [rdx]
 1015c1a:	mov    BYTE PTR [rsi+rcx*1],0x1
 1015c1e:	mov    rsi,QWORD PTR [rdx]
 1015c21:	mov    BYTE PTR [rsi+rcx*1+0x1],0x1
 1015c26:	mov    rsi,QWORD PTR [rdx]
 1015c29:	mov    BYTE PTR [rsi+rcx*1+0x2],0x1
 1015c2e:	mov    rdx,QWORD PTR [rdx]
 1015c31:	mov    BYTE PTR [rdx+rcx*1+0x3],0x1
 1015c36:	add    rcx,0x4
 1015c3a:	cmp    rax,rcx
 1015c3d:	jne    1015c10 <lyr_w2_b_run+0x2e0>
 1015c3f:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015c44:	mov    rsi,QWORD PTR [r8+0x8]
 1015c48:	cmp    rsi,rdi
 1015c4b:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015c51:	cmp    rsi,rcx
 1015c54:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015c5a:	cmp    rsi,rax
 1015c5d:	jbe    1016830 <lyr_w2_b_run+0xf00>
 1015c63:	lea    rdx,[rdi+rdi*2]
 1015c67:	lea    rdx,[r9+rdx*8]
 1015c6b:	lea    rcx,[rcx+rcx*2]
 1015c6f:	lea    rax,[rax+rax*2]
 1015c73:	movzx  eax,BYTE PTR [r9+rax*8]
 1015c78:	shlx   rax,QWORD PTR [r9+rcx*8],rax
 1015c7e:	jmp    10159c9 <lyr_w2_b_run+0x99>
 1015c83:	mov    rsi,QWORD PTR [r8+0x8]
 1015c87:	cmp    rsi,rdi
 1015c8a:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015c90:	lea    rax,[rdi+rdi*2]
 1015c94:	dec    QWORD PTR [r9+rax*8]
 1015c98:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015c9d:	mov    rsi,QWORD PTR [r8+0x8]
 1015ca1:	cmp    rsi,rdi
 1015ca4:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015caa:	cmp    rsi,rcx
 1015cad:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015cb3:	lea    rdx,[rdi+rdi*2]
 1015cb7:	mov    rdx,QWORD PTR [r9+rdx*8]
 1015cbb:	lea    rcx,[rcx+rcx*2]
 1015cbf:	cmp    rdx,QWORD PTR [r9+rcx*8]
 1015cc3:	jne    10159d0 <lyr_w2_b_run+0xa0>
 1015cc9:	jmp    101661c <lyr_w2_b_run+0xcec>
 1015cce:	mov    rsi,QWORD PTR [r8+0x8]
 1015cd2:	cmp    rsi,rdi
 1015cd5:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015cdb:	mov    rsi,QWORD PTR [r10+0x8]
 1015cdf:	cmp    rsi,rcx
 1015ce2:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015ce8:	lea    rax,[rdi+rdi*2]
 1015cec:	mov    rcx,QWORD PTR [r10+rcx*8+0x10]
 1015cf1:	mov    QWORD PTR [r9+rax*8],rcx
 1015cf5:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015cfa:	mov    rsi,QWORD PTR [r8+0x8]
 1015cfe:	cmp    rsi,rcx
 1015d01:	jbe    1016838 <lyr_w2_b_run+0xf08>
 1015d07:	lea    rax,[rcx+rcx*2]
 1015d0b:	mov    rax,QWORD PTR [r8+rax*8+0x20]
 1015d10:	mov    rax,QWORD PTR [rax]
 1015d13:	cmp    rax,0x1038c90
 1015d1a:	je     1016754 <lyr_w2_b_run+0xe24>
 1015d20:	cmp    rsi,rdi
 1015d23:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015d29:	xor    eax,eax
 1015d2b:	jmp    1016762 <lyr_w2_b_run+0xe32>
 1015d30:	mov    rsi,QWORD PTR [r8+0x8]
 1015d34:	cmp    rsi,rdi
 1015d37:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015d3d:	cmp    rsi,rcx
 1015d40:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015d46:	lea    rdx,[rdi+rdi*2]
 1015d4a:	lea    rcx,[rcx+rcx*2]
 1015d4e:	or     rax,QWORD PTR [r9+rcx*8]
 1015d52:	mov    QWORD PTR [r9+rdx*8],rax
 1015d56:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015d5b:	mov    rsi,QWORD PTR [r8+0x8]
 1015d5f:	cmp    rsi,rdi
 1015d62:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015d68:	cmp    rsi,rcx
 1015d6b:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015d71:	lea    rax,[rdi+rdi*2]
 1015d75:	lea    rcx,[rcx+rcx*2]
 1015d79:	xor    edx,edx
 1015d7b:	sub    rdx,QWORD PTR [r9+rcx*8]
 1015d7f:	mov    QWORD PTR [r9+rax*8],rdx
 1015d83:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015d88:	mov    rsi,QWORD PTR [r8+0x8]
 1015d8c:	cmp    rsi,rdi
 1015d8f:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015d95:	cmp    rsi,rcx
 1015d98:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015d9e:	cmp    rsi,rax
 1015da1:	jbe    1016830 <lyr_w2_b_run+0xf00>
 1015da7:	lea    rdx,[rdi+rdi*2]
 1015dab:	lea    rdx,[r9+rdx*8]
 1015daf:	lea    rcx,[rcx+rcx*2]
 1015db3:	lea    rax,[rax+rax*2]
 1015db7:	mov    rax,QWORD PTR [r9+rax*8]
 1015dbb:	xor    rax,QWORD PTR [r9+rcx*8]
 1015dbf:	jmp    10159c9 <lyr_w2_b_run+0x99>
 1015dc4:	mov    rsi,QWORD PTR [r8+0x8]
 1015dc8:	cmp    rsi,rcx
 1015dcb:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015dd1:	cmp    rsi,rdi
 1015dd4:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015dda:	lea    rcx,[rcx+rcx*2]
 1015dde:	lea    rdx,[rdi+rdi*2]
 1015de2:	lea    rax,[r9+rdx*8]
 1015de6:	vmovups xmm0,XMMWORD PTR [r9+rcx*8]
 1015dec:	mov    rcx,QWORD PTR [r9+rcx*8+0x10]
 1015df1:	mov    QWORD PTR [r9+rdx*8+0x10],rcx
 1015df6:	vmovups XMMWORD PTR [r9+rdx*8],xmm0
 1015dfc:	lea    rcx,[rip+0x28e6d]        # 103ec70 <lyr_gc_heap_base>
 1015e03:	sub    rax,QWORD PTR [rcx]
 1015e06:	lea    rcx,[rip+0x28e6b]        # 103ec78 <lyr_gc_heap_span>
 1015e0d:	cmp    rax,QWORD PTR [rcx]
 1015e10:	jae    10159d0 <lyr_w2_b_run+0xa0>
 1015e16:	mov    rcx,rax
 1015e19:	shr    rcx,0x8
 1015e1d:	add    rax,0x17
 1015e21:	shr    rax,0x8
 1015e25:	mov    rdx,rax
 1015e28:	sub    rdx,rcx
 1015e2b:	jb     10159d0 <lyr_w2_b_run+0xa0>
 1015e31:	inc    rax
 1015e34:	mov    esi,eax
 1015e36:	sub    esi,ecx
 1015e38:	and    esi,0x3
 1015e3b:	je     1015e56 <lyr_w2_b_run+0x526>
 1015e3d:	neg    rsi
 1015e40:	lea    rdi,[rip+0x28e11]        # 103ec58 <lyr_gc_cards>
 1015e47:	mov    rdi,QWORD PTR [rdi]
 1015e4a:	mov    BYTE PTR [rdi+rcx*1],0x1
 1015e4e:	inc    rcx
 1015e51:	inc    rsi
 1015e54:	jne    1015e40 <lyr_w2_b_run+0x510>
 1015e56:	cmp    rdx,0x3
 1015e5a:	jb     10159d0 <lyr_w2_b_run+0xa0>
 1015e60:	lea    rdx,[rip+0x28df1]        # 103ec58 <lyr_gc_cards>
 1015e67:	mov    rsi,QWORD PTR [rdx]
 1015e6a:	mov    BYTE PTR [rsi+rcx*1],0x1
 1015e6e:	mov    rsi,QWORD PTR [rdx]
 1015e71:	mov    BYTE PTR [rsi+rcx*1+0x1],0x1
 1015e76:	mov    rsi,QWORD PTR [rdx]
 1015e79:	mov    BYTE PTR [rsi+rcx*1+0x2],0x1
 1015e7e:	mov    rdx,QWORD PTR [rdx]
 1015e81:	mov    BYTE PTR [rdx+rcx*1+0x3],0x1
 1015e86:	add    rcx,0x4
 1015e8a:	cmp    rax,rcx
 1015e8d:	jne    1015e60 <lyr_w2_b_run+0x530>
 1015e8f:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015e94:	mov    rsi,QWORD PTR [r8+0x8]
 1015e98:	cmp    rsi,rdi
 1015e9b:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015ea1:	cmp    rsi,rcx
 1015ea4:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015eaa:	cmp    rsi,rax
 1015ead:	jbe    1016830 <lyr_w2_b_run+0xf00>
 1015eb3:	lea    rdx,[rdi+rdi*2]
 1015eb7:	lea    rdx,[r9+rdx*8]
 1015ebb:	lea    rcx,[rcx+rcx*2]
 1015ebf:	mov    rcx,QWORD PTR [r9+rcx*8]
 1015ec3:	lea    rax,[rax+rax*2]
 1015ec7:	sub    rcx,QWORD PTR [r9+rax*8]
 1015ecb:	mov    QWORD PTR [rdx],rcx
 1015ece:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015ed3:	mov    rsi,QWORD PTR [r8+0x8]
 1015ed7:	cmp    rsi,rdi
 1015eda:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015ee0:	cmp    rsi,rcx
 1015ee3:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015ee9:	lea    rdx,[rdi+rdi*2]
 1015eed:	lea    rcx,[rcx+rcx*2]
 1015ef1:	imul   rax,QWORD PTR [r9+rcx*8]
 1015ef6:	mov    QWORD PTR [r9+rdx*8],rax
 1015efa:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015eff:	mov    rsi,QWORD PTR [r8+0x8]
 1015f03:	cmp    rsi,rcx
 1015f06:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015f0c:	cmp    rsi,rax
 1015f0f:	jbe    1016830 <lyr_w2_b_run+0xf00>
 1015f15:	lea    rcx,[rcx+rcx*2]
 1015f19:	mov    rcx,QWORD PTR [r9+rcx*8]
 1015f1d:	lea    rax,[rax+rax*2]
 1015f21:	cmp    rcx,QWORD PTR [r9+rax*8]
 1015f25:	jne    1016031 <lyr_w2_b_run+0x701>
 1015f2b:	cmp    rsi,rdi
 1015f2e:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015f34:	xor    eax,eax
 1015f36:	jmp    101603f <lyr_w2_b_run+0x70f>
 1015f3b:	mov    rsi,QWORD PTR [r8+0x8]
 1015f3f:	cmp    rsi,rdi
 1015f42:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015f48:	cmp    rsi,rcx
 1015f4b:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015f51:	cmp    rsi,rax
 1015f54:	ja     10159b1 <lyr_w2_b_run+0x81>
 1015f5a:	jmp    1016830 <lyr_w2_b_run+0xf00>
 1015f5f:	mov    rsi,QWORD PTR [r8+0x8]
 1015f63:	cmp    rsi,rdi
 1015f66:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015f6c:	cmp    rsi,rcx
 1015f6f:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015f75:	cmp    rsi,rax
 1015f78:	jbe    1016830 <lyr_w2_b_run+0xf00>
 1015f7e:	lea    rdx,[rdi+rdi*2]
 1015f82:	lea    rdx,[r9+rdx*8]
 1015f86:	lea    rcx,[rcx+rcx*2]
 1015f8a:	lea    rax,[rax+rax*2]
 1015f8e:	mov    rax,QWORD PTR [r9+rax*8]
 1015f92:	imul   rax,QWORD PTR [r9+rcx*8]
 1015f97:	jmp    10159c9 <lyr_w2_b_run+0x99>
 1015f9c:	mov    rsi,QWORD PTR [r8+0x8]
 1015fa0:	cmp    rsi,rdi
 1015fa3:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015fa9:	lea    rcx,[rdi+rdi*2]
 1015fad:	cmp    QWORD PTR [r9+rcx*8],0x0
 1015fb2:	jne    10159d0 <lyr_w2_b_run+0xa0>
 1015fb8:	jmp    101661c <lyr_w2_b_run+0xcec>
 1015fbd:	mov    rsi,QWORD PTR [r8+0x8]
 1015fc1:	cmp    rsi,rdi
 1015fc4:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015fca:	cmp    rsi,rcx
 1015fcd:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1015fd3:	lea    rdx,[rdi+rdi*2]
 1015fd7:	lea    rcx,[rcx+rcx*2]
 1015fdb:	mov    rcx,QWORD PTR [r9+rcx*8]
 1015fdf:	add    rcx,rax
 1015fe2:	mov    QWORD PTR [r9+rdx*8],rcx
 1015fe6:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1015feb:	mov    rsi,QWORD PTR [r8+0x8]
 1015fef:	cmp    rsi,rdi
 1015ff2:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1015ff8:	lea    rax,[rdi+rdi*2]
 1015ffc:	inc    QWORD PTR [r9+rax*8]
 1016000:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1016005:	mov    rsi,QWORD PTR [r8+0x8]
 1016009:	cmp    rsi,rcx
 101600c:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1016012:	cmp    rsi,rax
 1016015:	jbe    1016830 <lyr_w2_b_run+0xf00>
 101601b:	lea    rcx,[rcx+rcx*2]
 101601f:	mov    rcx,QWORD PTR [r9+rcx*8]
 1016023:	lea    rax,[rax+rax*2]
 1016027:	cmp    rcx,QWORD PTR [r9+rax*8]
 101602b:	jbe    1015f2b <lyr_w2_b_run+0x5fb>
 1016031:	mov    eax,0x1
 1016036:	cmp    rsi,rdi
 1016039:	jbe    1016823 <lyr_w2_b_run+0xef3>
 101603f:	lea    rcx,[rdi+rdi*2]
 1016043:	mov    QWORD PTR [r9+rcx*8],rax
 1016047:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 101604c:	mov    rsi,QWORD PTR [r8+0x8]
 1016050:	cmp    rsi,rdi
 1016053:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1016059:	cmp    rsi,rcx
 101605c:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1016062:	lea    rdx,[rdi+rdi*2]
 1016066:	lea    rcx,[rcx+rcx*2]
 101606a:	mov    rcx,QWORD PTR [r9+rcx*8]
 101606e:	xor    rcx,rax
 1016071:	mov    QWORD PTR [r9+rdx*8],rcx
 1016075:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 101607a:	mov    rsi,QWORD PTR [r8+0x8]
 101607e:	cmp    rsi,rdi
 1016081:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1016087:	lea    rdx,[rdi+rdi*2]
 101608b:	shl    eax,0x10
 101608e:	or     rax,rcx
 1016091:	mov    QWORD PTR [r9+rdx*8],rax
 1016095:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 101609a:	mov    rsi,QWORD PTR [r8+0x8]
 101609e:	cmp    rsi,rcx
 10160a1:	jbe    1016828 <lyr_w2_b_run+0xef8>
 10160a7:	cmp    rsi,rax
 10160aa:	jbe    1016830 <lyr_w2_b_run+0xf00>
 10160b0:	lea    rcx,[rcx+rcx*2]
 10160b4:	mov    rcx,QWORD PTR [r9+rcx*8]
 10160b8:	lea    rax,[rax+rax*2]
 10160bc:	mov    rax,QWORD PTR [r9+rax*8]
 10160c0:	cmp    rcx,rax
 10160c3:	ja     10160c8 <lyr_w2_b_run+0x798>
 10160c5:	mov    rcx,rax
 10160c8:	cmp    rsi,rdi
 10160cb:	jbe    1016823 <lyr_w2_b_run+0xef3>
 10160d1:	lea    rax,[rdi+rdi*2]
 10160d5:	mov    QWORD PTR [r9+rax*8],rcx
 10160d9:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 10160de:	inc    rbx
 10160e1:	jo     1016802 <lyr_w2_b_run+0xed2>
 10160e7:	mov    rsi,QWORD PTR [r15+0x8]
 10160eb:	mov    rdi,QWORD PTR [rbp-0x50]
 10160ef:	cmp    rdi,rsi
 10160f2:	jae    1016823 <lyr_w2_b_run+0xef3>
 10160f8:	mov    QWORD PTR [r15+rdi*8+0x10],rbx
 10160fd:	inc    rdi
 1016100:	jo     1016802 <lyr_w2_b_run+0xed2>
 1016106:	mov    QWORD PTR [rbp-0x50],rdi
 101610a:	mov    rbx,rax
 101610d:	jmp    10159d9 <lyr_w2_b_run+0xa9>
 1016112:	mov    rsi,QWORD PTR [r8+0x8]
 1016116:	cmp    rsi,rdi
 1016119:	jbe    1016823 <lyr_w2_b_run+0xef3>
 101611f:	cmp    rsi,rcx
 1016122:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1016128:	cmp    rsi,rax
 101612b:	jbe    1016830 <lyr_w2_b_run+0xf00>
 1016131:	lea    rdx,[rdi+rdi*2]
 1016135:	lea    rdx,[r9+rdx*8]
 1016139:	lea    rcx,[rcx+rcx*2]
 101613d:	lea    rax,[rax+rax*2]
 1016141:	mov    rax,QWORD PTR [r9+rax*8]
 1016145:	and    rax,QWORD PTR [r9+rcx*8]
 1016149:	jmp    10159c9 <lyr_w2_b_run+0x99>
 101614e:	mov    rsi,QWORD PTR [r8+0x8]
 1016152:	cmp    rsi,rdi
 1016155:	jbe    1016823 <lyr_w2_b_run+0xef3>
 101615b:	cmp    rsi,rcx
 101615e:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1016164:	cmp    rsi,rax
 1016167:	jbe    1016830 <lyr_w2_b_run+0xf00>
 101616d:	lea    rdx,[rdi+rdi*2]
 1016171:	lea    rdx,[r9+rdx*8]
 1016175:	lea    rcx,[rcx+rcx*2]
 1016179:	lea    rax,[rax+rax*2]
 101617d:	movzx  eax,BYTE PTR [r9+rax*8]
 1016182:	shrx   rax,QWORD PTR [r9+rcx*8],rax
 1016188:	jmp    10159c9 <lyr_w2_b_run+0x99>
 101618d:	mov    rsi,QWORD PTR [r8+0x8]
 1016191:	cmp    rsi,rdi
 1016194:	jbe    1016823 <lyr_w2_b_run+0xef3>
 101619a:	cmp    rsi,rcx
 101619d:	jbe    1016828 <lyr_w2_b_run+0xef8>
 10161a3:	lea    rdx,[rdi+rdi*2]
 10161a7:	lea    rcx,[rcx+rcx*2]
 10161ab:	mov    ecx,DWORD PTR [r9+rcx*8]
 10161af:	and    ecx,eax
 10161b1:	mov    QWORD PTR [r9+rdx*8],rcx
 10161b5:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 10161ba:	mov    rsi,QWORD PTR [r8+0x8]
 10161be:	cmp    rsi,rcx
 10161c1:	jbe    1016828 <lyr_w2_b_run+0xef8>
 10161c7:	lea    rcx,[rcx+rcx*2]
 10161cb:	mov    rdx,QWORD PTR [r9+rcx*8+0x10]
 10161d0:	mov    rdx,QWORD PTR [rdx]
 10161d3:	cmp    rdx,0x1038c40
 10161da:	jne    1016872 <lyr_w2_b_run+0xf42>
 10161e0:	cmp    rsi,rdi
 10161e3:	jbe    1016823 <lyr_w2_b_run+0xef3>
 10161e9:	mov    rcx,QWORD PTR [r9+rcx*8+0x8]
 10161ee:	mov    rcx,QWORD PTR [rcx+0x8]
 10161f2:	mov    rsi,QWORD PTR [rcx+0x8]
 10161f6:	cmp    rsi,rax
 10161f9:	jbe    1016830 <lyr_w2_b_run+0xf00>
 10161ff:	lea    rdx,[rdi+rdi*2]
 1016203:	lea    rax,[rax+rax*2]
 1016207:	mov    rax,QWORD PTR [rcx+rax*8+0x10]
 101620c:	mov    QWORD PTR [r9+rdx*8],rax
 1016210:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1016215:	mov    rsi,QWORD PTR [r8+0x8]
 1016219:	cmp    rsi,rdi
 101621c:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1016222:	cmp    rsi,rcx
 1016225:	jbe    1016828 <lyr_w2_b_run+0xef8>
 101622b:	lea    rdx,[rdi+rdi*2]
 101622f:	mov    rdx,QWORD PTR [r9+rdx*8]
 1016233:	lea    rcx,[rcx+rcx*2]
 1016237:	cmp    rdx,QWORD PTR [r9+rcx*8]
 101623b:	jae    10159d0 <lyr_w2_b_run+0xa0>
 1016241:	jmp    101661c <lyr_w2_b_run+0xcec>
 1016246:	mov    rsi,QWORD PTR [r8+0x8]
 101624a:	cmp    rsi,rdi
 101624d:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1016253:	cmp    rsi,rcx
 1016256:	jbe    1016828 <lyr_w2_b_run+0xef8>
 101625c:	lea    rax,[rdi+rdi*2]
 1016260:	lea    rcx,[rcx+rcx*2]
 1016264:	mov    rcx,QWORD PTR [r9+rcx*8]
 1016268:	mov    QWORD PTR [r9+rax*8],rcx
 101626c:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1016271:	mov    rsi,QWORD PTR [r8+0x8]
 1016275:	cmp    rsi,rdi
 1016278:	jbe    1016823 <lyr_w2_b_run+0xef3>
 101627e:	cmp    rsi,rcx
 1016281:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1016287:	cmp    rsi,rax
 101628a:	jbe    1016830 <lyr_w2_b_run+0xf00>
 1016290:	lea    rax,[rax+rax*2]
 1016294:	mov    rsi,QWORD PTR [r9+rax*8]
 1016298:	test   rsi,rsi
 101629b:	je     101684b <lyr_w2_b_run+0xf1b>
 10162a1:	lea    rax,[rcx+rcx*2]
 10162a5:	mov    rax,QWORD PTR [r9+rax*8]
 10162a9:	mov    rcx,rax
 10162ac:	or     rcx,rsi
 10162af:	shr    rcx,0x20
 10162b3:	je     1016778 <lyr_w2_b_run+0xe48>
 10162b9:	xor    edx,edx
 10162bb:	div    rsi
 10162be:	jmp    101677c <lyr_w2_b_run+0xe4c>
 10162c3:	mov    rsi,QWORD PTR [r11+0x8]
 10162c7:	cmp    rsi,rcx
 10162ca:	jbe    1016828 <lyr_w2_b_run+0xef8>
 10162d0:	shl    ecx,0x4
 10162d3:	mov    QWORD PTR [rbp-0x70],0x0
 10162db:	mov    rax,QWORD PTR [rbp-0x78]
 10162df:	vmovups xmm0,XMMWORD PTR [rax+rcx*1]
 10162e4:	lea    rax,[rip+0x28985]        # 103ec70 <lyr_gc_heap_base>
 10162eb:	lea    rcx,[rbp-0x68]
 10162ef:	mov    rdx,rcx
 10162f2:	sub    rdx,QWORD PTR [rax]
 10162f5:	vmovups XMMWORD PTR [rcx],xmm0
 10162f9:	lea    rcx,[rip+0x28978]        # 103ec78 <lyr_gc_heap_span>
 1016300:	cmp    rdx,QWORD PTR [rcx]
 1016303:	jae    10163a3 <lyr_w2_b_run+0xa73>
 1016309:	mov    rsi,rdx
 101630c:	shr    rsi,0x8
 1016310:	add    rdx,0xf
 1016314:	shr    rdx,0x8
 1016318:	mov    r8,rdx
 101631b:	sub    r8,rsi
 101631e:	jb     10163a3 <lyr_w2_b_run+0xa73>
 1016324:	inc    rdx
 1016327:	mov    r9d,edx
 101632a:	sub    r9d,esi
 101632d:	and    r9d,0x3
 1016331:	je     1016357 <lyr_w2_b_run+0xa27>
 1016333:	neg    r9
 1016336:	cs nop WORD PTR [rax+rax*1+0x0]
 1016340:	lea    r10,[rip+0x28911]        # 103ec58 <lyr_gc_cards>
 1016347:	mov    r10,QWORD PTR [r10]
 101634a:	mov    BYTE PTR [r10+rsi*1],0x1
 101634f:	inc    rsi
 1016352:	inc    r9
 1016355:	jne    1016340 <lyr_w2_b_run+0xa10>
 1016357:	cmp    r8,0x3
 101635b:	mov    r10,QWORD PTR [rbp-0x30]
 101635f:	jb     10163a3 <lyr_w2_b_run+0xa73>
 1016361:	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 1016370:	lea    r8,[rip+0x288e1]        # 103ec58 <lyr_gc_cards>
 1016377:	mov    r9,QWORD PTR [r8]
 101637a:	mov    BYTE PTR [r9+rsi*1],0x1
 101637f:	mov    r9,QWORD PTR [r8]
 1016382:	mov    BYTE PTR [r9+rsi*1+0x1],0x1
 1016388:	mov    r9,QWORD PTR [r8]
 101638b:	mov    BYTE PTR [r9+rsi*1+0x2],0x1
 1016391:	mov    r8,QWORD PTR [r8]
 1016394:	mov    BYTE PTR [r8+rsi*1+0x3],0x1
 101639a:	add    rsi,0x4
 101639e:	cmp    rdx,rsi
 10163a1:	jne    1016370 <lyr_w2_b_run+0xa40>
 10163a3:	mov    r8,QWORD PTR [rbp-0x38]
 10163a7:	mov    rsi,QWORD PTR [r8+0x8]
 10163ab:	cmp    rsi,rdi
 10163ae:	jbe    1016823 <lyr_w2_b_run+0xef3>
 10163b4:	lea    rsi,[rdi+rdi*2]
 10163b8:	mov    r9,QWORD PTR [rbp-0x48]
 10163bc:	lea    rdx,[r9+rsi*8]
 10163c0:	mov    rdi,QWORD PTR [rbp-0x60]
 10163c4:	mov    QWORD PTR [r9+rsi*8+0x10],rdi
 10163c9:	vmovaps xmm0,XMMWORD PTR [rbp-0x70]
 10163ce:	vmovups XMMWORD PTR [r9+rsi*8],xmm0
 10163d4:	sub    rdx,QWORD PTR [rax]
 10163d7:	cmp    rdx,QWORD PTR [rcx]
 10163da:	jae    10159d0 <lyr_w2_b_run+0xa0>
 10163e0:	mov    rax,rdx
 10163e3:	shr    rax,0x8
 10163e7:	add    rdx,0x17
 10163eb:	shr    rdx,0x8
 10163ef:	mov    rcx,rdx
 10163f2:	sub    rcx,rax
 10163f5:	jb     10159d0 <lyr_w2_b_run+0xa0>
 10163fb:	inc    rdx
 10163fe:	mov    esi,edx
 1016400:	sub    esi,eax
 1016402:	and    esi,0x3
 1016405:	je     1016426 <lyr_w2_b_run+0xaf6>
 1016407:	neg    rsi
 101640a:	nop    WORD PTR [rax+rax*1+0x0]
 1016410:	lea    rdi,[rip+0x28841]        # 103ec58 <lyr_gc_cards>
 1016417:	mov    rdi,QWORD PTR [rdi]
 101641a:	mov    BYTE PTR [rdi+rax*1],0x1
 101641e:	inc    rax
 1016421:	inc    rsi
 1016424:	jne    1016410 <lyr_w2_b_run+0xae0>
 1016426:	cmp    rcx,0x3
 101642a:	jb     10159d0 <lyr_w2_b_run+0xa0>
 1016430:	lea    rcx,[rip+0x28821]        # 103ec58 <lyr_gc_cards>
 1016437:	mov    rsi,QWORD PTR [rcx]
 101643a:	mov    BYTE PTR [rsi+rax*1],0x1
 101643e:	mov    rsi,QWORD PTR [rcx]
 1016441:	mov    BYTE PTR [rsi+rax*1+0x1],0x1
 1016446:	mov    rsi,QWORD PTR [rcx]
 1016449:	mov    BYTE PTR [rsi+rax*1+0x2],0x1
 101644e:	mov    rcx,QWORD PTR [rcx]
 1016451:	mov    BYTE PTR [rcx+rax*1+0x3],0x1
 1016456:	add    rax,0x4
 101645a:	cmp    rdx,rax
 101645d:	jne    1016430 <lyr_w2_b_run+0xb00>
 101645f:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1016464:	mov    rsi,QWORD PTR [r8+0x8]
 1016468:	cmp    rsi,rcx
 101646b:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1016471:	cmp    rsi,rax
 1016474:	jbe    1016830 <lyr_w2_b_run+0xf00>
 101647a:	lea    rcx,[rcx+rcx*2]
 101647e:	mov    rcx,QWORD PTR [r9+rcx*8]
 1016482:	lea    rax,[rax+rax*2]
 1016486:	mov    rax,QWORD PTR [r9+rax*8]
 101648a:	cmp    rcx,rax
 101648d:	jb     10160c8 <lyr_w2_b_run+0x798>
 1016493:	jmp    10160c5 <lyr_w2_b_run+0x795>
 1016498:	mov    rsi,QWORD PTR [r8+0x8]
 101649c:	cmp    rsi,rdi
 101649f:	jbe    1016823 <lyr_w2_b_run+0xef3>
 10164a5:	cmp    rsi,rcx
 10164a8:	jbe    1016828 <lyr_w2_b_run+0xef8>
 10164ae:	cmp    rsi,rax
 10164b1:	jbe    1016830 <lyr_w2_b_run+0xf00>
 10164b7:	lea    rax,[rax+rax*2]
 10164bb:	mov    rsi,QWORD PTR [r9+rax*8]
 10164bf:	test   rsi,rsi
 10164c2:	je     101684b <lyr_w2_b_run+0xf1b>
 10164c8:	lea    rax,[rcx+rcx*2]
 10164cc:	mov    rax,QWORD PTR [r9+rax*8]
 10164d0:	mov    rcx,rax
 10164d3:	or     rcx,rsi
 10164d6:	shr    rcx,0x20
 10164da:	je     101678c <lyr_w2_b_run+0xe5c>
 10164e0:	xor    edx,edx
 10164e2:	div    rsi
 10164e5:	jmp    1016790 <lyr_w2_b_run+0xe60>
 10164ea:	mov    rsi,QWORD PTR [r8+0x8]
 10164ee:	cmp    rsi,rcx
 10164f1:	jbe    1016828 <lyr_w2_b_run+0xef8>
 10164f7:	cmp    rsi,rax
 10164fa:	jbe    1016830 <lyr_w2_b_run+0xf00>
 1016500:	lea    rcx,[rcx+rcx*2]
 1016504:	mov    rcx,QWORD PTR [r9+rcx*8]
 1016508:	lea    rax,[rax+rax*2]
 101650c:	cmp    rcx,QWORD PTR [r9+rax*8]
 1016510:	jne    1015f2b <lyr_w2_b_run+0x5fb>
 1016516:	jmp    1016031 <lyr_w2_b_run+0x701>
 101651b:	mov    rsi,QWORD PTR [r8+0x8]
 101651f:	cmp    rsi,rdi
 1016522:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1016528:	cmp    rsi,rcx
 101652b:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1016531:	lea    rax,[rdi+rdi*2]
 1016535:	lea    rcx,[rcx+rcx*2]
 1016539:	mov    rcx,QWORD PTR [r9+rcx*8]
 101653d:	not    rcx
 1016540:	mov    QWORD PTR [r9+rax*8],rcx
 1016544:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1016549:	mov    rsi,QWORD PTR [r8+0x8]
 101654d:	cmp    rsi,rdi
 1016550:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1016556:	cmp    rsi,rcx
 1016559:	jbe    1016838 <lyr_w2_b_run+0xf08>
 101655f:	lea    rax,[rdi+rdi*2]
 1016563:	mov    QWORD PTR [rbp-0x80],rax
 1016567:	lea    rax,[rcx+rcx*2]
 101656b:	mov    rdi,QWORD PTR [r9+rax*8+0x8]
 1016570:	mov    rsi,QWORD PTR [r9+rax*8+0x10]
 1016575:	call   QWORD PTR [rsi+0x8]
 1016578:	mov    r9,QWORD PTR [rbp-0x48]
 101657c:	mov    rcx,QWORD PTR [rbp-0x80]
 1016580:	mov    QWORD PTR [r9+rcx*8],rax
 1016584:	inc    rbx
 1016587:	jo     1016802 <lyr_w2_b_run+0xed2>
 101658d:	mov    r11,QWORD PTR [rbp-0x40]
 1016591:	mov    r10,QWORD PTR [rbp-0x30]
 1016595:	mov    r8,QWORD PTR [rbp-0x38]
 1016599:	jmp    10159d9 <lyr_w2_b_run+0xa9>
 101659e:	mov    rsi,QWORD PTR [r8+0x8]
 10165a2:	cmp    rsi,rcx
 10165a5:	jbe    1016828 <lyr_w2_b_run+0xef8>
 10165ab:	cmp    rsi,rax
 10165ae:	jbe    1016830 <lyr_w2_b_run+0xf00>
 10165b4:	lea    rcx,[rcx+rcx*2]
 10165b8:	mov    rcx,QWORD PTR [r9+rcx*8]
 10165bc:	lea    rax,[rax+rax*2]
 10165c0:	cmp    rcx,QWORD PTR [r9+rax*8]
 10165c4:	jae    1015f2b <lyr_w2_b_run+0x5fb>
 10165ca:	jmp    1016031 <lyr_w2_b_run+0x701>
 10165cf:	mov    rsi,QWORD PTR [r8+0x8]
 10165d3:	cmp    rsi,rcx
 10165d6:	jbe    1016828 <lyr_w2_b_run+0xef8>
 10165dc:	cmp    rsi,rax
 10165df:	jbe    1016830 <lyr_w2_b_run+0xf00>
 10165e5:	lea    rcx,[rcx+rcx*2]
 10165e9:	mov    rcx,QWORD PTR [r9+rcx*8]
 10165ed:	lea    rax,[rax+rax*2]
 10165f1:	cmp    rcx,QWORD PTR [r9+rax*8]
 10165f5:	ja     1015f2b <lyr_w2_b_run+0x5fb>
 10165fb:	jmp    1016031 <lyr_w2_b_run+0x701>
 1016600:	mov    rsi,QWORD PTR [r8+0x8]
 1016604:	cmp    rsi,rdi
 1016607:	jbe    1016823 <lyr_w2_b_run+0xef3>
 101660d:	lea    rcx,[rdi+rdi*2]
 1016611:	cmp    QWORD PTR [r9+rcx*8],0x0
 1016616:	je     10159d0 <lyr_w2_b_run+0xa0>
 101661c:	mov    rbx,rax
 101661f:	jmp    10159d9 <lyr_w2_b_run+0xa9>
 1016624:	mov    rdi,QWORD PTR [rbp-0x50]
 1016628:	dec    rdi
 101662b:	jo     1016850 <lyr_w2_b_run+0xf20>
 1016631:	mov    rsi,QWORD PTR [r15+0x8]
 1016635:	cmp    rdi,rsi
 1016638:	jae    1016823 <lyr_w2_b_run+0xef3>
 101663e:	mov    QWORD PTR [rbp-0x50],rdi
 1016642:	mov    rbx,QWORD PTR [r15+rdi*8+0x10]
 1016647:	jmp    10159d9 <lyr_w2_b_run+0xa9>
 101664c:	mov    rsi,QWORD PTR [r8+0x8]
 1016650:	cmp    rsi,rcx
 1016653:	jbe    1016828 <lyr_w2_b_run+0xef8>
 1016659:	lea    ecx,[rcx*8+0x0]
 1016660:	lea    rcx,[rcx+rcx*2]
 1016664:	mov    rdx,QWORD PTR [r9+rcx*1+0x10]
 1016669:	mov    rdx,QWORD PTR [rdx]
 101666c:	cmp    rdx,0x1038c40
 1016673:	jne    1016872 <lyr_w2_b_run+0xf42>
 1016679:	mov    rcx,QWORD PTR [r9+rcx*1+0x8]
 101667e:	mov    rdx,QWORD PTR [rcx+0x8]
 1016682:	mov    rcx,QWORD PTR [rdx+0x8]
 1016686:	cmp    rcx,rax
 1016689:	jbe    1016840 <lyr_w2_b_run+0xf10>
 101668f:	cmp    rsi,rdi
 1016692:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1016698:	lea    rcx,[rax+rax*2]
 101669c:	lea    rsi,[rdi+rdi*2]
 10166a0:	lea    rax,[r9+rsi*8]
 10166a4:	vmovups xmm0,XMMWORD PTR [rdx+rcx*8+0x10]
 10166aa:	mov    rcx,QWORD PTR [rdx+rcx*8+0x20]
 10166af:	mov    QWORD PTR [r9+rsi*8+0x10],rcx
 10166b4:	vmovups XMMWORD PTR [r9+rsi*8],xmm0
 10166ba:	lea    rcx,[rip+0x285af]        # 103ec70 <lyr_gc_heap_base>
 10166c1:	sub    rax,QWORD PTR [rcx]
 10166c4:	lea    rcx,[rip+0x285ad]        # 103ec78 <lyr_gc_heap_span>
 10166cb:	cmp    rax,QWORD PTR [rcx]
 10166ce:	jae    10159d0 <lyr_w2_b_run+0xa0>
 10166d4:	mov    rcx,rax
 10166d7:	shr    rcx,0x8
 10166db:	add    rax,0x17
 10166df:	shr    rax,0x8
 10166e3:	mov    rdx,rax
 10166e6:	sub    rdx,rcx
 10166e9:	jb     10159d0 <lyr_w2_b_run+0xa0>
 10166ef:	inc    rax
 10166f2:	mov    esi,eax
 10166f4:	sub    esi,ecx
 10166f6:	and    esi,0x3
 10166f9:	je     1016716 <lyr_w2_b_run+0xde6>
 10166fb:	neg    rsi
 10166fe:	xchg   ax,ax
 1016700:	lea    rdi,[rip+0x28551]        # 103ec58 <lyr_gc_cards>
 1016707:	mov    rdi,QWORD PTR [rdi]
 101670a:	mov    BYTE PTR [rdi+rcx*1],0x1
 101670e:	inc    rcx
 1016711:	inc    rsi
 1016714:	jne    1016700 <lyr_w2_b_run+0xdd0>
 1016716:	cmp    rdx,0x3
 101671a:	jb     10159d0 <lyr_w2_b_run+0xa0>
 1016720:	lea    rdx,[rip+0x28531]        # 103ec58 <lyr_gc_cards>
 1016727:	mov    rsi,QWORD PTR [rdx]
 101672a:	mov    BYTE PTR [rsi+rcx*1],0x1
 101672e:	mov    rsi,QWORD PTR [rdx]
 1016731:	mov    BYTE PTR [rsi+rcx*1+0x1],0x1
 1016736:	mov    rsi,QWORD PTR [rdx]
 1016739:	mov    BYTE PTR [rsi+rcx*1+0x2],0x1
 101673e:	mov    rdx,QWORD PTR [rdx]
 1016741:	mov    BYTE PTR [rdx+rcx*1+0x3],0x1
 1016746:	add    rcx,0x4
 101674a:	cmp    rax,rcx
 101674d:	jne    1016720 <lyr_w2_b_run+0xdf0>
 101674f:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 1016754:	mov    eax,0x1
 1016759:	cmp    rsi,rdi
 101675c:	jbe    1016823 <lyr_w2_b_run+0xef3>
 1016762:	lea    rcx,[rdi+rdi*2]
 1016766:	mov    QWORD PTR [r9+rcx*8],rax
 101676a:	inc    rbx
 101676d:	jno    10159d9 <lyr_w2_b_run+0xa9>
 1016773:	jmp    1016802 <lyr_w2_b_run+0xed2>
 1016778:	xor    edx,edx
 101677a:	div    esi
 101677c:	lea    rcx,[rdi+rdi*2]
 1016780:	lea    rcx,[r9+rcx*8]
 1016784:	mov    QWORD PTR [rcx],rax
 1016787:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 101678c:	xor    edx,edx
 101678e:	div    esi
 1016790:	lea    rax,[rdi+rdi*2]
 1016794:	lea    rax,[r9+rax*8]
 1016798:	mov    QWORD PTR [rax],rdx
 101679b:	jmp    10159d0 <lyr_w2_b_run+0xa0>
 10167a0:	lea    rax,[rip+0x28491]        # 103ec38 <lyr_gc_stop_requested>
 10167a7:	mov    eax,DWORD PTR [rax]
 10167a9:	mov    r12d,0x400
 10167af:	test   eax,eax
 10167b1:	je     10159eb <lyr_w2_b_run+0xbb>
 10167b7:	call   101b8b0 <lyr_gc_safepoint_slow>
 10167bc:	mov    r9,QWORD PTR [rbp-0x48]
 10167c0:	mov    r8,QWORD PTR [rbp-0x38]
 10167c4:	mov    r10,QWORD PTR [rbp-0x30]
 10167c8:	mov    r11,QWORD PTR [rbp-0x40]
 10167cc:	jmp    10159eb <lyr_w2_b_run+0xbb>
 10167d1:	lea    rax,[rip+0x28460]        # 103ec38 <lyr_gc_stop_requested>
 10167d8:	mov    eax,DWORD PTR [rax]
 10167da:	mov    r12d,0x400
 10167e0:	test   eax,eax
 10167e2:	je     10159e2 <lyr_w2_b_run+0xb2>
 10167e8:	call   101b8b0 <lyr_gc_safepoint_slow>
 10167ed:	mov    r9,QWORD PTR [rbp-0x48]
 10167f1:	mov    r8,QWORD PTR [rbp-0x38]
 10167f5:	mov    r10,QWORD PTR [rbp-0x30]
 10167f9:	mov    r11,QWORD PTR [rbp-0x40]
 10167fd:	jmp    10159e2 <lyr_w2_b_run+0xb2>
 1016802:	lea    rdi,[rip+0xfffffffffffec2de]        # 1002ae7 <lyr_refmap_ty_w2_b_ScriptObject+0x10ef>
 1016809:	call   1021709 <lyr_panic_overflow>
 101680e:	mov    rax,r14
 1016811:	add    rsp,0x58
 1016815:	pop    rbx
 1016816:	pop    r12
 1016818:	pop    r13
 101681a:	pop    r14
 101681c:	pop    r15
 101681e:	pop    rbp
 101681f:	ret
 1016820:	mov    rdi,rbx
 1016823:	call   10216c8 <lyr_panic_index>
 1016828:	mov    rdi,rcx
 101682b:	call   10216c8 <lyr_panic_index>
 1016830:	mov    rdi,rax
 1016833:	call   10216c8 <lyr_panic_index>
 1016838:	mov    rdi,rcx
 101683b:	call   10216c8 <lyr_panic_index>
 1016840:	mov    rdi,rax
 1016843:	mov    rsi,rcx
 1016846:	call   10216c8 <lyr_panic_index>
 101684b:	call   1021725 <lyr_panic_division_by_zero>
 1016850:	lea    rdi,[rip+0xfffffffffffec28e]        # 1002ae5 <lyr_refmap_ty_w2_b_ScriptObject+0x10ed>
 1016857:	call   1021709 <lyr_panic_overflow>
 101685c:	call   101b920 <lyr_gc_stack_slow>
 1016861:	mov    r8,QWORD PTR [rbp-0x38]
 1016865:	mov    r10,QWORD PTR [rbp-0x30]
 1016869:	mov    r11,QWORD PTR [rbp-0x40]
 101686d:	jmp    101597b <lyr_w2_b_run+0x4b>
 1016872:	lea    rdi,[rip+0x22857]        # 10390d0 <lyr_lit0>
 1016879:	call   102175b <lyr_panic_message>
 101687e:	ud2
 1016880:	lea    rdi,[rip+0x22869]        # 10390f0 <lyr_lit1>
 1016887:	call   102175b <lyr_panic_message>
 101688c:	ud2

