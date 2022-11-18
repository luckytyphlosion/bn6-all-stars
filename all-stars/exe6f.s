
OTHER_VERSION_ROM  equ "exe6g.gba"

IS_US equ 0

GregarVersionCrossWindows equ OppositeVersionCrossWindows
FalzarVersionCrossWindows equ 0x870A814

GregarVersionCrossWindowPalettes equ OppositeVersionCrossWindowPalettes
FalzarVersionCrossWindowPalettes equ 0x870BE94

GregarVersionEmotionMugsPointerTable equ OppositeVersionEmotionMugsPointerTable
FalzarVersionEmotionMugsPointerTable equ 0x801d12c

GregarVersionEmotionMugPalettes equ OppositeVersionEmotionMugPalettes
FalzarVersionEmotionMugPalettes equ 0x8753858

BeastButtonGfxPtr equ 0x870a414
BeastChipImageGfxPtr equ 0x87475d8
BeastChipPalettePtr equ 0x8749f58
THIS_VERSION_BEAST_SFX equ 0x193

OTHER_VERSION_CROSS_WINDOWS_FILE_ADDR equ 0x708774
OTHER_VERSION_CROSS_WINDOW_PALETTES_FILE_ADDR equ 0x709df4
OTHER_VERSION_EMOTION_MUG_POINTER_TABLE_ADDR equ 0x1d12c
OTHER_VERSION_EMOTION_MUG_PALETTES_ADDR equ 0x75178c

THIS_VERSION_BEAST equ 0xc

VERSION            equ FALZAR // 0 = Gregar, 1 = Falzar

// hooks
	.definelabel sub_8015952, 0x8015f52
	.definelabel PatchCountRemainingCrosses_Return, 0x802a2fe
	.definelabel PatchActiveCrossList_Return, 0x802a32e
	.definelabel PatchCrossWindowGfxPtr_Return, 0x802a1c0
	.definelabel PatchCrossSelectedPalette_Return, 0x802a2ca
	.definelabel PatchEmotionMugGfx_Return, 0x801cfec
	.definelabel PatchGetCrossDescription_Return, 0x8028f68
	.definelabel PatchLoadBeastIcon_Return, 0x80286c6
	.definelabel PatchLoadBeastChipImage_Return, 0x8028b3a
	.definelabel PatchLoadBeastChipPalette_Return, 0x8028b50
	.definelabel sub_80302B6, 0x8031272
	.definelabel PlaySoundEffect, 0x80005CC
	.definelabel PatchPlayBeastSoundEffect_Return, 0x8027B7E

	.definelabel Hook_OverrideCrossChosenInMenu, 0x802A49e
	.definelabel HookPool_OverrideCrossChosenInMenu, 0x0802a4f4

	.definelabel L_BUTTON_CUTSCENE_SCRIPT_ADDR, 0x809b770

	.definelabel SHUFFLE_FOLDER_SLICE_ADDR, 0x8000d12

	.definelabel CrossDescriptionTextArchive, 0x8712104
