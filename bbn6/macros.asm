VERBOSE equ 0
AM_DEBUGGING equ 0

.macro symoff
	.if VERBOSE == 0 :: .sym off :: .endif
.endmacro

.macro poool
	.sym off
	.pool
	.sym on
.endmacro
