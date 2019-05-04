#!/bin/bash

#vscode extensions
(cat ../config/vscode_extensions.list || cat ./config/vscode_extensions.list) | while read line; do
    cmd="code --install-extension"
    if [[ $line == "#"* ]];
    then 
	    continue
    fi
    echo "Installing $line..."
    $cmd $line
    echo
done