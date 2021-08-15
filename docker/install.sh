#!/bin/bash

_docker_proxy(){
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo cat << EOF > /etc/systemd/system/docker.service.d/proxy.conf
[Service]
Environment="http_proxy=$http_proxy"
Environment="https_proxy=$https_proxy"
Environment="no_proxy="localhost,127.0.0.1,::1"
EOF
}

_docker_gpu(){
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
&& curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
&& curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
}

if test ! $(which docker)
then
  
  if test "$(uname)" = "Darwin"
  then
  	 brew cask install docker
  
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
  	sudo apt install -y docker docker.io
	pip install docker-compose
  	_docker_gpu
  fi
fi

if test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
  	#_docker_proxy
  	GROUPNAME=docker
    getent group $GROUPNAME 2>&1 >/dev/null || groupadd $GROUPNAME
	sudo usermod -aG docker $(whoami)
  	sudo systemctl daemon-reload
  	sudo systemctl restart docker
fi
