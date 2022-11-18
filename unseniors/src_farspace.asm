
Hook_DoHiveCheckFirst:
	push r4,r6,r7,lr
	ldr r4, [r5, 0x54]

	ldr r1, =0x8010934|1
	mov lr, pc
	bx r1

	ldr r1, =0x200000
	tst r0, r1
	beq @@doAntiDmgCheck
	mov r1, 0x84
	ldrh r1, [r4, r1]
	cmp r1, 0
	bne @@doAntiDmgCheck
	mov r0, 0x82
	add r0, r0, r4
	ldrh r2, [r0]
	ldrh r1, [r0, 0x4]
	orr r2, r1
	ldrh r1, [r0, 0x6]
	orr r2, r1
	ldrh r1, [r0, 0x8]
	orr r2, r1
	cmp r2, 0x0
	beq @@cancelDamage
	ldr r3, [r5, 0x58]
	add r3, 0xA0
	mov r0, 0x1
	str r0, [r3, 0x30]

	mov r0, 0x6E
	ldr r1, =PlaySoundEffect|1
	mov lr, pc
	bx r1

	b @@cancelDamage
@@doAntiDmgCheck:
	ldr r0, =HiveBlockHappensHereFunction_AntiDmgCheck|1
	bx r0
@@cancelDamage:
	ldr r0, =HiveBlockHappensHereFunction_CancelDamage|1
	bx r0

Hook_FixTornadoDoubleDamage:
	ldrb r1, [r5, 0x13]
	mov r2, 2
	ldr r3, =object_setPanelType|1
	mov lr, pc
	bx r3
	ldrh r0, [r5, oBattleObject_Damage]
	ldr r1, =0xf800 
	mov r2, r1
	and r2, r0
	bic r0, r1
	ldr r1, =Hook_FixTornadoDoubleDamage_Return|1
	bx r1

Hook_BusterBugChargeShotDamageCalc:
	push r0
	ldrb r0, [r5, oBattleObject_Alliance]
	ldr r1, =callPossiblyGetBattleEmotion|1
	mov lr, pc
	bx r1
	cmp r0, 5
	pop r0
	bne @@notVeryTired
	mov r0, 1
@@notVeryTired:
	mov r1, 10
	mul r0, r1
	strh r0, [r7, oAIAttackVars_Damage]
	mov r1, oNaviStats_Unk_4f 
	ldr r0, =Hook_BusterBugChargeShotDamageCalc_Return|1
	bx r0

Hook_FixElementManTimeout:
	ldr r0, =GetPositiveSignedRNG2|1
	mov lr, pc
	bx r0
	mov r1, 3
	and r0, r1
	str r0, [r5, oBattleObject_ExtraVars]
	ldr r1, =@@elementManPalettes
	ldrb r0, [r1, r0]
	ldr r1, =sprite_setPalette|1
	mov lr, pc
	bx r1
	mov r0, 0xc
	strb r0, [r5, oBattleObject_CurAction]
	mov r0, 0
	strh r0, [r5, oBattleObject_CurPhaseAndPhaseInitialized]
	ldr r0, =Hook_FixElementManTimeout_Return|1
	bx r0

@@elementManPalettes:
	.byte 2, 4, 8, 6

	.pool

	