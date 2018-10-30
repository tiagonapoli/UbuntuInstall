#!/bin/bash
#TODO add chrome

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

#tweaks
sudo apt -y install gnome-tweaks
sudo apt-get install chrome-gnome-shell


