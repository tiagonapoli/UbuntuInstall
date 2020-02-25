#!/bin/bash
set -euo pipefail

display_info() {
  printf "Usage ./start.sh [OPT]\nOptions are:\n"
  printf "  -h: Show this message\n"
  printf "  -r: Restart installation\n"
  exit 0
}

RESET=false
while getopts "" OPT; do
  case "$OPT" in
    "r") RESET=true;;
    "h") display_info;;
    "?") display_info;;
  esac 
done

if [ "$RESET" == "true" ]; then
    echo "Installation will be restarted..."
    rm output/step.info
fi

# Install curl
sudo apt -y install curl

# Install NodeJS
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh -o /tmp/install_nvm.sh
bash /tmp/install_nvm.sh
. ~/.nvm/nvm.sh
nvm install 12 

# Install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt -y update
sudo apt -y install --no-install-recommends yarn


cd ./installer
yarn install --ignore-scripts
bash ./build.sh
reset
yarn start