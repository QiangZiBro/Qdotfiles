#!/bin/bash
# Install working softwares
# Notes: Most of the softwares below needs command proxy,
#		 which can used by docker
# Args: 
# -q : keep silent


cd "$(dirname $0)"/..

#if test "$(expr substr $(uname -s) 1 5)" = "Linux"
#then
#	# will install three kind of softwares
#	# bash scripts/init_new_machine/install_common_softwares.sh
#	# bash scripts/init_new_machine/install_develop_softwares.sh
#fi

# TODO: setup the proxy
for i in docker zsh neovim tmux homebrew
do
    echo installing $i
	if [ "$1" = "-q" ];
	then
		bash $i/install.sh 2>&1 > /dev/null 
	else
		bash $i/install.sh
	fi
done
