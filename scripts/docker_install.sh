#!/bin/bash

cd ~/Documents

#docker
docker --version
if [ $? -ne 0 ]
then
  curl -fsSL get.docker.com -o get-docker.sh
  chmod +x get-docker.sh
  ./get-docker.sh
  sudo usermod -aG docker $USER
  docker --version
  if [ $? -ne 0 ]
  then
    echo "Docker instalation failed"
    exit
  fi
fi

docker-compose --version
if [ $? -ne 0 ]
then
  sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
  if [ $? -ne 0]
  then
    echo "Docker-compose installation failed"
    exit
  fi
fi

docker-machine version
if [ $? -ne 0 ]
then
  base=https://github.com/docker/machine/releases/download/v0.14.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine
  docker-machine version
  if [ $? -ne 0]
  then
    echo "Docker-machine installation failed"
    exit
  fi
fi
