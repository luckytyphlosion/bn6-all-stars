mkdir -p "temp"

tools/TextPet.exe \
	Load-Plugins "tools/plugins" \
	Game MMBN6 \
	Read-Text-Archives "all-stars/text" --recursive --format tpl \
	Write-Text-Archives "temp\\" --format msg \

tools/TextPet.exe \
	Load-Plugins "tools/plugins" \
	Game EXE6 \
	Read-Text-Archives "all-stars/text_jp" --recursive --format tpl \
	Write-Text-Archives "temp\\" --format msg

# BN6 Standard
tools/armips.exe build.asm -sym bn6f-all-stars-temp.sym -strequ ver "bn6f.s" -equ IS_MASTERS 0 -equ SOUND_MOD 0
tools/armips.exe build.asm -sym bn6g-all-stars-temp.sym -strequ ver "bn6g.s" -equ IS_MASTERS 0 -equ SOUND_MOD 0

# EXE6 Unseniors
tools/armips.exe build.asm -sym exe6f-all-stars-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 0 -equ IS_MASTERS 0 -equ SOUND_MOD 0
tools/armips.exe build.asm -sym exe6g-all-stars-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 0 -equ IS_MASTERS 0 -equ SOUND_MOD 0

# EXE6 TL Unseniors
tools/armips.exe build.asm -sym exe6f_us-all-stars-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 1 -equ IS_MASTERS 0 -equ SOUND_MOD 0
tools/armips.exe build.asm -sym exe6g_us-all-stars-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 1 -equ IS_MASTERS 0 -equ SOUND_MOD 0

# EXE6 Masters
tools/armips.exe build.asm -sym exe6f-all-stars-masters-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 0 -equ IS_MASTERS 1 -equ SOUND_MOD 0
tools/TextPet.exe Run-Script "kaizouloader/exe6f.tps"

tools/armips.exe build.asm -sym exe6g-all-stars-masters-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 0 -equ IS_MASTERS 1 -equ SOUND_MOD 0
tools/TextPet.exe Run-Script "kaizouloader/exe6g.tps"

# EXE6 TL Masters
tools/armips.exe build.asm -sym exe6f_us-all-stars-masters-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 1 -equ IS_MASTERS 1 -equ SOUND_MOD 0
tools/TextPet.exe Run-Script "kaizouloader/exe6f_us.tps"

tools/armips.exe build.asm -sym exe6g_us-all-stars-masters-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 1 -equ IS_MASTERS 1 -equ SOUND_MOD 0
tools/TextPet.exe Run-Script "kaizouloader/exe6g_us.tps"

# BN6 Standard + SoundMod extend
tools/armips.exe build.asm -sym bn6f-all-stars-soundmod-extend-temp.sym -strequ ver "bn6f.s" -equ IS_MASTERS 0 -equ SOUND_MOD 1
tools/armips.exe build.asm -sym bn6g-all-stars-soundmod-extend-temp.sym -strequ ver "bn6g.s" -equ IS_MASTERS 0 -equ SOUND_MOD 1

# EXE6 Unseniors + SoundMod extend
tools/armips.exe build.asm -sym exe6f-all-stars-soundmod-extend-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 0 -equ IS_MASTERS 0 -equ SOUND_MOD 1
tools/armips.exe build.asm -sym exe6g-all-stars-soundmod-extend-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 0 -equ IS_MASTERS 0 -equ SOUND_MOD 1

# EXE6 Masters + SoundMod extend
tools/armips.exe build.asm -sym exe6f-all-stars-masters-soundmod-extend-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 0 -equ IS_MASTERS 1 -equ SOUND_MOD 1
tools/TextPet.exe Run-Script "kaizouloader/exe6f_soundmod_extend.tps"

tools/armips.exe build.asm -sym exe6g-all-stars-masters-soundmod-extend-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 0 -equ IS_MASTERS 1 -equ SOUND_MOD 1
tools/TextPet.exe Run-Script "kaizouloader/exe6g_soundmod_extend.tps"

if [[ $? -ne 0 ]] ; then
    exit 1
fi

head -c -1 bn6f-all-stars-temp.sym | cat - bn6f_nogba.sym > bn6f-all-stars.sym
head -c -1 bn6g-all-stars-temp.sym | cat - bn6f_nogba.sym > bn6g-all-stars.sym
head -c -1 exe6f-all-stars-temp.sym | cat - constants_ewram.sym > exe6f-all-stars.sym
head -c -1 exe6g-all-stars-temp.sym | cat - constants_ewram.sym > exe6g-all-stars.sym
head -c -1 exe6f_us-all-stars-temp.sym | cat - constants_ewram.sym > exe6f_us-all-stars.sym
head -c -1 exe6g_us-all-stars-temp.sym | cat - constants_ewram.sym > exe6g_us-all-stars.sym

head -c -1 exe6f-all-stars-masters-temp.sym | cat - constants_ewram.sym > exe6f-all-stars-masters.sym
head -c -1 exe6g-all-stars-masters-temp.sym | cat - constants_ewram.sym > exe6g-all-stars-masters.sym
head -c -1 exe6f_us-all-stars-masters-temp.sym | cat - constants_ewram.sym > exe6f_us-all-stars-masters.sym
head -c -1 exe6g_us-all-stars-masters-temp.sym | cat - constants_ewram.sym > exe6g_us-all-stars-masters.sym

head -c -1 bn6f-all-stars-soundmod-extend-temp.sym | cat - bn6f_nogba.sym > bn6f-all-stars-soundmod-extend.sym
head -c -1 bn6g-all-stars-soundmod-extend-temp.sym | cat - bn6f_nogba.sym > bn6g-all-stars-soundmod-extend.sym
head -c -1 exe6f-all-stars-soundmod-extend-temp.sym | cat - constants_ewram.sym > exe6f-all-stars-soundmod-extend.sym
head -c -1 exe6g-all-stars-soundmod-extend-temp.sym | cat - constants_ewram.sym > exe6g-all-stars-soundmod-extend.sym
head -c -1 exe6f-all-stars-masters-soundmod-extend-temp.sym | cat - constants_ewram.sym > exe6f-all-stars-masters-soundmod-extend.sym
head -c -1 exe6g-all-stars-masters-soundmod-extend-temp.sym | cat - constants_ewram.sym > exe6g-all-stars-masters-soundmod-extend.sym

rm bn6f-all-stars-temp.sym bn6g-all-stars-temp.sym exe6f-all-stars-temp.sym exe6g-all-stars-temp.sym \
	exe6f_us-all-stars-temp.sym exe6g_us-all-stars-temp.sym \
	exe6f-all-stars-masters-temp.sym exe6g-all-stars-masters-temp.sym \
	exe6f_us-all-stars-masters-temp.sym exe6g_us-all-stars-masters-temp.sym \
	bn6f-all-stars-soundmod-extend-temp.sym bn6g-all-stars-soundmod-extend-temp.sym \
	exe6f-all-stars-soundmod-extend-temp.sym exe6g-all-stars-soundmod-extend-temp.sym \
	exe6f-all-stars-masters-soundmod-extend-temp.sym exe6g-all-stars-masters-soundmod-extend-temp.sym \
	exe6f-all-stars-masters-temp.gba exe6g-all-stars-masters-temp.gba \
	exe6f_us-all-stars-masters-temp.gba exe6g_us-all-stars-masters-temp.gba \
	exe6f-all-stars-masters-soundmod-extend-temp.gba exe6g-all-stars-masters-soundmod-extend-temp.gba

# BN6 Standard
mkdir -p "out_patch/bn6_allstars/v1.1.0"
./tools/floating/flips.exe -c -b "bn6f.gba" "bn6f-all-stars.gba" "out_patch/bn6_allstars/v1.1.0/BR6J_00.bps"
./tools/floating/flips.exe -c -b "bn6g.gba" "bn6g-all-stars.gba" "out_patch/bn6_allstars/v1.1.0/BR5J_00.bps"
touch out_patch/bn6_allstars/info.toml

# EXE6 Unseniors
mkdir -p "out_patch/exe6_allstars_unseniors/v1.1.0"
./tools/floating/flips.exe -c -b "exe6f.gba" "exe6f-all-stars.gba" "out_patch/exe6_allstars_unseniors/v1.1.0/BR6J_00.bps"
./tools/floating/flips.exe -c -b "exe6g.gba" "exe6g-all-stars.gba" "out_patch/exe6_allstars_unseniors/v1.1.0/BR5J_00.bps"
touch out_patch/exe6_allstars_unseniors/info.toml

# EXE6 TL Unseniors
mkdir -p "out_patch/exe6_us_allstars_unseniors/v1.1.0"
./tools/floating/flips.exe -c -b "exe6f.gba" "exe6f_us-all-stars.gba" "out_patch/exe6_us_allstars_unseniors/v1.1.0/BR6J_00.bps"
./tools/floating/flips.exe -c -b "exe6g.gba" "exe6g_us-all-stars.gba" "out_patch/exe6_us_allstars_unseniors/v1.1.0/BR5J_00.bps"
touch out_patch/exe6_us_allstars_unseniors/info.toml

# EXE6 Masters
mkdir -p "out_patch/exe6_allstars_masters/v1.1.0"
./tools/floating/flips.exe -c -b "exe6f.gba" "exe6f-all-stars-masters.gba" "out_patch/exe6_allstars_masters/v1.1.0/BR6J_00.bps"
./tools/floating/flips.exe -c -b "exe6g.gba" "exe6g-all-stars-masters.gba" "out_patch/exe6_allstars_masters/v1.1.0/BR5J_00.bps"
touch out_patch/exe6_allstars_masters/info.toml

# EXE6 TL Masters
mkdir -p "out_patch/exe6_us_allstars_masters/v1.1.0"
./tools/floating/flips.exe -c -b "exe6f.gba" "exe6f_us-all-stars-masters.gba" "out_patch/exe6_us_allstars_masters/v1.1.0/BR6J_00.bps"
./tools/floating/flips.exe -c -b "exe6g.gba" "exe6g_us-all-stars-masters.gba" "out_patch/exe6_us_allstars_masters/v1.1.0/BR5J_00.bps"
touch out_patch/exe6_us_allstars_masters/info.toml

# BN6 Standard + SoundMod extend
mkdir -p "out_patch/bn6_allstars_soundmod_extend/v1.1.0"
./tools/floating/flips.exe -c -b "bn6f.gba" "bn6f-all-stars-soundmod-extend.gba" "out_patch/bn6_allstars_soundmod_extend/v1.1.0/BR6J_00.bps"
./tools/floating/flips.exe -c -b "bn6g.gba" "bn6g-all-stars-soundmod-extend.gba" "out_patch/bn6_allstars_soundmod_extend/v1.1.0/BR5J_00.bps"
touch out_patch/bn6_allstars_soundmod_extend/info.toml

# EXE6 Unseniors + SoundMod extend
mkdir -p "out_patch/exe6_allstars_unseniors_soundmod_extend/v1.1.0"
./tools/floating/flips.exe -c -b "exe6f.gba" "exe6f-all-stars-soundmod-extend.gba" "out_patch/exe6_allstars_unseniors_soundmod_extend/v1.1.0/BR6J_00.bps"
./tools/floating/flips.exe -c -b "exe6g.gba" "exe6g-all-stars-soundmod-extend.gba" "out_patch/exe6_allstars_unseniors_soundmod_extend/v1.1.0/BR5J_00.bps"
touch out_patch/exe6_allstars_unseniors_soundmod_extend/info.toml

# EXE6 Masters + SoundMod extend
mkdir -p "out_patch/exe6_allstars_masters_soundmod_extend/v1.1.0"
./tools/floating/flips.exe -c -b "exe6f.gba" "exe6f-all-stars-masters-soundmod-extend.gba" "out_patch/exe6_allstars_masters_soundmod_extend/v1.1.0/BR6J_00.bps"
./tools/floating/flips.exe -c -b "exe6g.gba" "exe6g-all-stars-masters-soundmod-extend.gba" "out_patch/exe6_allstars_masters_soundmod_extend/v1.1.0/BR5J_00.bps"
touch out_patch/exe6_allstars_masters_soundmod_extend/info.toml
