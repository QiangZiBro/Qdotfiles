#!/bin/bash
# Install working softwares
# Notes: Most of the softwares below needs command proxy,
#		 which can used by docker
# Args: 
# -q : keep silent


cd "$(dirname $0)"/..

bash scripts/init_new_machine/install_common_softwares.sh

for i in docker zsh neovim tmux
do
    echo installing $i
	if [ "$1" = "-q" ];
	then
		bash $i/install.sh 2>&1 > /dev/null 
	else
		bash $i/install.sh
	fi
done

#wait
