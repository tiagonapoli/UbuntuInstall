#!/bin/bash
#./cuda_install.sh nvidia-version cuda-version

cd ~/Downloads

sudo apt-get -y install linux-headers-$(uname -r)
sudo apt-get -y install libglu1-mesa libxi-dev \
                        libxmu-dev libglu1-mesa-dev \
                        libgl1-mesa-dev freeglut3 freeglut3-dev \
                        mesa-common-dev

wget -O cuda_installer.run -c https://developer.nvidia.com/compute/cuda/$2/Prod/local_installers/cuda_$3_linux
sudo sh cuda_installer.run
sudo sh cuda_installer.run -silent -driver


#echo "PATH=$PATH:/usr/local/cuda-10.0/bin:" >> ~/.profile
#export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64\
#                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
