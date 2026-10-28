00000000010156e0 <lyr_p1_reg_run>:
 10156e0:	push   rbp
 10156e1:	mov    rbp,rsp
 10156e4:	push   r15
 10156e6:	push   r14
 10156e8:	push   r13
 10156ea:	push   r12
 10156ec:	push   rbx
 10156ed:	sub    rsp,0x28
 10156f1:	mov    QWORD PTR [rbp-0x50],rdx
 10156f5:	mov    rax,rbp
 10156f8:	add    rax,0xffffffffffffad20
 10156fe:	mov    rdx,0xffffffffffffffe0
 1015705:	mov    rdx,QWORD PTR fs:[rdx+0x10]
 101570a:	cmp    rax,rdx
 101570d:	jb     1016091 <lyr_p1_reg_run+0x9b1>
 1015713:	lea    r13,[rsi+0x10]
 1015717:	mov    r15d,0x400
 101571d:	xor    r14d,r14d
 1015720:	lea    rbx,[rip+0xfffffffffffec0b9]        # 10017e0 <__abi_tag+0x14e4>
 1015727:	xor    r11d,r11d
 101572a:	xor    r12d,r12d
 101572d:	jmp    1015752 <lyr_p1_reg_run+0x72>
 101572f:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 1015734:	or     rdx,QWORD PTR [r13+rax*8+0x0]
 1015739:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 101573e:	xchg   ax,ax
 1015740:	inc    r12
 1015743:	jo     101600a <lyr_p1_reg_run+0x92a>
 1015749:	dec    r15d
 101574c:	je     1015fbc <lyr_p1_reg_run+0x8dc>
 1015752:	dec    r15d
 1015755:	je     1015f6e <lyr_p1_reg_run+0x88e>
 101575b:	mov    rax,QWORD PTR [rdi+0x8]
 101575f:	cmp    r12,rax
 1015762:	jae    1016028 <lyr_p1_reg_run+0x948>
 1015768:	inc    r14
 101576b:	jo     101600a <lyr_p1_reg_run+0x92a>
 1015771:	movzx  r10d,BYTE PTR [rdi+r12*8+0x10]
 1015777:	cmp    r10,0x2f
 101577b:	ja     10160b6 <lyr_p1_reg_run+0x9d6>
 1015781:	movzx  r9d,WORD PTR [rdi+r12*8+0x12]
 1015787:	movzx  eax,WORD PTR [rdi+r12*8+0x14]
 101578d:	movzx  edx,WORD PTR [rdi+r12*8+0x16]
 1015793:	movsxd r10,DWORD PTR [rbx+r10*4]
 1015797:	add    r10,rbx
 101579a:	jmp    r10
 101579d:	mov    r10,QWORD PTR [rsi+0x8]
 10157a1:	cmp    r10,rax
 10157a4:	jbe    101603e <lyr_p1_reg_run+0x95e>
 10157aa:	cmp    r10,rdx
 10157ad:	jbe    1016049 <lyr_p1_reg_run+0x969>
 10157b3:	cmp    r10,r9
 10157b6:	jbe    1016033 <lyr_p1_reg_run+0x953>
 10157bc:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 10157c1:	add    rdx,QWORD PTR [r13+rax*8+0x0]
 10157c6:	jmp    1015739 <lyr_p1_reg_run+0x59>
 10157cb:	mov    r10,QWORD PTR [rsi+0x8]
 10157cf:	cmp    r10,rax
 10157d2:	jbe    101603e <lyr_p1_reg_run+0x95e>
 10157d8:	cmp    r10,rdx
 10157db:	jbe    1016049 <lyr_p1_reg_run+0x969>
 10157e1:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 10157e6:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 10157eb:	cmp    rax,rdx
 10157ee:	jb     1015f2d <lyr_p1_reg_run+0x84d>
 10157f4:	jmp    1015f2a <lyr_p1_reg_run+0x84a>
 10157f9:	mov    r10,QWORD PTR [rsi+0x8]
 10157fd:	cmp    r10,r9
 1015800:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015806:	cmp    r10,rax
 1015809:	jbe    101603e <lyr_p1_reg_run+0x95e>
 101580f:	mov    r9,QWORD PTR [r13+r9*8+0x0]
 1015814:	cmp    r9,QWORD PTR [r13+rax*8+0x0]
 1015819:	je     1015740 <lyr_p1_reg_run+0x60>
 101581f:	jmp    1015ecb <lyr_p1_reg_run+0x7eb>
 1015824:	mov    r10,QWORD PTR [rsi+0x8]
 1015828:	cmp    r10,rax
 101582b:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015831:	cmp    r10,r9
 1015834:	jbe    1016033 <lyr_p1_reg_run+0x953>
 101583a:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 101583f:	xor    rax,rdx
 1015842:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015847:	jmp    1015740 <lyr_p1_reg_run+0x60>
 101584c:	mov    r10,QWORD PTR [rsi+0x8]
 1015850:	cmp    r10,rax
 1015853:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015859:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 101585e:	add    rax,rdx
 1015861:	mov    rdx,QWORD PTR [rcx+0x8]
 1015865:	cmp    rax,rdx
 1015868:	jae    1016054 <lyr_p1_reg_run+0x974>
 101586e:	cmp    r10,r9
 1015871:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015877:	mov    rax,QWORD PTR [rcx+rax*8+0x10]
 101587c:	jmp    1015f36 <lyr_p1_reg_run+0x856>
 1015881:	mov    rdx,QWORD PTR [rsi+0x8]
 1015885:	cmp    rdx,rax
 1015888:	jbe    1016054 <lyr_p1_reg_run+0x974>
 101588e:	cmp    rdx,r9
 1015891:	jbe    101606a <lyr_p1_reg_run+0x98a>
 1015897:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 101589c:	not    rax
 101589f:	mov    QWORD PTR [r13+r9*8+0x0],rax
 10158a4:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10158a9:	mov    r10,QWORD PTR [rsi+0x8]
 10158ad:	cmp    r10,r9
 10158b0:	jbe    1016033 <lyr_p1_reg_run+0x953>
 10158b6:	cmp    r10,rax
 10158b9:	jbe    101603e <lyr_p1_reg_run+0x95e>
 10158bf:	mov    r9,QWORD PTR [r13+r9*8+0x0]
 10158c4:	cmp    r9,QWORD PTR [r13+rax*8+0x0]
 10158c9:	jb     1015740 <lyr_p1_reg_run+0x60>
 10158cf:	jmp    1015ecb <lyr_p1_reg_run+0x7eb>
 10158d4:	mov    r10,QWORD PTR [rsi+0x8]
 10158d8:	cmp    r10,r9
 10158db:	jbe    1016033 <lyr_p1_reg_run+0x953>
 10158e1:	cmp    r10,rax
 10158e4:	jbe    101603e <lyr_p1_reg_run+0x95e>
 10158ea:	mov    r9,QWORD PTR [r13+r9*8+0x0]
 10158ef:	cmp    r9,QWORD PTR [r13+rax*8+0x0]
 10158f4:	jne    1015740 <lyr_p1_reg_run+0x60>
 10158fa:	jmp    1015ecb <lyr_p1_reg_run+0x7eb>
 10158ff:	mov    r10,QWORD PTR [rsi+0x8]
 1015903:	cmp    r10,rax
 1015906:	jbe    101603e <lyr_p1_reg_run+0x95e>
 101590c:	cmp    r10,rdx
 101590f:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015915:	mov    rbx,r11
 1015918:	mov    r11,QWORD PTR [r13+rdx*8+0x0]
 101591d:	test   r11,r11
 1015920:	je     1016080 <lyr_p1_reg_run+0x9a0>
 1015926:	cmp    r10,r9
 1015929:	jbe    1016033 <lyr_p1_reg_run+0x953>
 101592f:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015934:	mov    rdx,rax
 1015937:	or     rdx,r11
 101593a:	shr    rdx,0x20
 101593e:	je     1015f40 <lyr_p1_reg_run+0x860>
 1015944:	xor    edx,edx
 1015946:	div    r11
 1015949:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 101594e:	jmp    1015f56 <lyr_p1_reg_run+0x876>
 1015953:	mov    rdx,QWORD PTR [rsi+0x8]
 1015957:	cmp    rdx,rax
 101595a:	jbe    1016054 <lyr_p1_reg_run+0x974>
 1015960:	cmp    rdx,r9
 1015963:	jbe    101606a <lyr_p1_reg_run+0x98a>
 1015969:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 101596e:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015973:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015978:	mov    r10,QWORD PTR [rsi+0x8]
 101597c:	cmp    r10,rax
 101597f:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015985:	cmp    r10,r9
 1015988:	jbe    1016033 <lyr_p1_reg_run+0x953>
 101598e:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015993:	add    rax,rdx
 1015996:	mov    rdx,QWORD PTR [rcx+0x8]
 101599a:	cmp    rax,rdx
 101599d:	jae    1016054 <lyr_p1_reg_run+0x974>
 10159a3:	mov    rdx,QWORD PTR [r13+r9*8+0x0]
 10159a8:	mov    QWORD PTR [rcx+rax*8+0x10],rdx
 10159ad:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10159b2:	mov    r10,QWORD PTR [rsi+0x8]
 10159b6:	cmp    r10,rax
 10159b9:	jbe    101603e <lyr_p1_reg_run+0x95e>
 10159bf:	cmp    r10,r9
 10159c2:	ja     1015db7 <lyr_p1_reg_run+0x6d7>
 10159c8:	jmp    1016033 <lyr_p1_reg_run+0x953>
 10159cd:	mov    r10,QWORD PTR [rsi+0x8]
 10159d1:	cmp    r10,rax
 10159d4:	jbe    101603e <lyr_p1_reg_run+0x95e>
 10159da:	cmp    r10,rdx
 10159dd:	jbe    1016049 <lyr_p1_reg_run+0x969>
 10159e3:	cmp    r10,r9
 10159e6:	jbe    1016033 <lyr_p1_reg_run+0x953>
 10159ec:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 10159f1:	xor    rdx,QWORD PTR [r13+rax*8+0x0]
 10159f6:	jmp    1015739 <lyr_p1_reg_run+0x59>
 10159fb:	mov    r10,QWORD PTR [rsi+0x8]
 10159ff:	cmp    r10,rax
 1015a02:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015a08:	cmp    r10,r9
 1015a0b:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015a11:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015a16:	imul   rax,rdx
 1015a1a:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015a1f:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015a24:	mov    r10,QWORD PTR [rsi+0x8]
 1015a28:	cmp    r10,rax
 1015a2b:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015a31:	cmp    r10,rdx
 1015a34:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015a3a:	cmp    r10,r9
 1015a3d:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015a43:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015a48:	sub    rax,QWORD PTR [r13+rdx*8+0x0]
 1015a4d:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015a52:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015a57:	mov    r10,QWORD PTR [rsi+0x8]
 1015a5b:	cmp    r10,rax
 1015a5e:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015a64:	cmp    r10,r9
 1015a67:	ja     1015d46 <lyr_p1_reg_run+0x666>
 1015a6d:	jmp    1016033 <lyr_p1_reg_run+0x953>
 1015a72:	mov    r10,QWORD PTR [rsi+0x8]
 1015a76:	cmp    r10,rax
 1015a79:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015a7f:	cmp    r10,rdx
 1015a82:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015a88:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015a8d:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015a92:	jae    1015b8a <lyr_p1_reg_run+0x4aa>
 1015a98:	mov    eax,0x1
 1015a9d:	jmp    1015f2d <lyr_p1_reg_run+0x84d>
 1015aa2:	mov    r10,QWORD PTR [rsi+0x8]
 1015aa6:	cmp    r10,rax
 1015aa9:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015aaf:	cmp    r10,rdx
 1015ab2:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015ab8:	cmp    r10,r9
 1015abb:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015ac1:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 1015ac6:	imul   rdx,QWORD PTR [r13+rax*8+0x0]
 1015acc:	jmp    1015739 <lyr_p1_reg_run+0x59>
 1015ad1:	mov    r10,QWORD PTR [rsi+0x8]
 1015ad5:	cmp    r10,rax
 1015ad8:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015ade:	cmp    r10,r9
 1015ae1:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015ae7:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015aec:	add    rax,rdx
 1015aef:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015af4:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015af9:	mov    rdx,QWORD PTR [rsi+0x8]
 1015afd:	cmp    rdx,rax
 1015b00:	jbe    1016054 <lyr_p1_reg_run+0x974>
 1015b06:	cmp    rdx,r9
 1015b09:	jbe    101606a <lyr_p1_reg_run+0x98a>
 1015b0f:	xor    edx,edx
 1015b11:	sub    rdx,QWORD PTR [r13+rax*8+0x0]
 1015b16:	jmp    1015739 <lyr_p1_reg_run+0x59>
 1015b1b:	mov    rax,QWORD PTR [rsi+0x8]
 1015b1f:	cmp    rax,r9
 1015b22:	jbe    101605f <lyr_p1_reg_run+0x97f>
 1015b28:	cmp    QWORD PTR [r13+r9*8+0x0],0x0
 1015b2e:	jne    1015740 <lyr_p1_reg_run+0x60>
 1015b34:	jmp    1015ecb <lyr_p1_reg_run+0x7eb>
 1015b39:	mov    r10,QWORD PTR [rsi+0x8]
 1015b3d:	cmp    r10,r9
 1015b40:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015b46:	cmp    r10,rax
 1015b49:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015b4f:	mov    r9,QWORD PTR [r13+r9*8+0x0]
 1015b54:	cmp    r9,QWORD PTR [r13+rax*8+0x0]
 1015b59:	ja     1015740 <lyr_p1_reg_run+0x60>
 1015b5f:	jmp    1015ecb <lyr_p1_reg_run+0x7eb>
 1015b64:	mov    r10,QWORD PTR [rsi+0x8]
 1015b68:	cmp    r10,rax
 1015b6b:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015b71:	cmp    r10,rdx
 1015b74:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015b7a:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015b7f:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015b84:	jae    1015a98 <lyr_p1_reg_run+0x3b8>
 1015b8a:	cmp    r10,r9
 1015b8d:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015b93:	xor    eax,eax
 1015b95:	jmp    1015f36 <lyr_p1_reg_run+0x856>
 1015b9a:	mov    r10,QWORD PTR [rsi+0x8]
 1015b9e:	cmp    r10,rax
 1015ba1:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015ba7:	cmp    r10,rdx
 1015baa:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015bb0:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015bb5:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015bba:	je     1015a98 <lyr_p1_reg_run+0x3b8>
 1015bc0:	jmp    1015b8a <lyr_p1_reg_run+0x4aa>
 1015bc2:	mov    r10,QWORD PTR [rsi+0x8]
 1015bc6:	cmp    r10,rax
 1015bc9:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015bcf:	cmp    r10,rdx
 1015bd2:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015bd8:	cmp    r10,r9
 1015bdb:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015be1:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 1015be6:	and    rdx,QWORD PTR [r13+rax*8+0x0]
 1015beb:	jmp    1015739 <lyr_p1_reg_run+0x59>
 1015bf0:	mov    r10,QWORD PTR [rsi+0x8]
 1015bf4:	cmp    r10,rax
 1015bf7:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015bfd:	cmp    r10,rdx
 1015c00:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015c06:	mov    rbx,r11
 1015c09:	mov    r11,QWORD PTR [r13+rdx*8+0x0]
 1015c0e:	test   r11,r11
 1015c11:	je     1016080 <lyr_p1_reg_run+0x9a0>
 1015c17:	cmp    r10,r9
 1015c1a:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015c20:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015c25:	mov    rdx,rax
 1015c28:	or     rdx,r11
 1015c2b:	shr    rdx,0x20
 1015c2f:	je     1015f4c <lyr_p1_reg_run+0x86c>
 1015c35:	xor    edx,edx
 1015c37:	div    r11
 1015c3a:	jmp    1015f51 <lyr_p1_reg_run+0x871>
 1015c3f:	mov    rax,QWORD PTR [rsi+0x8]
 1015c43:	cmp    rax,r9
 1015c46:	jbe    101605f <lyr_p1_reg_run+0x97f>
 1015c4c:	dec    QWORD PTR [r13+r9*8+0x0]
 1015c51:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015c56:	dec    r11
 1015c59:	jo     1016085 <lyr_p1_reg_run+0x9a5>
 1015c5f:	mov    rax,QWORD PTR [r8+0x8]
 1015c63:	cmp    r11,rax
 1015c66:	jae    1016075 <lyr_p1_reg_run+0x995>
 1015c6c:	mov    r12,QWORD PTR [r8+r11*8+0x10]
 1015c71:	jmp    1015749 <lyr_p1_reg_run+0x69>
 1015c76:	mov    r10,QWORD PTR [rsi+0x8]
 1015c7a:	cmp    r10,rax
 1015c7d:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015c83:	cmp    r10,r9
 1015c86:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015c8c:	mov    eax,DWORD PTR [r13+rax*8+0x0]
 1015c91:	and    eax,edx
 1015c93:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015c98:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015c9d:	mov    r10,QWORD PTR [rsi+0x8]
 1015ca1:	cmp    r10,r9
 1015ca4:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015caa:	cmp    r10,rax
 1015cad:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015cb3:	mov    r9,QWORD PTR [r13+r9*8+0x0]
 1015cb8:	cmp    r9,QWORD PTR [r13+rax*8+0x0]
 1015cbd:	jae    1015740 <lyr_p1_reg_run+0x60>
 1015cc3:	jmp    1015ecb <lyr_p1_reg_run+0x7eb>
 1015cc8:	mov    r10,QWORD PTR [rsi+0x8]
 1015ccc:	cmp    r10,rax
 1015ccf:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015cd5:	cmp    r10,r9
 1015cd8:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015cde:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015ce3:	sub    rax,rdx
 1015ce6:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015ceb:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015cf0:	mov    rdx,QWORD PTR [rbp-0x50]
 1015cf4:	mov    rdx,QWORD PTR [rdx+0x8]
 1015cf8:	cmp    rdx,rax
 1015cfb:	jbe    1016054 <lyr_p1_reg_run+0x974>
 1015d01:	mov    rdx,QWORD PTR [rsi+0x8]
 1015d05:	cmp    rdx,r9
 1015d08:	jbe    101606a <lyr_p1_reg_run+0x98a>
 1015d0e:	mov    rdx,QWORD PTR [rbp-0x50]
 1015d12:	mov    rax,QWORD PTR [rdx+rax*8+0x10]
 1015d17:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015d1c:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015d21:	mov    r10,QWORD PTR [rsi+0x8]
 1015d25:	cmp    r10,rax
 1015d28:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015d2e:	cmp    r10,rdx
 1015d31:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015d37:	cmp    r10,r9
 1015d3a:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015d40:	movzx  edx,BYTE PTR [r13+rdx*8+0x0]
 1015d46:	shlx   rax,QWORD PTR [r13+rax*8+0x0],rdx
 1015d4d:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015d52:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015d57:	mov    r10,QWORD PTR [rsi+0x8]
 1015d5b:	cmp    r10,rax
 1015d5e:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015d64:	cmp    r10,rdx
 1015d67:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015d6d:	cmp    r10,r9
 1015d70:	ja     101572f <lyr_p1_reg_run+0x4f>
 1015d76:	jmp    1016033 <lyr_p1_reg_run+0x953>
 1015d7b:	mov    rax,QWORD PTR [rsi+0x8]
 1015d7f:	cmp    rax,r9
 1015d82:	jbe    101605f <lyr_p1_reg_run+0x97f>
 1015d88:	inc    QWORD PTR [r13+r9*8+0x0]
 1015d8d:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015d92:	mov    r10,QWORD PTR [rsi+0x8]
 1015d96:	cmp    r10,rax
 1015d99:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015d9f:	cmp    r10,rdx
 1015da2:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015da8:	cmp    r10,r9
 1015dab:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015db1:	movzx  edx,BYTE PTR [r13+rdx*8+0x0]
 1015db7:	shrx   rax,QWORD PTR [r13+rax*8+0x0],rdx
 1015dbe:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015dc3:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015dc8:	mov    r10,QWORD PTR [rsi+0x8]
 1015dcc:	cmp    r10,rax
 1015dcf:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015dd5:	cmp    r10,rdx
 1015dd8:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015dde:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015de3:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015de8:	jne    1015a98 <lyr_p1_reg_run+0x3b8>
 1015dee:	jmp    1015b8a <lyr_p1_reg_run+0x4aa>
 1015df3:	mov    r10,QWORD PTR [rsi+0x8]
 1015df7:	cmp    r10,rax
 1015dfa:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015e00:	cmp    r10,r9
 1015e03:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015e09:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015e0e:	or     rax,rdx
 1015e11:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015e16:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015e1b:	inc    r12
 1015e1e:	jo     101600a <lyr_p1_reg_run+0x92a>
 1015e24:	mov    rax,QWORD PTR [r8+0x8]
 1015e28:	cmp    r11,rax
 1015e2b:	jae    1016075 <lyr_p1_reg_run+0x995>
 1015e31:	mov    QWORD PTR [r8+r11*8+0x10],r12
 1015e36:	inc    r11
 1015e39:	jno    1015ecb <lyr_p1_reg_run+0x7eb>
 1015e3f:	jmp    101600a <lyr_p1_reg_run+0x92a>
 1015e44:	mov    r10,QWORD PTR [rsi+0x8]
 1015e48:	cmp    r10,r9
 1015e4b:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015e51:	shl    edx,0x10
 1015e54:	or     rdx,rax
 1015e57:	jmp    1015739 <lyr_p1_reg_run+0x59>
 1015e5c:	mov    r10,QWORD PTR [rsi+0x8]
 1015e60:	cmp    r10,rax
 1015e63:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015e69:	cmp    r10,rdx
 1015e6c:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015e72:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015e77:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015e7c:	jbe    1015a98 <lyr_p1_reg_run+0x3b8>
 1015e82:	jmp    1015b8a <lyr_p1_reg_run+0x4aa>
 1015e87:	mov    r10,QWORD PTR [rsi+0x8]
 1015e8b:	cmp    r10,rax
 1015e8e:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015e94:	cmp    r10,rdx
 1015e97:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015e9d:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015ea2:	cmp    rax,QWORD PTR [r13+rdx*8+0x0]
 1015ea7:	ja     1015a98 <lyr_p1_reg_run+0x3b8>
 1015ead:	jmp    1015b8a <lyr_p1_reg_run+0x4aa>
 1015eb2:	mov    rax,QWORD PTR [rsi+0x8]
 1015eb6:	cmp    rax,r9
 1015eb9:	jbe    101605f <lyr_p1_reg_run+0x97f>
 1015ebf:	cmp    QWORD PTR [r13+r9*8+0x0],0x0
 1015ec5:	je     1015740 <lyr_p1_reg_run+0x60>
 1015ecb:	mov    r12,rdx
 1015ece:	jmp    1015749 <lyr_p1_reg_run+0x69>
 1015ed3:	mov    r10,QWORD PTR [rsi+0x8]
 1015ed7:	cmp    r10,rdx
 1015eda:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015ee0:	cmp    QWORD PTR [r13+rdx*8+0x0],0x0
 1015ee6:	je     1015740 <lyr_p1_reg_run+0x60>
 1015eec:	cmp    r10,rax
 1015eef:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015ef5:	cmp    r10,r9
 1015ef8:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015efe:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015f03:	jmp    1015f36 <lyr_p1_reg_run+0x856>
 1015f05:	mov    r10,QWORD PTR [rsi+0x8]
 1015f09:	cmp    r10,rax
 1015f0c:	jbe    101603e <lyr_p1_reg_run+0x95e>
 1015f12:	cmp    r10,rdx
 1015f15:	jbe    1016049 <lyr_p1_reg_run+0x969>
 1015f1b:	mov    rax,QWORD PTR [r13+rax*8+0x0]
 1015f20:	mov    rdx,QWORD PTR [r13+rdx*8+0x0]
 1015f25:	cmp    rax,rdx
 1015f28:	ja     1015f2d <lyr_p1_reg_run+0x84d>
 1015f2a:	mov    rax,rdx
 1015f2d:	cmp    r10,r9
 1015f30:	jbe    1016033 <lyr_p1_reg_run+0x953>
 1015f36:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015f3b:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015f40:	xor    edx,edx
 1015f42:	div    r11d
 1015f45:	mov    QWORD PTR [r13+r9*8+0x0],rdx
 1015f4a:	jmp    1015f56 <lyr_p1_reg_run+0x876>
 1015f4c:	xor    edx,edx
 1015f4e:	div    r11d
 1015f51:	mov    QWORD PTR [r13+r9*8+0x0],rax
 1015f56:	inc    r12
 1015f59:	jo     101600a <lyr_p1_reg_run+0x92a>
 1015f5f:	mov    r11,rbx
 1015f62:	lea    rbx,[rip+0xfffffffffffeb877]        # 10017e0 <__abi_tag+0x14e4>
 1015f69:	jmp    1015749 <lyr_p1_reg_run+0x69>
 1015f6e:	lea    rax,[rip+0x27713]        # 103d688 <lyr_gc_stop_requested>
 1015f75:	mov    eax,DWORD PTR [rax]
 1015f77:	mov    r15d,0x400
 1015f7d:	test   eax,eax
 1015f7f:	je     101575b <lyr_p1_reg_run+0x7b>
 1015f85:	mov    QWORD PTR [rbp-0x48],r8
 1015f89:	mov    QWORD PTR [rbp-0x38],rcx
 1015f8d:	mov    QWORD PTR [rbp-0x40],rsi
 1015f91:	mov    QWORD PTR [rbp-0x30],rdi
 1015f95:	mov    rbx,r11
 1015f98:	call   101a630 <lyr_gc_safepoint_slow>
 1015f9d:	mov    r11,rbx
 1015fa0:	lea    rbx,[rip+0xfffffffffffeb839]        # 10017e0 <__abi_tag+0x14e4>
 1015fa7:	mov    rdi,QWORD PTR [rbp-0x30]
 1015fab:	mov    rsi,QWORD PTR [rbp-0x40]
 1015faf:	mov    rcx,QWORD PTR [rbp-0x38]
 1015fb3:	mov    r8,QWORD PTR [rbp-0x48]
 1015fb7:	jmp    101575b <lyr_p1_reg_run+0x7b>
 1015fbc:	lea    rax,[rip+0x276c5]        # 103d688 <lyr_gc_stop_requested>
 1015fc3:	mov    eax,DWORD PTR [rax]
 1015fc5:	mov    r15d,0x400
 1015fcb:	test   eax,eax
 1015fcd:	je     1015752 <lyr_p1_reg_run+0x72>
 1015fd3:	mov    QWORD PTR [rbp-0x48],r8
 1015fd7:	mov    QWORD PTR [rbp-0x38],rcx
 1015fdb:	mov    QWORD PTR [rbp-0x40],rsi
 1015fdf:	mov    QWORD PTR [rbp-0x30],rdi
 1015fe3:	mov    rbx,r11
 1015fe6:	call   101a630 <lyr_gc_safepoint_slow>
 1015feb:	mov    r11,rbx
 1015fee:	lea    rbx,[rip+0xfffffffffffeb7eb]        # 10017e0 <__abi_tag+0x14e4>
 1015ff5:	mov    rdi,QWORD PTR [rbp-0x30]
 1015ff9:	mov    rsi,QWORD PTR [rbp-0x40]
 1015ffd:	mov    rcx,QWORD PTR [rbp-0x38]
 1016001:	mov    r8,QWORD PTR [rbp-0x48]
 1016005:	jmp    1015752 <lyr_p1_reg_run+0x72>
 101600a:	lea    rdi,[rip+0xfffffffffffeca1a]        # 1002a2b <lyr_refmap_ty_std_core_StringBuilder+0x1093>
 1016011:	call   10203a9 <lyr_panic_overflow>
 1016016:	mov    rax,r14
 1016019:	add    rsp,0x28
 101601d:	pop    rbx
 101601e:	pop    r12
 1016020:	pop    r13
 1016022:	pop    r14
 1016024:	pop    r15
 1016026:	pop    rbp
 1016027:	ret
 1016028:	mov    rdi,r12
 101602b:	mov    rsi,rax
 101602e:	call   1020368 <lyr_panic_index>
 1016033:	mov    rdi,r9
 1016036:	mov    rsi,r10
 1016039:	call   1020368 <lyr_panic_index>
 101603e:	mov    rdi,rax
 1016041:	mov    rsi,r10
 1016044:	call   1020368 <lyr_panic_index>
 1016049:	mov    rdi,rdx
 101604c:	mov    rsi,r10
 101604f:	call   1020368 <lyr_panic_index>
 1016054:	mov    rdi,rax
 1016057:	mov    rsi,rdx
 101605a:	call   1020368 <lyr_panic_index>
 101605f:	mov    rdi,r9
 1016062:	mov    rsi,rax
 1016065:	call   1020368 <lyr_panic_index>
 101606a:	mov    rdi,r9
 101606d:	mov    rsi,rdx
 1016070:	call   1020368 <lyr_panic_index>
 1016075:	mov    rdi,r11
 1016078:	mov    rsi,rax
 101607b:	call   1020368 <lyr_panic_index>
 1016080:	call   10203c5 <lyr_panic_division_by_zero>
 1016085:	lea    rdi,[rip+0xfffffffffffec99d]        # 1002a29 <lyr_refmap_ty_std_core_StringBuilder+0x1091>
 101608c:	call   10203a9 <lyr_panic_overflow>
 1016091:	mov    rbx,rdi
 1016094:	mov    rdi,rax
 1016097:	mov    r14,r8
 101609a:	mov    r12,rcx
 101609d:	mov    r15,rsi
 10160a0:	call   101a6a0 <lyr_gc_stack_slow>
 10160a5:	mov    rdi,rbx
 10160a8:	mov    rsi,r15
 10160ab:	mov    rcx,r12
 10160ae:	mov    r8,r14
 10160b1:	jmp    1015713 <lyr_p1_reg_run+0x33>
 10160b6:	lea    rdi,[rip+0x21b33]        # 1037bf0 <lyr_lit0>
 10160bd:	call   10203fb <lyr_panic_message>
 10160c2:	ud2
 10160c4:	int3
 10160c5:	int3
 10160c6:	int3
 10160c7:	int3
 10160c8:	int3
 10160c9:	int3
 10160ca:	int3
 10160cb:	int3
 10160cc:	int3
 10160cd:	int3
 10160ce:	int3
 10160cf:	int3
