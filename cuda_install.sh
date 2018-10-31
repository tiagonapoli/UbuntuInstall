#!/bin/bash

#CUDA 9.1

cd ~/Downloads

sudo apt-get -y install linux-headers-$(uname -r)
sudo apt-get -y install libglu1-mesa libxi-dev \
                        libxmu-dev libglu1-mesa-dev \
                        libgl1-mesa-dev freeglut3 freeglut3-dev \
                        mesa-common-dev

if [ ! -e "cuda_10.0.130_410.48_linux.run" ]; then
    echo "Download CUDA 10.0"
    wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux
    mv cuda_10.0.130_410.48_linux cuda_10.0.130_410.48_linux.run
fi

sudo sh cuda_10.0.130_410.48_linux.run
sudo sh cuda_10.0.130_410.48_linux.run -silent -driver


echo "PATH=$PATH:/usr/local/cuda-10.0/bin:" >> ~/.profile
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
