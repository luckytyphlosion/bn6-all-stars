
	.if SOUND_MOD == 1
		INPUT_ROM          equ "bn6g-soundmod-extend.gba"
		OUTPUT_ROM         equ "bn6g-all-stars-soundmod-extend.gba"
		fspace             equ 0x08843000
	.else
		INPUT_ROM          equ "bn6g.gba"
		OUTPUT_ROM         equ "bn6g-all-stars.gba"
		fspace             equ 0x087FE36C
	.endif

	.include "all-stars/bn6g.s"
	.include "bbn6/bn6g_addr.asm"
