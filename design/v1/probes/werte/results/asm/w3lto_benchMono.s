000000000101d470 <lyr_w3_map_benchMono>:
 101d470:	push   rbp
 101d471:	mov    rbp,rsp
 101d474:	push   r15
 101d476:	push   r14
 101d478:	push   r13
 101d47a:	push   r12
 101d47c:	push   rbx
 101d47d:	sub    rsp,0x48
 101d481:	mov    r15,rsi
 101d484:	mov    r14,rdi
 101d487:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101d490:	cmp    rax,rbp
 101d493:	ja     101d75f <lyr_w3_map_benchMono+0x2ef>
 101d499:	mov    rax,QWORD PTR [r15+0x8]
 101d49d:	dec    rax
 101d4a0:	mov    QWORD PTR [rbp-0x60],rax
 101d4a4:	jo     101d772 <lyr_w3_map_benchMono+0x302>
 101d4aa:	mov    rax,rdx
 101d4ad:	sar    rax,0x3f
 101d4b1:	andn   rax,rax,rdx
 101d4b6:	mov    QWORD PTR [rbp-0x68],rax
 101d4ba:	mov    edx,0x400
 101d4bf:	xor    ecx,ecx
 101d4c1:	mov    QWORD PTR [rbp-0x48],0x0
 101d4c9:	mov    QWORD PTR [rbp-0x50],0x0
 101d4d1:	mov    QWORD PTR [rbp-0x38],r15
 101d4d5:	jmp    101d4ee <lyr_w3_map_benchMono+0x7e>
 101d4d7:	nop    WORD PTR [rax+rax*1+0x0]
 101d4e0:	mov    r15,QWORD PTR [rbp-0x38]
 101d4e4:	mov    rcx,QWORD PTR [rbp-0x40]
 101d4e8:	mov    edx,DWORD PTR [rbp-0x2c]
 101d4eb:	inc    rcx
 101d4ee:	dec    edx
 101d4f0:	je     101d6c3 <lyr_w3_map_benchMono+0x253>
 101d4f6:	cmp    rcx,QWORD PTR [rbp-0x68]
 101d4fa:	je     101d725 <lyr_w3_map_benchMono+0x2b5>
 101d500:	mov    rdi,rcx
 101d503:	and    rdi,QWORD PTR [rbp-0x60]
 101d507:	mov    rsi,QWORD PTR [r15+0x8]
 101d50b:	cmp    rdi,rsi
 101d50e:	jae    101d750 <lyr_w3_map_benchMono+0x2e0>
 101d514:	mov    DWORD PTR [rbp-0x2c],edx
 101d517:	mov    QWORD PTR [rbp-0x40],rcx
 101d51b:	mov    rbx,QWORD PTR [r15+rdi*8+0x10]
 101d520:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101d529:	cmp    rax,rbp
 101d52c:	ja     101d703 <lyr_w3_map_benchMono+0x293>
 101d532:	mov    rax,QWORD PTR fs:0xfffffffffffffff8
 101d53b:	cmp    rax,rbp
 101d53e:	ja     101d710 <lyr_w3_map_benchMono+0x2a0>
 101d544:	mov    QWORD PTR [rbp-0x58],0x0
 101d54c:	mov    rsi,QWORD PTR [rbx+0x8]
 101d550:	lea    rdi,[rbx+0x10]
 101d554:	mov    QWORD PTR [rbp-0x70],rdi
 101d558:	lea    rdx,[rbp-0x58]
 101d55c:	call   1024430 <lyr_std_core_hashText_w3_map_Fx__be0ed00d>
 101d561:	mov    rax,QWORD PTR [rbp-0x58]
 101d565:	mov    rcx,rax
 101d568:	shr    rcx,0x1d
 101d56c:	xor    rcx,rax
 101d56f:	movabs rax,0xbf58476d1ce4e5b9
 101d579:	imul   rcx,rax
 101d57d:	mov    r15,rcx
 101d580:	shr    r15,0x20
 101d584:	xor    r15,rcx
 101d587:	or     r15,0x1
 101d58b:	mov    r12,QWORD PTR [r14+0x20]
 101d58f:	and    r12,r15
 101d592:	mov    r13d,0x400
 101d598:	dec    r13d
 101d59b:	jne    101d5d0 <lyr_w3_map_benchMono+0x160>
 101d59d:	mov    eax,DWORD PTR [rip+0x2831d]        # 10458c0 <lyr_gc_stop_requested>
 101d5a3:	mov    r13d,0x400
 101d5a9:	test   eax,eax
 101d5ab:	je     101d5d0 <lyr_w3_map_benchMono+0x160>
 101d5ad:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101d5b6:	test   rdi,rdi
 101d5b9:	je     101d5d0 <lyr_w3_map_benchMono+0x160>
 101d5bb:	mov    eax,DWORD PTR [rip+0x282ff]        # 10458c0 <lyr_gc_stop_requested>
 101d5c1:	test   eax,eax
 101d5c3:	je     101d5d0 <lyr_w3_map_benchMono+0x160>
 101d5c5:	call   1026760 <park_here.llvm.8023764427486792703>
 101d5ca:	nop    WORD PTR [rax+rax*1+0x0]
 101d5d0:	mov    rax,QWORD PTR [r14+0x10]
 101d5d4:	mov    rsi,QWORD PTR [rax+0x8]
 101d5d8:	cmp    r12,rsi
 101d5db:	jae    101d74d <lyr_w3_map_benchMono+0x2dd>
 101d5e1:	mov    rax,QWORD PTR [rax+r12*8+0x10]
 101d5e6:	test   rax,rax
 101d5e9:	je     101d4e0 <lyr_w3_map_benchMono+0x70>
 101d5ef:	cmp    rax,r15
 101d5f2:	jne    101d62a <lyr_w3_map_benchMono+0x1ba>
 101d5f4:	mov    rax,QWORD PTR [r14+0x8]
 101d5f8:	mov    rsi,QWORD PTR [rax+0x8]
 101d5fc:	cmp    r12,rsi
 101d5ff:	jae    101d74d <lyr_w3_map_benchMono+0x2dd>
 101d605:	mov    rdi,QWORD PTR [rax+r12*8+0x10]
 101d60a:	cmp    rdi,rbx
 101d60d:	je     101d680 <lyr_w3_map_benchMono+0x210>
 101d60f:	mov    rdx,QWORD PTR [rdi+0x8]
 101d613:	cmp    rdx,QWORD PTR [rbx+0x8]
 101d617:	jne    101d62a <lyr_w3_map_benchMono+0x1ba>
 101d619:	add    rdi,0x10
 101d61d:	mov    rsi,QWORD PTR [rbp-0x70]
 101d621:	call   103e760 <bcmp@plt>
 101d626:	test   eax,eax
 101d628:	je     101d680 <lyr_w3_map_benchMono+0x210>
 101d62a:	dec    r13d
 101d62d:	je     101d646 <lyr_w3_map_benchMono+0x1d6>
 101d62f:	inc    r12
 101d632:	jo     101d755 <lyr_w3_map_benchMono+0x2e5>
 101d638:	and    r12,QWORD PTR [r14+0x20]
 101d63c:	dec    r13d
 101d63f:	jne    101d5d0 <lyr_w3_map_benchMono+0x160>
 101d641:	jmp    101d59d <lyr_w3_map_benchMono+0x12d>
 101d646:	mov    eax,DWORD PTR [rip+0x28274]        # 10458c0 <lyr_gc_stop_requested>
 101d64c:	mov    r13d,0x400
 101d652:	test   eax,eax
 101d654:	je     101d62f <lyr_w3_map_benchMono+0x1bf>
 101d656:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101d65f:	test   rdi,rdi
 101d662:	je     101d62f <lyr_w3_map_benchMono+0x1bf>
 101d664:	mov    eax,DWORD PTR [rip+0x28256]        # 10458c0 <lyr_gc_stop_requested>
 101d66a:	test   eax,eax
 101d66c:	je     101d62f <lyr_w3_map_benchMono+0x1bf>
 101d66e:	call   1026760 <park_here.llvm.8023764427486792703>
 101d673:	jmp    101d62f <lyr_w3_map_benchMono+0x1bf>
 101d675:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 101d680:	mov    rax,QWORD PTR [r14+0x18]
 101d684:	mov    rsi,QWORD PTR [rax+0x8]
 101d688:	cmp    r12,rsi
 101d68b:	jae    101d74d <lyr_w3_map_benchMono+0x2dd>
 101d691:	mov    rax,QWORD PTR [rax+r12*8+0x10]
 101d696:	test   rax,rax
 101d699:	js     101d4e0 <lyr_w3_map_benchMono+0x70>
 101d69f:	add    QWORD PTR [rbp-0x50],rax
 101d6a3:	mov    r15,QWORD PTR [rbp-0x38]
 101d6a7:	mov    rcx,QWORD PTR [rbp-0x40]
 101d6ab:	mov    edx,DWORD PTR [rbp-0x2c]
 101d6ae:	jo     101d755 <lyr_w3_map_benchMono+0x2e5>
 101d6b4:	inc    QWORD PTR [rbp-0x48]
 101d6b8:	jno    101d4eb <lyr_w3_map_benchMono+0x7b>
 101d6be:	jmp    101d755 <lyr_w3_map_benchMono+0x2e5>
 101d6c3:	mov    eax,DWORD PTR [rip+0x281f7]        # 10458c0 <lyr_gc_stop_requested>
 101d6c9:	mov    edx,0x400
 101d6ce:	test   eax,eax
 101d6d0:	je     101d4f6 <lyr_w3_map_benchMono+0x86>
 101d6d6:	mov    rbx,rcx
 101d6d9:	mov    rdi,QWORD PTR fs:0xffffffffffffffa0
 101d6e2:	test   rdi,rdi
 101d6e5:	je     101d71d <lyr_w3_map_benchMono+0x2ad>
 101d6e7:	mov    eax,DWORD PTR [rip+0x281d3]        # 10458c0 <lyr_gc_stop_requested>
 101d6ed:	test   eax,eax
 101d6ef:	je     101d71d <lyr_w3_map_benchMono+0x2ad>
 101d6f1:	call   1026760 <park_here.llvm.8023764427486792703>
 101d6f6:	mov    rcx,rbx
 101d6f9:	mov    edx,0x400
 101d6fe:	jmp    101d4f6 <lyr_w3_map_benchMono+0x86>
 101d703:	mov    rdi,rbp
 101d706:	call   1026790 <lyr_gc_stack_slow>
 101d70b:	jmp    101d532 <lyr_w3_map_benchMono+0xc2>
 101d710:	mov    rdi,rbp
 101d713:	call   1026790 <lyr_gc_stack_slow>
 101d718:	jmp    101d544 <lyr_w3_map_benchMono+0xd4>
 101d71d:	mov    rcx,rbx
 101d720:	jmp    101d4f6 <lyr_w3_map_benchMono+0x86>
 101d725:	mov    rcx,QWORD PTR [rbp-0x48]
 101d729:	movsxd rax,ecx
 101d72c:	cmp    rax,rcx
 101d72f:	jne    101d77c <lyr_w3_map_benchMono+0x30c>
 101d731:	shl    rcx,0x20
 101d735:	mov    rax,QWORD PTR [rbp-0x50]
 101d739:	add    rax,rcx
 101d73c:	jo     101d755 <lyr_w3_map_benchMono+0x2e5>
 101d73e:	add    rsp,0x48
 101d742:	pop    rbx
 101d743:	pop    r12
 101d745:	pop    r13
 101d747:	pop    r14
 101d749:	pop    r15
 101d74b:	pop    rbp
 101d74c:	ret
 101d74d:	mov    rdi,r12
 101d750:	call   102bafc <lyr_panic_index>
 101d755:	mov    edi,0x1002fe0
 101d75a:	call   102bb35 <lyr_panic_overflow>
 101d75f:	mov    rdi,rbp
 101d762:	mov    rbx,rdx
 101d765:	call   1026790 <lyr_gc_stack_slow>
 101d76a:	mov    rdx,rbx
 101d76d:	jmp    101d499 <lyr_w3_map_benchMono+0x29>
 101d772:	mov    edi,0x1002fde
 101d777:	call   102bb35 <lyr_panic_overflow>
 101d77c:	mov    edi,0x1002fe2
 101d781:	call   102bb35 <lyr_panic_overflow>

