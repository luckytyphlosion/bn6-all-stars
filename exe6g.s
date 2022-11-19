
	.if TL_PATCH == 1
		INPUT_ROM          equ "exe6g_us.gba"
		.if IS_MASTERS == 1
			OUTPUT_ROM equ "exe6g_us-all-stars-masters-temp.gba"
		.else
			OUTPUT_ROM equ "exe6g_us-all-stars.gba"
		.endif
		.definelabel fspace, 0x88fa800
	.else
		.if IS_MASTERS == 1 && SOUND_MOD == 1
			INPUT_ROM equ "exe6g-soundmod-extend.gba"
			OUTPUT_ROM equ "exe6g-all-stars-masters-soundmod-extend-temp.gba"
			.definelabel fspace, 0x8843000
		.elseif IS_MASTERS == 1 && SOUND_MOD == 0
			INPUT_ROM equ "exe6g.gba"
			OUTPUT_ROM equ "exe6g-all-stars-masters-temp.gba"
			.definelabel fspace, 0x87ff4fc
		.elseif IS_MASTERS == 0 && SOUND_MOD == 1
			INPUT_ROM equ "exe6g-soundmod-extend.gba"
			OUTPUT_ROM equ "exe6g-all-stars-soundmod-extend.gba"			
			.definelabel fspace, 0x8843000
		.else
			INPUT_ROM equ "exe6g.gba"
			OUTPUT_ROM equ "exe6g-all-stars.gba"
			.definelabel fspace, 0x87ff4fc
		.endif
	.endif

	.include "all-stars/exe6g.s"
	.if IS_US == 0 && IS_MASTERS == 0
	.include "unseniors/exe6g.s"
	.endif
	.include "bbn6/exe6g_addr.asm"
	.if IS_MASTERS == 1
	.include "kaizouloader/Taisen_GXX.asm"
	.endif
