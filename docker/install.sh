#!/bin/bash
_setting_docker_runtime_proxy() {
  sudo mkdir -p /etc/systemd/system/docker.service.d
  sudo cat <<EOF >/etc/systemd/system/docker.service.d/proxy.conf
[Service]
Environment="http_proxy=$http_proxy"
Environment="https_proxy=$https_proxy"
Environment="no_proxy="localhost,127.0.0.1,::1"
EOF
}

_install_nvidia_docker() {
if test ! $(which nvidia-docker); then
  distribution=$(
    . /etc/os-release
    echo $ID$VERSION_ID
  ) &&
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - &&
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
  sudo apt-get update
  sudo apt-get install -y nvidia-docker2
fi
}

if test ! $(which docker); then
  curl -sSL https://get.docker.com/ | sh 
  pip install docker-compose
fi
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  #_setting_docker_runtime_proxy
  # 解决Linux下docker要sudo的问题
  GROUPNAME=docker
  getent group $GROUPNAME 2>&1 >/dev/null || groupadd $GROUPNAME
  sudo usermod -aG docker $(whoami)
  # 安装GPU支持的docker
  _install_nvidia_docker

  sudo systemctl daemon-reload
  sudo systemctl restart docker
fi
