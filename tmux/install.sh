#!/bin/bash

set -e
if ! command -v  tmux &> /dev/null
then
    # installation process...
    if test "$(uname)" = "darwin"
    then
         # mac installation branch
         brew install tmux

    elif test "$(expr substr $(uname -s) 1 5)" = "linux"
    then
         # linux installation branch
         sudo apt install tmux -y
    fi
fi

# tmux plug manager
dir="~/.tmux/plugins/tpm"
if [ ! -d $dir ];then
	git clone https://github.com/tmux-plugins/tpm $dir
fi
tmux source ~/.tmux.conf

exit 0
