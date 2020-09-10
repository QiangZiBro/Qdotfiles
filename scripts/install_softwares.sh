#!/bin/bash

cd "$(dirname $0)"/..


for i in  common zsh neovim zlua #ccat
do
    echo installing $i
    bash $i/install.sh #2>&1 > /dev/null 
done
wait
