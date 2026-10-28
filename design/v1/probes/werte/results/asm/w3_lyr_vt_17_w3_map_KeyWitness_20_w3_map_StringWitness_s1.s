00000000010163f0 <lyr_vt_17_w3_map_KeyWitness_20_w3_map_StringWitness_s1>:
 10163f0:	mov    rax,QWORD PTR [rcx]
 10163f3:	cmp    rax,0x103e368
 10163fa:	jne    1016408 <lyr_vt_17_w3_map_KeyWitness_20_w3_map_StringWitness_s1+0x18>
 10163fc:	mov    rax,QWORD PTR [r9]
 10163ff:	cmp    rax,0x103e368
 1016406:	je     101640b <lyr_vt_17_w3_map_KeyWitness_20_w3_map_StringWitness_s1+0x1b>
 1016408:	xor    eax,eax
 101640a:	ret
 101640b:	push   rbp
 101640c:	mov    rbp,rsp
 101640f:	mov    rdi,QWORD PTR [rdx+0x8]
 1016413:	mov    rsi,QWORD PTR [r8+0x8]
 1016417:	call   1026d90 <lyr_str_eq>
 101641c:	pop    rbp
 101641d:	ret

