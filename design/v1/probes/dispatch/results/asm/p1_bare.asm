00000000010156e0 <lyr_p1_reg_run>:
 10156e0:	push   rbp
 10156e1:	mov    rbp,rsp
 10156e4:	push   r15
 10156e6:	push   r14
 10156e8:	push   r13
 10156ea:	push   r12
 10156ec:	push   rbx
 10156ed:	push   rax
 10156ee:	mov    rbx,rdx
 10156f1:	mov    rax,rbp
 10156f4:	add    rax,0xffffffffffffad20
 10156fa:	mov    rdx,0xffffffffffffffe0
 1015701:	mov    rdx,QWORD PTR fs:[rdx+0x10]
 1015706:	cmp    rax,rdx
 1015709:	jb     1015aa1 <lyr_p1_reg_run+0x3c1>
 101570f:	add    rsi,0x10
 1015713:	add    rcx,0x10
 1015717:	mov    r9d,0x1
 101571d:	xor    r10d,r10d
 1015720:	lea    r11,[rip+0xfffffffffffec161]        # 1001888 <__abi_tag+0x158c>
 1015727:	lea    r14,[rip+0xfffffffffffec0b2]        # 10017e0 <__abi_tag+0x14e4>
 101572e:	xor    r15d,r15d
 1015731:	jmp    1015750 <lyr_p1_reg_run+0x70>
 1015733:	movzx  eax,BYTE PTR [rsi+rax*8]
 1015737:	shrx   rax,QWORD PTR [rsi+rdx*8],rax
 101573d:	nop    DWORD PTR [rax]
 1015740:	mov    QWORD PTR [rsi+r12*8],rax
 1015744:	inc    r15
 1015747:	mov    rax,r15
 101574a:	inc    r9
 101574d:	mov    r15,rax
 1015750:	movzx  r13d,BYTE PTR [rdi+r15*8+0x10]
 1015756:	movzx  r12d,WORD PTR [rdi+r15*8+0x12]
 101575c:	movzx  edx,WORD PTR [rdi+r15*8+0x14]
 1015762:	movzx  eax,WORD PTR [rdi+r15*8+0x16]
 1015768:	cmp    r13,0x29
 101576c:	ja     10159e1 <lyr_p1_reg_run+0x301>
 1015772:	movsxd r13,DWORD PTR [r14+r13*4]
 1015776:	add    r13,r14
 1015779:	jmp    r13
 101577c:	mov    rax,QWORD PTR [rsi+rax*8]
 1015780:	add    rax,QWORD PTR [rsi+rdx*8]
 1015784:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015786:	mov    rdx,QWORD PTR [rsi+rdx*8]
 101578a:	mov    rax,QWORD PTR [rsi+rax*8]
 101578e:	cmp    rdx,rax
 1015791:	cmovb  rax,rdx
 1015795:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015797:	mov    r12,QWORD PTR [rsi+r12*8]
 101579b:	cmp    r12,QWORD PTR [rsi+rdx*8]
 101579f:	je     1015744 <lyr_p1_reg_run+0x64>
 10157a1:	jmp    101574a <lyr_p1_reg_run+0x6a>
 10157a3:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10157a7:	sub    rdx,rax
 10157aa:	mov    QWORD PTR [rsi+r12*8],rdx
 10157ae:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10157b0:	mov    r12,QWORD PTR [rsi+r12*8]
 10157b4:	cmp    r12,QWORD PTR [rsi+rdx*8]
 10157b8:	jb     1015744 <lyr_p1_reg_run+0x64>
 10157ba:	jmp    101574a <lyr_p1_reg_run+0x6a>
 10157bc:	mov    r12,QWORD PTR [rsi+r12*8]
 10157c0:	cmp    r12,QWORD PTR [rsi+rdx*8]
 10157c4:	jne    1015744 <lyr_p1_reg_run+0x64>
 10157ca:	jmp    101574a <lyr_p1_reg_run+0x6a>
 10157cf:	mov    r13,QWORD PTR [rsi+rax*8]
 10157d3:	test   r13,r13
 10157d6:	je     1015a90 <lyr_p1_reg_run+0x3b0>
 10157dc:	mov    rax,QWORD PTR [rsi+rdx*8]
 10157e0:	mov    rdx,rax
 10157e3:	or     rdx,r13
 10157e6:	shr    rdx,0x20
 10157ea:	je     1015a0d <lyr_p1_reg_run+0x32d>
 10157f0:	xor    edx,edx
 10157f2:	div    r13
 10157f5:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10157fa:	mov    rax,QWORD PTR [rsi+rax*8]
 10157fe:	imul   rax,QWORD PTR [rsi+rdx*8]
 1015803:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015808:	mov    rdx,QWORD PTR [rsi+rdx*8]
 101580c:	or     rdx,rax
 101580f:	mov    QWORD PTR [rsi+r12*8],rdx
 1015813:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015818:	mov    r12,QWORD PTR [rsi+r12*8]
 101581c:	cmp    r12,QWORD PTR [rsi+rdx*8]
 1015820:	jae    1015744 <lyr_p1_reg_run+0x64>
 1015826:	jmp    101574a <lyr_p1_reg_run+0x6a>
 101582b:	xor    eax,eax
 101582d:	sub    rax,QWORD PTR [rsi+rdx*8]
 1015831:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015836:	mov    rdx,QWORD PTR [rsi+rdx*8]
 101583a:	sub    rdx,QWORD PTR [rsi+rax*8]
 101583e:	mov    QWORD PTR [rsi+r12*8],rdx
 1015842:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015847:	mov    edx,DWORD PTR [rsi+rdx*8]
 101584a:	and    edx,eax
 101584c:	mov    QWORD PTR [rsi+r12*8],rdx
 1015850:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015855:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015859:	imul   rdx,rax
 101585d:	mov    QWORD PTR [rsi+r12*8],rdx
 1015861:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015866:	mov    rdx,QWORD PTR [rsi+rdx*8]
 101586a:	xor    r13d,r13d
 101586d:	cmp    rdx,QWORD PTR [rsi+rax*8]
 1015871:	setne  r13b
 1015875:	mov    QWORD PTR [rsi+r12*8],r13
 1015879:	jmp    1015744 <lyr_p1_reg_run+0x64>
 101587e:	movzx  eax,BYTE PTR [rsi+rax*8]
 1015882:	shlx   rax,QWORD PTR [rsi+rdx*8],rax
 1015888:	jmp    1015740 <lyr_p1_reg_run+0x60>
 101588d:	cmp    QWORD PTR [rsi+r12*8],0x0
 1015892:	jne    1015744 <lyr_p1_reg_run+0x64>
 1015898:	jmp    101574a <lyr_p1_reg_run+0x6a>
 101589d:	mov    r12,QWORD PTR [rsi+r12*8]
 10158a1:	cmp    r12,QWORD PTR [rsi+rdx*8]
 10158a5:	ja     1015744 <lyr_p1_reg_run+0x64>
 10158ab:	jmp    101574a <lyr_p1_reg_run+0x6a>
 10158b0:	mov    rax,QWORD PTR [rsi+rax*8]
 10158b4:	xor    rax,QWORD PTR [rsi+rdx*8]
 10158b8:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10158bd:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10158c1:	xor    r13d,r13d
 10158c4:	cmp    rdx,QWORD PTR [rsi+rax*8]
 10158c8:	seta   r13b
 10158cc:	mov    QWORD PTR [rsi+r12*8],r13
 10158d0:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10158d5:	mov    rax,QWORD PTR [rsi+rax*8]
 10158d9:	and    rax,QWORD PTR [rsi+rdx*8]
 10158dd:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10158e2:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10158e6:	add    rdx,rax
 10158e9:	mov    QWORD PTR [rsi+r12*8],rdx
 10158ed:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10158f2:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10158f6:	xor    rdx,rax
 10158f9:	mov    QWORD PTR [rsi+r12*8],rdx
 10158fd:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015902:	mov    rax,QWORD PTR [rbx+rdx*8+0x10]
 1015907:	jmp    1015740 <lyr_p1_reg_run+0x60>
 101590c:	dec    QWORD PTR [rsi+r12*8]
 1015910:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015915:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015919:	xor    r13d,r13d
 101591c:	cmp    rdx,QWORD PTR [rsi+rax*8]
 1015920:	setae  r13b
 1015924:	mov    QWORD PTR [rsi+r12*8],r13
 1015928:	jmp    1015744 <lyr_p1_reg_run+0x64>
 101592d:	shl    eax,0x10
 1015930:	or     rax,rdx
 1015933:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015938:	mov    rax,QWORD PTR [rsi+rax*8]
 101593c:	or     rax,QWORD PTR [rsi+rdx*8]
 1015940:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015945:	mov    r13,QWORD PTR [rsi+rax*8]
 1015949:	test   r13,r13
 101594c:	je     1015a90 <lyr_p1_reg_run+0x3b0>
 1015952:	mov    rax,QWORD PTR [rsi+rdx*8]
 1015956:	mov    rdx,rax
 1015959:	or     rdx,r13
 101595c:	shr    rdx,0x20
 1015960:	je     1015a17 <lyr_p1_reg_run+0x337>
 1015966:	xor    edx,edx
 1015968:	div    r13
 101596b:	mov    QWORD PTR [rsi+r12*8],rdx
 101596f:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015974:	inc    QWORD PTR [rsi+r12*8]
 1015978:	jmp    1015744 <lyr_p1_reg_run+0x64>
 101597d:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015981:	xor    r13d,r13d
 1015984:	cmp    rdx,QWORD PTR [rsi+rax*8]
 1015988:	sete   r13b
 101598c:	mov    QWORD PTR [rsi+r12*8],r13
 1015990:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015995:	mov    rax,QWORD PTR [rsi+rdx*8]
 1015999:	not    rax
 101599c:	jmp    1015740 <lyr_p1_reg_run+0x60>
 10159a1:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10159a5:	xor    r13d,r13d
 10159a8:	cmp    rdx,QWORD PTR [rsi+rax*8]
 10159ac:	setb   r13b
 10159b0:	mov    QWORD PTR [rsi+r12*8],r13
 10159b4:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10159b9:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10159bd:	xor    r13d,r13d
 10159c0:	cmp    rdx,QWORD PTR [rsi+rax*8]
 10159c4:	setbe  r13b
 10159c8:	mov    QWORD PTR [rsi+r12*8],r13
 10159cc:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10159d1:	cmp    QWORD PTR [rsi+r12*8],0x0
 10159d6:	jne    101574a <lyr_p1_reg_run+0x6a>
 10159dc:	jmp    1015744 <lyr_p1_reg_run+0x64>
 10159e1:	add    r13d,0xffffffd6
 10159e5:	cmp    r13d,0x5
 10159e9:	ja     1015ac6 <lyr_p1_reg_run+0x3e6>
 10159ef:	movsxd r13,DWORD PTR [r11+r13*4]
 10159f3:	add    r13,r11
 10159f6:	jmp    r13
 10159f9:	mov    rdx,QWORD PTR [rsi+rdx*8]
 10159fd:	mov    rax,QWORD PTR [rsi+rax*8]
 1015a01:	cmp    rdx,rax
 1015a04:	cmova  rax,rdx
 1015a08:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015a0d:	xor    edx,edx
 1015a0f:	div    r13d
 1015a12:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015a17:	xor    edx,edx
 1015a19:	div    r13d
 1015a1c:	mov    QWORD PTR [rsi+r12*8],rdx
 1015a20:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015a25:	dec    r10
 1015a28:	jo     1015a95 <lyr_p1_reg_run+0x3b5>
 1015a2a:	mov    rax,QWORD PTR [r8+r10*8+0x10]
 1015a2f:	jmp    101574a <lyr_p1_reg_run+0x6a>
 1015a34:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015a38:	mov    r12,QWORD PTR [rsi+r12*8]
 1015a3c:	lea    rdx,[rcx+rdx*8]
 1015a40:	mov    QWORD PTR [rdx+rax*8],r12
 1015a44:	jmp    1015744 <lyr_p1_reg_run+0x64>
 1015a49:	inc    r15
 1015a4c:	mov    QWORD PTR [r8+r10*8+0x10],r15
 1015a51:	inc    r10
 1015a54:	jmp    101574a <lyr_p1_reg_run+0x6a>
 1015a59:	mov    rdx,QWORD PTR [rsi+rdx*8]
 1015a5d:	lea    rdx,[rcx+rdx*8]
 1015a61:	mov    rax,QWORD PTR [rdx+rax*8]
 1015a65:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015a6a:	cmp    QWORD PTR [rsi+rax*8],0x0
 1015a6f:	je     1015744 <lyr_p1_reg_run+0x64>
 1015a75:	mov    rax,QWORD PTR [rsi+rdx*8]
 1015a79:	jmp    1015740 <lyr_p1_reg_run+0x60>
 1015a7e:	mov    rax,r9
 1015a81:	add    rsp,0x8
 1015a85:	pop    rbx
 1015a86:	pop    r12
 1015a88:	pop    r13
 1015a8a:	pop    r14
 1015a8c:	pop    r15
 1015a8e:	pop    rbp
 1015a8f:	ret
 1015a90:	call   1020275 <lyr_panic_division_by_zero>
 1015a95:	lea    rdi,[rip+0xfffffffffffecf8d]        # 1002a29 <lyr_refmap_ty_std_core_StringBuilder+0x1091>
 1015a9c:	call   1020259 <lyr_panic_overflow>
 1015aa1:	mov    r14,rdi
 1015aa4:	mov    rdi,rax
 1015aa7:	mov    r15,r8
 1015aaa:	mov    r13,rcx
 1015aad:	mov    r12,rsi
 1015ab0:	call   101a550 <lyr_gc_stack_slow>
 1015ab5:	mov    rdi,r14
 1015ab8:	mov    rsi,r12
 1015abb:	mov    rcx,r13
 1015abe:	mov    r8,r15
 1015ac1:	jmp    101570f <lyr_p1_reg_run+0x2f>
 1015ac6:	lea    rdi,[rip+0x21fd3]        # 1037aa0 <lyr_lit0>
 1015acd:	call   10202ab <lyr_panic_message>
 1015ad2:	ud2
 1015ad4:	int3
 1015ad5:	int3
 1015ad6:	int3
 1015ad7:	int3
 1015ad8:	int3
 1015ad9:	int3
 1015ada:	int3
 1015adb:	int3
 1015adc:	int3
 1015add:	int3
 1015ade:	int3
 1015adf:	int3
