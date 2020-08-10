#!/bin/bash

set -e
# Smartly use code below, this code can't find command for alias
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
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

exit 0
