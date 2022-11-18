
	.include "all-stars/include/macros/enum.inc"
	.include "all-stars/include/bytecode/map_script.inc"
	.include "all-stars/include/bytecode/cutscene_script.inc"
	.include "all-stars/include/bytecode/cutscene_camera_script.inc"
	.include "all-stars/include/bytecode/npc_script.inc"
	.include "all-stars/include/bytecode/gfx_anim_script.inc"
	.include "all-stars/constants.inc"
	.include "all-stars/version_macros.inc"

	.macro map_id, map
	.byte GROUP_map, MAP_map
	.endmacro

	.definelabel eCustScreenMenu, 0x20364c0
	.definelabel eCrossList, 0x2003f40

	.definelabel CopyBytes, 0x8000920
	.vdefinelabel GetBattleNaviStatsAddr, 0x8013682, 0x8013c82
	.definelabel GetPositiveSignedRNG1, 0x8001562
