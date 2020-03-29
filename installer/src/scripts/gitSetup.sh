#!/bin/bash
set -euo pipefail

display_info() {
  printf "Usage ./start.sh [OPT]\nOptions are:\n"
  printf "  -e: Email from github\n"
  printf "  -u: Your name\n"
  printf "  -t: Desired editor\n"
  printf "  -h: Show this message\n"
  exit 0
}

EMAIL=""
USERNAME=""
EDITOR=""
while getopts "e:u:t:" OPT; do
  case "$OPT" in
    "e") EMAIL=$OPTARG;;
    "u") USERNAME=$OPTARG;;
    "t") EDITOR=$OPTARG;;
    "h") display_info;;
    "?") display_info;;
  esac 
done

if [ "$EMAIL" == "" ]; then
  echo "MISSING EMAIL FLAG"
  exit 1
fi

if [ "$USERNAME" == "" ]; then
  echo "MISSING USERNAME FLAG"
  exit 1
fi

if [ "$EDITOR" == "" ]; then
  echo "MISSING EDITOR FLAG"
  exit 1
fi

GIT_CONFIG="[user]\n\
  email = \"$EMAIL\"\n\
  name = \"$USERNAME\"\n\
[core]\n\
  editor = $EDITOR\n\
[alias]\n\
  tree = log --graph --decorate --pretty=oneline --abbrev-commit\n\
  st = status\n\
  co = checkout\n\
  c = commit -s -v\n\
  cssh = !sh -c 'git clone git@github.com:\$1 ' -\n\
  rc = rebase --continue\n\
  rom = rebase origin/master\n\
  undo = reset HEAD~1 --mixed\n\
  amend = commit -s -v --amend\n\
[commit]\n\
  gpgsign = true\
"

GITHUB_TOKEN=""

function git_install {
    sudo apt-get -y install git
    echo -e "$GIT_CONFIG" > ~/.gitconfig
}

function sshkey_creation {
    rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
    ssh-keygen -t rsa -b 4096 -C "$1"
    ssh-add ~/.ssh/id_rsa
}

function send_sshkey_to_github {
  pub=`cat ~/.ssh/id_rsa.pub`
  user=$1

  ret=$(curl --request POST \
             --url    https://api.github.com/user/keys \
             --header "Authorization: token $GITHUB_TOKEN" \
             --data   "{\"title\":\"`hostname`\",\"key\":\"$pub\"}")

  if echo $ret | grep -q "message"; then
    echo $ret
    echo "Error on sending ssh key to github"
    return 1
  else
    return 0
  fi
}

function generate_gpg_key {
  BATCH_FILE="%no-protection\n\
Key-Type: default\n\
Subkey-Type: default\n\
Name-Real: $USERNAME\n\
Name-Email: $EMAIL\n\
Expire-Date: 0"

  echo -e $BATCH_FILE > /tmp/gpg-conf
  gpg --gen-key --batch /tmp/gpg-conf

  echo "===================================================================="
  echo "GPG KEYS"
  echo "===================================================================="

  gpg --list-secret-keys --keyid-format LONG
  echo "===================================================================="

  GPG_ARMORED_PUBLIC_KEY=$(gpg --armor --export $EMAIL | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g')
  DATA="{\"armored_public_key\":\""$GPG_ARMORED_PUBLIC_KEY"\"}"
  ret=$(curl --request POST \
             --url     https://api.github.com/user/gpg_keys \
             --header  "Authorization: token $GITHUB_TOKEN" \
             --data    "$DATA")

  if echo $ret | grep -q "message"; then
    echo $ret
    echo "Error on sending gpg key to github"
    return 1
  else
    return 0
  fi
}

function create_api_token {
  echo "===================================================================="
  echo "GITHUB_API_TOKEN: In this step you'll have to create a personal"
  echo "access token with:"
  echo "- all 'repo' permissions"
  echo "- Write 'admin:gpg_key'"
  echo "- Write 'admin:public_key'"
  echo "https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line"
  echo "===================================================================="

  read -p "Enter your GITHUB_API_TOKEN: " GITHUB_TOKEN

  echo -e "\n\
## GITHUB setup\n\
export GITHUB_API_TOKEN=$GITHUB_TOKEN\n\
################\n" >> ~/.bashrc
}

function jump_lines {
  echo ""
  echo ""
}

git_install
jump_lines

create_api_token
jump_lines

sshkey_creation $EMAIL
jump_lines

send_sshkey_to_github $EMAIL || exit 1
jump_lines

generate_gpg_key || exit 1
jump_lines