
INPUT_ROM          equ "bn6g.gba"
OUTPUT_ROM         equ "bn6g-all-stars.gba"
fspace             equ 0x087FE36C

	.include "all-stars/bn6g.s"
	.include "bbn6/bn6g_addr.asm"
