
INPUT_ROM          equ "bn6f.gba"
OUTPUT_ROM         equ "bn6f-all-stars.gba"
fspace             equ 0x087FE36C

	.include "all-stars/bn6f.s"
	.include "bbn6/bn6f_addr.asm"
