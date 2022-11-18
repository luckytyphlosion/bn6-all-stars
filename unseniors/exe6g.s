
	.ifdef TL_PATCH
		INPUT_ROM          equ "exe6g_us.gba"
		OUTPUT_ROM         equ "exe6g_us-unseniors.gba"
		.definelabel fspace, 0x88fa800
	.else
		INPUT_ROM          equ "exe6g.gba"
		OUTPUT_ROM         equ "exe6g-unseniors.gba"
		.definelabel fspace, 0x87ff4fc
	.endif

	.definelabel AirspinHP, 0x80dc4d4
	.definelabel HiveBlockHappensHereFunction, 0x0802DA50
	.definelabel HiveBlockHappensHereFunction_AntiDmgCheck, 0x802DA54
	.definelabel HiveBlockHappensHereFunction_CancelDamage, 0x802DB0E
	.definelabel HiveBlockHappensHereFunction_Fix0DamageAntiMagic, 0x802DAA4
	.definelabel HiveBlockHappensHereFunction_OldHiveCheck, 0x802DAD8
	.definelabel HiveBlockHappensHereFunction_Return, 0x802DB4C

	.definelabel SpoutCrossBPwrAtkInitialize, 0x801225e
	.definelabel SlashCrossBPwrAtkInitialize, 0x80122d2

	// need to maintain compatibility with exeguy11's patch
	.definelabel TornadoDoubleDamage, 0x80cf10c

	// buster bug very tired glitch
	.definelabel callPossiblyGetBattleEmotion, 0x8016154
	.definelabel BusterBugChargeShotDamageCalc_HookLoc, 0x8012098

	// elementman timeout
	.definelabel HandleElementManTimeout, 0x80be506

	.definelabel PlaySoundEffect, 0x80005CC
	.definelabel object_setPanelType, 0x800d226
	.definelabel GetPositiveSignedRNG2, 0x8001532
	.definelabel sprite_setPalette, 0x8002d80
