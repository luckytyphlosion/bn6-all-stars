
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
	.definelabel TornadoDoubleDamage, 0x80cd8ac

	// buster bug very tired glitch
	.definelabel callPossiblyGetBattleEmotion, 0x8016154
	.definelabel BusterBugChargeShotDamageCalc_HookLoc, 0x8012098

	// elementman timeout
	.definelabel HandleElementManTimeout, 0x80bcca6

	.definelabel object_setPanelType, 0x800d226
	.definelabel GetPositiveSignedRNG2, 0x8001532
	.definelabel sprite_setPalette, 0x8002d80
