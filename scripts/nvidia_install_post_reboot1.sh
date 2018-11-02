#!/bin/bash
#./nvidia_install_post_reboot1.sh nvidia-version cuda-version

sudo bash ~/Downloads/nvidia_driver_installer$1.run --install-libglvnd
nvidia-smi

sleep 5
