#!/bin/bash
#./git_install email username editor

function git_install {
    sudo apt-get -y install git
    git config --global user.email $1
    git config --global user.name $2
    git config --global core.editor $3
}

function sshkey_creation {
    rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
    ssh-keygen -t rsa
    ssh-add ~/.ssh/id_rsa
}

function send_sshkey_to_github {
    pub=`cat ~/.ssh/id_rsa.pub`
    read -s -p "Enter github password for user $1: " githubpass
    ret=$(curl -u "$1:$githubpass" -X POST -d "{\"title\":\"`hostname`\",\"key\":\"$pub\"}" https://api.github.com/user/keys)
    echo $ret
    if echo $ret | grep -q "message"; then
        echo "Error on sending ssh key to github"
        return 1
    else
        return 0
    fi    
}

git_install $1 $2 $3
sshkey_creation 
send_sshkey_to_github $2 || exit 1
