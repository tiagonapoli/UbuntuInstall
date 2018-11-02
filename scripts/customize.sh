#!/bin/bash

gsettings set com.ubuntu.sound allow-amplified-volume true
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'vscode_vscode.desktop']"
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 20
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'br'), ('xkb', 'us')]"
gsettings set org.gnome.desktop.input-sources mru-sources "[('xkb', 'us'), ('xkb', 'br')]"
gsettings set org.gnome.desktop.input-sources xkb-options "[]"