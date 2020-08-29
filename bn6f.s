
INPUT_ROM          equ "bn6f.gba"
OTHER_VERSION_ROM  equ "bn6g.gba"

GregarVersionCrossWindows equ OppositeVersionCrossWindows
FalzarVersionCrossWindows equ 0x86E7DCC

GregarVersionCrossWindowPalettes equ OppositeVersionCrossWindowPalettes
FalzarVersionCrossWindowPalettes equ 0x86E944C

GregarVersionEmotionMugsPointerTable equ OppositeVersionEmotionMugsPointerTable
FalzarVersionEmotionMugsPointerTable equ 0x801cd08

GregarVersionEmotionMugPalettes equ OppositeVersionEmotionMugPalettes
FalzarVersionEmotionMugPalettes equ 0x872f114

OTHER_VERSION_CROSS_WINDOWS_FILE_ADDR equ 0x6e5d50
OTHER_VERSION_CROSS_WINDOW_PALETTES_FILE_ADDR equ 0x6e73d0
OTHER_VERSION_EMOTION_MUG_POINTER_TABLE_ADDR equ 0x1cd08
OTHER_VERSION_EMOTION_MUG_PALETTES_ADDR equ 0x72d050

THIS_VERSION_CROSS_WINDOWS_ADDR equ 0x86E7DCC

fspace             equ 0x087FE36C
VERSION            equ FALZAR // 0 = Gregar, 1 = Falzar
