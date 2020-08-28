// MegaMan Battle Network 6: Cybeast Gregar/Falzar (U)
// Any Crosses Hack v2.0b
// Change the 5 Crosses in your Custom Screen with flags or NCPs.
// By Prof. 9
// Made for ARMIPS assembler v0.7c

GREGAR equ 0
FALZAR equ 1

	.gba
	.include ver

NCPeffect   equ 0
set2flag    equ 0

	.open INPUT_ROM, "bn6f-all-stars.gba", 0x8000000

	.org fspace

// 2036510 - active crosses
// sub_8029EF8 - initializes active cross list

// 86e5d50 - gregar cross windows
// 86e73d0 - gregar cross window palettes
	.align 2
crosses:
	// Cross1,Cross2,Cross3,Cross4,Cross5,Beast
	.byte 0x01,0x06,0x03,0x04,0x05,0x0B
	.byte 0x06,0x07,0x08,0x09,0x0A,0x0C

	.align 2
windowmugs:
	// selection window button graphics
	.word 0x086E7DCC
	.word 0x086E7DCC

windowpals:
	// selection window button palettes
	.word 0x086E944C
	.word 0x086E944C

beastbutton:
	// Button graphics, Chip Image, Chip Palette, Sound Effect
	.word 0x086E79CC, 0x08723034, 0x08725814, 0x193
	.word 0x086E79CC, 0x08723034, 0x08725814, 0x193

	.align 2
OverrideCrossChosenInMenu:
	push r5
	push lr
	mov	r6, r0
	bl GetCrossList
	ldrb r6, [r1,r6]
	pop	pc

PatchChosenCrossAndCrossUsedFlag:
	push lr
	bl GetCrossList
	ldrb r0, [r5,0x1a]
	ldrb r0, [r1,r0]
	add	r0, r0, r4
	mov	r1, 0x0
	ldr	r3, =0x8015953
	mov	lr, pc
	bx r3
	sub	r0, r0, r4
	pop	pc

PatchResultingBeastForm:
	push lr
	mov	r4, 0x0
	cmp	r0, 0x1
	beq	@@isBeastOver
	cmp	r1, 0x0
	beq	@@isNullBeast
	add	r1, 0xc
	mov	r4, r1
	b @@isCrossBeast

@@isBeastOver:
	mov	r4, 0xc

@@isNullBeast:
	bl GetCrossList
	ldrb r0, [r1,0x5]
	add	r4, r0, r4
@@isCrossBeast:
	pop	pc

PatchCountRemainingCrosses:
	bl CheckCrossUsedUp
	ldr	r1,=0x8029EE9+VERSION*2
	bx r1

PatchActiveCrossList:
	ldr	r3,=0x20349A0
	bl CheckCrossUsedUp
	ldr	r1,=0x8029F17+VERSION*4
	bx r1

CheckCrossUsedUp:
	push {lr}
	bl GetCrossList
	ldrb r1, [r1,r4]
	sub	r1, 1
	mov	r0, 1
	lsl	r0, r1
	ldr	r3, [r3]
	and	r3, r0
	pop	{pc}

// free regs: r1, r2, r3, r4, r5
PatchCrossWindowGfxPtr:
	bl GetCrossList
	// r7 = which cross mug
	ldrb r1, [r1,r7]
	sub r1, 1
	ldr r2, =GregarVersionCrossWindows
	cmp r1, 5
	blt @@isGregarCross
	sub r1, 5
	ldr r2, =FalzarVersionCrossWindows
@@isGregarCross:
	add r0, r0, r1 // add unselected offset
	ldr r1, =0x240 // cross window size
	mul r0, r1
	add r0, r2, r0
	ldr	r1, =0x8029DAD
	bx r1

PatchCrossSelectedPalette:
	push {r3}
	sub r0, r0, r2 // temporarily reverse selected palette operation
	bl GetCrossList
	ldrb r1, [r1,r0]
	sub r1, 1
	ldr r3, =GregarVersionCrossWindowPalettes
	cmp r1, 5
	blt @@isGregarCross
	sub r1, 5
	ldr r3, =FalzarVersionCrossWindowPalettes
@@isGregarCross:
	add r1, r1, r2 // add selected offset
	mov r0, 0x20
	mul r0, r1
	add r0, r3, r0
	pop {r3}
	ldr	r1, =0x8029EB7
	bx r1

PatchGetCrossDescription:
	push {r0}
	bl GetCrossList
	ldrb r0, [r5,0x1b]
	add	r2, r2, r0
	ldrb r0, [r5,r2]
	ldrb r1, [r1,r0]
	sub	r1, 1
	pop	{r0}
	ldr	r2, =0x8028B55
	bx r2

PatchLoadBeastIcon:
	push lr
	mov	r2, 0
	bl getbst
	ldr	r2, =0x80282B3
	bx r2

PatchLoadBeastChipImage:
	mov	r2, 4
	bl getbst
	ldr	r1, =0x6009560
	ldr	r2, =0x8028727
	bx r2

PatchLoadBeastChipPalette:
	mov	r2, 8
	bl getbst
	add	r0, r0, r1
	ldr	r1, =0x802873D
	bx r1

PatchPlayBeastSoundEffect:
	mov	r2, pc
	add	r2, 7h
	mov	lr, r2
	ldr	r2, =0x80302B7
	bx r2
	mov	r2, 0x0C
	bl getbst
	ldr	r1, =0x80005CD
	mov	lr, pc
	bx r1
	ldr	r0, =0x802776B
	bx r0

getptr:	 // input: r3 = pointer list start, output: r0 = required pointer
	push {r0,r1,r3,lr}
	mov r0, 0 // bl GetCrossList
	lsl	r0, r0, 2
	ldr	r3, [r3,r0]
	pop	{r0,r1}
	add	r0, r0, r3
	pop	{r3,pc}

getbst: // input: r2 = pointer number * 4, output: r0 = beastbutton
	push {r1,lr}
	mov r0, 0 // bl GetCrossList
	lsl	r0, r0, 4
	ldr	r1, =beastbutton
	add	r0, r1, r0
	ldr	r0, [r0,r2]
	pop	{r1,pc}

GetCrossList: // output: r0 = set value, r1 = set offset
	ldr	r1, =crosses
	bx lr
	.pool

	.align 2
OppositeVersionCrossWindows:
	.import OTHER_VERSION_ROM, OTHER_VERSION_CROSS_WINDOWS_FILE_ADDR, 0x240 * 10

	.align 2
OppositeVersionCrossWindowPalettes:
	.import OTHER_VERSION_ROM, OTHER_VERSION_CROSS_WINDOW_PALETTES_FILE_ADDR, 0x20 * 10

	.org 0x0802A086 + VERSION * 4
Hook_OverrideCrossChosenInMenu:
	ldr	r6, =OverrideCrossChosenInMenu|1
	mov	lr, pc
	bx r6

// free space for hook
	.org 0x0802A0DC + VERSION * 4
	.pool

// sub_802937A - set cross used flag, also set some other stuff?
// sub_8029EF8 - populate cross list
	.org 0x0802937C
	mov	r4, 0
	.org 0x08029386
	mov	r4, 0xc

	.org 0x08029390
	ldr	r1, =PatchChosenCrossAndCrossUsedFlag|1
	mov	lr, pc
	bx r1
	b 0x80293A0
	.pool

// sub_8029344
	.org 0x08029352
	ldr	r4, =PatchResultingBeastForm|1
	mov	lr, pc
	bx r4
	b 0x8029368
	.pool

// sub_8029EC8
	.org 0x08029EE0
	ldr	r0, =PatchCountRemainingCrosses|1
	bx r0
	.pool

// sub_8029EF8
	.org 0x08029F0C + VERSION * 2
	ldr	r0, =PatchActiveCrossList|1
	bx r0
	.pool

// sub_8029D94
	.org 0x08029DA2
	ldr	r1, =PatchCrossWindowGfxPtr|1
	bx r1
	.org 0x08029DD8
	.pool

// sub_8029EAC
	.org 0x08029EAE
	ldr	r1, =PatchCrossSelectedPalette|1
	bx r1
	.org 0x08029EC0
	.pool

// sub_8028A78
	.org 0x08028B4A
	ldr	r2, [0x8028B6C]
	ldr	r1, =PatchGetCrossDescription|1
	bx r1
	.pool

// sub_80282AE (called from jumptable in sub_8028250)
	.org 0x08028378
	.word PatchLoadBeastIcon|1b

// sub_802871C
	.org 0x08028722
	ldr	r0, =PatchLoadBeastChipImage|1
	bx r0
	.org 0x0802874C
	.pool

// sub_802871C
	.org 0x08028738
	ldr	r0, =PatchLoadBeastChipPalette|1
	bx r0
	.org 0x08028750
	.pool

// sub_802774C
	.org 0x0802775E
	ldr	r2,=PatchPlayBeastSoundEffect|1
	bx r2
	.org 0x08027764
	.pool

	.close
// eof
