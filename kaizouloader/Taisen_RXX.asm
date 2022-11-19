; for EXE6RXX
loadPasswordIndex equ 0x08044898
loadKaizouCard equ 0x8141868
playSound equ 0x081597FE
playSoundConst1 equ 0x8163150
memcopyCardNames equ 0x0815879C
cardNameAddress	equ 0x081417B4

	.if SOUND_MOD == 1
		kaizouLoaderCodeSpace equ 0x0806fb10 ; not actually free space, overwrites some comps1 coord text indices
	.else
		kaizouLoaderCodeSpace equ 0x08071E00 ; not actually free space, overwrites some comps2 coord text indices
	.endif

; new
	.definelabel LansRoomSecondaryTextScriptPtrLoc, 0x80456b4
	.definelabel LansRoomNPCScriptsPtrLoc, 0x80503cc
	.definelabel LansRoom_NPCScript0, 0x80535cc
