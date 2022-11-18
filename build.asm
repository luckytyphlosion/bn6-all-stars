
	.gba
	.include ver
	.include "macros.asm"

	.open INPUT_ROM, OUTPUT_ROM, 0x8000000

	; === orgs ===
	.include "all-stars/src_orgs.s"

	.if IS_US == 0 && IS_MASTERS == 0
	.include "unseniors/src_orgs.asm"
	.endif

	.include "bbn6/src_orgs.asm"

	.if IS_MASTERS == 1
	.include "kaizouloader/src_orgs.asm"
	.endif

	; === Free Space ===
	.org fspace
	.include "all-stars/src_farspace.s"

	.if IS_US == 0 && IS_MASTERS == 0
	.include "unseniors/src_farspace.asm"
	.endif

	.include "bbn6/src_farspace.asm"

	.if IS_MASTERS == 1
	.include "kaizouloader/src_farspace.asm"
	.endif

	.close
; eof
