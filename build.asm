
	.gba
	.include ver
	.include "macros.asm"

	.open INPUT_ROM, OUTPUT_ROM, 0x8000000

	; orgs
	.include "all-stars/src_orgs.s"

	.if IS_US == 0
	.include "unseniors/src_orgs.asm"
	.endif

	.include "bbn6/src_orgs.asm"

	.org fspace
	.include "all-stars/src_farspace.s"

	.if IS_US == 0
	.include "unseniors/src_farspace.asm"
	.endif

	.include "bbn6/src_farspace.asm"

	.close
; eof
