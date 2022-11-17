
// maybe one day I'll add redefinable labels to armips
//	.definelabel __enum_inc_amount, 1
//	.definelabel __subenum_inc_amount, 1
//
//	.macro enum_start, x, inc_amount
//	.definelabel __enum__, x
//	.definelabel __enum_inc_amount, inc_amount
//	.endmacro
//
//	.macro enum, constant
//	.definelabel constant, __enum__
//	.definelabel __enum__, __enum__ + __enum_inc_amount
//	.endmacro
//
//	.macro enum_skip, skip_amount
//	.definelabel __enum__, __enum__ + skip_amount
//	.endmacro
//
//	.macro subenum_start, x, inc_amount
//	.definelabel __subenum__, x
//	.definelabel __subenum_inc_amount, inc_amount
//	.endmacro
//
//	.macro subenum, constant
//	.definelabel constant, __subenum__
//	.definelabel __subenum__, __subenum__ + __subenum_inc_amount
//	.endmacro
//
//	.macro subenum_skip, skip_amount
//	.definelabel __subenum__, __subenum__ + skip_amount
//	.endmacro
//
//	.definelabel __sum, __enum_inc_amount + __subenum_inc_amount

	.macro fake_enum_start, x, inc_amount
	.endmacro

	.macro fake_enum, constant, value
	.definelabel constant, value
	.endmacro

	.macro fake_enum_skip, skip_amount
	.endmacro

	.macro fake_subenum_start, x, inc_amount
	.endmacro

	.macro fake_subenum, constant, value
	.definelabel constant, value
	.endmacro

	.macro fake_subenum_skip, skip_amount
	.endmacro

	// .macro enum_start
	// .headersize 0
	// .org 0
	// .endmacro

	// .macro enum_end
	// .headersize 0x8000000
	// .endmacro

	// .macro enum, name
// name:
	// .skip 1
	// .endmacro
