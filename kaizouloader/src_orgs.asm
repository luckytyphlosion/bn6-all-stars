
	; .org LansRoomSecondaryTextScriptPtrLoc
	; 
	; .org LansRoomNPCScriptsPtrLoc

	.org kaizouLoaderCodeSpace
kaizouLoader:
	push	r14

	cmp		r0, 0xDD	; TextPetで用意したフラグかチェック
	bne 	@@originalProcessing	; 違ったら元々の処理だけやって抜ける

	push	r2-r5		; 自作の処理をする前にレジスタの値を保持
	ldr		r2,=kaizouLoaderXtra|1
	bx		r2

	@@originalProcessing:
	mov		r1,0x80
	ldr		r1,[r5,r1]

	pop		r15

.pool

; Hook
.org loadPasswordIndex ; パスワードチェック関数の内部（会話から呼び出せるのでTextPetと連携しやすい）
	bl kaizouLoader
