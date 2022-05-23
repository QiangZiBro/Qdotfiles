#!/bin/bash
# When ready to work on a new system, download some basic softwares of development
cd "$(dirname $0)"/..

# Some common softwares installed by linux apt
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt update -y
  bash "scripts/init_a_fresh_ubuntu/2.install_common_softwares.sh"
fi

# Some softwares need more complicated installation/configuration/more addons.
dist_install(){
	for i in $@
	do
		bash $i/install.sh &
	done
	wait
}
seq_install(){
	for i in $@
	do
		bash $i/install.sh 
	done
}
softwares=(homebrew neovim tmux fzf zsh lazygit)
if [ "$1" = "dist" ];then
	dist_install "${softwares[@]}"
else
	seq_install "${softwares[@]}"
fi
