
PatchLButtonCutsceneScript:
	cs_lock_player_for_non_npc_dialogue_809e0b0
	cs_nop_80377d0
	cs_set_event_flag CS_VAR_IMM, 0x1731
	cs_write_ow_player_fixed_anim_select_8037dac CS_VAR_IMM, 0x4
	cs_decomp_text_archive ChooseCrossesTextScript
	cs_run_text_script CS_VAR_IMM, 0
	cs_wait_chatbox 0x80
	cs_ow_player_sprite_special_with_arg 0x4, CS_VAR_IMM, 0x4
	cs_write_ow_player_fixed_anim_select_8037dac CS_VAR_IMM, 0x4
	cs_unlock_player_after_non_npc_dialogue_809e122
	cs_end_for_map_reload_maybe_8037c64

	.align 4, 0
ChooseCrossesTextScript:
	.import "temp/ChooseCrossesTextScript.msg"
