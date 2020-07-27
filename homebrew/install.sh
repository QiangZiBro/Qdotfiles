#!/bin/bash
if ! command -v  brew &> /dev/null
then
	# installation process...
    if test "$(uname)" = "Darwin"
    then
     	# Mac installation branch
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
     	# Linux installation branch
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
    fi
fi
exit 0
