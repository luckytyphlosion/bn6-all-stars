
	.if TL_PATCH == 1
		INPUT_ROM          equ "exe6f_us.gba"
		.if IS_MASTERS == 1
			OUTPUT_ROM equ "exe6f_us-all-stars-masters-temp.gba"
		.else
			OUTPUT_ROM equ "exe6f_us-all-stars.gba"
		.endif
		.definelabel fspace, 0x8911200
	.else
		INPUT_ROM          equ "exe6f.gba"
		.if IS_MASTERS == 1
			OUTPUT_ROM equ "exe6f-all-stars-masters-temp.gba"
		.else
			OUTPUT_ROM equ "exe6f-all-stars.gba"
		.endif
		.definelabel fspace, 0x87ff4fc
	.endif

	.include "all-stars/exe6f.s"
	.if IS_US == 0 && IS_MASTERS == 0
	.include "unseniors/exe6f.s"
	.endif
	.include "bbn6/exe6f_addr.asm"
	.if IS_MASTERS == 1
	.include "kaizouloader/Taisen_RXX.asm"
	.endif
