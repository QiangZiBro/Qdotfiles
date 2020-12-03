#!/bin/bash
if test "$(uname)" = "Darwin"
then
    echo not supported now on mac now!

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
    sudo apt install -y git zsh ranger curl tree \
		make htop nodejs tmux snapd
fi
