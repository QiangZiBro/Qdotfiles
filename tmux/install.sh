#!/bin/bash

set -e
if test "$(uname)" = "Darwin"
then
	 # mac installation branch
	 brew install tmux

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
	#https://gist.github.com/joelrich/2f6fa444649adaae8b8499e7b3a5769e
	sudo apt update
	sudo apt install -y build-essential autoconf automake pkg-config libevent-dev libncurses5-dev bison byacc
	if [ -e /tmp/tmux ];then
		rm -rf /tmp/tmux
	fi
	git clone https://github.com/tmux/tmux.git --depth 1 /tmp/tmux
	cd /tmp/tmux
	#git checkout 3.0a
	sh autogen.sh
	./configure && make
	sudo make install
fi

# tmux plug manager
if [ ! -d ~/.tmux/plugins/ ];then
	mkdir -p ~/.tmux/plugins/
fi

if [ ! -d ~/.tmux/plugins/tpm ];then
	cd ~/.tmux/plugins/
	git clone https://github.com/tmux-plugins/tpm
fi
tmux source ~/.tmux.conf

exit 0
