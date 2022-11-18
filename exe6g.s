
	.if TL_PATCH == 1
		INPUT_ROM          equ "exe6g_us.gba"
		OUTPUT_ROM         equ "exe6g_us-all-stars.gba"
		.definelabel fspace, 0x88fa800
	.else
		INPUT_ROM          equ "exe6g.gba"
		OUTPUT_ROM         equ "exe6g-all-stars.gba"
		.definelabel fspace, 0x87ff4fc
	.endif

	.include "all-stars/exe6g.s"
	.include "unseniors/exe6g.s"
	.include "bbn6/exe6g_addr.asm"
