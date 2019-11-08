#!/bin/bash

cd ~/Downloads

function install_docker {
  sudo apt -y install docker docker.io
  sudo usermod -aG docker $USER
  if ! docker --version; then
    echo "Docker instalation failed"
    exit 1
  fi
}

function install_docker_compose {
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  if ! docker-compose --version; then
    echo "Docker-compose installation failed"
    exit 1
  fi
}


#docker
docker --version || install_docker
docker-compose --version || install_docker_compose