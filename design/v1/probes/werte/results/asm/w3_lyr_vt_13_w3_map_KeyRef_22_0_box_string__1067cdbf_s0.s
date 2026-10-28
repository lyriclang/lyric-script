0000000001016610 <lyr_vt_13_w3_map_KeyRef_22_0_box_string__1067cdbf_s0>:
 1016610:	push   rbp
 1016611:	mov    rbp,rsp
 1016614:	push   r14
 1016616:	push   rbx
 1016617:	sub    rsp,0x10
 101661b:	mov    rdi,QWORD PTR [rdi+0x8]
 101661f:	mov    rbx,0xffffffffffffffe0
 1016626:	mov    rax,QWORD PTR fs:[rbx+0x10]
 101662b:	cmp    rax,rbp
 101662e:	ja     1016682 <lyr_vt_13_w3_map_KeyRef_22_0_box_string__1067cdbf_s0+0x72>
 1016630:	mov    rax,QWORD PTR fs:[rbx+0x10]
 1016635:	cmp    rax,rbp
 1016638:	ja     1016692 <lyr_vt_13_w3_map_KeyRef_22_0_box_string__1067cdbf_s0+0x82>
 101663a:	mov    QWORD PTR [rbp-0x18],0x0
 1016642:	mov    rsi,QWORD PTR [rdi+0x8]
 1016646:	add    rdi,0x10
 101664a:	lea    rdx,[rbp-0x18]
 101664e:	call   101edf0 <lyr_std_core_hashText_w3_map_Fx__be0ed00d>
 1016653:	mov    rax,QWORD PTR [rbp-0x18]
 1016657:	mov    rcx,rax
 101665a:	shr    rcx,0x1d
 101665e:	xor    rcx,rax
 1016661:	movabs rdx,0xbf58476d1ce4e5b9
 101666b:	imul   rdx,rcx
 101666f:	mov    rax,rdx
 1016672:	shr    rax,0x20
 1016676:	xor    rax,rdx
 1016679:	add    rsp,0x10
 101667d:	pop    rbx
 101667e:	pop    r14
 1016680:	pop    rbp
 1016681:	ret
 1016682:	mov    r14,rdi
 1016685:	mov    rdi,rbp
 1016688:	call   1020d50 <lyr_gc_stack_slow>
 101668d:	mov    rdi,r14
 1016690:	jmp    1016630 <lyr_vt_13_w3_map_KeyRef_22_0_box_string__1067cdbf_s0+0x20>
 1016692:	mov    rbx,rdi
 1016695:	mov    rdi,rbp
 1016698:	call   1020d50 <lyr_gc_stack_slow>
 101669d:	mov    rdi,rbx
 10166a0:	jmp    101663a <lyr_vt_13_w3_map_KeyRef_22_0_box_string__1067cdbf_s0+0x2a>

