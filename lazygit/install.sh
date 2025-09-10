#!/bin/bash
source $(dirname $(realpath "$0"))/../scripts/util_vars.sh

install_linux(){
cd /tmp && rm -rf lazygit*.tar.gz && rm -rf lazygit
curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep "browser_download_url" |grep $QD_ARCH |grep $QD_PLATFORM | cut -d : -f 2,3 | tr -d \" | wget -qi -
tar xzf lazygit*.tar.gz
${SUDO} cp lazygit /usr/local/bin
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
