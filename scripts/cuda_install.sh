#!/bin/bash

cd ~/Downloads

sudo apt-get -y install linux-headers-$(uname -r)
sudo apt-get -y install libglu1-mesa libxi-dev \
                        libxmu-dev libglu1-mesa-dev \
                        libgl1-mesa-dev freeglut3 freeglut3-dev \
                        mesa-common-dev

if [ ! -e "cuda_9.1.85_387.26_linux.run" ]; then
    echo "Download CUDA 9.1"
    wget https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda_9.1.85_387.26_linux
    mv cuda_9.1.85_387.26_linux cuda_9.1.85_387.26_linux.run
fi


sudo sh cuda_9.1.85_387.26_linux.run
sudo sh cuda_9.1.85_387.26_linux.run -silent -driver


#echo "PATH=$PATH:/usr/local/cuda-10.0/bin:" >> ~/.profile
#export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64\
#                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
