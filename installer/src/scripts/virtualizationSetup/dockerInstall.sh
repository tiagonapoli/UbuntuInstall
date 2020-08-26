#!/bin/bash

function install_docker {
  sudo apt -y remove docker docker-engine docker.io containerd runc
  sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  sudo apt-get update

  sudo apt -y install docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker $USER
  if ! docker --version; then
    echo "Docker installation failed"
    exit 1
  fi
}

function install_docker_compose {
  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  if ! docker-compose --version; then
    echo "Docker-compose installation failed"
    exit 1
  fi
}

docker --version || install_docker
docker-compose --version || install_docker_compose
