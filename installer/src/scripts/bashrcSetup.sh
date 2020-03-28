#!/bin/bash

# Add aliases to .bashrc
set -euo pipefail

display_info() {
  printf "Usage ./bashrcSetup.sh [OPT]\nOptions are:\n"
  printf "  -h: Show this message\n"
  exit 0
}

while getopts "e:u:t:" OPT; do
  case "$OPT" in
    "h") display_info;;
    "?") display_info;;
  esac
done

read -p "Enter the default openvpn user: " OPENVPN_USER

if [ "$OPENVPN_USER" == "" ]; then
  echo "MISSING OPENVPN DEFAULT USER"
  exit 1
fi

echo "
alias install_dir='yarn global add file:\$PWD'
alias r='reset'
alias cdv='cd ~/Documents/vtex'
alias cdt='cd ~/Documents/tmp'

## Builder-Hub utilities
alias bhv='vtex deps ls | grep builder-hub'
function bhi() {
  CMD=\"vtex install vtex.builder-hub@\$1\" 
  echo \$CMD
  \$CMD
}
################

## vtex aliases
alias vtex='vtex --verbose'
alias vl='vtex link --verbose' 
alias vr='vtex workspace reset --verbose'
################

## PATH setup
export PATH=\$PATH:\$HOME/.yarn/bin
################

## OCLIF
export PATH=$PATH:$HOME/.oclif/dev/bin
export PATH=$PATH:$HOME/.vtex/dev/bin
################

## GO setup
export GOPATH=\$HOME/Documents/go-workspace
export PATH=\$PATH:\$GOPATH/bin
################

## OPENVPN aliases
alias startvpn='(echo $OPENVPN_USER > /tmp/vpnpass) && sudo openvpn --config ~/config.ovpn --auth-user-pass /tmp/vpnpass --daemon'
alias startvpn-no-daemon='(echo $OPENVPN_USER > /tmp/vpnpass) && sudo openvpn --config ~/config.ovpn --auth-user-pass /tmp/vpnpass'
################
" >> ~/.bashrc
