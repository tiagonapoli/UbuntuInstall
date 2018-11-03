#!/bin/bash
#./cuda_install.sh nvidia-version cuda-version

#https://kislayabhi.github.io/Installing_CUDA_with_Ubuntu/

cd ~/Downloads

sudo apt-get -y install linux-headers-$(uname -r)
sudo apt-get -y install libglu1-mesa libxi-dev \
                        libxmu-dev libglu1-mesa-dev \
                        libgl1-mesa-dev freeglut3 freeglut3-dev \
                        mesa-common-dev

wget -O cuda_installer$2.run -c https://developer.nvidia.com/compute/cuda/$2/Prod/local_installers/cuda_$3_linux

sudo sh cuda_installer$2.run --override --silent --toolkit --samples --verbose

echo "===================================="
cat /proc/driver/nvidia/version
echo "===================================="

echo "PATH=$PATH:/usr/local/cuda-$2/bin:" >> ~/.profile
echo "LD_LIBRARY_PATH=/usr/local/cuda-$2/lib64:$LD_LIBRARY_PATH" >> ~/.profile

cd /usr/local/cuda/samples/1_Utilities/deviceQuery
sudo make || exit 2
./deviceQuery || exit 3


