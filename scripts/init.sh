#!/bin/bash

source_if_exists(){
    file="$1"

    if [ -f "$file" ];then
        source "$file"
    fi
}

# zsh
source ~/.Qdotfiles/zsh/aliases.zsh
source ~/.Qdotfiles/zsh/theme.zsh

# ss
source ~/.Qdotfiles/ss/proxy.zsh

# zlua
source ~/.Qdotfiles/zlua/zlua.zsh

# github
source ~/.Qdotfiles/git/aliases.zsh

# ccat
source ~/.Qdotfiles/ccat/ccat.zsh

# conda
source ~/.Qdotfiles/conda/conda.zsh

# github
source_if_exists ~/.Qdotfiles/git/outh.sh
