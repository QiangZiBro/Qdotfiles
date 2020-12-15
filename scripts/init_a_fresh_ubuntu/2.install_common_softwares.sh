#!/bin/bash
if test "$(uname)" = "Darwin"
then
    echo not supported now on mac now!

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
	softwares="git vim zsh silversearcher-ag\
		       ranger curl tree make htop nodejs npm\
			   snapd docker docker.io docker-compose"
	echo "Hi handsome user! I will install some very common softwares\
		you may need such as $softwares"

    sudo apt install -y $softwares
fi
