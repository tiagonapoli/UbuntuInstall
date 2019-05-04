#!/bin/bash

#update
sudo apt -y update && sudo apt -y upgrade

#Preload
sudo apt -y install preload

#TLP
sudo add-apt-repository -r -y  ppa:linrunner/tlp
sudo add-apt-repository -y ppa:linrunner/tlp
sudo apt update
sudo apt -y install tlp tlp-rdw
sudo tlp start

#restricted extras
sudo apt -y install ubuntu-restricted-extras

#base
sudo apt -y install htop terminator curl

#snap
sudo apt -y install snapd snapd-xdg-open

#Editors
sudo apt -y install vim
export EDITOR=/usr/bin/gedit
wget -O ~/Downloads/vscode_install.deb -c https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i ~/Downloads/vscode_install.deb
sudo apt install -y -f

#Media & social
sudo snap install discord vlc spotify telegram-desktop

#Langs
sudo apt -y install python3 python-pip

#Chrome
sudo apt -y install libxss1 libappindicator1 libindicator7
wget -O ~/Downloads/google_chrome_install.deb -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ~/Downloads/google_chrome_install.deb
sudo apt install -f

#tweaks
sudo apt -y install gnome-tweaks
sudo apt -y install chrome-gnome-shell

#wallpaper natgeo
sudo add-apt-repository -y ppa:atareao/atareao && sudo apt update
sudo apt install -y national-geographic-wallpaper

#alternate tab
./scripts/gnome-shell-extension.sh --install --extension-id 15

#system-monitor gnome extension
sudo apt install -y gir1.2-gtop-2.0 gir1.2-networkmanager-1.0  gir1.2-clutter-1.0
./scripts/gnome-shell-extension.sh --install --extension-id 120

#vscode
./vscode_extensions.sh

#Web development
sudo apt -y install nodejs
sudo apt -y install build-essential libssl-dev
cd ~/Downloads
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o install_nvm.sh
bash install_nvm.sh
. ~/.nvm/nvm.sh
nvm install 11.4.0 
snap install postman

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt -y update
sudo apt -y install --no-install-recommends yarn

