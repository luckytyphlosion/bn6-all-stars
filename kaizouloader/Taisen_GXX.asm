; for EXE6GXX
loadPasswordIndex equ 0x08044868
loadKaizouCard equ 0x8143630
playSound equ 0x0815B33A
playSoundConst1 equ 0x8164C8C
memcopyCardNames equ 0x0815A2D8
cardNameAddress	equ 0x0814357C
kaizouLoaderCodeSpace equ 0x08072CA0 ; not actually free space, overwrites some comps2 coord text indices

; new
	.definelabel LansRoomSecondaryTextScriptPtrLoc, 0x8045684
	.definelabel LansRoomNPCScriptsPtrLoc, 0x8051250
	.definelabel LansRoom_NPCScript0, 0x8054450
