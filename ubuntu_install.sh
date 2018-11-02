#!/bin/bash
#-r reset

if [ "$1" == "-r" ]; then
    echo "Restart script"
    rm output/step.info
fi
sudo apt-get -y install python3 python-pip
reset

python3 ./scripts/ubuntu_install.py
