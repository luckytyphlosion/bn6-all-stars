
OTHER_VERSION_ROM  equ "bn6f.gba"

IS_US equ 1
TL_PATCH equ 0

GregarVersionCrossWindows equ 0x86E5D50
FalzarVersionCrossWindows equ OppositeVersionCrossWindows

GregarVersionCrossWindowPalettes equ 0x86e73d0
FalzarVersionCrossWindowPalettes equ OppositeVersionCrossWindowPalettes

GregarVersionEmotionMugsPointerTable equ 0x801cd08
FalzarVersionEmotionMugsPointerTable equ OppositeVersionEmotionMugsPointerTable

GregarVersionEmotionMugPalettes equ 0x872d050
FalzarVersionEmotionMugPalettes equ OppositeVersionEmotionMugPalettes

BeastButtonGfxPtr equ 0x86e5950
BeastChipImageGfxPtr equ 0x8720f70
BeastChipPalettePtr equ 0x8723750
THIS_VERSION_BEAST_SFX equ 0x191

OTHER_VERSION_CROSS_WINDOWS_FILE_ADDR equ 0x6e7dcc
OTHER_VERSION_CROSS_WINDOW_PALETTES_FILE_ADDR equ 0x6e944c
OTHER_VERSION_EMOTION_MUG_POINTER_TABLE_ADDR equ 0x1cd08
OTHER_VERSION_EMOTION_MUG_PALETTES_ADDR equ 0x72f114

THIS_VERSION_BEAST equ 0xb

VERSION            equ GREGAR // 0 = Gregar, 1 = Falzar

// hooks
	.definelabel sub_8015952, 0x8015952
	.definelabel PatchCountRemainingCrosses_Return, 0x8029ee8
	.definelabel PatchActiveCrossList_Return, 0x8029f16
	.definelabel PatchCrossWindowGfxPtr_Return, 0x8029dac
	.definelabel PatchCrossSelectedPalette_Return, 0x8029EB6
	.definelabel PatchEmotionMugGfx_Return, 0x801cbc8
	.definelabel PatchGetCrossDescription_Return, 0x8028B52
	.definelabel PatchLoadBeastIcon_Return, 0x80282B2
	.definelabel PatchLoadBeastChipImage_Return, 0x8028726
	.definelabel PatchLoadBeastChipPalette_Return, 0x802873C
	.definelabel sub_80302B6, 0x80302B6
	.definelabel PlaySoundEffect, 0x80005CC
	.definelabel PatchPlayBeastSoundEffect_Return, 0x802776A

	.definelabel Hook_OverrideCrossChosenInMenu, 0x802A086
	.definelabel HookPool_OverrideCrossChosenInMenu, 0x0802A0DC

	.definelabel L_BUTTON_CUTSCENE_SCRIPT_ADDR, 0x809a72c

	.definelabel SHUFFLE_FOLDER_SLICE_ADDR, 0x8000d12

	.definelabel CrossDescriptionTextArchive, 0x86ed458
