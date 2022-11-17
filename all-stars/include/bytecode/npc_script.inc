
	fake_enum_start 0, 1

	fake_enum npc_end_cmd, 0x00 // 0x00
// 0x00
// end npc script
	.macro npc_end
	.byte npc_end_cmd
	.endmacro

	fake_enum_skip 1

	fake_enum npc_jump_cmd, 0x02 // 0x02
// 0x02 destination1
// jump to another script
// destination1 - script to jump to
	.macro npc_jump, destination1
	.byte npc_jump_cmd
	.word destination1
	.endmacro

	fake_enum npc_free_and_end_cmd, 0x03 // 0x03
// 0x03
// free current npc
	.macro npc_free_and_end
	.byte npc_free_and_end_cmd
	.endmacro

	fake_enum npc_jump_if_flag_set_cmd, 0x04 // 0x04
// 0x04 hword1 destination3
// jump if the given event flag is set
// hword1 - event flag to test
// destination3 - script to jump to
	.macro npc_jump_if_flag_set, hword1, destination3
	.byte npc_jump_if_flag_set_cmd
	.halfword hword1
	.word destination3
	.endmacro

	fake_enum npc_jump_if_flag_clear_cmd, 0x05 // 0x05
// 0x05 hword1 destination3
// jump if the given event flag is clear
// hword1 - event flag to test
// destination3 - script to jump to
	.macro npc_jump_if_flag_clear, hword1, destination3
	.byte npc_jump_if_flag_clear_cmd
	.halfword hword1
	.word destination3
	.endmacro

	fake_enum npc_set_event_flag_cmd, 0x06 // 0x06
// 0x06 hword1
// set event flag
// hword1 - event flag to set
	.macro npc_set_event_flag, hword1
	.byte npc_set_event_flag_cmd
	.halfword hword1
	.endmacro

	fake_enum npc_clear_event_flag_cmd, 0x07 // 0x07
// 0x07 hword1
// clear event flag
// hword1 - event flag to clear
	.macro npc_clear_event_flag, hword1
	.byte npc_clear_event_flag_cmd
	.halfword hword1
	.endmacro

	fake_enum npc_set_active_and_visible_cmd, 0x08 // 0x08
// 0x08
// set the npc to be active and visible
	.macro npc_set_active_and_visible
	.byte npc_set_active_and_visible_cmd
	.endmacro

	fake_enum npc_set_active_and_invisible_cmd, 0x09 // 0x09
// 0x09
// set the npc to be active and invisible
	.macro npc_set_active_and_invisible
	.byte npc_set_active_and_invisible_cmd
	.endmacro

	fake_enum npc_set_collision_radius_cmd, 0x0a // 0x0a
// 0x0a byte1
// set npc collision radius
// byte1 - new value of collision radius
	.macro npc_set_collision_radius, byte1
	.byte npc_set_collision_radius_cmd
	.byte byte1
	.endmacro

	fake_enum npc_set_z_reach_cmd, 0x0b // 0x0b
// 0x0b byte1
// set the z reach value for the current npc
// z reach being the maximum difference of z coordinates
// between two objects for them to interact
// e.g. talking to an NPC on a slope
// byte1 - new z reach value
	.macro npc_set_z_reach, byte1
	.byte npc_set_z_reach_cmd
	.byte byte1
	.endmacro

	fake_enum npc_shift_center_cmd, 0x0c // 0x0c
// 0x0c signedbyte1 signedbyte2 signedbyte3
// shift the center of the npc given the three args
// not exactly sure what this is for
// npc collision is shifted, as well as the interaction area
// but the npc sprite is not shifted
// and the interaction area without the center shift still exists
// and interacting to the npc via the original interaction area
// will cause the sprite to move
// signedbyte1 - x offset for npc center
// signedbyte2 - y offset for npc center
// signedbyte3 - z offset for npc center
	.macro npc_shift_center, signedbyte1, signedbyte2, signedbyte3
	.byte npc_shift_center_cmd
	.byte signedbyte1
	.byte signedbyte2
	.byte signedbyte3
	.endmacro

	fake_enum npc_enable_npc_interaction_cmd, 0x0d // 0x0d
// 0x0d
// enable NPC interaction (talking to the NPC)
	.macro npc_enable_npc_interaction
	.byte npc_enable_npc_interaction_cmd
	.endmacro

	fake_enum npc_disable_npc_interaction_cmd, 0x0e // 0x0e
// 0x0e
// disable NPC interaction (talking to the NPC)
	.macro npc_disable_npc_interaction
	.byte npc_disable_npc_interaction_cmd
	.endmacro

	fake_enum npc_set_npc_palette_index_cmd, 0x0f // 0x0f
// 0x0f byte1
// set npc palette index
// byte1 - value to set npc's palette index to
	.macro npc_set_npc_palette_index, byte1
	.byte npc_set_npc_palette_index_cmd
	.byte byte1
	.endmacro

	fake_enum npc_pause_cmd, 0x10 // 0x10
// 0x10 byte1
// wait a given number of frames for this npc's script
// byte1 - number of frames to wait
	.macro npc_pause, byte1
	.byte npc_pause_cmd
	.byte byte1
	.endmacro

	fake_enum npc_init_hop_cmd, 0x11 // 0x11
// 0x11 byte1 byte2
// npc performs a hop
// given that the npc starts at z=0
// the z values of the hop are given (in decimal)
// by the quadratic z = ((byte2/2)x^2 + (byte2/2 + byte1)x)/16
// starting at x=1, until z becomes negative, at which z is
// set to the default value (depending on position)
// e.g. if byte1 = 96 and byte2 = -36, the equation would be:
// z = (-18x^2 + 78x)/16

// alternatively, the z values can be mapped as follows (in 16.16 fixed point):
// byte1 *= 4096
// byte2 *= 4096
// start loop
// byte1 += byte2
// z += byte1
// end loop when z becomes negative

// byte1 - hop param base
// byte2 - hop param delta
	.macro npc_init_hop, byte1, byte2
	.byte npc_init_hop_cmd
	.byte byte1
	.byte byte2
	.endmacro

	fake_enum npc_face_player_when_interacted_cmd, 0x12 // 0x12
// 0x12
// npc faces the player when the player interacts with this NPC
	.macro npc_face_player_when_interacted
	.byte npc_face_player_when_interacted_cmd
	.endmacro

	fake_enum npc_do_not_face_player_when_interacted_cmd, 0x13 // 0x13
// 0x13
// npc does not face the player when the player interacts with this NPC
	.macro npc_do_not_face_player_when_interacted
	.byte npc_do_not_face_player_when_interacted_cmd
	.endmacro

	fake_enum npc_set_coords_cmd, 0x14 // 0x14
// 0x14 hword1 hword3 hword5
// set npc coordinates
// hword1 - x coordinate
// hword3 - y coordinate
// hword5 - z coordinate
	.macro npc_set_coords, hword1, hword3, hword5
	.byte npc_set_coords_cmd
	.halfword hword1
	.halfword hword3
	.halfword hword5
	.endmacro

	fake_enum npc_move_in_direction_cmd, 0x15 // 0x15
// 0x15	byte1 byte2 byte3
// move npc in the given direction
// byte1 - direction to move npc in
// byte2 - speed of movement
// byte3 - distance of movement
	.macro npc_move_in_direction, byte1, byte2, byte3
	.byte npc_move_in_direction_cmd	
	.byte byte1
	.byte byte2
	.byte byte3
	.endmacro

	fake_enum npc_set_animation_cmd, 0x16 // 0x16
// 0x16 byte1
// set npc animation
// byte1 - animation to set
	.macro npc_set_animation, byte1
	.byte npc_set_animation_cmd
	.byte byte1
	.endmacro

	fake_enum npc_set_sprite_cmd, 0x17 // 0x17
// 0x17 byte1
// set NPC sprite for sprite category 0x18 (NPCs)
// certain sprites also set the palette index and hide some OAM pieces
// e.g. Yuichiro and Generic SciLab NPC share the same sprite, but have certain
// OAM pieces hidden and use a different palette index
// byte1 - new sprite id of NPC
	.macro npc_set_sprite, byte1
	.byte npc_set_sprite_cmd
	.byte byte1
	.endmacro

	fake_enum npc_set_text_script_index_cmd, 0x18 // 0x18
// 0x18 byte1
// set text script index
// byte1 - new text script index of NPC
	.macro npc_set_text_script_index, byte1
	.byte npc_set_text_script_index_cmd
	.byte byte1
	.endmacro

	fake_enum npc_disable_layer_priority_override_cmd, 0x19 // 0x19
// 0x19
// disable layer priority override
// layer priority being which sprites are shown first when overlapped
// as well as the background layer which the sprite is on
	.macro npc_disable_layer_priority_override
	.byte npc_disable_layer_priority_override_cmd
	.endmacro

	fake_enum npc_set_layer_priority_override_to_2_cmd, 0x1a // 0x1a
// 0x1a
// override the current NPC's layer priority to 2
	.macro npc_set_layer_priority_override_to_2
	.byte npc_set_layer_priority_override_to_2_cmd
	.endmacro

	fake_enum npc_set_layer_priority_override_to_3_cmd, 0x1b // 0x1b
// 0x1b
// override the current NPC's layer priority to 3
	.macro npc_set_layer_priority_override_to_3
	.byte npc_set_layer_priority_override_to_3_cmd
	.endmacro

	fake_enum npc_write_hidden_oam_pieces_cmd, 0x1c // 0x1c
// 0x1c word1
// set the current NPC's hidden OAM pieces
// used for NPC sprites which use the same sprite pointer
// but have overlapping OAMs which can be removed to
// show a different resulting sprite
// word1 - bitfield of OAM pieces indicating which OAM pieces to show and hide
	.macro npc_write_hidden_oam_pieces, word1
	.byte npc_write_hidden_oam_pieces_cmd
	.word word1
	.endmacro

	fake_enum npc_set_individual_hidden_oam_piece_cmd, 0x1d // 0x1d
// 0x1d byte1
// set a single individual hidden OAM piece for the current NPC
// this command can only set one bit for the hidden OAM piece bitfield
// byte1 - the OAM piece to hide
	.macro npc_set_individual_hidden_oam_piece, byte1
	.byte npc_set_individual_hidden_oam_piece_cmd
	.byte byte1
	.endmacro

	fake_enum npc_clear_individual_hidden_oam_piece_cmd, 0x1e // 0x1e
// 0x1e byte1
// clear a single individual hidden OAM piece for the current NPC
// this command can only clear one bit for the hidden OAM piece bitfield
// byte1 - the OAM piece to hide
	.macro npc_clear_individual_hidden_oam_piece, byte1
	.byte npc_clear_individual_hidden_oam_piece_cmd
	.byte byte1
	.endmacro

	fake_enum npc_disable_collision_cmd, 0x1f // 0x1f
// 0x1f
// disable the current NPC's collision (NPC becomes passable)
	.macro npc_disable_collision
	.byte npc_disable_collision_cmd
	.endmacro

	fake_enum npc_enable_collision_cmd, 0x20 // 0x20
// 0x20
// enable the current NPC's collision (NPC becomes impassable)
	.macro npc_enable_collision
	.byte npc_enable_collision_cmd
	.endmacro

	fake_enum npc_give_attached_shadow_cmd, 0x21 // 0x21
// 0x21
// attach shadow to the current NPC
// so that the shadow moves with the NPC's z coordinate
	.macro npc_give_attached_shadow
	.byte npc_give_attached_shadow_cmd
	.endmacro

	fake_enum npc_give_detatched_shadow_cmd, 0x22 // 0x22
// 0x22
// give a shadow for the current NPC, but do not attach it
// so that the shadow does not move with the NPC's z coordinate
	.macro npc_give_detatched_shadow
	.byte npc_give_detatched_shadow_cmd
	.endmacro

	fake_enum npc_remove_shadow_cmd, 0x23 // 0x23
// 0x23
// remove the current NPC's shadow
	.macro npc_remove_shadow
	.byte npc_remove_shadow_cmd
	.endmacro

	fake_enum npc_set_sprite_to_cur_pet_navi_cmd, 0x24 // 0x24
// 0x24
// set the current npc's sprite to the current PET navi's sprite
	.macro npc_set_sprite_to_cur_pet_navi
	.byte npc_set_sprite_to_cur_pet_navi_cmd
	.endmacro

	fake_enum npc_set_sprite_with_category_cmd, 0x25 // 0x25
// 0x25 byte1 byte2
// set the current npc's sprite to a sprite from any sprite category
// byte1 - sprite id
// byte2 - sprite category
	.macro npc_set_sprite_with_category, byte1, byte2
	.byte npc_set_sprite_with_category_cmd
	.byte byte1
	.byte byte2
	.endmacro

	fake_enum npc_toggle_sprite_mirror_cmd, 0x26 // 0x26
// 0x26
// toggle whether the current npc's sprite is mirrored
// if the current npc's sprite is mirrored, it stays so
// even when interacted with
	.macro npc_toggle_sprite_mirror
	.byte npc_toggle_sprite_mirror_cmd
	.endmacro

	fake_enum npc_disable_collision_alternate_cmd, 0x27 // 0x27
// 0x27
// disable collision for current NPC
// functionally different than the other disable collision command
// but the differences are unknown
	.macro npc_disable_collision_alternate
	.byte npc_disable_collision_alternate_cmd
	.endmacro

	fake_enum npc_play_sound_cmd, 0x28 // 0x28
// 0x28 hword1
// play sound effect
// hword1 - sound effect to play
	.macro npc_play_sound, hword1
	.byte npc_play_sound_cmd
	.halfword hword1
	.endmacro

	fake_enum npc_init_mystery_data_cmd, 0x29 // 0x29
// 0x29 hword1
// initialize mystery data
// does the following:
// - sets internal flags indicating this is a mystery data
// - sets mystery data palette
// - sets mystery data text archive ptr
// - sets mystery data coordinates
// - sets collision radius to 4, center offset x to 2, and center offset y to -2
// hword1 - mystery data ID
	.macro npc_init_mystery_data, hword1
	.byte npc_init_mystery_data_cmd
	.halfword hword1
	.endmacro

	fake_enum npc_wait_anim_frame_cmd, 0x2a // 0x2a
// 0x2a byte1
// wait for the current npc's animation to equal the specified frame
// if bit 7 or bit 6 of byte1 is set, test for the specified bits instead
// byte1 - frame of the current npc's animation to wait for
	.macro npc_wait_anim_frame, byte1
	.byte npc_wait_anim_frame_cmd
	.byte byte1
	.endmacro

	fake_enum npc_set_color_shader_cmd, 0x2b // 0x2b
// 0x2b hword1
// set current npc's color shader (mixes with current palette)
// hword1 - new color shader as 15bit RGB
	.macro npc_set_color_shader, hword1
	.byte npc_set_color_shader_cmd
	.halfword hword1
	.endmacro

	fake_enum_skip 1

	fake_enum npc_set_mosaic_cmd, 0x2d // 0x2d
// 0x2d byte1 byte2
// give a mosaic effect to the current npc
// mosaic effect being the "blur" effect when viruses spawn in a battle
// if byte1 + byte2 == 0, then remove the mosaic effect, if there is one
// byte1 - mosaic width
// byte2 - mosaic height
	.macro npc_set_mosaic, byte1, byte2
	.byte npc_set_mosaic_cmd
	.byte byte1
	.byte byte2
	.endmacro

	fake_enum npc_set_animation_force_update_cmd, 0x2e // 0x2e
// 0x2e byte1
// set npc animation and force it to update
// so that it updates even if the current animation is the same
// byte1 - animation to set
	.macro npc_set_animation_force_update, byte1
	.byte npc_set_animation_force_update_cmd
	.byte byte1
	.endmacro

	fake_enum npc_set_transform_cmd, 0x2f // 0x2f
// 0x2f byte1 byte2 byte3
// set transform for the current npc
// the way the transform works seems buggy
// as certain facing directions don't scale correctly
// and show rectangles instead
// byte1 - horizontal compress value
// byte2 - vertical compress value
// byte3 - rotation value
	.macro npc_set_transform, byte1, byte2, byte3
	.byte npc_set_transform_cmd
	.byte byte1
	.byte byte2
	.byte byte3
	.endmacro

	fake_enum npc_remove_transform_cmd, 0x30 // 0x30
// 0x30
// remove transform for the current npc
	.macro npc_remove_transform
	.byte npc_remove_transform_cmd
	.endmacro

	fake_enum npc_set_alpha_cmd, 0x31 // 0x31
// 0x31 byte1
// set the alpha for the current npc's sprite
// but doesn't actually work (inherent to sprite_setAlpha_8002c7a)
// byte1 - alpha to set (range 0-15). if byte1 is zero, then disable alpha
	.macro npc_set_alpha, byte1
	.byte npc_set_alpha_cmd
	.byte byte1
	.endmacro

	fake_enum npc_run_secondary_script_cmd, 0x32 // 0x32
// 0x32 word1
// run a secondary NPC script
// called separately from the primary NPC script
// word1 - script to run
	.macro npc_run_secondary_script, word1
	.byte npc_run_secondary_script_cmd
	.word word1
	.endmacro

	fake_enum npc_pause_secondary_script_cmd, 0x33 // 0x33
// 0x33 byte1
// wait a given number of frames for the current npc's secondary script
// byte1 - number of frames to wait
	.macro npc_pause_secondary_script, byte1
	.byte npc_pause_secondary_script_cmd
	.byte byte1
	.endmacro

	fake_enum npc_end_secondary_script_cmd, 0x34 // 0x34
// 0x34
// end the current npc's secondary script
	.macro npc_end_secondary_script
	.byte npc_end_secondary_script_cmd
	.endmacro

	fake_enum npc_init_native_callback_cmd, 0x35 // 0x35
// 0x35 word1
// initialize a native callback for the current npc
// also writes to the link register field (of the current npc)
// word1 - native function to set as callback
	.macro npc_init_native_callback, word1
	.byte npc_init_native_callback_cmd
	.word word1
	.endmacro

	fake_enum npc_jump_with_link_cmd, 0x36 // 0x36
// 0x36 destination1
// set the npc link register, and jump to another script
// destination1 - script to jump to
	.macro npc_jump_with_link, destination1
	.byte npc_jump_with_link_cmd
	.word destination1
	.endmacro

	fake_enum npc_init_native_callback_with_args_cmd, 0x37 // 0x37
// 0x37 byte1 byte2 byte3 byte4 word5
// initialize a native callback for the current npc, with four byte arguments
// also writes to the link register field (of the current npc)
// byte1 - first param for native callback
// byte2 - second param for native callback
// byte3 - third param for native callback
// byte4 - fourth param for native callback
// word5 - native function to set as callback
	.macro npc_init_native_callback_with_args, byte1, byte2, byte3, byte4, word5
	.byte npc_init_native_callback_with_args_cmd
	.byte byte1
	.byte byte2
	.byte byte3
	.byte byte4
	.word word5
	.endmacro

	fake_enum npc_init_movement_cmd, 0x38 // 0x38
// 0x38 byte1 byte2 byte3 destination4
// initialize NPC movement
// byte1 - direction to move in
// byte2 - speed of movement
// byte3 - amount of movement iterations to do (8 pixels each)
// destination4 - movement handler to call
	.macro npc_init_movement, byte1, byte2, byte3, destination4
	.byte npc_init_movement_cmd
	.byte byte1
	.byte byte2
	.byte byte3
	.word destination4
	.endmacro

	fake_enum npc_change_movement_direction_cmd, 0x39 // 0x39
// 0x39 byte1
// move in a new direction, relative to the old direction
// byte1 - new movement direction, relative to the old movement direction
// possible values are:
// 0x0 - turn 0 degrees
// 0x2 - turn 90 degrees
// 0x4 - turn 180 degrees
// 0x6 - turn 270 degrees
	.macro npc_change_movement_direction, byte1
	.byte npc_change_movement_direction_cmd
	.byte byte1
	.endmacro

	fake_enum npc_return_to_link_cmd, 0x3a // 0x3a
// 0x3a
// return to the current npc's linked routine
	.macro npc_return_to_link
	.byte npc_return_to_link_cmd
	.endmacro

	fake_enum npc_jump_if_progress_in_range_cmd, 0x3b // 0x3b
// 0x3b byte1 byte2 destination3
// jump if byte1 <= progress byte <= byte2
// byte1 - lower bound for progress byte
// byte2 - upper bound for progress byte
// destination3 - script to jump to
	.macro npc_jump_if_progress_in_range, byte1, byte2, destination3
	.byte npc_jump_if_progress_in_range_cmd
	.byte byte1
	.byte byte2
	.word destination3
	.endmacro

	fake_enum npc_write_cutscene_var_cmd, 0x3c // 0x3c
// 0x3c byte1 byte2
// write a value to a cutscene variable
// byte1 - cutscene variable to write to
// byte2 - value to write to cutscene variable
	.macro npc_write_cutscene_var, byte1, byte2
	.byte npc_write_cutscene_var_cmd
	.byte byte1
	.byte byte2
	.endmacro

	fake_enum npc_jump_if_cutscene_var_equals_cmd, 0x3d // 0x3d
// 0x3d byte1 byte2 destination3
// jump if a cutscene variable equals the given value
// byte1 - cutscene variable to compare
// byte2 - value to compare with the cutscene variable
// destination3 - script to jump to
	.macro npc_jump_if_cutscene_var_equals, byte1, byte2, destination3
	.byte npc_jump_if_cutscene_var_equals_cmd
	.byte byte1
	.byte byte2
	.word destination3
	.endmacro

	fake_enum npc_jump_if_cutscene_var_not_equal_cmd, 0x3e // 0x3e
// 0x3e byte1 byte2 destination3
// jump if a cutscene variable does not equal the given value
// byte1 - cutscene variable to compare
// byte2 - value to compare with the cutscene variable
// destination3 - script to jump to
	.macro npc_jump_if_cutscene_var_not_equal, byte1, byte2, destination3
	.byte npc_jump_if_cutscene_var_not_equal_cmd
	.byte byte1
	.byte byte2
	.word destination3
	.endmacro

	fake_enum npc_wait_cutscene_var_cmd, 0x3f // 0x3f
// 0x3f byte1 byte2
// wait for a cutscene variable to equal a given value
// byte1 - cutscene variable to compare
// byte2 - value to compare with the cutscene variable
	.macro npc_wait_cutscene_var, byte1, byte2
	.byte npc_wait_cutscene_var_cmd
	.byte byte1
	.byte byte2
	.endmacro

	fake_enum npc_set_unk_flags_60_flag_0x200_cmd, 0x40 // 0x40
// 0x40
// set the flag OW_NPC_UNK_FLAGS_60_0x200 to the current npc's flags
	.macro npc_set_unk_flags_60_flag_0x200
	.byte npc_set_unk_flags_60_flag_0x200_cmd
	.endmacro

	fake_enum npc_clear_unk_flags_60_flag_0x200_cmd, 0x41 // 0x41
// 0x41
// clear the flag OW_NPC_UNK_FLAGS_60_0x200 from the current npc's flags
	.macro npc_clear_unk_flags_60_flag_0x200
	.byte npc_clear_unk_flags_60_flag_0x200_cmd
	.endmacro

	fake_enum_skip 2

	fake_enum npc_set_text_script_index_and_ptr_cmd, 0x44 // 0x44
// 0x44 byte1 word2
// set text script pointer and index for the current npc
// byte1 - new text script index
// word2 - new text script pointer
	.macro npc_set_text_script_index_and_ptr, byte1, word2
	.byte npc_set_text_script_index_and_ptr_cmd
	.byte byte1
	.word word2
	.endmacro

	fake_enum npc_wait_mystery_data_taken_cmd, 0x45 // 0x45
// 0x45 hword1
// wait for the npc (being a mystery data) to be taken
// hword1 - mystery data id
	.macro npc_wait_mystery_data_taken, hword1
	.byte npc_wait_mystery_data_taken_cmd
	.halfword hword1
	.endmacro

	fake_enum npc_set_obj_window_mode_cmd, 0x46 // 0x46
// 0x46 byte1
// if byte1 == 0, turn on obj window mode for the current npc's sprite
// otherwise, disable object window mode
	.macro npc_set_obj_window_mode, byte1
	.byte npc_set_obj_window_mode_cmd
	.byte byte1
	.endmacro

	fake_enum npc_play_music_cmd, 0x47 // 0x47
// 0x47 hword1
// play music
// hword1 - music to play
	.macro npc_play_music, hword1
	.byte npc_play_music_cmd
	.halfword hword1
	.endmacro

	fake_enum npc_set_sprite_0x3_bit5_cmd, 0x48 // 0x48
// 0x48
// set bit 5 of sprite field 0x3 for the current NPC
// the function sprite_setField0x3Bit5 in question seems to go unused
// (all other calls to it are dead)
	.macro npc_set_sprite_0x3_bit5
	.byte npc_set_sprite_0x3_bit5_cmd
	.endmacro

	fake_enum npc_remove_shadow_ignore_flags_cmd, 0x49 // 0x49
// 0x49
// remove the current NPC's shadow, but don't set flags
// that keep the shadow removed if the current NPC's sprite changes
	.macro npc_remove_shadow_ignore_flags
	.byte npc_remove_shadow_ignore_flags_cmd
	.endmacro

	fake_enum npc_do_camera_shake_cmd, 0x4a // 0x4a
// 0x4a byte1 hword2
// do a camera shake effect
// byte1 - shake type
// hword2 - shake timer
	.macro npc_do_camera_shake, byte1, hword2
	.byte npc_do_camera_shake_cmd
	.byte byte1
	.halfword hword2
	.endmacro

	fake_enum npc_jump_if_anim_not_equal_cmd, 0x4b // 0x4b
// 0x4b byte1
// jump if the current npc's animation does not equal the given animation
// byte1 - animation to compare the current npc's animation with
	.macro npc_jump_if_anim_not_equal, byte1
	.byte npc_jump_if_anim_not_equal_cmd
	.byte byte1
	.endmacro

	fake_enum npc_set_text_script_index_and_ptr_to_decomp_buffer_cmd, 0x4c // 0x4c
// 0x4c byte1
// set text script pointer to a hardcoded buffer and index to the given value for the current npc
// byte1 - new text script index
	.macro npc_set_text_script_index_and_ptr_to_decomp_buffer, byte1
	.byte npc_set_text_script_index_and_ptr_to_decomp_buffer_cmd
	.byte byte1
	.endmacro

	fake_enum npc_jump_based_on_version_cmd, 0x4d // 0x4d
// 0x4d destination1 destination5
// in gregar version: jump to destination1
// in falzar version: jump to destination5
// the jump is hardcoded in the code
// in gregar version, it is `add r0, r6, #1` instead
// destination1 - gregar script to jump to
// destination5 - falzar script to jump to
	.macro npc_jump_based_on_version
	.byte npc_jump_based_on_version_cmd
	.word destination1
	.word destination5
	.endmacro

	fake_enum npc_init_leap_cmd, 0x4e // 0x4e
// 0x4e byte1 byte2 byte3 byte4
// npc performs a leap
// i.e. a hop except an xy coordinate is offset for each iteration

// hop mechanics copied from the hop command:
// given that the npc starts at z=0
// the z values of the hop are given (in decimal)
// by the quadratic z = ((byte2/2)x^2 + (byte2/2 + byte1)x)/16
// starting at x=1, until z becomes negative, at which z is
// set to the default value (depending on position)
// e.g. if byte1 = 96 and byte2 = -36, the equation would be:
// z = (-18x^2 + 78x)/16

// alternatively, the z values can be mapped as follows (in 16.16 fixed point):
// byte1 *= 4096
// byte2 *= 4096
// start loop
// byte1 += byte2
// z += byte1
// end loop when z becomes negative

// byte1 - hop param base
// byte2 - hop param delta
// byte3 - direction of leap
// 00 - up right
// 01 - up left
// 02 - down left
// 03 - down right
// byte4 - velocity of leap, in whole pixels
	.macro npc_init_leap, byte1, byte2, byte3, byte4
	.byte npc_init_leap_cmd
	.byte byte1
	.byte byte2
	.byte byte3
	.byte byte4
	.endmacro

	fake_enum npc_init_vertical_movement_cmd, 0x4f // 0x4f
// 0x4f byte1 byte2 byte3
// increase or decrease the current npc's z coordinate by a given offset for a given number of frames
// i.e. init vertical movement
// byte1 - number of frames to wait
// byte2 - direction (0 = upwards, 1 = downwards)
// byte3 - velocity of vertical movement
	.macro npc_init_vertical_movement, byte1, byte2, byte3
	.byte npc_init_vertical_movement_cmd
	.byte byte1
	.byte byte2
	.byte byte3
	.endmacro

	fake_enum npc_init_diagonal_leap_cmd, 0x50 // 0x50
// 0x50 byte1 byte2 byte3 byte4
// npc performs a diagonal leap
// i.e. same as a leap, except the leap stops at the peak
// in other words, the vertex of the parabola

// hop mechanics partially copied from the hop command:
// given that the npc starts at z=0
// the z values of the hop are given (in decimal)
// by the quadratic z = ((byte2/2)x^2 + (byte2/2 + byte1)x)/16
// starting at x=1, until z is the vertex of the quadratic, at which z is
// set to the z at the vertex
// e.g. if byte1 = 96 and byte2 = -36, the equation would be:
// z = (-18x^2 + 78x)/16

// alternatively, the z values can be mapped as follows (in 16.16 fixed point):
// byte1 *= 4096
// byte2 *= 4096
// start loop
// byte1 += byte2
// stop if byte1 is zero or less
// z += byte1
// end loop
	.macro npc_init_diagonal_leap, byte1, byte2, byte3, byte4
	.byte npc_init_diagonal_leap_cmd
	.byte byte1
	.byte byte2
	.byte byte3
	.byte byte4
	.endmacro

	fake_enum npc_init_groundman_minigame_prog_cmd, 0x51 // 0x51
// 0x51 hword1
// initialize prog npc for the groundman minigame
// the npc's text script index and coordinates are set based on the input event flag
// and the text script ptr is set to the text archive for the groundman minigame
// hword1 - event flag of prog
	.macro npc_init_groundman_minigame_prog, hword1
	.byte npc_init_groundman_minigame_prog_cmd
	.halfword hword1
	.endmacro

	fake_enum npc_jack_out_cmd, 0x52 // 0x52
// 0x52
// have the current npc do a "jack out" effect
// npc cannot be interacted with and has no collision once this command is run
	.macro npc_jack_out
	.byte npc_jack_out_cmd
	.endmacro

	fake_enum npc_jump_if_screen_fade_active_cmd, 0x53 // 0x53
// 0x53 destination1
// jump if the screen is fading
// destination1 - script to jump to
	.macro npc_jump_if_screen_fade_active, destination1
	.byte npc_jump_if_screen_fade_active_cmd
	.word destination1
	.endmacro

