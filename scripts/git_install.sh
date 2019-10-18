#!/bin/bash
#./git_install email username editor

function git_install {
    sudo apt-get -y install git
    # gitconfig
    echo "
    [user]
        email = tiago.napoli@vtex.com.br
        name = tiagonapoli
    [core]
        editor = vim
    [alias]
        tree = log --graph --decorate --pretty=oneline --abbrev-commit
        st = status
        co = checkout
        cssh = !sh -c 'git clone git@github.com:\$1 ' -
    " > ~/.gitconfig
}

function sshkey_creation {
    rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
    ssh-keygen -t rsa -b 4096 -C "$1"
    ssh-add ~/.ssh/id_rsa
}

function send_sshkey_to_github {
    pub=`cat ~/.ssh/id_rsa.pub`
    user=$1
    read -s -p "Enter github password for user $1: " password
    read -p "Enter the 2 factor key: " otp
    auth=$(echo -n $user:$password | base64 -)
    
    ret=$(curl --request POST \
               --url https://api.github.com/user/keys \
               --header "Authorization: Basic $auth" \
               --header "x-github-otp: $otp" \
               --data   "{\"title\":\"`hostname`\",\"key\":\"$pub\"}")
    
    echo $ret
    if echo $ret | grep -q "message"; then
        echo "Error on sending ssh key to github"
        return 1
    else
        return 0
    fi    
}

read -p "Enter your GITHUB_API_TOKEN (https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line): " gitToken

echo "
export GITHUB_API_TOKEN=$gitToken
" >> ~/.bashrc

git_install
sshkey_creation
send_sshkey_to_github $2 || exit 1
