#!/bin/bash

cd ~/Documents

#update
sudo apt -y update && sudo apt -y upgrade

#Preload
sudo apt-get -y install preload

#TLP
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get -y install tlp tlp-rdw
sudo tlp start

#restricted extras
sudo apt -y install ubuntu-restricted-extras


#base
sudo apt-get -y install htop terminator curl

#snap
sudo apt-get -y install snapd snapd-xdg-open


#Editors
sudo apt-get -y install vim
sudo snap install --classic vscode
sudo snap install discord vlc spotify telegram-desktop

#Langs
sudo apt-get -y install python3 python-pip

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

#git
sudo apt-get -y install git
git config --global user.email "napoli.tiago@hotmail.com"
git config --global user.name "tiagonapoli"

#ssh git
echo "ssh github"
rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
ssh-keygen -t rsa
ssh-add ~/.ssh/id_rsa
pub=`cat ~/.ssh/id_rsa.pub`
read -p "Enter github username: " githubuser
echo "Using username $githubuser"
read -s -p "Enter github password for user $githubuser: " githubpass
curl -u "$githubuser:$githubpass" -X POST -d "{\"title\":\"`hostname`\",\"key\":\"$pub\"}" https://api.github.com/user/keys

#clone git
git clone git@github.com:tiagonapoli/maratona.git
cp maratona/vimrc ~/.vimrc

#tweaks
sudo apt -y install gnome-tweaks
sudo apt-get install chrome-gnome-shell


