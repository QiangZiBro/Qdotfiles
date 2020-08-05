#!/bin/bash

cd "$(dirname $0)"/..

for i in  zsh neovim #ccat zlua 
do
    bash $i/install.sh
done
