#!/bin/bash

if test ! $(which nvim)
then
    echo Install neovim...
	# Homebrew is not installed, so install it
    if test "$(uname)" = "Darwin"
    then
     	# Mac installation branch
        brew install neovim

    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
     	# Linux installation branch
        http_proxy= https_proxy= sudo apt-get install --no-install-recommends -y neovim
    fi
fi

curl -sLf https://spacevim.org/install.sh | bash
cp init.toml  ~/.SpaceVim.d
