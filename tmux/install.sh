#!/bin/bash

set -e
if ! command -v  tmux &> /dev/null
then
    # installation process...
    if test "$(uname)" = "Darwin"
    then
         # mac installation branch
         brew install tmux

    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
         # linux installation branch
         sudo apt install tmux -y
    fi
fi

# tmux plug manager
if [ ! -d ~/.tmux/plugins/ ];then
	mkdir -p ~/.tmux/plugins/
fi

if [ ! -d ~/.tmux/plugins/tqm ];then
	cd ~/.tmux/plugins/
	git clone https://github.com/tmux-plugins/tpm
fi
tmux source ~/.tmux.conf

exit 0
