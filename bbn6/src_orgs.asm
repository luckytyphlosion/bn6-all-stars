.gba

.if	AM_DEBUGGING
	;.include ASMfldr+ "debugging.asm"
.endif

;	run all other asm files here 
;.include ASMfldr+ "file.asm"


;  ============  ;	Hooks and small edits

;	.org 0x08000000

.if AM_DEBUGGING
	; boot to black screen with a very early hook
	.org 0x080000D0
		.arm
		ldr		r0,=DarkBoot1
		bx		r0
		poool
		DarkBoot1Return:
		.thumb

	;	maintain black screen during startup
	.org screenio1
		mov		r0,40h
	.org screenio2
		mov		r0,40h
	.org screenio3
		ldr		r0,=DarkBoot2|1
		bx		r0
		poool
		nop

	;	skip the capcom logo
	.org BootScene1
		mov		r0,10h
	.org BootScene2
		mov		r0,0Ch
.endif

; make it fade to a black screen when starting pvp

.org PVPFade	; pvp 
	mov r0,0Ch
.org BossFade	;pve
	mov r0,0Ch
.org PVPUnfade	; triple battle
	mov r0,8h
.org PVPUnfade + 0x0C	; single battle
	mov r0,8h


; fix the glitch that prevents decrossing
.org DecrossChecker
	b		SafeDecrossWrite
	ReturnFromSafeDecrossWrite:

.org DecrossChecker + 0xC
	CopyCodeChunk2:
	ldr		r1,=PasteCodeChunk2|1
	mov		r14,r15
	bx		r1
	b		CopyCodeChunk1
	SafeDecrossWrite:
	ldrb	r2,[r6,r0]
	orr		r1,r2
	strb	r1,[r6,r0]
	b		ReturnFromSafeDecrossWrite

	CopyCodeChunk1:
	ldr		r1,=PasteCodeChunk1|1
	mov		r14,r15
	bx		r1
	b		ResumeDecrossChecker
	poool

.org DecrossChecker + 0x32
	ResumeDecrossChecker:



; windrack: delay the movement of the invisible gusts so that players will get moved by the gusts regardless of their entity update order if they're hit point blank while they are being protected by a barrier

	; point to a new table of routines for windrack's logic
	.org RedirectWindrack
		.dw WindrackJumpTable

	; don't let the gusts move on the same frame they're spawned
	.org WindRStep2 - 0xA
		nop
		nop
; endrack

; BDT and Thunder: when the targeted character is on the same panel as the thunder ball, make the ball move in a relative "forward" direction instead of moving in a hardcoded direction that ignores which side spawned the thunder
	
	.org ThunderHook
	; the skipped bytes are a push r14 and an important routine, 
	; easier to leave those intact
	.skip 0x2*3
	ldr		r2,=ThunderMove|1
	bx		r2
	poool
	nop
	freedspace1:	; the remaining space is now unused, so it can be repurposed for holding new functions
; thunder doneder



;  ============  ;	Freed up space (from repointing existing functions)


; this space is from the Thunder code
.org freedspace1
	.sym off :: .area 0x080C95E6 - 0x080C957C, 0x0	:: .sym on


	.sym off :: .endarea :: .sym on
; end of freedspace1

