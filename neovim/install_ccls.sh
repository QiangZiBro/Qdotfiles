#!/usr/bin/env bash

######################################################################
# @author      : QiangZiBro (qiangzibro@gmail.com)
# @created     : Thursday Jan 05, 2023 17:08:30 CST
#
# @description : 
######################################################################

PREFIX=${PREFIX-/tmp/ccls}
if test "$(uname)" = "Darwin"; then
	brew install ccls
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
	sudo apt install  zlib1g-dev -y
	sudo apt install clang cmake libclang-dev llvm-dev rapidjson-dev -y
	sudo apt install libtinfo5 -y
	git clone --depth=1 --recursive https://github.com/MaskRay/ccls $PREFIX
	cd $PREFIX
	wget --no-check-certificate -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
	tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
	cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
	cmake --build Release
	sudo cmake --build Release --target install
	cd -
fi
