#!/bin/bash
#./nvidia_install_pre_reboot.sh nvidia-version cuda-version

cd ~/Documents

wget -O nvidia_driver_installer.run -c http://us.download.nvidia.com/XFree86/Linux-x86_64/$1/NVIDIA-Linux-x86_64-$1.run
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install build-essential libc6:i386 dkms pkg-config

#disable noveau
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"

cat /etc/modprobe.d/blacklist-nvidia-nouveau.conf

sudo update-initramfs -u
