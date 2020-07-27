#!/bin/bash
# check the software based on the directory.
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
        zlua_dir=/usr/softwares/z.lua
        if [ ! -d $zlua_dir ]
        then
         	# linux installation branch
            git clone https://github.com/skywind3000/z.lua $zlua_dir
        fi
fi
