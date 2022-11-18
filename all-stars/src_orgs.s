// MegaMan Battle Network 6: Cybeast Gregar/Falzar (U)
// Any Crosses Hack v2.0b
// Change the 5 Crosses in your Custom Screen with flags or NCPs.
// By Prof. 9
// Made for ARMIPS assembler v0.7c

// Modified into the MMBN6 All Stars patch
// https://i.imgur.com/yIfsan8.png


	.org Hook_OverrideCrossChosenInMenu
	ldr	r6, =OverrideCrossChosenInMenu|1
	mov	lr, pc
	bx r6

// free space for hook
	.org HookPool_OverrideCrossChosenInMenu
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

// sub_801CB38
	.org 0x801CBBE
	ldr r2, =PatchEmotionMugGfx|1
	bx r2
	.pool

// sub_801CB38
	.org 0x801CC24
	nop
	nop
	mov r0, r4

// sub_8028A78
	.org 0x08028B48
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

	.org L_BUTTON_CUTSCENE_SCRIPT_ADDR
	cs_jump PatchLButtonCutsceneScript

	.org SHUFFLE_FOLDER_SLICE_ADDR
ShuffleFolderSlice:
	push {r4-r6,lr}
	sub r4, r1, 1
	beq @@done
@@loop:
	push {r0}
	bl GetPositiveSignedRNG1
	add r1, r4, 1
	swi 6 // r1 = rand() % (r1 + 1)
	pop {r0}

	add r1, r1, r1
	add r3, r4, r4
	ldrh r5, [r0,r1]
	ldrh r6, [r0,r3]
	strh r6, [r0,r1]
	strh r5, [r0,r3]
	sub r4, 1
	bne @@loop
@@done:
	pop {r4-r6,pc}
