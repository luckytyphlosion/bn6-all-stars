
PatchLButtonCutsceneScript:
	cs_lock_player_for_non_npc_dialogue_809e0b0
	cs_nop_80377d0
	cs_set_event_flag CS_VAR_IMM, 0x1731
	cs_write_ow_player_fixed_anim_select_8037dac CS_VAR_IMM, 0x4
	cs_decomp_text_archive ChooseCrossesTextScript
	cs_set_var 4, 0
	cs_set_var 5, 0
	cs_set_var 6, 0
	cs_set_var 7, 0
	cs_run_text_script CS_VAR_IMM, 0
@@loop:
	cs_wait_var_equal 8, 1 // wait for cross to be selected
	cs_jump_if_var_equal 9, 1, @@abortedCrossSelection
	cs_call_native_with_return_value AddCrossToSelectedCrosses|1
	cs_jump_if_var_equal 5, 5, @@allCrossesSelected
	cs_jump @@loop
@@abortedCrossSelection:
	cs_set_var 8, 0
	cs_wait_chatbox 0x80
	cs_jump @@finishCutscene
@@allCrossesSelected:
	cs_wait_chatbox 0x80
	cs_call_native_with_return_value WriteCrossesToCrossList|1
@@finishCutscene:
	cs_ow_player_sprite_special_with_arg 0x4, CS_VAR_IMM, 0x4
	cs_write_ow_player_fixed_anim_select_8037dac CS_VAR_IMM, 0x4
	cs_unlock_player_after_non_npc_dialogue_809e122
	cs_end_for_map_reload_maybe_8037c64

	.align 2, 0
AddCrossToSelectedCrosses:
	push {r4-r7,lr}
	ldrb r3, [r5,4] // temp var
	mov r0, 0x44
	add r0, r5, r0 // extra cutscene variables
	mov r1, 0
	strb r1, [r5,8]
@@loop:
	ldrb r2, [r0,r1]
	cmp r2, 0
	beq @@endOfList
	cmp r2, r3
	beq @@crossAlreadyAdded
	add r1, 1
	cmp r1, 5
	blt @@loop
@@endOfList:
	strb r3, [r0,r1]
	add r1, 1
	strb r1, [r5,5] // current cross
	mov r0, 0
	pop {r4-r7,lr}
@@crossAlreadyAdded:
	mov r0, 1
	strb r0, [r5,6]
	mov r0, 0
	pop {r4-r7,lr}

WriteCrossesToCrossList:
	push {r4-r7,lr}
	mov r0, 0x44
	add r0, r5, r0
	ldr r1, =eCrossList
	mov r2, 5
	ldr r3, =CopyBytes|1
	mov lr, pc
	bx r3
	mov r0, 0
	pop {r4-r7,lr}
	.align 4, 0
	.pool

	.align 4, 0
ChooseCrossesTextScript:
	.import "temp/ChooseCrossesTextScript.msg"

