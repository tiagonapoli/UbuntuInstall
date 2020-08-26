#!/bin/bash

set -euo pipefail

#tweaks
sudo apt -y install gnome-tweaks
sudo apt -y install chrome-gnome-shell

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`

#alternate tab
$SCRIPTPATH/gnomeShellExtension.sh --install --extension-id 15

#system-monitor gnome extension
sudo apt -y install gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0
$SCRIPTPATH/gnomeShellExtension.sh --install --extension-id 120

gsettings set com.ubuntu.sound allow-amplified-volume true
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'code.desktop']"
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 20
