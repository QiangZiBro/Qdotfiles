#!/bin/bash
# check the software based on the directory.
set -x
if test "$(uname)" = "Darwin"
then
    zlua_dir=~/applications/z.lua
    if [ ! -d $zlua_dir ]
    then
 	    # Mac installation branch
        git clone https://github.com/skywind3000/z.lua $zlua_dir
    fi
 	
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
        zlua_dir=/usr/local/softwares/z.lua
        if [ ! -d $zlua_dir ]
        then
            sudo apt-get install lua5.3
            # sudo ln -s /usr/bin/lua5.3 /usr/bin/lua
         	# linux installation branch
            git clone https://github.com/skywind3000/z.lua $zlua_dir
        fi
fi
