#!/bin/bash
# install all softwares

cd "$(dirname $0)"/..


for i in zsh neovim zlua #ccat
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
