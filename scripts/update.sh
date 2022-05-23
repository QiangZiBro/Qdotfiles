#!/usr/bin/env bash

######################################################################
# @author      : QiangZiBro (qiangzibro@gmail.com)
# @file        : update
# @created     : 星期一  9 12, 2022 20:53:23 CST
#
# @description : 
######################################################################

update_nvim() {
	trap 'return' INT

    #set rust environment variables
    export RUSTC_WRAPPER=$(which sccache)
    export RUSTUP_TOOLCHAIN='stable'

    #update vim-plug and extensions
    nvim +PlugInstall +UpdateRemotePlugins +PlugUpgrade +PlugUpdate +PlugDiff +'w ~/.PlugDiff' +CocUpdate +qa
    cat ~/.PlugDiff
    rm ~/.PlugDiff
    unset RUSTC_WRAPPER RUSTUP_TOOLCHAIN
}
update_nvim
