if test "$(uname)" = "Darwin"
then
 	# Mac installation branch
    eval "$(lua ~/applications/z.lua/z.lua --init zsh)"

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
 	# Linux installation branch
    eval "$(lua /usr/softwares/z.lua/z.lua --init zsh)"
fi

alias z=_zlua
