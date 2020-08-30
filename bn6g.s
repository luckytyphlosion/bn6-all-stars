
INPUT_ROM          equ "bn6g.gba"
OTHER_VERSION_ROM  equ "bn6f.gba"
OUTPUT_ROM         equ "bn6g-all-stars.gba"

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

fspace             equ 0x087FE36C
VERSION            equ GREGAR // 0 = Gregar, 1 = Falzar
