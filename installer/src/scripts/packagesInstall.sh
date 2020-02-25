#!/bin/bash

set -euo pipefail

#update
sudo apt -y update && sudo apt -y upgrade

#snap
sudo apt -y install snapd snapd-xdg-open

#Media & social
sudo snap install vlc telegram-desktop
sudo snap install slack --classic

#Preload
sudo apt -y install preload

#TLP
sudo apt -y install tlp
sudo tlp start

#restricted extras
sudo apt -y install ubuntu-restricted-extras

#base
sudo apt -y install htop terminator curl zstd

#Editors
sudo apt -y install vim
wget -O /tmp/vscode_install.deb -c https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i /tmp/vscode_install.deb
sudo apt install -y -f

#Langs
sudo apt -y install python3 python-pip

#Chrome
sudo apt -y install libxss1 libappindicator1 libindicator7
wget -O /tmp/google_chrome_install.deb -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google_chrome_install.deb
sudo apt install -y -f

#Web development
sudo apt -y install nodejs
sudo apt -y install build-essential libssl-dev
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o /tmp/install_nvm.sh
bash /tmp/install_nvm.sh
. ~/.nvm/nvm.sh
nvm install 12 
snap install postman

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt -y update
sudo apt -y install --no-install-recommends yarn

# Add yarn global packages
yarn global add \
  @tiagonapoli/vtex-scripts \
  cost-of-modules \
  releasy \
  typescript \
  vtex

# Dropbox
wget -O /tmp/dropbox.deb -c https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2019.02.14_amd64.deb
sudo dpkg -i /tmp/dropbox.deb