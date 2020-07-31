#!/bin/bash

cd "$(dirname $0)"/..

for i in  zsh neovim zlua
do
    bash $i/install.sh
done
