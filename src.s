// MegaMan Battle Network 6: Cybeast Gregar/Falzar (U)
// Any Crosses Hack v2.0b
// Change the 5 Crosses in your Custom Screen with flags or NCPs.
// By Prof. 9
// Made for ARMIPS assembler v0.7c

// Modified into the MMBN6 All Stars patch
// https://i.imgur.com/yIfsan8.png

// 0 = decross only removes cross, keeps you in same beast
// 1 = decross always sets beast to your version beast
OPT_DECROSS_INTO_VERSION_BEAST equ 1

GREGAR equ 0
FALZAR equ 1

	.gba
	.include ver
	.include "macros.inc"
	.include "constants.inc"

	.definelabel eCustScreenMenu, 0x20364c0
	.definelabel GetBattleNaviStatsAddr, 0x8013682
	.definelabel CopyBytes, 0x8000920
	.definelabel eCrossList, 0x2003f40
	.definelabel GetPositiveSignedRNG1, 0x8001562
	.open INPUT_ROM, OUTPUT_ROM, 0x8000000

	.org fspace

// normal, anger, tired, full synchro, critical
// spout, tomahawk, tengu, ground, dust
// tired spout, tired tomahawk, tired tengu, tired ground, tired dust
// spoutbeast, tomahawkbeast, tengubeast, groundbeast, dustbeast
// falzarbeast, full synchro falzarbeast, falzarbeast over

// eEventFlags - 2001c88
// eFolders - 2002178
// 0x4f0 bytes
// 0x2780 flags

// free save space: 2003f40

// 2036510 - active crosses
// sub_8029EF8 - initializes active cross list

// 86e5d50 - gregar cross windows
// 86e73d0 - gregar cross window palettes

// 30016d0 - mugshot palette
	.align 4
DefaultCrossList:
	// Cross1,Cross2,Cross3,Cross4,Cross5,Beast
	.if VERSION == GREGAR
	.byte 0x01, 0x02, 0x03, 0x04, 0x05
	.else
	.byte 0x06, 0x07, 0x08, 0x09, 0x0a
	.endif

	.align 4

beastbutton:
	// Button graphics, Chip Image, Chip Palette, Sound Effect
	.word BeastButtonGfxPtr, BeastChipImageGfxPtr, BeastChipPalettePtr, THIS_VERSION_BEAST_SFX

	.align 4
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
	ldr	r3, =sub_8015952|1
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
	mov r0, THIS_VERSION_BEAST
	add	r4, r0, r4
@@isCrossBeast:
	pop	pc

PatchCountRemainingCrosses:
	bl CheckCrossUsedUp
	ldr	r1, =PatchCountRemainingCrosses_Return|1
	bx r1

PatchActiveCrossList:
	ldr	r3, =0x20349A0
	bl CheckCrossUsedUp
	ldr	r1, =PatchActiveCrossList_Return|1
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
	ldr	r1, =PatchCrossWindowGfxPtr_Return|1
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
	ldr	r1, =PatchCrossSelectedPalette_Return|1
	bx r1

// 0x20352cc chosen cross?
// hook at 0x801cbbe
// free regs: r0, r1, r2
// other struct (r5): 0x2035280

// normal -> beast
// normal -> cross
// cross -> beast
// beast -> cross

// r0 - emotion window index
// r1 - ???
// r2 - free
// r3 - free
// r4 - emotion window index copy
// r5 - eStruct2035280
// r6 - r1 copy
// r7 - used
PatchEmotionMugGfx:
	// first check if it's a non-version exclusive mug
	mov r4, r0
	mov r6, r1
	mov r1, VERSION
	cmp r4, 5
	blt @@gotVersion
	// check if the mug has changed because we selected a cross in the cust menu
	mov r0, 0x4c
	ldrb r0, [r5,r0]
	cmp r0, 0
	// jump if the player didn't choose to transform
	beq @@getVersionFromTransformation
	// check if beast transformation was chosen
	ldr r2, =eCustScreenMenu
	ldrb r3, [r2,0x17]
	tst r3, r3
	bne @@getVersionFromTransformation
	// check if cross transformation was chosen (should always be true)
	ldrb r3, [r2,0x19]
	tst r3, r3
	beq @@getVersionFromTransformation
	// get actual chosen
	bl GetCrossList
	ldrb r0, [r2,0x1a]
	ldrb r0, [r1,r0]
	mov r1, GREGAR
	cmp r0, 6
	blt @@gotVersion
	mov r1, FALZAR
	b @@gotVersion
@@getVersionFromTransformation:
	ldr r3, [r5,0x48] // battle object ptr
	ldrb r0, [r3,0x16] // alliance field
	ldr r1, =GetBattleNaviStatsAddr|1
	mov lr, pc
	bx r1
	mov r2, 0x2c // transformation
	ldrb r2, [r0,r2]

	mov r1, VERSION
	cmp r2, 0 // baseman
	beq @@gotVersion

	mov r1, GREGAR
	cmp r2, 6 // [heat, charge]
	blt @@gotVersion

	mov r1, FALZAR
	cmp r2, 11 // [spout, dust]
	blt @@gotVersion
	cmp r2, 12 // falzar beast
	beq @@gotVersion

	mov r1, GREGAR
	cmp r2, 11 // gregar beast
	beq @@gotVersion
	cmp r2, 18 // [heatbeast, chargebeast]
	blt @@gotVersion

	mov r1, FALZAR
	cmp r2, 23 // [spoutbeast, dustbeast]
	blt @@gotVersion

	cmp r2, 24 // falzar beastover
	beq @@gotVersion
	mov r1, GREGAR

@@gotVersion:
	ldr r0, =GregarVersionEmotionMugsPointerTable
	ldr r3, =GregarVersionEmotionMugPalettes
	cmp r1, GREGAR
	beq @@gotPointerTable
	ldr r0, =FalzarVersionEmotionMugsPointerTable
	ldr r3, =FalzarVersionEmotionMugPalettes
@@gotPointerTable:
	// get emotion mug pointer
	lsl r2, r4, 2
	ldr r0, [r0,r2]
	// get emotion mug palette pointer
	lsl r4, r4, 5
	add r4, r3, r4
	ldr r1, =PatchEmotionMugGfx_Return|1
	bx r1

PatchGetCrossDescription:
	bl GetCrossList
	ldrb r0, [r5,0x1b]
	mov r2, 0x50
	add	r2, r2, r0
	ldrb r0, [r5,r2]
	ldrb r1, [r1,r0]
	sub	r1, 1
	ldr r0, =CrossDescriptionTextArchive
	ldr	r2, =PatchGetCrossDescription_Return|1
	bx r2

PatchLoadBeastIcon:
	push lr
	mov	r2, 0
	bl getbst
	ldr	r2, =PatchLoadBeastIcon_Return|1
	bx r2

PatchLoadBeastChipImage:
	mov	r2, 4
	bl getbst
	ldr	r1, =0x6009560
	ldr	r2, =PatchLoadBeastChipImage_Return|1
	bx r2

PatchLoadBeastChipPalette:
	mov	r2, 8
	bl getbst
	add	r0, r0, r1
	ldr	r1, =PatchLoadBeastChipPalette_Return|1
	bx r1

PatchPlayBeastSoundEffect:
	mov	r2, pc
	add	r2, 7h
	mov	lr, r2
	ldr	r2, =sub_80302B6|1
	bx r2
	mov	r2, 0x0C
	bl getbst
	ldr	r1, =PlaySoundEffect|1
	mov	lr, pc
	bx r1
	ldr	r0, =PatchPlayBeastSoundEffect_Return|1
	bx r0

getbst: // input: r2 = pointer number * 4, output: r0 = beastbutton
	push {r1,lr}
	ldr	r0, =beastbutton
	ldr	r0, [r0,r2]
	pop	{r1,pc}

GetCrossList:
	push {r0}
	ldr	r1, =eCrossList
	ldrb r0, [r1,0]
	cmp r0, 0
	bne @@crossListInitialized
	ldr r1, =DefaultCrossList
@@crossListInitialized:
	pop {r0}
	bx lr
	.pool

	.align 4
OppositeVersionCrossWindows:
	.import OTHER_VERSION_ROM, OTHER_VERSION_CROSS_WINDOWS_FILE_ADDR, 0x240 * 10

	.align 4
OppositeVersionCrossWindowPalettes:
	.import OTHER_VERSION_ROM, OTHER_VERSION_CROSS_WINDOW_PALETTES_FILE_ADDR, 0x20 * 10

	.macro import_mug_ptr, index
	.word readu32(OTHER_VERSION_ROM, OTHER_VERSION_EMOTION_MUG_POINTER_TABLE_ADDR + index * 4)
	.endmacro

	.macro import_mug, index
	.import OTHER_VERSION_ROM, readu32(OTHER_VERSION_ROM, OTHER_VERSION_EMOTION_MUG_POINTER_TABLE_ADDR + (index + 5) * 4) - 0x8000000, 0x100
	.endmacro

	.align 4
OppositeVersionEmotionMugsPointerTable:
	import_mug_ptr 0
	import_mug_ptr 1
	import_mug_ptr 2
	import_mug_ptr 3
	import_mug_ptr 4
	.word Cross1EmotionMug
	.word Cross2EmotionMug
	.word Cross3EmotionMug
	.word Cross4EmotionMug
	.word Cross5EmotionMug
	.word Cross1TiredEmotionMug
	.word Cross2TiredEmotionMug
	.word Cross3TiredEmotionMug
	.word Cross4TiredEmotionMug
	.word Cross5TiredEmotionMug
	.word Cross1EmotionMug
	.word Cross2EmotionMug
	.word Cross3EmotionMug
	.word Cross4EmotionMug
	.word Cross5EmotionMug
	.word NullBeastEmotionMug
	.word NullBeastEmotionMug
	.word BeastOverEmotionMug

OppositeVersionEmotionMugPalettes:
	.import OTHER_VERSION_ROM, OTHER_VERSION_EMOTION_MUG_PALETTES_ADDR, 0x20 * 23

	.align 4
Cross1EmotionMug:
	import_mug 0

Cross2EmotionMug:
	import_mug 1

Cross3EmotionMug:
	import_mug 2

Cross4EmotionMug:
	import_mug 3

Cross5EmotionMug:
	import_mug 4

Cross1TiredEmotionMug:
	import_mug 5

Cross2TiredEmotionMug:
	import_mug 6

Cross3TiredEmotionMug:
	import_mug 7

Cross4TiredEmotionMug:
	import_mug 8

Cross5TiredEmotionMug:
	import_mug 9

NullBeastEmotionMug:
	import_mug 15

BeastOverEmotionMug:
	import_mug 17

	.include "cutscene.s"

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

// sub_8015766 - decross controller
.if OPT_DECROSS_INTO_VERSION_BEAST
	.org 0x08015802
	mov	r1,THIS_VERSION_BEAST
	.org 0x08015808
	mov	r1,THIS_VERSION_BEAST
.endif

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

	.close
// eof
