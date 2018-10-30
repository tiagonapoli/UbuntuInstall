#!/bin/bash

chmod +x docker_install.sh
chmod +x git_install.sh
chmod +x packages_install.sh
chmod +x nvidia_install_pre_reboot.sh
chmod +x nvidia_install_post_reboot.sh

./packages_install.sh
./docker_install.sh
./git_install.sh
./nvidia_install_pre_reboot.sh

