
INPUT_ROM          equ "bn6f.gba"
OTHER_VERSION_ROM  equ "bn6g.gba"

GregarVersionCrossWindows equ OppositeVersionCrossWindows
FalzarVersionCrossWindows equ 0x86E7DCC

GregarVersionCrossWindowPalettes equ OppositeVersionCrossWindowPalettes
FalzarVersionCrossWindowPalettes equ 0x86E944C

OTHER_VERSION_CROSS_WINDOWS_FILE_ADDR equ 0x6e5d50
OTHER_VERSION_CROSS_WINDOW_PALETTES_FILE_ADDR equ 0x6e73d0

THIS_VERSION_CROSS_WINDOWS_ADDR equ 0x86E7DCC

fspace             equ 0x087FE36C
VERSION            equ FALZAR // 0 = Gregar, 1 = Falzar
