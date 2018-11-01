#!/bin/bash

cd ~/Documents

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


