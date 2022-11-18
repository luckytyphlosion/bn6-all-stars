
	.if TL_PATCH == 1
		OTHER_VERSION_ROM equ "exe6f_us.gba"
	.else
		OTHER_VERSION_ROM equ "exe6f.gba"
	.endif

IS_US equ 0

GregarVersionCrossWindows equ 0x8708774
FalzarVersionCrossWindows equ OppositeVersionCrossWindows

GregarVersionCrossWindowPalettes equ 0x8709df4
FalzarVersionCrossWindowPalettes equ OppositeVersionCrossWindowPalettes

GregarVersionEmotionMugsPointerTable equ 0x801d12c
FalzarVersionEmotionMugsPointerTable equ OppositeVersionEmotionMugsPointerTable

GregarVersionEmotionMugPalettes equ 0x875178c
FalzarVersionEmotionMugPalettes equ OppositeVersionEmotionMugPalettes

BeastButtonGfxPtr equ 0x8708374
BeastChipImageGfxPtr equ 0x874550c
BeastChipPalettePtr equ 0x8747e8c
THIS_VERSION_BEAST_SFX equ 0x191

	.if TL_PATCH == 1
		OTHER_VERSION_CROSS_WINDOWS_FILE_ADDR equ 0x810208
	.else
		OTHER_VERSION_CROSS_WINDOWS_FILE_ADDR equ 0x70A814
	.endif

OTHER_VERSION_CROSS_WINDOW_PALETTES_FILE_ADDR equ 0x70BE94
OTHER_VERSION_EMOTION_MUG_POINTER_TABLE_ADDR equ 0x1d12c
OTHER_VERSION_EMOTION_MUG_PALETTES_ADDR equ 0x753858

THIS_VERSION_BEAST equ 0xb

VERSION            equ GREGAR // 0 = Gregar, 1 = Falzar

// hooks
	.definelabel sub_8015952, 0x8015f52
	.definelabel PatchCountRemainingCrosses_Return, 0x802a2fc
	.definelabel PatchActiveCrossList_Return, 0x802a32a
	.definelabel PatchCrossWindowGfxPtr_Return, 0x802a1c0
	.definelabel PatchCrossSelectedPalette_Return, 0x802a2ca
	.definelabel PatchEmotionMugGfx_Return, 0x801cfec
	.definelabel PatchGetCrossDescription_Return, 0x8028f66
	.definelabel PatchLoadBeastIcon_Return, 0x80286c6
	.definelabel PatchLoadBeastChipImage_Return, 0x8028b3a
	.definelabel PatchLoadBeastChipPalette_Return, 0x8028b50
	.definelabel sub_80302B6, 0x8031272
	.definelabel PlaySoundEffect, 0x80005CC
	.definelabel PatchPlayBeastSoundEffect_Return, 0x8027B7E

	.definelabel Hook_OverrideCrossChosenInMenu, 0x802A49A

	.definelabel HookPool_OverrideCrossChosenInMenu, 0x0802a4f0

	.definelabel L_BUTTON_CUTSCENE_SCRIPT_ADDR, 0x809cca0

	.definelabel SHUFFLE_FOLDER_SLICE_ADDR, 0x8000d12

	.if TL_PATCH == 1
		.definelabel CrossDescriptionTextArchive, 0x883d70c
	.else
		.definelabel CrossDescriptionTextArchive, 0x8710064
	.endif