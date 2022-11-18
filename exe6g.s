
	.if TL_PATCH == 1
		INPUT_ROM          equ "exe6g_us.gba"
		.if IS_MASTERS == 1
			OUTPUT_ROM equ "exe6g_us-all-stars-masters-temp.gba"
		.else
			OUTPUT_ROM equ "exe6g_us-all-stars.gba"
		.endif
		.definelabel fspace, 0x88fa800
	.else
		INPUT_ROM          equ "exe6g.gba"
		.if IS_MASTERS == 1
			OUTPUT_ROM equ "exe6g-all-stars-masters-temp.gba"
		.else
			OUTPUT_ROM equ "exe6g-all-stars-masters.gba"
		.endif
		.definelabel fspace, 0x87ff4fc
	.endif

	.include "all-stars/exe6g.s"
	.if IS_US == 0 && IS_MASTERS == 0
	.include "unseniors/exe6g.s"
	.endif
	.include "bbn6/exe6g_addr.asm"
	.if IS_MASTERS == 1
	.include "kaizouloader/Taisen_GXX.asm"
	.endif
