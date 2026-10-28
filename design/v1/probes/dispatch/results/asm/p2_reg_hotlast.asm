00000000010156f0 <lyr_p2_reg_hotlast_run>:
 10156f0:	push   rbp
 10156f1:	mov    rbp,rsp
 10156f4:	push   r15
 10156f6:	push   r14
 10156f8:	push   r13
 10156fa:	push   r12
 10156fc:	push   rbx
 10156fd:	sub    rsp,0x28
 1015701:	mov    QWORD PTR [rbp-0x50],rdx
 1015705:	mov    rax,rbp
 1015708:	add    rax,0xffffffffffffad20
 101570e:	mov    rdx,0xffffffffffffffe0
 1015715:	mov    rdx,QWORD PTR fs:[rdx+0x10]
 101571a:	cmp    rax,rdx
 101571d:	jb     101608d <lyr_p2_reg_hotlast_run+0x99d>
 1015723:	lea    r13,[rsi+0x10]
 1015727:	mov    r15d,0x400
 101572d:	xor    r14d,r14d
 1015730:	lea    rbx,[rip+0xfffffffffffec0a9]        # 10017e0 <__abi_tag+0x14e4>
 1015737:	xor    r11d,r11d
 101573a:	xor    r12d,r12d
 101573d:	jmp    1015764 <lyr_p2_reg_hotlast_run+0x74>
 101573f:	mov    eax,0x1
 1015744:	cmp    r10,r9
 1015747:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 101574d:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015752:	inc    r12
 1015755:	jo     1016006 <lyr_p2_reg_hotlast_run+0x916>
 101575b:	dec    r15d
 101575e:	je     1015fb8 <lyr_p2_reg_hotlast_run+0x8c8>
 1015764:	dec    r15d
 1015767:	je     1015f6a <lyr_p2_reg_hotlast_run+0x87a>
 101576d:	mov    rax,QWORD PTR [rdi+0x8]
 1015771:	cmp    r12,rax
 1015774:	jae    1016024 <lyr_p2_reg_hotlast_run+0x934>
 101577a:	inc    r14
 101577d:	jo     1016006 <lyr_p2_reg_hotlast_run+0x916>
 1015783:	movzx  r10d,BYTE PTR [rdi+r12*8+0x10]
 1015789:	cmp    r10,0x2f
 101578d:	ja     10160b2 <lyr_p2_reg_hotlast_run+0x9c2>
 1015793:	movzx  r9d,WORD PTR [rdi+r12*8+0x12]
 1015799:	movzx  eax,WORD PTR [rdi+r12*8+0x14]
 101579f:	movzx  edx,WORD PTR [rdi+r12*8+0x16]
 10157a5:	movsxd r10,DWORD PTR [rbx+r10*4]
 10157a9:	add    r10,rbx
 10157ac:	jmp    r10
 10157af:	mov    r10,QWORD PTR [rsi+0x8]
 10157b3:	cmp    r10,rax
 10157b6:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 10157bc:	cmp    r10,rdx
 10157bf:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 10157c5:	cmp    r10,r9
 10157c8:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 10157ce:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 10157d3:	add    rdx,QWORD PTR [r13+rax*8+0x0]
 10157d8:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 10157dd:	jmp    1015752 <lyr_p2_reg_hotlast_run+0x62>
 10157e2:	mov    r10,QWORD PTR [rsi+0x8]
 10157e6:	cmp    r10,rax
 10157e9:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 10157ef:	cmp    r10,rdx
 10157f2:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 10157f8:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 10157fd:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 1015802:	cmp    rax,rdx
 1015805:	jb     1015744 <lyr_p2_reg_hotlast_run+0x54>
 101580b:	jmp    1015f34 <lyr_p2_reg_hotlast_run+0x844>
 1015810:	mov    r10,QWORD PTR [rsi+0x8]
 1015814:	cmp    r10,r9
 1015817:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 101581d:	cmp    r10,rax
 1015820:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015826:	mov    r9,QWORD PTR [r13+r9*8+0x0]
 101582b:	cmp    r9,QWORD PTR [r13+rax*8+0x0]
 1015830:	je     1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015836:	jmp    1015ece <lyr_p2_reg_hotlast_run+0x7de>
 101583b:	mov    r10,QWORD PTR [rsi+0x8]
 101583f:	cmp    r10,rax
 1015842:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015848:	cmp    r10,r9
 101584b:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015851:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015856:	xor    rax,rdx
 1015859:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 101585e:	mov    r10,QWORD PTR [rsi+0x8]
 1015862:	cmp    r10,rax
 1015865:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 101586b:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015870:	add    rax,rdx
 1015873:	mov    rdx,QWORD PTR [rcx+0x8]
 1015877:	cmp    rax,rdx
 101587a:	jae    1016050 <lyr_p2_reg_hotlast_run+0x960>
 1015880:	cmp    r10,r9
 1015883:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015889:	mov    rax,QWORD PTR [rcx+rax*8+0x10]
 101588e:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 1015893:	mov    rdx,QWORD PTR [rsi+0x8]
 1015897:	cmp    rdx,rax
 101589a:	jbe    1016050 <lyr_p2_reg_hotlast_run+0x960>
 10158a0:	cmp    rdx,r9
 10158a3:	jbe    1016066 <lyr_p2_reg_hotlast_run+0x976>
 10158a9:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 10158ae:	not    rax
 10158b1:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 10158b6:	mov    r10,QWORD PTR [rsi+0x8]
 10158ba:	cmp    r10,r9
 10158bd:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 10158c3:	cmp    r10,rax
 10158c6:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 10158cc:	mov    r9,QWORD PTR [r13+r9*8+0x0]
 10158d1:	cmp    r9,QWORD PTR [r13+rax*8+0x0]
 10158d6:	jb     1015752 <lyr_p2_reg_hotlast_run+0x62>
 10158dc:	jmp    1015ece <lyr_p2_reg_hotlast_run+0x7de>
 10158e1:	mov    r10,QWORD PTR [rsi+0x8]
 10158e5:	cmp    r10,r9
 10158e8:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 10158ee:	cmp    r10,rax
 10158f1:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 10158f7:	mov    r9,QWORD PTR [r13+r9*8+0x0]
 10158fc:	cmp    r9,QWORD PTR [r13+rax*8+0x0]
 1015901:	jne    1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015907:	jmp    1015ece <lyr_p2_reg_hotlast_run+0x7de>
 101590c:	mov    r10,QWORD PTR [rsi+0x8]
 1015910:	cmp    r10,rax
 1015913:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015919:	cmp    r10,rdx
 101591c:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015922:	mov    rbx,r11
 1015925:	mov    r11,QWORD PTR [r13+rdx*8+0x0]
 101592a:	test   r11,r11
 101592d:	je     101607c <lyr_p2_reg_hotlast_run+0x98c>
 1015933:	cmp    r10,r9
 1015936:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 101593c:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015941:	mov    rdx,rax
 1015944:	or     rdx,r11
 1015947:	shr    rdx,0x20
 101594b:	je     1015f3c <lyr_p2_reg_hotlast_run+0x84c>
 1015951:	xor    edx,edx
 1015953:	div    r11
 1015956:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 101595b:	jmp    1015f52 <lyr_p2_reg_hotlast_run+0x862>
 1015960:	mov    rdx,QWORD PTR [rsi+0x8]
 1015964:	cmp    rdx,rax
 1015967:	jbe    1016050 <lyr_p2_reg_hotlast_run+0x960>
 101596d:	cmp    rdx,r9
 1015970:	ja     1015f01 <lyr_p2_reg_hotlast_run+0x811>
 1015976:	jmp    1016066 <lyr_p2_reg_hotlast_run+0x976>
 101597b:	mov    r10,QWORD PTR [rsi+0x8]
 101597f:	cmp    r10,rax
 1015982:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015988:	cmp    r10,r9
 101598b:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015991:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015996:	add    rax,rdx
 1015999:	mov    rdx,QWORD PTR [rcx+0x8]
 101599d:	cmp    rax,rdx
 10159a0:	jae    1016050 <lyr_p2_reg_hotlast_run+0x960>
 10159a6:	mov    rdx,QWORD PTR [r13+r9*8+0x0]
 10159ab:	mov    QWORD PTR [rcx+rax*8+0x10],rdx
 10159b0:	jmp    1015752 <lyr_p2_reg_hotlast_run+0x62>
 10159b5:	mov    r10,QWORD PTR [rsi+0x8]
 10159b9:	cmp    r10,rax
 10159bc:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 10159c2:	cmp    r10,r9
 10159c5:	ja     1015db7 <lyr_p2_reg_hotlast_run+0x6c7>
 10159cb:	jmp    101602f <lyr_p2_reg_hotlast_run+0x93f>
 10159d0:	mov    r10,QWORD PTR [rsi+0x8]
 10159d4:	cmp    r10,rax
 10159d7:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 10159dd:	cmp    r10,rdx
 10159e0:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 10159e6:	cmp    r10,r9
 10159e9:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 10159ef:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 10159f4:	xor    rdx,QWORD PTR [r13+rax*8+0x0]
 10159f9:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 10159fe:	jmp    1015c93 <lyr_p2_reg_hotlast_run+0x5a3>
 1015a03:	mov    r10,QWORD PTR [rsi+0x8]
 1015a07:	cmp    r10,rax
 1015a0a:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015a10:	cmp    r10,r9
 1015a13:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015a19:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015a1e:	imul   rax,rdx
 1015a22:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 1015a27:	mov    r10,QWORD PTR [rsi+0x8]
 1015a2b:	cmp    r10,rax
 1015a2e:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015a34:	cmp    r10,rdx
 1015a37:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015a3d:	cmp    r10,r9
 1015a40:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015a46:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015a4b:	sub    rax,QWORD PTR [r13+rdx*8+0x0]
 1015a50:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 1015a55:	mov    r10,QWORD PTR [rsi+0x8]
 1015a59:	cmp    r10,rax
 1015a5c:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015a62:	cmp    r10,r9
 1015a65:	ja     1015d3c <lyr_p2_reg_hotlast_run+0x64c>
 1015a6b:	jmp    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015a70:	mov    r10,QWORD PTR [rsi+0x8]
 1015a74:	cmp    r10,rax
 1015a77:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015a7d:	cmp    r10,rdx
 1015a80:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015a86:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015a8b:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015a90:	jb     101573f <lyr_p2_reg_hotlast_run+0x4f>
 1015a96:	jmp    1015ea5 <lyr_p2_reg_hotlast_run+0x7b5>
 1015a9b:	mov    r10,QWORD PTR [rsi+0x8]
 1015a9f:	cmp    r10,rax
 1015aa2:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015aa8:	cmp    r10,rdx
 1015aab:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015ab1:	cmp    r10,r9
 1015ab4:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015aba:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 1015abf:	imul   rdx,QWORD PTR [r13+rax*8+0x0]
 1015ac5:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 1015aca:	jmp    1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015acf:	mov    r10,QWORD PTR [rsi+0x8]
 1015ad3:	cmp    r10,rax
 1015ad6:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015adc:	cmp    r10,r9
 1015adf:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015ae5:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015aea:	add    rax,rdx
 1015aed:	jmp    1015c8e <lyr_p2_reg_hotlast_run+0x59e>
 1015af2:	mov    rdx,QWORD PTR [rsi+0x8]
 1015af6:	cmp    rdx,rax
 1015af9:	jbe    1016050 <lyr_p2_reg_hotlast_run+0x960>
 1015aff:	cmp    rdx,r9
 1015b02:	jbe    1016066 <lyr_p2_reg_hotlast_run+0x976>
 1015b08:	xor    edx,edx
 1015b0a:	sub    rdx,QWORD PTR [r13+rax*8+0x0]
 1015b0f:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 1015b14:	jmp    1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015b19:	mov    rax,QWORD PTR [rsi+0x8]
 1015b1d:	cmp    rax,r9
 1015b20:	jbe    101605b <lyr_p2_reg_hotlast_run+0x96b>
 1015b26:	cmp    QWORD PTR [r13+r9*8+0x0],0x0
 1015b2c:	jne    1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015b32:	jmp    1015ece <lyr_p2_reg_hotlast_run+0x7de>
 1015b37:	mov    r10,QWORD PTR [rsi+0x8]
 1015b3b:	cmp    r10,r9
 1015b3e:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015b44:	cmp    r10,rax
 1015b47:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015b4d:	mov    r9,QWORD PTR [r13+r9*8+0x0]
 1015b52:	cmp    r9,QWORD PTR [r13+rax*8+0x0]
 1015b57:	ja     1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015b5d:	jmp    1015ece <lyr_p2_reg_hotlast_run+0x7de>
 1015b62:	mov    r10,QWORD PTR [rsi+0x8]
 1015b66:	cmp    r10,rax
 1015b69:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015b6f:	cmp    r10,rdx
 1015b72:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015b78:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015b7d:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015b82:	jae    101573f <lyr_p2_reg_hotlast_run+0x4f>
 1015b88:	jmp    1015ea5 <lyr_p2_reg_hotlast_run+0x7b5>
 1015b8d:	mov    r10,QWORD PTR [rsi+0x8]
 1015b91:	cmp    r10,rax
 1015b94:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015b9a:	cmp    r10,rdx
 1015b9d:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015ba3:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015ba8:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015bad:	je     101573f <lyr_p2_reg_hotlast_run+0x4f>
 1015bb3:	jmp    1015ea5 <lyr_p2_reg_hotlast_run+0x7b5>
 1015bb8:	mov    r10,QWORD PTR [rsi+0x8]
 1015bbc:	cmp    r10,rax
 1015bbf:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015bc5:	cmp    r10,rdx
 1015bc8:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015bce:	cmp    r10,r9
 1015bd1:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015bd7:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 1015bdc:	and    rdx,QWORD PTR [r13+rax*8+0x0]
 1015be1:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 1015be6:	jmp    1015c93 <lyr_p2_reg_hotlast_run+0x5a3>
 1015beb:	mov    r10,QWORD PTR [rsi+0x8]
 1015bef:	cmp    r10,rax
 1015bf2:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015bf8:	cmp    r10,rdx
 1015bfb:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015c01:	mov    rbx,r11
 1015c04:	mov    r11,QWORD PTR [r13+rdx*8+0x0]
 1015c09:	test   r11,r11
 1015c0c:	je     101607c <lyr_p2_reg_hotlast_run+0x98c>
 1015c12:	cmp    r10,r9
 1015c15:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015c1b:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015c20:	mov    rdx,rax
 1015c23:	or     rdx,r11
 1015c26:	shr    rdx,0x20
 1015c2a:	je     1015f48 <lyr_p2_reg_hotlast_run+0x858>
 1015c30:	xor    edx,edx
 1015c32:	div    r11
 1015c35:	jmp    1015f4d <lyr_p2_reg_hotlast_run+0x85d>
 1015c3a:	mov    rax,QWORD PTR [rsi+0x8]
 1015c3e:	cmp    rax,r9
 1015c41:	jbe    101605b <lyr_p2_reg_hotlast_run+0x96b>
 1015c47:	dec    QWORD PTR [r13+r9*8+0x0]
 1015c4c:	jmp    1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015c51:	dec    r11
 1015c54:	jo     1016081 <lyr_p2_reg_hotlast_run+0x991>
 1015c5a:	mov    rax,QWORD PTR [r8+0x8]
 1015c5e:	cmp    r11,rax
 1015c61:	jae    1016071 <lyr_p2_reg_hotlast_run+0x981>
 1015c67:	mov    r12,QWORD PTR [r8+r11*8+0x10]
 1015c6c:	jmp    101575b <lyr_p2_reg_hotlast_run+0x6b>
 1015c71:	mov    r10,QWORD PTR [rsi+0x8]
 1015c75:	cmp    r10,rax
 1015c78:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015c7e:	cmp    r10,r9
 1015c81:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015c87:	mov    eax,DWORD PTR [r13+rax*8+0x0]
 1015c8c:	and    eax,edx
 1015c8e:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015c93:	inc    r12
 1015c96:	jno    101575b <lyr_p2_reg_hotlast_run+0x6b>
 1015c9c:	jmp    1016006 <lyr_p2_reg_hotlast_run+0x916>
 1015ca1:	mov    r10,QWORD PTR [rsi+0x8]
 1015ca5:	cmp    r10,r9
 1015ca8:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015cae:	cmp    r10,rax
 1015cb1:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015cb7:	mov    r9,QWORD PTR [r13+r9*8+0x0]
 1015cbc:	cmp    r9,QWORD PTR [r13+rax*8+0x0]
 1015cc1:	jae    1015c93 <lyr_p2_reg_hotlast_run+0x5a3>
 1015cc3:	jmp    1015ece <lyr_p2_reg_hotlast_run+0x7de>
 1015cc8:	mov    r10,QWORD PTR [rsi+0x8]
 1015ccc:	cmp    r10,rax
 1015ccf:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015cd5:	cmp    r10,r9
 1015cd8:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015cde:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015ce3:	sub    rax,rdx
 1015ce6:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 1015ceb:	mov    rdx,QWORD PTR [rbp-0x50]
 1015cef:	mov    rdx,QWORD PTR [rdx+0x8]
 1015cf3:	cmp    rdx,rax
 1015cf6:	jbe    1016050 <lyr_p2_reg_hotlast_run+0x960>
 1015cfc:	mov    rdx,QWORD PTR [rsi+0x8]
 1015d00:	cmp    rdx,r9
 1015d03:	jbe    1016066 <lyr_p2_reg_hotlast_run+0x976>
 1015d09:	mov    rdx,QWORD PTR [rbp-0x50]
 1015d0d:	mov    rax,QWORD PTR [rdx+rax*8+0x10]
 1015d12:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 1015d17:	mov    r10,QWORD PTR [rsi+0x8]
 1015d1b:	cmp    r10,rax
 1015d1e:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015d24:	cmp    r10,rdx
 1015d27:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015d2d:	cmp    r10,r9
 1015d30:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015d36:	movzx  edx,BYTE PTR [r13+rdx*8+0x0]
 1015d3c:	shlx   rax,QWORD PTR [r13+rax*8+0x0],rdx
 1015d43:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 1015d48:	mov    r10,QWORD PTR [rsi+0x8]
 1015d4c:	cmp    r10,rax
 1015d4f:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015d55:	cmp    r10,rdx
 1015d58:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015d5e:	cmp    r10,r9
 1015d61:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015d67:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 1015d6c:	or     rdx,QWORD PTR [r13+rax*8+0x0]
 1015d71:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 1015d76:	jmp    1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015d7b:	mov    rax,QWORD PTR [rsi+0x8]
 1015d7f:	cmp    rax,r9
 1015d82:	jbe    101605b <lyr_p2_reg_hotlast_run+0x96b>
 1015d88:	inc    QWORD PTR [r13+r9*8+0x0]
 1015d8d:	jmp    1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015d92:	mov    r10,QWORD PTR [rsi+0x8]
 1015d96:	cmp    r10,rax
 1015d99:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015d9f:	cmp    r10,rdx
 1015da2:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015da8:	cmp    r10,r9
 1015dab:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015db1:	movzx  edx,BYTE PTR [r13+rdx*8+0x0]
 1015db7:	shrx   rax,QWORD PTR [r13+rax*8+0x0],rdx
 1015dbe:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 1015dc3:	mov    r10,QWORD PTR [rsi+0x8]
 1015dc7:	cmp    r10,rax
 1015dca:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015dd0:	cmp    r10,rdx
 1015dd3:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015dd9:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015dde:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015de3:	jne    101573f <lyr_p2_reg_hotlast_run+0x4f>
 1015de9:	jmp    1015ea5 <lyr_p2_reg_hotlast_run+0x7b5>
 1015dee:	mov    r10,QWORD PTR [rsi+0x8]
 1015df2:	cmp    r10,rax
 1015df5:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015dfb:	cmp    r10,r9
 1015dfe:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015e04:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015e09:	or     rax,rdx
 1015e0c:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 1015e11:	inc    r12
 1015e14:	jo     1016006 <lyr_p2_reg_hotlast_run+0x916>
 1015e1a:	mov    rax,QWORD PTR [r8+0x8]
 1015e1e:	cmp    r11,rax
 1015e21:	jae    1016071 <lyr_p2_reg_hotlast_run+0x981>
 1015e27:	mov    QWORD PTR [r8+r11*8+0x10],r12
 1015e2c:	inc    r11
 1015e2f:	jno    1015ece <lyr_p2_reg_hotlast_run+0x7de>
 1015e35:	jmp    1016006 <lyr_p2_reg_hotlast_run+0x916>
 1015e3a:	mov    r10,QWORD PTR [rsi+0x8]
 1015e3e:	cmp    r10,r9
 1015e41:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015e47:	shl    edx,0x10
 1015e4a:	or     rdx,rax
 1015e4d:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 1015e52:	jmp    1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015e57:	mov    r10,QWORD PTR [rsi+0x8]
 1015e5b:	cmp    r10,rax
 1015e5e:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015e64:	cmp    r10,rdx
 1015e67:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015e6d:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015e72:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015e77:	jbe    101573f <lyr_p2_reg_hotlast_run+0x4f>
 1015e7d:	jmp    1015ea5 <lyr_p2_reg_hotlast_run+0x7b5>
 1015e7f:	mov    r10,QWORD PTR [rsi+0x8]
 1015e83:	cmp    r10,rax
 1015e86:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015e8c:	cmp    r10,rdx
 1015e8f:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015e95:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015e9a:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015e9f:	ja     101573f <lyr_p2_reg_hotlast_run+0x4f>
 1015ea5:	cmp    r10,r9
 1015ea8:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015eae:	xor    eax,eax
 1015eb0:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 1015eb5:	mov    rax,QWORD PTR [rsi+0x8]
 1015eb9:	cmp    rax,r9
 1015ebc:	jbe    101605b <lyr_p2_reg_hotlast_run+0x96b>
 1015ec2:	cmp    QWORD PTR [r13+r9*8+0x0],0x0
 1015ec8:	je     1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015ece:	mov    r12,rdx
 1015ed1:	jmp    101575b <lyr_p2_reg_hotlast_run+0x6b>
 1015ed6:	mov    r10,QWORD PTR [rsi+0x8]
 1015eda:	cmp    r10,rdx
 1015edd:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015ee3:	cmp    QWORD PTR [r13+rdx*8+0x0],0x0
 1015ee9:	je     1015752 <lyr_p2_reg_hotlast_run+0x62>
 1015eef:	cmp    r10,rax
 1015ef2:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015ef8:	cmp    r10,r9
 1015efb:	jbe    101602f <lyr_p2_reg_hotlast_run+0x93f>
 1015f01:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015f06:	jmp    101574d <lyr_p2_reg_hotlast_run+0x5d>
 1015f0b:	mov    r10,QWORD PTR [rsi+0x8]
 1015f0f:	cmp    r10,rax
 1015f12:	jbe    101603a <lyr_p2_reg_hotlast_run+0x94a>
 1015f18:	cmp    r10,rdx
 1015f1b:	jbe    1016045 <lyr_p2_reg_hotlast_run+0x955>
 1015f21:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015f26:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 1015f2b:	cmp    rax,rdx
 1015f2e:	ja     1015744 <lyr_p2_reg_hotlast_run+0x54>
 1015f34:	mov    rax,rdx
 1015f37:	jmp    1015744 <lyr_p2_reg_hotlast_run+0x54>
 1015f3c:	xor    edx,edx
 1015f3e:	div    r11d
 1015f41:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 1015f46:	jmp    1015f52 <lyr_p2_reg_hotlast_run+0x862>
 1015f48:	xor    edx,edx
 1015f4a:	div    r11d
 1015f4d:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015f52:	inc    r12
 1015f55:	jo     1016006 <lyr_p2_reg_hotlast_run+0x916>
 1015f5b:	mov    r11,rbx
 1015f5e:	lea    rbx,[rip+0xfffffffffffeb87b]        # 10017e0 <__abi_tag+0x14e4>
 1015f65:	jmp    101575b <lyr_p2_reg_hotlast_run+0x6b>
 1015f6a:	lea    rax,[rip+0x27707]        # 103d678 <lyr_gc_stop_requested>
 1015f71:	mov    eax,DWORD PTR [rax]
 1015f73:	mov    r15d,0x400
 1015f79:	test   eax,eax
 1015f7b:	je     101576d <lyr_p2_reg_hotlast_run+0x7d>
 1015f81:	mov    QWORD PTR [rbp-0x48],r8
 1015f85:	mov    QWORD PTR [rbp-0x38],rcx
 1015f89:	mov    QWORD PTR [rbp-0x40],rsi
 1015f8d:	mov    QWORD PTR [rbp-0x30],rdi
 1015f91:	mov    rbx,r11
 1015f94:	call   101a620 <lyr_gc_safepoint_slow>
 1015f99:	mov    r11,rbx
 1015f9c:	lea    rbx,[rip+0xfffffffffffeb83d]        # 10017e0 <__abi_tag+0x14e4>
 1015fa3:	mov    rdi,QWORD PTR [rbp-0x30]
 1015fa7:	mov    rsi,QWORD PTR [rbp-0x40]
 1015fab:	mov    rcx,QWORD PTR [rbp-0x38]
 1015faf:	mov    r8,QWORD PTR [rbp-0x48]
 1015fb3:	jmp    101576d <lyr_p2_reg_hotlast_run+0x7d>
 1015fb8:	lea    rax,[rip+0x276b9]        # 103d678 <lyr_gc_stop_requested>
 1015fbf:	mov    eax,DWORD PTR [rax]
 1015fc1:	mov    r15d,0x400
 1015fc7:	test   eax,eax
 1015fc9:	je     1015764 <lyr_p2_reg_hotlast_run+0x74>
 1015fcf:	mov    QWORD PTR [rbp-0x48],r8
 1015fd3:	mov    QWORD PTR [rbp-0x38],rcx
 1015fd7:	mov    QWORD PTR [rbp-0x40],rsi
 1015fdb:	mov    QWORD PTR [rbp-0x30],rdi
 1015fdf:	mov    rbx,r11
 1015fe2:	call   101a620 <lyr_gc_safepoint_slow>
 1015fe7:	mov    r11,rbx
 1015fea:	lea    rbx,[rip+0xfffffffffffeb7ef]        # 10017e0 <__abi_tag+0x14e4>
 1015ff1:	mov    rdi,QWORD PTR [rbp-0x30]
 1015ff5:	mov    rsi,QWORD PTR [rbp-0x40]
 1015ff9:	mov    rcx,QWORD PTR [rbp-0x38]
 1015ffd:	mov    r8,QWORD PTR [rbp-0x48]
 1016001:	jmp    1015764 <lyr_p2_reg_hotlast_run+0x74>
 1016006:	lea    rdi,[rip+0xfffffffffffeca26]        # 1002a33 <lyr_refmap_ty_std_core_StringBuilder+0x109b>
 101600d:	call   1020399 <lyr_panic_overflow>
 1016012:	mov    rax,r14
 1016015:	add    rsp,0x28
 1016019:	pop    rbx
 101601a:	pop    r12
 101601c:	pop    r13
 101601e:	pop    r14
 1016020:	pop    r15
 1016022:	pop    rbp
 1016023:	ret
 1016024:	mov    rdi,r12
 1016027:	mov    rsi,rax
 101602a:	call   1020358 <lyr_panic_index>
 101602f:	mov    rdi,r9
 1016032:	mov    rsi,r10
 1016035:	call   1020358 <lyr_panic_index>
 101603a:	mov    rdi,rax
 101603d:	mov    rsi,r10
 1016040:	call   1020358 <lyr_panic_index>
 1016045:	mov    rdi,rdx
 1016048:	mov    rsi,r10
 101604b:	call   1020358 <lyr_panic_index>
 1016050:	mov    rdi,rax
 1016053:	mov    rsi,rdx
 1016056:	call   1020358 <lyr_panic_index>
 101605b:	mov    rdi,r9
 101605e:	mov    rsi,rax
 1016061:	call   1020358 <lyr_panic_index>
 1016066:	mov    rdi,r9
 1016069:	mov    rsi,rdx
 101606c:	call   1020358 <lyr_panic_index>
 1016071:	mov    rdi,r11
 1016074:	mov    rsi,rax
 1016077:	call   1020358 <lyr_panic_index>
 101607c:	call   10203b5 <lyr_panic_division_by_zero>
 1016081:	lea    rdi,[rip+0xfffffffffffec9a9]        # 1002a31 <lyr_refmap_ty_std_core_StringBuilder+0x1099>
 1016088:	call   1020399 <lyr_panic_overflow>
 101608d:	mov    rbx,rdi
 1016090:	mov    rdi,rax
 1016093:	mov    r14,r8
 1016096:	mov    r12,rcx
 1016099:	mov    r15,rsi
 101609c:	call   101a690 <lyr_gc_stack_slow>
 10160a1:	mov    rdi,rbx
 10160a4:	mov    rsi,r15
 10160a7:	mov    rcx,r12
 10160aa:	mov    r8,r14
 10160ad:	jmp    1015723 <lyr_p2_reg_hotlast_run+0x33>
 10160b2:	lea    rdi,[rip+0x21b27]        # 1037be0 <lyr_lit0>
 10160b9:	call   10203eb <lyr_panic_message>
 10160be:	ud2
