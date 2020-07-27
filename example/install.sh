#!/bin/bash

# Smartly use code below, this code can't find command for alias
if ! command -v  conda &> /dev/null
then
    # installation process...
    if test "$(uname)" = "darwin"
    then
         # mac installation branch
        echo mac install

    elif test "$(expr substr $(uname -s) 1 5)" = "linux"
    then
         # linux installation branch
        echo linux install

    fi
fi

# BUGGY!!!!! 
#    though you can find alias output results in command line, but when you run this file, nothing
#    can be done
# Don't use now!
# check_exists() {
#     local COMMAND=$1
#     if ! command -v  $COMMAND &> /dev/null
#     then
#         alias $COMMAND >/dev/null 2>&1 && echo "$1 is set as an alias" || echo "$1 is not an alias"
#         if ! alias $COMMAND >/dev/null 2>&1
#         then
#             echo "$COMMAND is not an alias"
#         fi
#     fi
# }


# check_exists _zlua
