#!/bin/bash

# variables
DATA_DIR="/mnt/data"
DOT_DIR="${DATA_DIR}/dot"
PRV_DIR="${DATA_DIR}/prv"

# zsh
ln -nfs ${DOT_DIR}/.zshrc ${HOME}/.zshrc

# neovim
mkdir -p ${HOME}/.config/nvim
ln -nfs ${DOT_DIR}/init.vim ${HOME}/.config/nvim/init.vim

# asdf
if [[ ! -d ${HOME}/.asdf ]]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
fi

# ssh
mkdir -p ${HOME}/.ssh
cat ${PRV_DIR}/zasdaym.osh > ${HOME}/.ssh/id_rsa
cat ${PRV_DIR}/zasdaym.pub > ${HOME}/.ssh/id_rsa.pub
cp ${PRV_DIR}/ssh_config ${HOME}/.ssh/config

echo -e "Done"
