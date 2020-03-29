#!/bin/bash

curl -sL https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz -o /tmp/goInstall.tar.gz
sudo tar -C /usr/local -xzf /tmp/goInstall.tar.gz

mkdir ~/Documents/go-workspace

echo -e "\n\
## GO setup\n\
export PATH=\$PATH:/usr/local/go/bin\n\
export GOPATH=\$HOME/Documents/go-workspace\n\
export PATH=\$PATH:\$GOPATH/bin\n\
################\n" >> ~/.bashrc