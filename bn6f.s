
INPUT_ROM          equ "bn6f.gba"
OTHER_VERSION_ROM  equ "bn6g.gba"
OUTPUT_ROM         equ "bn6f-all-stars.gba"

GregarVersionCrossWindows equ OppositeVersionCrossWindows
FalzarVersionCrossWindows equ 0x86E7DCC

GregarVersionCrossWindowPalettes equ OppositeVersionCrossWindowPalettes
FalzarVersionCrossWindowPalettes equ 0x86E944C

GregarVersionEmotionMugsPointerTable equ OppositeVersionEmotionMugsPointerTable
FalzarVersionEmotionMugsPointerTable equ 0x801cd08

GregarVersionEmotionMugPalettes equ OppositeVersionEmotionMugPalettes
FalzarVersionEmotionMugPalettes equ 0x872f114

BeastButtonGfxPtr equ 0x86e79cc
BeastChipImageGfxPtr equ 0x8723034
BeastChipPalettePtr equ 0x8725814
THIS_VERSION_BEAST_SFX equ 0x193

OTHER_VERSION_CROSS_WINDOWS_FILE_ADDR equ 0x6e5d50
OTHER_VERSION_CROSS_WINDOW_PALETTES_FILE_ADDR equ 0x6e73d0
OTHER_VERSION_EMOTION_MUG_POINTER_TABLE_ADDR equ 0x1cd08
OTHER_VERSION_EMOTION_MUG_PALETTES_ADDR equ 0x72d050

THIS_VERSION_BEAST equ 0xc

fspace             equ 0x087FE36C
VERSION            equ FALZAR // 0 = Gregar, 1 = Falzar

// hooks
	.definelabel sub_8015952, 0x8015952
	.definelabel PatchCountRemainingCrosses_Return, 0x8029eea
	.definelabel PatchActiveCrossList_Return, 0x8029f1a
	.definelabel PatchCrossWindowGfxPtr_Return, 0x8029dac
	.definelabel PatchCrossSelectedPalette_Return, 0x8029EB6
	.definelabel PatchEmotionMugGfx_Return, 0x801cbc8
	.definelabel PatchGetCrossDescription_Return, 0x8028B54
	.definelabel PatchLoadBeastIcon_Return, 0x80282B2
	.definelabel PatchLoadBeastChipImage_Return, 0x8028726
	.definelabel PatchLoadBeastChipPalette_Return, 0x802873C
	.definelabel sub_80302B6, 0x80302B6
	.definelabel PlaySoundEffect, 0x80005CC
	.definelabel PatchPlayBeastSoundEffect_Return, 0x802776A

	.definelabel Hook_OverrideCrossChosenInMenu, 0x802A08A
	.definelabel HookPool_OverrideCrossChosenInMenu, 0x0802A0E0

	.definelabel L_BUTTON_CUTSCENE_SCRIPT_ADDR, 0x80991f4

