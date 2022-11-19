
	.if SOUND_MOD == 1
		INPUT_ROM          equ "bn6f-soundmod-extend.gba"
		OUTPUT_ROM         equ "bn6f-all-stars-soundmod-extend.gba"
		fspace             equ 0x08843000
	.else
		INPUT_ROM          equ "bn6f.gba"
		OUTPUT_ROM         equ "bn6f-all-stars.gba"
		fspace             equ 0x087FE36C
	.endif

	.include "all-stars/bn6f.s"
	.include "bbn6/bn6f_addr.asm"
