#!/bin/bash

cd "$(dirname $0)"/..

for i in  zsh neovim zlua #ccat 
do
    bash $i/install.sh
done
