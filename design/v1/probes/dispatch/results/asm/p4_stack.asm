00000000010156a0 <lyr_p4_stack_run>:
 10156a0:	push   rbp
 10156a1:	mov    rbp,rsp
 10156a4:	push   r15
 10156a6:	push   r14
 10156a8:	push   r13
 10156aa:	push   r12
 10156ac:	push   rbx
 10156ad:	sub    rsp,0x38
 10156b1:	mov    QWORD PTR [rbp-0x30],rcx
 10156b5:	mov    QWORD PTR [rbp-0x60],rdx
 10156b9:	mov    r15,rdi
 10156bc:	mov    rdi,rbp
 10156bf:	add    rdi,0xffffffffffff92c0
 10156c6:	mov    rax,0xffffffffffffffe0
 10156cd:	mov    rax,QWORD PTR fs:[rax+0x10]
 10156d2:	cmp    rdi,rax
 10156d5:	jb     101618f <lyr_p4_stack_run+0xaef>
 10156db:	lea    rbx,[r9+0x10]
 10156df:	mov    r13d,0x400
 10156e5:	xor    r12d,r12d
 10156e8:	xor    edi,edi
 10156ea:	mov    QWORD PTR [rbp-0x38],0x0
 10156f2:	xor    r14d,r14d
 10156f5:	jmp    1015722 <lyr_p4_stack_run+0x82>
 10156f7:	mov    rax,QWORD PTR [rbp-0x60]
 10156fb:	mov    rax,QWORD PTR [rax+rdx*8+0x10]
 1015700:	mov    QWORD PTR [rbx+rdi*8],rax
 1015704:	inc    rdi
 1015707:	jo     101610b <lyr_p4_stack_run+0xa6b>
 101570d:	nop    DWORD PTR [rax]
 1015710:	inc    r14
 1015713:	jo     101610b <lyr_p4_stack_run+0xa6b>
 1015719:	dec    r13d
 101571c:	je     10160ca <lyr_p4_stack_run+0xa2a>
 1015722:	dec    r13d
 1015725:	je     1016089 <lyr_p4_stack_run+0x9e9>
 101572b:	mov    rax,QWORD PTR [r15+0x8]
 101572f:	cmp    r14,rax
 1015732:	jae    1016135 <lyr_p4_stack_run+0xa95>
 1015738:	inc    r12
 101573b:	jo     101610b <lyr_p4_stack_run+0xa6b>
 1015741:	movzx  r10d,BYTE PTR [r15+r14*8+0x10]
 1015747:	cmp    r10,0x2f
 101574b:	ja     10161ab <lyr_p4_stack_run+0xb0b>
 1015751:	movzx  eax,WORD PTR [r15+r14*8+0x12]
 1015757:	movzx  edx,WORD PTR [r15+r14*8+0x14]
 101575d:	movzx  ecx,WORD PTR [r15+r14*8+0x16]
 1015763:	lea    r11,[rip+0xfffffffffffec076]        # 10017e0 <__abi_tag+0x14e4>
 101576a:	movsxd r10,DWORD PTR [r11+r10*4]
 101576e:	add    r10,r11
 1015771:	jmp    r10
 1015774:	mov    rcx,QWORD PTR [rsi+0x8]
 1015778:	cmp    rcx,rax
 101577b:	jbe    1016140 <lyr_p4_stack_run+0xaa0>
 1015781:	mov    rcx,QWORD PTR [r9+0x8]
 1015785:	cmp    rdi,rcx
 1015788:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 101578e:	mov    rax,QWORD PTR [rsi+rax*8+0x10]
 1015793:	jmp    1015700 <lyr_p4_stack_run+0x60>
 1015798:	mov    rcx,QWORD PTR [rsi+0x8]
 101579c:	cmp    rcx,rax
 101579f:	jbe    1016140 <lyr_p4_stack_run+0xaa0>
 10157a5:	dec    QWORD PTR [rsi+rax*8+0x10]
 10157aa:	jmp    1015710 <lyr_p4_stack_run+0x70>
 10157af:	mov    rax,rdi
 10157b2:	dec    rax
 10157b5:	jo     1016129 <lyr_p4_stack_run+0xa89>
 10157bb:	mov    rcx,QWORD PTR [r9+0x8]
 10157bf:	cmp    rax,rcx
 10157c2:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 10157c8:	not    QWORD PTR [rbx+rax*8]
 10157cc:	jmp    1015710 <lyr_p4_stack_run+0x70>
 10157d1:	dec    rdi
 10157d4:	jo     1016129 <lyr_p4_stack_run+0xa89>
 10157da:	mov    rax,QWORD PTR [r9+0x8]
 10157de:	cmp    rdi,rax
 10157e1:	jae    101614b <lyr_p4_stack_run+0xaab>
 10157e7:	mov    rcx,rdi
 10157ea:	dec    rcx
 10157ed:	jo     1016129 <lyr_p4_stack_run+0xa89>
 10157f3:	cmp    rcx,rax
 10157f6:	jae    101615e <lyr_p4_stack_run+0xabe>
 10157fc:	mov    rax,QWORD PTR [rbx+rdi*8]
 1015800:	cmp    rax,QWORD PTR [rbx+rcx*8]
 1015804:	jbe    1015710 <lyr_p4_stack_run+0x70>
 101580a:	jmp    1016064 <lyr_p4_stack_run+0x9c4>
 101580f:	dec    rdi
 1015812:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015818:	mov    rax,rdi
 101581b:	dec    rax
 101581e:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015824:	mov    rcx,QWORD PTR [r9+0x8]
 1015828:	cmp    rax,rcx
 101582b:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015831:	cmp    rdi,rcx
 1015834:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 101583a:	mov    rcx,QWORD PTR [rbx+rdi*8]
 101583e:	or     QWORD PTR [rbx+rax*8],rcx
 1015842:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015847:	dec    rdi
 101584a:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015850:	mov    rax,QWORD PTR [r9+0x8]
 1015854:	cmp    rdi,rax
 1015857:	jae    101614b <lyr_p4_stack_run+0xaab>
 101585d:	cmp    QWORD PTR [rbx+rdi*8],0x0
 1015862:	jne    1015e63 <lyr_p4_stack_run+0x7c3>
 1015868:	jmp    1015710 <lyr_p4_stack_run+0x70>
 101586d:	dec    rdi
 1015870:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015876:	mov    rax,rdi
 1015879:	dec    rax
 101587c:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015882:	mov    rcx,QWORD PTR [r9+0x8]
 1015886:	cmp    rax,rcx
 1015889:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 101588f:	cmp    rdi,rcx
 1015892:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015898:	mov    rcx,QWORD PTR [rbx+rax*8]
 101589c:	xor    edx,edx
 101589e:	cmp    rcx,QWORD PTR [rbx+rdi*8]
 10158a2:	setae  dl
 10158a5:	mov    QWORD PTR [rbx+rax*8],rdx
 10158a9:	jmp    1015710 <lyr_p4_stack_run+0x70>
 10158ae:	mov    rax,rdi
 10158b1:	dec    rax
 10158b4:	jo     1016129 <lyr_p4_stack_run+0xa89>
 10158ba:	mov    rcx,QWORD PTR [r9+0x8]
 10158be:	cmp    rax,rcx
 10158c1:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 10158c7:	cmp    rdi,rcx
 10158ca:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 10158d0:	mov    rax,QWORD PTR [rbx+rax*8]
 10158d4:	jmp    1015700 <lyr_p4_stack_run+0x60>
 10158d9:	mov    rax,rdi
 10158dc:	dec    rax
 10158df:	jo     1016129 <lyr_p4_stack_run+0xa89>
 10158e5:	mov    rdx,QWORD PTR [r9+0x8]
 10158e9:	cmp    rax,rdx
 10158ec:	jae    1016153 <lyr_p4_stack_run+0xab3>
 10158f2:	mov    rdx,QWORD PTR [rbx+rax*8]
 10158f6:	add    rdx,rcx
 10158f9:	mov    rcx,QWORD PTR [rbp-0x30]
 10158fd:	mov    rcx,QWORD PTR [rcx+0x8]
 1015901:	cmp    rdx,rcx
 1015904:	jae    1016179 <lyr_p4_stack_run+0xad9>
 101590a:	mov    rcx,QWORD PTR [rbp-0x30]
 101590e:	mov    rcx,QWORD PTR [rcx+rdx*8+0x10]
 1015913:	mov    QWORD PTR [rbx+rax*8],rcx
 1015917:	jmp    1015710 <lyr_p4_stack_run+0x70>
 101591c:	mov    rax,rdi
 101591f:	dec    rax
 1015922:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015928:	mov    rdx,QWORD PTR [r9+0x8]
 101592c:	cmp    rax,rdx
 101592f:	jae    1016153 <lyr_p4_stack_run+0xab3>
 1015935:	mov    rdx,QWORD PTR [rbx+rax*8]
 1015939:	imul   rdx,rcx
 101593d:	mov    QWORD PTR [rbx+rax*8],rdx
 1015941:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015946:	dec    rdi
 1015949:	jo     1016129 <lyr_p4_stack_run+0xa89>
 101594f:	mov    rax,rdi
 1015952:	dec    rax
 1015955:	jo     1016129 <lyr_p4_stack_run+0xa89>
 101595b:	mov    rcx,QWORD PTR [r9+0x8]
 101595f:	cmp    rax,rcx
 1015962:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015968:	cmp    rdi,rcx
 101596b:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015971:	movzx  ecx,BYTE PTR [rbx+rdi*8]
 1015975:	shr    QWORD PTR [rbx+rax*8],cl
 1015979:	jmp    1015710 <lyr_p4_stack_run+0x70>
 101597e:	dec    rdi
 1015981:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015987:	mov    rax,rdi
 101598a:	dec    rax
 101598d:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015993:	mov    rcx,QWORD PTR [r9+0x8]
 1015997:	cmp    rax,rcx
 101599a:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 10159a0:	cmp    rdi,rcx
 10159a3:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 10159a9:	mov    rcx,QWORD PTR [rbx+rdi*8]
 10159ad:	sub    QWORD PTR [rbx+rax*8],rcx
 10159b1:	jmp    1015710 <lyr_p4_stack_run+0x70>
 10159b6:	mov    rax,rdi
 10159b9:	dec    rax
 10159bc:	jo     1016129 <lyr_p4_stack_run+0xa89>
 10159c2:	mov    rdx,QWORD PTR [r9+0x8]
 10159c6:	cmp    rax,rdx
 10159c9:	jae    1016153 <lyr_p4_stack_run+0xab3>
 10159cf:	add    QWORD PTR [rbx+rax*8],rcx
 10159d3:	jmp    1015710 <lyr_p4_stack_run+0x70>
 10159d8:	dec    rdi
 10159db:	jo     1016129 <lyr_p4_stack_run+0xa89>
 10159e1:	mov    rcx,QWORD PTR [r9+0x8]
 10159e5:	cmp    rdi,rcx
 10159e8:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 10159ee:	mov    rcx,QWORD PTR [rsi+0x8]
 10159f2:	cmp    rcx,rax
 10159f5:	jbe    1016140 <lyr_p4_stack_run+0xaa0>
 10159fb:	mov    rcx,QWORD PTR [rbx+rdi*8]
 10159ff:	mov    QWORD PTR [rsi+rax*8+0x10],rcx
 1015a04:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015a09:	mov    rax,rdi
 1015a0c:	dec    rax
 1015a0f:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015a15:	mov    rdx,QWORD PTR [r9+0x8]
 1015a19:	cmp    rax,rdx
 1015a1c:	jae    1016153 <lyr_p4_stack_run+0xab3>
 1015a22:	sub    QWORD PTR [rbx+rax*8],rcx
 1015a26:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015a2b:	mov    rax,rdi
 1015a2e:	dec    rax
 1015a31:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015a37:	mov    rdx,QWORD PTR [r9+0x8]
 1015a3b:	cmp    rax,rdx
 1015a3e:	jae    1016153 <lyr_p4_stack_run+0xab3>
 1015a44:	shl    QWORD PTR [rbx+rax*8],cl
 1015a48:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015a4d:	dec    rdi
 1015a50:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015a56:	mov    rcx,rdi
 1015a59:	dec    rcx
 1015a5c:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015a62:	mov    rax,QWORD PTR [r9+0x8]
 1015a66:	cmp    rcx,rax
 1015a69:	jae    101615e <lyr_p4_stack_run+0xabe>
 1015a6f:	cmp    rdi,rax
 1015a72:	jae    101614b <lyr_p4_stack_run+0xaab>
 1015a78:	mov    r10,QWORD PTR [rbx+rdi*8]
 1015a7c:	test   r10,r10
 1015a7f:	je     1016174 <lyr_p4_stack_run+0xad4>
 1015a85:	mov    rax,QWORD PTR [rbx+rcx*8]
 1015a89:	mov    rdx,rax
 1015a8c:	or     rdx,r10
 1015a8f:	shr    rdx,0x20
 1015a93:	je     101606d <lyr_p4_stack_run+0x9cd>
 1015a99:	xor    edx,edx
 1015a9b:	div    r10
 1015a9e:	mov    QWORD PTR [rbx+rcx*8],rdx
 1015aa2:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015aa7:	dec    rdi
 1015aaa:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015ab0:	mov    rax,rdi
 1015ab3:	dec    rax
 1015ab6:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015abc:	mov    rcx,QWORD PTR [r9+0x8]
 1015ac0:	cmp    rax,rcx
 1015ac3:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015ac9:	cmp    rdi,rcx
 1015acc:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015ad2:	mov    rcx,QWORD PTR [rbx+rdi*8]
 1015ad6:	add    QWORD PTR [rbx+rax*8],rcx
 1015ada:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015adf:	dec    rdi
 1015ae2:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015ae8:	mov    rax,rdi
 1015aeb:	dec    rax
 1015aee:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015af4:	mov    rcx,QWORD PTR [r9+0x8]
 1015af8:	cmp    rax,rcx
 1015afb:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015b01:	cmp    rdi,rcx
 1015b04:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015b0a:	mov    rcx,QWORD PTR [rbx+rax*8]
 1015b0e:	xor    edx,edx
 1015b10:	cmp    rcx,QWORD PTR [rbx+rdi*8]
 1015b14:	setbe  dl
 1015b17:	mov    QWORD PTR [rbx+rax*8],rdx
 1015b1b:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015b20:	dec    rdi
 1015b23:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015b29:	mov    rax,rdi
 1015b2c:	dec    rax
 1015b2f:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015b35:	mov    rcx,QWORD PTR [r9+0x8]
 1015b39:	cmp    rax,rcx
 1015b3c:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015b42:	cmp    rdi,rcx
 1015b45:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015b4b:	mov    rcx,QWORD PTR [rbx+rdi*8]
 1015b4f:	and    QWORD PTR [rbx+rax*8],rcx
 1015b53:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015b58:	dec    rdi
 1015b5b:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015b61:	mov    rax,QWORD PTR [r9+0x8]
 1015b65:	cmp    rdi,rax
 1015b68:	jae    101614b <lyr_p4_stack_run+0xaab>
 1015b6e:	cmp    QWORD PTR [rbx+rdi*8],0x0
 1015b73:	jne    1015710 <lyr_p4_stack_run+0x70>
 1015b79:	jmp    1015e63 <lyr_p4_stack_run+0x7c3>
 1015b7e:	dec    rdi
 1015b81:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015b87:	mov    rax,rdi
 1015b8a:	dec    rax
 1015b8d:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015b93:	mov    rcx,QWORD PTR [r9+0x8]
 1015b97:	cmp    rax,rcx
 1015b9a:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015ba0:	cmp    rdi,rcx
 1015ba3:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015ba9:	mov    rcx,QWORD PTR [rbx+rax*8]
 1015bad:	xor    edx,edx
 1015baf:	cmp    rcx,QWORD PTR [rbx+rdi*8]
 1015bb3:	setne  dl
 1015bb6:	mov    QWORD PTR [rbx+rax*8],rdx
 1015bba:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015bbf:	mov    rax,rdi
 1015bc2:	dec    rax
 1015bc5:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015bcb:	mov    rdx,QWORD PTR [r9+0x8]
 1015bcf:	cmp    rax,rdx
 1015bd2:	jae    1016153 <lyr_p4_stack_run+0xab3>
 1015bd8:	or     QWORD PTR [rbx+rax*8],rcx
 1015bdc:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015be1:	mov    rax,QWORD PTR [rbp-0x60]
 1015be5:	mov    rax,QWORD PTR [rax+0x8]
 1015be9:	cmp    rax,rdx
 1015bec:	jbe    1016169 <lyr_p4_stack_run+0xac9>
 1015bf2:	mov    rax,QWORD PTR [r9+0x8]
 1015bf6:	cmp    rdi,rax
 1015bf9:	jb     10156f7 <lyr_p4_stack_run+0x57>
 1015bff:	jmp    101614b <lyr_p4_stack_run+0xaab>
 1015c04:	mov    rcx,QWORD PTR [rsi+0x8]
 1015c08:	cmp    rcx,rax
 1015c0b:	jbe    1016140 <lyr_p4_stack_run+0xaa0>
 1015c11:	inc    QWORD PTR [rsi+rax*8+0x10]
 1015c16:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015c1b:	inc    r14
 1015c1e:	jo     101610b <lyr_p4_stack_run+0xa6b>
 1015c24:	mov    rax,QWORD PTR [r8+0x8]
 1015c28:	mov    rdx,QWORD PTR [rbp-0x38]
 1015c2c:	cmp    rdx,rax
 1015c2f:	jae    1016169 <lyr_p4_stack_run+0xac9>
 1015c35:	mov    QWORD PTR [r8+rdx*8+0x10],r14
 1015c3a:	inc    rdx
 1015c3d:	jo     101610b <lyr_p4_stack_run+0xa6b>
 1015c43:	mov    QWORD PTR [rbp-0x38],rdx
 1015c47:	mov    r14,rcx
 1015c4a:	jmp    1015719 <lyr_p4_stack_run+0x79>
 1015c4f:	dec    rdi
 1015c52:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015c58:	mov    rax,rdi
 1015c5b:	dec    rax
 1015c5e:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015c64:	mov    rcx,QWORD PTR [r9+0x8]
 1015c68:	cmp    rax,rcx
 1015c6b:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015c71:	cmp    rdi,rcx
 1015c74:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015c7a:	mov    rcx,QWORD PTR [rbx+rdi*8]
 1015c7e:	imul   rcx,QWORD PTR [rbx+rax*8]
 1015c83:	mov    QWORD PTR [rbx+rax*8],rcx
 1015c87:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015c8c:	dec    rdi
 1015c8f:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015c95:	mov    rax,rdi
 1015c98:	dec    rax
 1015c9b:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015ca1:	mov    rcx,QWORD PTR [r9+0x8]
 1015ca5:	cmp    rax,rcx
 1015ca8:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015cae:	cmp    rdi,rcx
 1015cb1:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015cb7:	movzx  ecx,BYTE PTR [rbx+rdi*8]
 1015cbb:	shl    QWORD PTR [rbx+rax*8],cl
 1015cbf:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015cc4:	dec    rdi
 1015cc7:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015ccd:	mov    rax,rdi
 1015cd0:	dec    rax
 1015cd3:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015cd9:	mov    rcx,QWORD PTR [r9+0x8]
 1015cdd:	cmp    rax,rcx
 1015ce0:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015ce6:	cmp    rdi,rcx
 1015ce9:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015cef:	mov    rcx,QWORD PTR [rbx+rax*8]
 1015cf3:	xor    edx,edx
 1015cf5:	cmp    rcx,QWORD PTR [rbx+rdi*8]
 1015cf9:	setb   dl
 1015cfc:	mov    QWORD PTR [rbx+rax*8],rdx
 1015d00:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015d05:	dec    rdi
 1015d08:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015d0e:	mov    rax,rdi
 1015d11:	dec    rax
 1015d14:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015d1a:	mov    rcx,QWORD PTR [r9+0x8]
 1015d1e:	cmp    rax,rcx
 1015d21:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015d27:	cmp    rdi,rcx
 1015d2a:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015d30:	mov    rcx,QWORD PTR [rbx+rdi*8]
 1015d34:	xor    QWORD PTR [rbx+rax*8],rcx
 1015d38:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015d3d:	add    rdi,0xfffffffffffffffe
 1015d41:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015d47:	mov    rax,QWORD PTR [r9+0x8]
 1015d4b:	cmp    rdi,rax
 1015d4e:	jae    101614b <lyr_p4_stack_run+0xaab>
 1015d54:	mov    rdx,rdi
 1015d57:	inc    rdx
 1015d5a:	jo     101610b <lyr_p4_stack_run+0xa6b>
 1015d60:	cmp    rdx,rax
 1015d63:	jae    1016169 <lyr_p4_stack_run+0xac9>
 1015d69:	mov    rax,QWORD PTR [rbx+rdi*8]
 1015d6d:	cmp    rax,QWORD PTR [rbx+rdx*8]
 1015d71:	jae    1015710 <lyr_p4_stack_run+0x70>
 1015d77:	jmp    1015e63 <lyr_p4_stack_run+0x7c3>
 1015d7c:	mov    rax,rdi
 1015d7f:	dec    rax
 1015d82:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015d88:	mov    rdx,QWORD PTR [r9+0x8]
 1015d8c:	cmp    rax,rdx
 1015d8f:	jae    1016153 <lyr_p4_stack_run+0xab3>
 1015d95:	mov    edx,DWORD PTR [rbx+rax*8]
 1015d98:	and    edx,ecx
 1015d9a:	mov    QWORD PTR [rbx+rax*8],rdx
 1015d9e:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015da3:	mov    rax,QWORD PTR [r9+0x8]
 1015da7:	cmp    rdi,rax
 1015daa:	jae    101614b <lyr_p4_stack_run+0xaab>
 1015db0:	shl    ecx,0x10
 1015db3:	or     rcx,rdx
 1015db6:	mov    QWORD PTR [rbx+rdi*8],rcx
 1015dba:	inc    rdi
 1015dbd:	jno    1015710 <lyr_p4_stack_run+0x70>
 1015dc3:	jmp    101610b <lyr_p4_stack_run+0xa6b>
 1015dc8:	mov    rax,rdi
 1015dcb:	dec    rax
 1015dce:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015dd4:	mov    rdx,QWORD PTR [r9+0x8]
 1015dd8:	cmp    rax,rdx
 1015ddb:	jae    1016153 <lyr_p4_stack_run+0xab3>
 1015de1:	mov    rcx,rdi
 1015de4:	add    rcx,0xfffffffffffffffe
 1015de8:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015dee:	cmp    rcx,rdx
 1015df1:	jae    1016184 <lyr_p4_stack_run+0xae4>
 1015df7:	mov    rdx,QWORD PTR [rbx+rax*8]
 1015dfb:	mov    r10,QWORD PTR [r9+rcx*8+0x10]
 1015e00:	mov    QWORD PTR [r9+rax*8+0x10],r10
 1015e05:	mov    rax,QWORD PTR [r9+0x8]
 1015e09:	cmp    rcx,rax
 1015e0c:	jae    101615e <lyr_p4_stack_run+0xabe>
 1015e12:	mov    QWORD PTR [rbx+rcx*8],rdx
 1015e16:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015e1b:	dec    rdi
 1015e1e:	jno    1015710 <lyr_p4_stack_run+0x70>
 1015e24:	jmp    1016129 <lyr_p4_stack_run+0xa89>
 1015e29:	add    rdi,0xfffffffffffffffe
 1015e2d:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015e33:	mov    rax,QWORD PTR [r9+0x8]
 1015e37:	cmp    rdi,rax
 1015e3a:	jae    101614b <lyr_p4_stack_run+0xaab>
 1015e40:	mov    rdx,rdi
 1015e43:	inc    rdx
 1015e46:	jo     101610b <lyr_p4_stack_run+0xa6b>
 1015e4c:	cmp    rdx,rax
 1015e4f:	jae    1016169 <lyr_p4_stack_run+0xac9>
 1015e55:	mov    rax,QWORD PTR [rbx+rdi*8]
 1015e59:	cmp    rax,QWORD PTR [rbx+rdx*8]
 1015e5d:	jne    1015710 <lyr_p4_stack_run+0x70>
 1015e63:	mov    r14,rcx
 1015e66:	jmp    1015719 <lyr_p4_stack_run+0x79>
 1015e6b:	dec    rdi
 1015e6e:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015e74:	mov    rcx,rdi
 1015e77:	dec    rcx
 1015e7a:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015e80:	mov    rax,QWORD PTR [r9+0x8]
 1015e84:	cmp    rcx,rax
 1015e87:	jae    101615e <lyr_p4_stack_run+0xabe>
 1015e8d:	cmp    rdi,rax
 1015e90:	jae    101614b <lyr_p4_stack_run+0xaab>
 1015e96:	mov    r10,QWORD PTR [rbx+rdi*8]
 1015e9a:	test   r10,r10
 1015e9d:	je     1016174 <lyr_p4_stack_run+0xad4>
 1015ea3:	mov    rax,QWORD PTR [rbx+rcx*8]
 1015ea7:	mov    rdx,rax
 1015eaa:	or     rdx,r10
 1015ead:	shr    rdx,0x20
 1015eb1:	je     101607b <lyr_p4_stack_run+0x9db>
 1015eb7:	xor    edx,edx
 1015eb9:	div    r10
 1015ebc:	mov    QWORD PTR [rbx+rcx*8],rax
 1015ec0:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015ec5:	mov    rax,rdi
 1015ec8:	dec    rax
 1015ecb:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015ed1:	mov    rdx,QWORD PTR [r9+0x8]
 1015ed5:	cmp    rax,rdx
 1015ed8:	jae    1016153 <lyr_p4_stack_run+0xab3>
 1015ede:	xor    QWORD PTR [rbx+rax*8],rcx
 1015ee2:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015ee7:	mov    rax,rdi
 1015eea:	dec    rax
 1015eed:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015ef3:	mov    rcx,QWORD PTR [r9+0x8]
 1015ef7:	cmp    rax,rcx
 1015efa:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015f00:	neg    QWORD PTR [rbx+rax*8]
 1015f04:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015f09:	add    rdi,0xfffffffffffffffe
 1015f0d:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015f13:	mov    rax,QWORD PTR [r9+0x8]
 1015f17:	cmp    rdi,rax
 1015f1a:	jae    101614b <lyr_p4_stack_run+0xaab>
 1015f20:	mov    rdx,rdi
 1015f23:	inc    rdx
 1015f26:	jo     101610b <lyr_p4_stack_run+0xa6b>
 1015f2c:	cmp    rdx,rax
 1015f2f:	jae    1016169 <lyr_p4_stack_run+0xac9>
 1015f35:	mov    rax,QWORD PTR [rbx+rdi*8]
 1015f39:	add    rax,rcx
 1015f3c:	mov    rcx,QWORD PTR [rbp-0x30]
 1015f40:	mov    rcx,QWORD PTR [rcx+0x8]
 1015f44:	cmp    rax,rcx
 1015f47:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015f4d:	mov    rcx,QWORD PTR [rbx+rdx*8]
 1015f51:	mov    rdx,QWORD PTR [rbp-0x30]
 1015f55:	mov    QWORD PTR [rdx+rax*8+0x10],rcx
 1015f5a:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015f5f:	mov    rax,rdi
 1015f62:	dec    rax
 1015f65:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015f6b:	mov    rdx,QWORD PTR [r9+0x8]
 1015f6f:	cmp    rax,rdx
 1015f72:	jae    1016153 <lyr_p4_stack_run+0xab3>
 1015f78:	shr    QWORD PTR [rbx+rax*8],cl
 1015f7c:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015f81:	dec    rdi
 1015f84:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015f8a:	mov    rax,rdi
 1015f8d:	dec    rax
 1015f90:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015f96:	mov    rcx,QWORD PTR [r9+0x8]
 1015f9a:	cmp    rax,rcx
 1015f9d:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015fa3:	cmp    rdi,rcx
 1015fa6:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015fac:	mov    rcx,QWORD PTR [rbx+rax*8]
 1015fb0:	xor    edx,edx
 1015fb2:	cmp    rcx,QWORD PTR [rbx+rdi*8]
 1015fb6:	sete   dl
 1015fb9:	mov    QWORD PTR [rbx+rax*8],rdx
 1015fbd:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1015fc2:	dec    rdi
 1015fc5:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015fcb:	mov    rax,rdi
 1015fce:	dec    rax
 1015fd1:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1015fd7:	mov    rcx,QWORD PTR [r9+0x8]
 1015fdb:	cmp    rax,rcx
 1015fde:	jae    1016140 <lyr_p4_stack_run+0xaa0>
 1015fe4:	cmp    rdi,rcx
 1015fe7:	jae    1016143 <lyr_p4_stack_run+0xaa3>
 1015fed:	mov    rcx,QWORD PTR [rbx+rax*8]
 1015ff1:	xor    edx,edx
 1015ff3:	cmp    rcx,QWORD PTR [rbx+rdi*8]
 1015ff7:	seta   dl
 1015ffa:	mov    QWORD PTR [rbx+rax*8],rdx
 1015ffe:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1016003:	mov    rcx,QWORD PTR [rbp-0x38]
 1016007:	dec    rcx
 101600a:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1016010:	mov    rax,QWORD PTR [r8+0x8]
 1016014:	cmp    rcx,rax
 1016017:	jae    101615e <lyr_p4_stack_run+0xabe>
 101601d:	mov    QWORD PTR [rbp-0x38],rcx
 1016021:	mov    r14,QWORD PTR [r8+rcx*8+0x10]
 1016026:	jmp    1015719 <lyr_p4_stack_run+0x79>
 101602b:	dec    rdi
 101602e:	jo     1016129 <lyr_p4_stack_run+0xa89>
 1016034:	mov    rax,QWORD PTR [r9+0x8]
 1016038:	cmp    rdi,rax
 101603b:	jae    101614b <lyr_p4_stack_run+0xaab>
 1016041:	mov    rcx,rdi
 1016044:	dec    rcx
 1016047:	jo     1016129 <lyr_p4_stack_run+0xa89>
 101604d:	cmp    rcx,rax
 1016050:	jae    101615e <lyr_p4_stack_run+0xabe>
 1016056:	mov    rax,QWORD PTR [rbx+rdi*8]
 101605a:	cmp    rax,QWORD PTR [rbx+rcx*8]
 101605e:	jae    1015710 <lyr_p4_stack_run+0x70>
 1016064:	mov    QWORD PTR [rbx+rcx*8],rax
 1016068:	jmp    1015710 <lyr_p4_stack_run+0x70>
 101606d:	xor    edx,edx
 101606f:	div    r10d
 1016072:	mov    QWORD PTR [rbx+rcx*8],rdx
 1016076:	jmp    1015710 <lyr_p4_stack_run+0x70>
 101607b:	xor    edx,edx
 101607d:	div    r10d
 1016080:	mov    QWORD PTR [rbx+rcx*8],rax
 1016084:	jmp    1015710 <lyr_p4_stack_run+0x70>
 1016089:	lea    rax,[rip+0x278d8]        # 103d968 <lyr_gc_stop_requested>
 1016090:	mov    eax,DWORD PTR [rax]
 1016092:	mov    r13d,0x400
 1016098:	test   eax,eax
 101609a:	je     101572b <lyr_p4_stack_run+0x8b>
 10160a0:	mov    QWORD PTR [rbp-0x58],rdi
 10160a4:	mov    QWORD PTR [rbp-0x48],r9
 10160a8:	mov    QWORD PTR [rbp-0x50],r8
 10160ac:	mov    QWORD PTR [rbp-0x40],rsi
 10160b0:	call   101a910 <lyr_gc_safepoint_slow>
 10160b5:	mov    rsi,QWORD PTR [rbp-0x40]
 10160b9:	mov    r8,QWORD PTR [rbp-0x50]
 10160bd:	mov    r9,QWORD PTR [rbp-0x48]
 10160c1:	mov    rdi,QWORD PTR [rbp-0x58]
 10160c5:	jmp    101572b <lyr_p4_stack_run+0x8b>
 10160ca:	lea    rax,[rip+0x27897]        # 103d968 <lyr_gc_stop_requested>
 10160d1:	mov    eax,DWORD PTR [rax]
 10160d3:	mov    r13d,0x400
 10160d9:	test   eax,eax
 10160db:	je     1015722 <lyr_p4_stack_run+0x82>
 10160e1:	mov    QWORD PTR [rbp-0x58],rdi
 10160e5:	mov    QWORD PTR [rbp-0x48],r9
 10160e9:	mov    QWORD PTR [rbp-0x50],r8
 10160ed:	mov    QWORD PTR [rbp-0x40],rsi
 10160f1:	call   101a910 <lyr_gc_safepoint_slow>
 10160f6:	mov    rsi,QWORD PTR [rbp-0x40]
 10160fa:	mov    r8,QWORD PTR [rbp-0x50]
 10160fe:	mov    r9,QWORD PTR [rbp-0x48]
 1016102:	mov    rdi,QWORD PTR [rbp-0x58]
 1016106:	jmp    1015722 <lyr_p4_stack_run+0x82>
 101610b:	lea    rdi,[rip+0xfffffffffffec8db]        # 10029ed <lyr_refmap_ty_std_core_StringBuilder+0x1095>
 1016112:	call   1020689 <lyr_panic_overflow>
 1016117:	mov    rax,r12
 101611a:	add    rsp,0x38
 101611e:	pop    rbx
 101611f:	pop    r12
 1016121:	pop    r13
 1016123:	pop    r14
 1016125:	pop    r15
 1016127:	pop    rbp
 1016128:	ret
 1016129:	lea    rdi,[rip+0xfffffffffffec8bb]        # 10029eb <lyr_refmap_ty_std_core_StringBuilder+0x1093>
 1016130:	call   1020689 <lyr_panic_overflow>
 1016135:	mov    rdi,r14
 1016138:	mov    rsi,rax
 101613b:	call   1020648 <lyr_panic_index>
 1016140:	mov    rdi,rax
 1016143:	mov    rsi,rcx
 1016146:	call   1020648 <lyr_panic_index>
 101614b:	mov    rsi,rax
 101614e:	call   1020648 <lyr_panic_index>
 1016153:	mov    rdi,rax
 1016156:	mov    rsi,rdx
 1016159:	call   1020648 <lyr_panic_index>
 101615e:	mov    rdi,rcx
 1016161:	mov    rsi,rax
 1016164:	call   1020648 <lyr_panic_index>
 1016169:	mov    rdi,rdx
 101616c:	mov    rsi,rax
 101616f:	call   1020648 <lyr_panic_index>
 1016174:	call   10206a5 <lyr_panic_division_by_zero>
 1016179:	mov    rdi,rdx
 101617c:	mov    rsi,rcx
 101617f:	call   1020648 <lyr_panic_index>
 1016184:	mov    rdi,rcx
 1016187:	mov    rsi,rdx
 101618a:	call   1020648 <lyr_panic_index>
 101618f:	mov    rbx,r9
 1016192:	mov    r12,r8
 1016195:	mov    r14,rsi
 1016198:	call   101a980 <lyr_gc_stack_slow>
 101619d:	mov    rsi,r14
 10161a0:	mov    r8,r12
 10161a3:	mov    r9,rbx
 10161a6:	jmp    10156db <lyr_p4_stack_run+0x3b>
 10161ab:	lea    rdi,[rip+0x21d1e]        # 1037ed0 <lyr_lit0>
 10161b2:	call   10206db <lyr_panic_message>
 10161b7:	ud2
 10161b9:	int3
 10161ba:	int3
 10161bb:	int3
 10161bc:	int3
 10161bd:	int3
 10161be:	int3
 10161bf:	int3
