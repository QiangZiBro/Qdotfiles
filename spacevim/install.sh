#!/bin/bash
if test "$(uname)" = "Darwin"
then
    # mac installation branch
    curl -sLf https://spacevim.org/install.sh | bash
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
    # linux installation branch
    curl -sLf https://spacevim.org/install.sh | bash

fi
cp init.toml  ~/.SpaceVim.d
