#!/bin/bash

cd "$(dirname $0)"/..


for i in  common zsh neovim zlua ccat ranger
do
    bash $i/install.sh
done
