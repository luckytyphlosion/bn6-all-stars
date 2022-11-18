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

tools/armips.exe build.asm -sym bn6f-all-stars-temp.sym -strequ ver "bn6f.s"
tools/armips.exe build.asm -sym bn6g-all-stars-temp.sym -strequ ver "bn6g.s"
tools/armips.exe build.asm -sym exe6f-all-stars-temp.sym -strequ ver "exe6f.s" -equ TL_PATCH 0
tools/armips.exe build.asm -sym exe6g-all-stars-temp.sym -strequ ver "exe6g.s" -equ TL_PATCH 0

if [[ $? -ne 0 ]] ; then
    exit 1
fi

head -c -1 bn6f-all-stars-temp.sym | cat - bn6f_nogba.sym > bn6f-all-stars.sym
head -c -1 bn6g-all-stars-temp.sym | cat - bn6f_nogba.sym > bn6g-all-stars.sym
head -c -1 exe6f-all-stars-temp.sym | cat - constants_ewram.sym > exe6f-all-stars.sym
head -c -1 exe6g-all-stars-temp.sym | cat - constants_ewram.sym > exe6g-all-stars.sym

rm bn6f-all-stars-temp.sym bn6g-all-stars-temp.sym