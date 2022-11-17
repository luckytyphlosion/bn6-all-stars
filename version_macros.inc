
	.macro .vdefinelabel, label_name, us_offset, jp_offset
		.if IS_US == 1
			.definelabel label_name, us_offset
		.else
			.definelabel label_name, jp_offset
		.endif
	.endmacro

	.macro .vorg, us_offset, jp_offset
		.if IS_US == 1
			.org us_offset
		.else
			.org jp_offset
		.endif
	.endmacro
