if test "$(uname)" = "Darwin"
then
 	# Mac installation branch
    eval "$(lua ~/applications/z.lua/z.lua --init zsh)"

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
 	# Linux installation branch
    if command -v  lua5.3 &> /dev/null && test -f /usr/local/softwares/z.lua/z.lua 
    then
        # exists
        eval "$(lua5.3 /usr/local/softwares/z.lua/z.lua --init zsh)"
        alias z=_zlua
    fi
fi

