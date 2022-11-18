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
	.vorg 0x0802937C, 0x8029790
	mov	r4, 0
	.vorg 0x08029386, 0x802979a
	mov	r4, 0xc

	.vorg 0x08029390, 0x80297a4
	ldr	r1, =PatchChosenCrossAndCrossUsedFlag|1
	mov	lr, pc
	bx r1
	.vbranch 0x80293A0, 0x80297b4
	.pool

// sub_8029344
	.vorg 0x08029352, 0x8029766
	ldr	r4, =PatchResultingBeastForm|1
	mov	lr, pc
	bx r4
	.vbranch 0x8029368, 0x802977c
	.pool

// sub_8029EC8
	.vorg 0x08029EE0, 0x0802A2F4
	ldr	r0, =PatchCountRemainingCrosses|1
	bx r0
	.pool

// sub_8029EF8
	.vorg 0x08029F0C + VERSION * 2, 0x802a320 + VERSION * 2
	ldr	r0, =PatchActiveCrossList|1
	bx r0
	.pool

// sub_8029D94
	.vorg 0x08029DA2, 0x802a1b6
	ldr	r1, =PatchCrossWindowGfxPtr|1
	bx r1
	.vorg 0x08029DD8, 0x802a1ec
	.pool

// sub_8029EAC
	.vorg 0x08029EAE, 0x802a2c2
	ldr	r1, =PatchCrossSelectedPalette|1
	bx r1
	.vorg 0x08029EC0, 0x802a2d4
	.pool

// sub_801CB38
	.vorg 0x801CBBE, 0x801cfe2
	ldr r2, =PatchEmotionMugGfx|1
	bx r2
	.pool

// sub_801CB38
	.vorg 0x801CC24, 0x801d048
	nop
	nop
	mov r0, r4

// sub_8028A78
	.vorg 0x08028B48, 0x8028f5c
	ldr	r1, =PatchGetCrossDescription|1
	bx r1
	.pool

// sub_80282AE (called from jumptable in sub_8028250)
	.vorg 0x08028378, 0x802878c
	.word PatchLoadBeastIcon|1b

// sub_802871C
	.vorg 0x08028722, 0x8028b36
	ldr	r0, =PatchLoadBeastChipImage|1
	bx r0
	.vorg 0x0802874C, 0x8028b60
	.pool

// sub_802871C
	.vorg 0x08028738, 0x8028b4c
	ldr	r0, =PatchLoadBeastChipPalette|1
	bx r0
	.vorg 0x08028750, 0x8028b64
	.pool

// sub_802774C
	.vorg 0x0802775E, 0x8027b72
	ldr	r2,=PatchPlayBeastSoundEffect|1
	bx r2
	.vorg 0x08027764, 0x8027b78
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
