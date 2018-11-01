#!/bin/bash

function header {
    text=" Run $1 "
    sz=${#text}

    a=""
    for ((i=0;i<10;i++)); do
        a="=$a"
    done
    b=""
    for ((i=0;i<$sz;i++)); do
        b="=$b"
    done
    echo "$a$b$a"
    echo "$a$text$a"
    echo "$a$b$a"
}

Scripts=( "scripts/packages_install.sh" \
          "scripts/docker_install.sh" \
          "scripts/git_install.sh" \
          "scripts/nvidia_install_pre_reboot.sh" \
          "scripts/nvidia_install_post_reboot0.sh" \
          "scripts/nvidia_install_post_reboot1.sh" \
          "scripts/cuda_install.sh" \
          "scripts/nvidia_docker_install.sh"
)

for script in ${Scripts[*]}; do
    chmod +x ${script}
done

if [ ! -e "output/step.info" ]; then
    echo 0 > output/step.info
fi
step=$(cat output/step.info)

for (( ;$step<${#Scripts[*]};step+=1 )); do
    command="./${Scripts[step]}"  
    echo $command
    header ${Scripts[step]}
    ${command}    
done

