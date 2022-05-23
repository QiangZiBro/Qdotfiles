#!/bin/bash
source $(dirname $0)/../homebrew/homebrew.zsh

install_linux(){
cd /tmp
curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
| grep "https://.*Linux_x86_64.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
tar xzf *Linux_x86_64.tar.gz
sudo cp lazygit /usr/local/bin
}
if command -v lazygit 2>&1 >/dev/null; then
  echo lazygit has been installed
else
  if [[ "$OSTYPE" = "linux-gnu"* ]]; then
	  install_linux
  elif [[ "$OSTYPE" = "darwin"* ]]; then
	  brew install jesseduffield/lazygit/lazygit
  fi
fi
