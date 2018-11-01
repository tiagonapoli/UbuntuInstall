#!/bin/bash

function install_docker {
  curl -fsSL get.docker.com -o get-docker.sh
  chmod +x get-docker.sh
  ./get-docker.sh
  sudo usermod -aG docker $USER
  docker --version || echo "Docker instalation failed"
}

function install_docker_compose {
  sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version || echo "Docker-compose installation failed"
}

function install_docker_machine {
  base=https://github.com/docker/machine/releases/download/v0.14.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine
  docker-machine version || echo "Docker-machine installation failed"
}

cd ~/Documents

#docker
docker --version || install_docker
docker-compose --version || install_docker_compose
docker-machine version || install_docker_machine
