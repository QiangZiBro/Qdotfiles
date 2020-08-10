#!/bin/bash

cd "$(dirname $0)"/..

for i in  zsh spacevim #neovim zlua #ccat 
do
    bash $i/install.sh
done
