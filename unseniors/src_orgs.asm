
	.macro fizzle_chip, chip_id
	.org 0x80221bc + (chip_id) * 44 + 0xb
	.byte 0x1c, 3
	.endmacro

	; fix riskyhoney hive block difference on antidmg and antisword
	.org HiveBlockHappensHereFunction
	ldr r0, =Hook_DoHiveCheckFirst|1
	bx r0

	.org HiveBlockHappensHereFunction_Fix0DamageAntiMagic
	blt HiveBlockHappensHereFunction_AntiDmgNotTriggered

	.org HiveBlockHappensHereFunction_OldHiveCheck
HiveBlockHappensHereFunction_AntiDmgNotTriggered:
	cmp r6, 1
	beq HiveBlockHappensHereFunction_CancelDamage
	b HiveBlockHappensHereFunction_Return
	.pool

	; fix B PowerAttack glitch
	.org SpoutCrossBPwrAtkInitialize+0x14
	strb r0, [r7, 0x2]
	mov r0, 0xd
	str r0, [r7, 0xc]
	mov r0, 0
	strh r0, [r7, 0x6] ; atk boost
	mov r0, 0x25
	pop pc

	.org SlashCrossBPwrAtkInitialize
	push r4,lr ; modify push since we tail into another function to save space

	.org SlashCrossBPwrAtkInitialize+0x10
	mov r0, 0x80
	strb r0, [r7, 2]
	mov r0, 0
	str r0, [r7, 0xc]
	strh r0, [r7, 0x6] ; atk boost
	mov r0, 0x10
	b SlashCrossBPwrAtkInitialize-0x6

	.org TornadoDoubleDamage
	ldr r1, =Hook_FixTornadoDoubleDamage|1
	bx r1
	.pool
Hook_FixTornadoDoubleDamage_Return:
	lsl r0, r0, 1
	orr r0, r2

	.org BusterBugChargeShotDamageCalc_HookLoc
	ldr r1, =Hook_BusterBugChargeShotDamageCalc|1
	bx r1
	.pool
Hook_BusterBugChargeShotDamageCalc_Return:

	.org HandleElementManTimeout
	ldr r0, =Hook_FixElementManTimeout|1
	bx r0
	.pool

	.org HandleElementManTimeout+0x1a
Hook_FixElementManTimeout_Return:

	fizzle_chip 18 ; GunDelEX
	fizzle_chip 153 ; Otenko
	fizzle_chip 256+19 ; HackJack
	fizzle_chip 256+20 ; HackJckEX
	fizzle_chip 256+21 ; HackJckSP
	fizzle_chip 256+22 ; Django
	fizzle_chip 256+23 ; Django2
	fizzle_chip 256+24 ; Django3
	fizzle_chip 256+55 ; DblBeast
	fizzle_chip 256+56 ; Gregar
	fizzle_chip 256+57 ; Falzar
	fizzle_chip 256+93 ; CrosOver

	.org AirspinHP
	.halfword 400
