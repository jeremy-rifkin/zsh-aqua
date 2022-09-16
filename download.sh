#!/bin/bash
cd
if [ -d ".zsh-aqua/" ]
then
    echo "Directory .zsh-aqua/ already exists. Please remove it."
else
    mkdir .zsh-aqua && cd .zsh-aqua
    wget "https://raw.githubusercontent.com/jeremy-rifkin/zsh-aqua/master/bundle.tar.gz"
    tar -xzf bundle.tar.gz && rm bundle.tar.gz
    cd ..
fi
