#!/bin/bash
#./nvidia_install_post_reboot0.sh nvidia-version cuda-version

ret=$(cat ./output/step.info | cut -d" " -f2-)
echo $ret > ./output/step.info
sudo telinit 3