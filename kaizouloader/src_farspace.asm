
kaizouLoaderXtra:
	mov		r0,0x0
	ldr		r2,=2009D1Ch	; パスワード入力で一番左のケタの数値が格納されるアドレス（レジスタに格納されてるWARAMのアドレスを表示したらたまたま見つけた）
	ldrb	r1,[r2]		; 100の位
	mov		r3,0x64
	mul		r1,r3		; x100
	add		r0,r1
	add		r2,1h		;ldr	r2, =0x02009D1D
	ldrb	r1,[r2]		; 10の位
	mov		r3,0xA
	mul		r1,r3		; x10
	add		r0,r1
	add		r2,1h		;ldr	r2, =0x02009D1E
	ldrb	r1,[r2]		; 1の位
	add		r0,r1

	;sanitize the ID
	cmp		r0,75h	;0x75 is the highest existing ID
	bgt		@@flagbadID
	cmp		r0,0h
	bgt		@@isclean

@@flagbadID:
	mov		r2,0h		;set value that says why the ID is invalid (BAD ID)
	b		@@invalid


@@isclean:
	
	ldr		r2,=loadKaizouCard|1
	mov		r14,r15
	bx		r2
	;bl loadKaizouCard	; 改造カードのロード（r0 = カードID）

	;check if MB limit	reached
	ldr		r0,=65F0h
	lsl		r3,8h
	lsr		r3,8h
	cmp		r0,r3
	bne		@@jump5
	mov		r2,1h		;set value that says why the ID is invalid (MB)
	b		@@invalid


	;check if Duplicate
	@@jump5:
	cmp		r2,7Fh
	bne		@@jump6
	mov		r2,2h		;set value that says why the ID is invalid (DUPLICATE)
	b		@@invalid

@@jump6:
@@invalid:

@@finish2:
	mov		r0, 0xDD	; 一応もとの値に戻しとく
	pop		r2-r5
	mov		r1,0x80
	ldr		r1,[r5,r1]

	pop		r15
	.pool