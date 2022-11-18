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

# BN6 standard
tools/armips.exe build.asm -sym bn6f-all-stars-temp.sym -strequ ver "bn6f.s" -equ IS_MASTERS 0
tools/armips.exe build.asm -sym bn6g-all-stars-temp.sym -strequ ver "bn6g.s" -equ IS_MASTERS 0

# EXE6 Unseniors
tools/armips.exe build.asm -sym exe6f-all-stars-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 0 -equ IS_MASTERS 0
tools/armips.exe build.asm -sym exe6g-all-stars-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 0 -equ IS_MASTERS 0

# EXE6 TL Unseniors
tools/armips.exe build.asm -sym exe6f_us-all-stars-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 1 -equ IS_MASTERS 0
tools/armips.exe build.asm -sym exe6g_us-all-stars-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 1 -equ IS_MASTERS 0

# EXE6 Masters
tools/armips.exe build.asm -sym exe6f-all-stars-masters-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 0 -equ IS_MASTERS 1
tools/TextPet.exe \
	Load-Plugins "tools/plugins" \
	Game EXE6 \
	Load-File-Index "kaizouloader\exe6f.tpi" \
	Read-Text-Archives "exe6f-all-stars-masters-temp.gba" \
	Read-Text-Archives "kaizouloader\exe6f.tpl" -p \
	Write-Text-Archives "exe6f-all-stars-masters.gba"

tools/armips.exe build.asm -sym exe6g-all-stars-masters-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 0 -equ IS_MASTERS 1
tools/TextPet.exe \
	Load-Plugins "tools/plugins" \
	Game EXE6 \
	Load-File-Index "kaizouloader\exe6g.tpi" \
	Read-Text-Archives "exe6g-all-stars-masters-temp.gba" \
	Read-Text-Archives "kaizouloader\exe6g.tpl" -p \
	Write-Text-Archives "exe6g-all-stars-masters.gba"

# EXE6 TL Masters
tools/armips.exe build.asm -sym exe6f_us-all-stars-masters-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 1 -equ IS_MASTERS 1
tools/TextPet.exe \
	Load-Plugins "tools/plugins" \
	Game MMBN6 \
	Load-File-Index "kaizouloader\exe6f_us.tpi" \
	Read-Text-Archives "exe6f_us-all-stars-masters-temp.gba" \
	Read-Text-Archives "kaizouloader\exe6f_us.tpl" -p \
	Write-Text-Archives "exe6f_us-all-stars-masters.gba"

tools/armips.exe build.asm -sym exe6g_us-all-stars-masters-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 1 -equ IS_MASTERS 1
tools/TextPet.exe \
	Load-Plugins "tools/plugins" \
	Game MMBN6 \
	Load-File-Index "kaizouloader\exe6g_us.tpi" \
	Read-Text-Archives "exe6g_us-all-stars-masters-temp.gba" \
	Read-Text-Archives "kaizouloader\exe6g_us.tpl" -p \
	Write-Text-Archives "exe6g_us-all-stars-masters.gba"

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


rm bn6f-all-stars-temp.sym bn6g-all-stars-temp.sym exe6f-all-stars-temp.sym exe6g-all-stars-temp.sym \
	exe6f-all-stars-masters-temp.gba exe6g-all-stars-masters-temp.gba \
	exe6f_us-all-stars-masters-temp.gba exe6g_us-all-stars-masters-temp.gba
