#!/bin/bash

function install_docker {
  curl -fsSL get.docker.com -o get-docker.sh
  chmod +x get-docker.sh
  ./get-docker.sh
  sudo usermod -aG docker $USER
  docker --version \
    ||  echo "Docker instalation failed" \
        && exit
}

function install_docker_compose {
  sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version \
    ||  echo "Docker-compose installation failed" \
        && exit
}

function install_docker_machine {
  base=https://github.com/docker/machine/releases/download/v0.14.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine
  docker-machine version \
    ||  echo "Docker-machine installation failed" \
        && exit
}

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

#Chrome
sudo apt-get -y install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
sudo apt-get install -f

#tweaks
sudo apt -y install gnome-tweaks
sudo apt-get install chrome-gnome-shell

#alternate tab
./gnome-shell-extension.sh --install --extension-id 15


