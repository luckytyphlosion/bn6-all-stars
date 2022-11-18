
	.if TL_PATCH == 1
		INPUT_ROM          equ "exe6f_us.gba"
		OUTPUT_ROM         equ "exe6f_us-all-stars.gba"
		.definelabel fspace, 0x8911200
	.else
		INPUT_ROM          equ "exe6f.gba"
		OUTPUT_ROM         equ "exe6f-all-stars.gba"
		.definelabel fspace, 0x87ff4fc
	.endif

	.include "all-stars/exe6f.s"
	.include "unseniors/exe6f.s"
	.include "bbn6/exe6f_addr.asm"
