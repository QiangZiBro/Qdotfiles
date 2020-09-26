#!/bin/bash
# install all softwares

cd "$(dirname $0)"/..

bash scripts/init_new_machine/install_common_softwares.sh

for i in zsh neovim 
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
