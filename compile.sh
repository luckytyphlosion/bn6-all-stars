mkdir -p "temp"

tools/TextPet.exe \
	Load-Plugins "tools/plugins" \
	Game MMBN6 \
	Read-Text-Archives "all-stars/text" --recursive --format tpl \
	Write-Text-Archives "temp\\" --format msg

tools/armips.exe build.asm -sym bn6f-all-stars-temp.sym -strequ ver "bn6f.s"
tools/armips.exe build.asm -sym bn6g-all-stars-temp.sym -strequ ver "bn6g.s"

if [[ $? -ne 0 ]] ; then
    exit 1
fi

head -c -1 bn6f-all-stars-temp.sym | cat - bn6f_nogba.sym > bn6f-all-stars.sym
head -c -1 bn6g-all-stars-temp.sym | cat - bn6f_nogba.sym > bn6g-all-stars.sym
# head -c -1 exe6f_us-unseniors-temp.sym | cat - constants_ewram.sym > exe6f_us-unseniors.sym
# head -c -1 exe6g_us-unseniors-temp.sym | cat - constants_ewram.sym > exe6g_us-unseniors.sym

rm bn6f-all-stars-temp.sym bn6g-all-stars-temp.sym