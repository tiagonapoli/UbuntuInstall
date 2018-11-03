#!/bin/bash
#./nvidia_install_pre_reboot.sh nvidia-version cuda-version

wget -O ~/Downloads/nvidia_driver_installer$1.run -c http://us.download.nvidia.com/XFree86/Linux-x86_64/$1/NVIDIA-Linux-x86_64-$1.run
sudo dpkg --add-architecture i386
sudo apt update
sudo apt -y install build-essential libc6:i386 dkms pkg-config

#disable noveau
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"

cat /etc/modprobe.d/blacklist-nvidia-nouveau.conf

sudo update-initramfs -u
ret=$(cat ./output/step.info | cut -d" " -f2-)
echo $ret > ./output/step.info
reboot
