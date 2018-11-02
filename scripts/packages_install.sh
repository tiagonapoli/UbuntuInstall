#!/bin/bash

#update
sudo apt -y update && sudo apt -y upgrade

#Preload
sudo apt-get -y install preload

#TLP
sudo add-apt-repository -r -y  ppa:linrunner/tlp
sudo add-apt-repository -y ppa:linrunner/tlp
sudo apt-get update
sudo apt-get -y install tlp tlp-rdw
sudo tlp start

#restricted extras
sudo apt -y install ubuntu-restricted-extras

#base
sudo apt-get -y install htop terminator curl cut

#snap
sudo apt-get -y install snapd snapd-xdg-open

#Editors
sudo apt-get -y install vim
wget -O ~/Downloads/vscode_install.deb -c https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i ~/Downloads/vscode_install.deb
sudo apt-get install -y -f

#Media & social
sudo snap install discord vlc spotify telegram-desktop

#Langs
sudo apt-get -y install python3 python-pip

#Chrome
sudo apt-get -y install libxss1 libappindicator1 libindicator7
wget -O ~/Downloads/google_chrome_install.deb -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ~/Downloads/google_chrome_install.deb
sudo apt-get install -f

#tweaks
sudo apt -y install gnome-tweaks
sudo apt-get install chrome-gnome-shell

#alternate tab
./scripts/gnome-shell-extension.sh --install --extension-id 15


