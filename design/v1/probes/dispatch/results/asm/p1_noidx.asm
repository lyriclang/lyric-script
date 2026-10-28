00000000010156e0 <lyr_p1_reg_run>:
 10156e0:	push   rbp
 10156e1:	mov    rbp,rsp
 10156e4:	push   r15
 10156e6:	push   r14
 10156e8:	push   r13
 10156ea:	push   r12
 10156ec:	push   rbx
 10156ed:	sub    rsp,0x28
 10156f1:	mov    r11,rdx
 10156f4:	mov    rax,rbp
 10156f7:	add    rax,0xffffffffffffad20
 10156fd:	mov    rdx,0xffffffffffffffe0
 1015704:	mov    rdx,QWORD PTR fs:[rdx+0x10]
 1015709:	cmp    rax,rdx
 101570c:	jb     1015b54 <lyr_p1_reg_run+0x474>
 1015712:	add    rsi,0x10
 1015716:	add    rcx,0x10
 101571a:	mov    r13d,0x400
 1015720:	xor    r14d,r14d
 1015723:	lea    r12,[rip+0xfffffffffffec0b6]        # 10017e0 <__abi_tag+0x14e4>
 101572a:	xor    r15d,r15d
 101572d:	xor    ebx,ebx
 101572f:	jmp    1015756 <lyr_p1_reg_run+0x76>
 1015731:	cmp    QWORD PTR [rsi+rax*8],0x0
 1015736:	je     1015744 <lyr_p1_reg_run+0x64>
 1015738:	mov    rax,QWORD PTR [rsi+rdx*8]
 101573c:	nop    DWORD PTR [rax+0x0]
 1015740:	mov    QWORD PTR [rsi+r9*8],rax
 1015744:	inc    rbx
 1015747:	jo     1015b25 <lyr_p1_reg_run+0x445>
 101574d:	dec    r13d
 1015750:	je     1015adc <lyr_p1_reg_run+0x3fc>
 1015756:	dec    r13d
 1015759:	je     1015a93 <lyr_p1_reg_run+0x3b3>
 101575f:	inc    r14
 1015762:	jo     1015b25 <lyr_p1_reg_run+0x445>
 1015768:	movzx  r10d,BYTE PTR [rdi+rbx*8+0x10]
 101576e:	cmp    r10,0x2f
 1015772:	ja     1015b7f <lyr_p1_reg_run+0x49f>
 1015778:	movzx  r9d,WORD PTR [rdi+rbx*8+0x12]
 101577e:	movzx  edx,WORD PTR [rdi+rbx*8+0x14]
 1015783:	movzx  eax,WORD PTR [rdi+rbx*8+0x16]
 1015788:	movsxd r10,DWORD PTR [r12+r10*4]
 101578c:	add    r10,r12
 101578f:	jmp    r10
 1015792:	mov    rax,QWORD PTR [rsi+rax*8]
 1015796:	add    rax,QWORD PTR [rsi+rdx*8]
 101579a:	jmp    1015740 <lyr_p1_reg_run+0x60>
 101579c:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10157a0:	mov    rax,QWORD PTR [rsi+rax*8]
 10157a4:	cmp    rdx,rax
 10157a7:	cmovb  rax,rdx
 10157ab:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10157ad:	mov    r9,QWORD PTR [rsi+r9*8]
 10157b1:	cmp    r9,QWORD PTR [rsi+rdx*8]
 10157b5:	je     1015744 <lyr_p1_reg_run+0x64>
 10157b7:	jmp    1015a5f <lyr_p1_reg_run+0x37f>
 10157bc:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10157c0:	imul   rdx,rax
 10157c4:	mov    QWORD PTR [rsi+r9*8],rdx
 10157c8:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10157cd:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10157d1:	lea    rdx,[rcx+rdx*8]
 10157d5:	mov    rax,QWORD PTR [rdx+rax*8]
 10157d9:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10157de:	movzx  eax,BYTE PTR [rsi+rax*8]
 10157e2:	shrx   rax,QWORD PTR [rsi+rdx*8],rax
 10157e8:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10157ed:	mov    r9,QWORD PTR [rsi+r9*8]
 10157f1:	cmp    r9,QWORD PTR [rsi+rdx*8]
 10157f5:	jb     1015744 <lyr_p1_reg_run+0x64>
 10157fb:	jmp    1015a5f <lyr_p1_reg_run+0x37f>
 1015800:	mov    r9,QWORD PTR [rsi+r9*8]
 1015804:	cmp    r9,QWORD PTR [rsi+rdx*8]
 1015808:	jne    1015744 <lyr_p1_reg_run+0x64>
 101580e:	jmp    1015a5f <lyr_p1_reg_run+0x37f>
 1015813:	mov    r10,QWORD PTR [rsi+rax*8]
 1015817:	test   r10,r10
 101581a:	je     1015b43 <lyr_p1_reg_run+0x463>
 1015820:	mov    rax,QWORD PTR [rsi+rdx*8]
 1015824:	mov    rdx,rax
 1015827:	or     rdx,r10
 101582a:	shr    rdx,0x20
 101582e:	je     1015a7b <lyr_p1_reg_run+0x39b>
 1015834:	xor    edx,edx
 1015836:	div    r10
 1015839:	mov    QWORD PTR [rsi+r9*8],rdx
 101583d:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015842:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015846:	mov    r9,QWORD PTR [rsi+r9*8]
 101584a:	lea    rdx,[rcx+rdx*8]
 101584e:	mov    QWORD PTR [rdx+rax*8],r9
 1015852:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015857:	mov    rdx,QWORD PTR [rsi+rdx*8]
 101585b:	xor    rdx,rax
 101585e:	mov    QWORD PTR [rsi+r9*8],rdx
 1015862:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015867:	mov    rax,QWORD PTR [rsi+rax*8]
 101586b:	xor    rax,QWORD PTR [rsi+rdx*8]
 101586f:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015874:	mov    rax,QWORD PTR [rsi+rdx*8]
 1015878:	not    rax
 101587b:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015880:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015884:	sub    rdx,QWORD PTR [rsi+rax*8]
 1015888:	mov    QWORD PTR [rsi+r9*8],rdx
 101588c:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015891:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015895:	or     rdx,rax
 1015898:	mov    QWORD PTR [rsi+r9*8],rdx
 101589c:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10158a1:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10158a5:	xor    r10d,r10d
 10158a8:	cmp    rdx,QWORD PTR [rsi+rax*8]
 10158ac:	setb   r10b
 10158b0:	mov    QWORD PTR [rsi+r9*8],r10
 10158b4:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10158b9:	mov    rax,QWORD PTR [rsi+rax*8]
 10158bd:	imul   rax,QWORD PTR [rsi+rdx*8]
 10158c2:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10158c7:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10158cb:	add    rdx,rax
 10158ce:	mov    QWORD PTR [rsi+r9*8],rdx
 10158d2:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10158d7:	cmp    QWORD PTR [rsi+r9*8],0x0
 10158dc:	jne    1015744 <lyr_p1_reg_run+0x64>
 10158e2:	jmp    1015a5f <lyr_p1_reg_run+0x37f>
 10158e7:	mov    r9,QWORD PTR [rsi+r9*8]
 10158eb:	cmp    r9,QWORD PTR [rsi+rdx*8]
 10158ef:	ja     1015744 <lyr_p1_reg_run+0x64>
 10158f5:	jmp    1015a5f <lyr_p1_reg_run+0x37f>
 10158fa:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10158fe:	xor    r10d,r10d
 1015901:	cmp    rdx,QWORD PTR [rsi+rax*8]
 1015905:	setae  r10b
 1015909:	mov    QWORD PTR [rsi+r9*8],r10
 101590d:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015912:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015916:	xor    r10d,r10d
 1015919:	cmp    rdx,QWORD PTR [rsi+rax*8]
 101591d:	sete   r10b
 1015921:	mov    QWORD PTR [rsi+r9*8],r10
 1015925:	jmp    1015744 <lyr_p1_reg_run+0x64>
 101592a:	mov    rax,QWORD PTR [rsi+rax*8]
 101592e:	and    rax,QWORD PTR [rsi+rdx*8]
 1015932:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015937:	mov    r10,QWORD PTR [rsi+rax*8]
 101593b:	test   r10,r10
 101593e:	je     1015b43 <lyr_p1_reg_run+0x463>
 1015944:	mov    rax,QWORD PTR [rsi+rdx*8]
 1015948:	mov    rdx,rax
 101594b:	or     rdx,r10
 101594e:	shr    rdx,0x20
 1015952:	je     1015a89 <lyr_p1_reg_run+0x3a9>
 1015958:	xor    edx,edx
 101595a:	div    r10
 101595d:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015962:	dec    QWORD PTR [rsi+r9*8]
 1015966:	jmp    1015744 <lyr_p1_reg_run+0x64>
 101596b:	dec    r15
 101596e:	jo     1015b48 <lyr_p1_reg_run+0x468>
 1015974:	mov    rbx,QWORD PTR [r8+r15*8+0x10]
 1015979:	jmp    101574d <lyr_p1_reg_run+0x6d>
 101597e:	mov    edx,DWORD PTR [rsi+rdx*8]
 1015981:	and    edx,eax
 1015983:	mov    QWORD PTR [rsi+r9*8],rdx
 1015987:	jmp    1015744 <lyr_p1_reg_run+0x64>
 101598c:	mov    r9,QWORD PTR [rsi+r9*8]
 1015990:	cmp    r9,QWORD PTR [rsi+rdx*8]
 1015994:	jae    1015744 <lyr_p1_reg_run+0x64>
 101599a:	jmp    1015a5f <lyr_p1_reg_run+0x37f>
 101599f:	xor    eax,eax
 10159a1:	sub    rax,QWORD PTR [rsi+rdx*8]
 10159a5:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10159aa:	mov    rax,QWORD PTR [r11+rdx*8+0x10]
 10159af:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10159b4:	mov    rax,QWORD PTR [rsi+rax*8]
 10159b8:	or     rax,QWORD PTR [rsi+rdx*8]
 10159bc:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10159c1:	inc    QWORD PTR [rsi+r9*8]
 10159c5:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10159ca:	movzx  eax,BYTE PTR [rsi+rax*8]
 10159ce:	shlx   rax,QWORD PTR [rsi+rdx*8],rax
 10159d4:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10159d9:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10159dd:	xor    r10d,r10d
 10159e0:	cmp    rdx,QWORD PTR [rsi+rax*8]
 10159e4:	setne  r10b
 10159e8:	mov    QWORD PTR [rsi+r9*8],r10
 10159ec:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10159f1:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10159f5:	sub    rdx,rax
 10159f8:	mov    QWORD PTR [rsi+r9*8],rdx
 10159fc:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015a01:	inc    rbx
 1015a04:	jo     1015b25 <lyr_p1_reg_run+0x445>
 1015a0a:	mov    QWORD PTR [r8+r15*8+0x10],rbx
 1015a0f:	inc    r15
 1015a12:	jno    1015a5f <lyr_p1_reg_run+0x37f>
 1015a14:	jmp    1015b25 <lyr_p1_reg_run+0x445>
 1015a19:	shl    eax,0x10
 1015a1c:	or     rax,rdx
 1015a1f:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015a24:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015a28:	xor    r10d,r10d
 1015a2b:	cmp    rdx,QWORD PTR [rsi+rax*8]
 1015a2f:	setbe  r10b
 1015a33:	mov    QWORD PTR [rsi+r9*8],r10
 1015a37:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015a3c:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015a40:	xor    r10d,r10d
 1015a43:	cmp    rdx,QWORD PTR [rsi+rax*8]
 1015a47:	seta   r10b
 1015a4b:	mov    QWORD PTR [rsi+r9*8],r10
 1015a4f:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015a54:	cmp    QWORD PTR [rsi+r9*8],0x0
 1015a59:	je     1015744 <lyr_p1_reg_run+0x64>
 1015a5f:	mov    rbx,rax
 1015a62:	jmp    101574d <lyr_p1_reg_run+0x6d>
 1015a67:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015a6b:	mov    rax,QWORD PTR [rsi+rax*8]
 1015a6f:	cmp    rdx,rax
 1015a72:	cmova  rax,rdx
 1015a76:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015a7b:	xor    edx,edx
 1015a7d:	div    r10d
 1015a80:	mov    QWORD PTR [rsi+r9*8],rdx
 1015a84:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015a89:	xor    edx,edx
 1015a8b:	div    r10d
 1015a8e:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015a93:	lea    rax,[rip+0x2779e]        # 103d238 <lyr_gc_stop_requested>
 1015a9a:	mov    eax,DWORD PTR [rax]
 1015a9c:	mov    r13d,0x400
 1015aa2:	test   eax,eax
 1015aa4:	je     101575f <lyr_p1_reg_run+0x7f>
 1015aaa:	mov    QWORD PTR [rbp-0x50],r8
 1015aae:	mov    QWORD PTR [rbp-0x40],rcx
 1015ab2:	mov    QWORD PTR [rbp-0x48],rsi
 1015ab6:	mov    QWORD PTR [rbp-0x38],rdi
 1015aba:	mov    QWORD PTR [rbp-0x30],r11
 1015abe:	call   101a1e0 <lyr_gc_safepoint_slow>
 1015ac3:	mov    r11,QWORD PTR [rbp-0x30]
 1015ac7:	mov    rdi,QWORD PTR [rbp-0x38]
 1015acb:	mov    rsi,QWORD PTR [rbp-0x48]
 1015acf:	mov    rcx,QWORD PTR [rbp-0x40]
 1015ad3:	mov    r8,QWORD PTR [rbp-0x50]
 1015ad7:	jmp    101575f <lyr_p1_reg_run+0x7f>
 1015adc:	lea    rax,[rip+0x27755]        # 103d238 <lyr_gc_stop_requested>
 1015ae3:	mov    eax,DWORD PTR [rax]
 1015ae5:	mov    r13d,0x400
 1015aeb:	test   eax,eax
 1015aed:	je     1015756 <lyr_p1_reg_run+0x76>
 1015af3:	mov    QWORD PTR [rbp-0x50],r8
 1015af7:	mov    QWORD PTR [rbp-0x40],rcx
 1015afb:	mov    QWORD PTR [rbp-0x48],rsi
 1015aff:	mov    QWORD PTR [rbp-0x38],rdi
 1015b03:	mov    QWORD PTR [rbp-0x30],r11
 1015b07:	call   101a1e0 <lyr_gc_safepoint_slow>
 1015b0c:	mov    r11,QWORD PTR [rbp-0x30]
 1015b10:	mov    rdi,QWORD PTR [rbp-0x38]
 1015b14:	mov    rsi,QWORD PTR [rbp-0x48]
 1015b18:	mov    rcx,QWORD PTR [rbp-0x40]
 1015b1c:	mov    r8,QWORD PTR [rbp-0x50]
 1015b20:	jmp    1015756 <lyr_p1_reg_run+0x76>
 1015b25:	lea    rdi,[rip+0xfffffffffffeceff]        # 1002a2b <lyr_refmap_ty_std_core_StringBuilder+0x1093>
 1015b2c:	call   101ff59 <lyr_panic_overflow>
 1015b31:	mov    rax,r14
 1015b34:	add    rsp,0x28
 1015b38:	pop    rbx
 1015b39:	pop    r12
 1015b3b:	pop    r13
 1015b3d:	pop    r14
 1015b3f:	pop    r15
 1015b41:	pop    rbp
 1015b42:	ret
 1015b43:	call   101ff75 <lyr_panic_division_by_zero>
 1015b48:	lea    rdi,[rip+0xfffffffffffeceda]        # 1002a29 <lyr_refmap_ty_std_core_StringBuilder+0x1091>
 1015b4f:	call   101ff59 <lyr_panic_overflow>
 1015b54:	mov    rbx,rdi
 1015b57:	mov    rdi,rax
 1015b5a:	mov    r14,r8
 1015b5d:	mov    r12,rcx
 1015b60:	mov    r15,rsi
 1015b63:	mov    r13,r11
 1015b66:	call   101a250 <lyr_gc_stack_slow>
 1015b6b:	mov    r11,r13
 1015b6e:	mov    rdi,rbx
 1015b71:	mov    rsi,r15
 1015b74:	mov    rcx,r12
 1015b77:	mov    r8,r14
 1015b7a:	jmp    1015712 <lyr_p1_reg_run+0x32>
 1015b7f:	lea    rdi,[rip+0x21c1a]        # 10377a0 <lyr_lit0>
 1015b86:	call   101ffab <lyr_panic_message>
 1015b8b:	ud2
 1015b8d:	int3
 1015b8e:	int3
 1015b8f:	int3
