#!/bin/bash

# variables
DATA_DIR="/mnt/data"
DOT_DIR="${DATA_DIR}/dot"
PRV_DIR="${DATA_DIR}/prv"

# oh-my-zsh
if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# zsh
ln -nfs ${DOT_DIR}/.zshrc ${HOME}/.zshrc

# asdf
if [[ ! -d ${HOME}/.asdf ]]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
fi

# neovim
mkdir -p ${HOME}/.config/nvim
ln -nfs ${DOT_DIR}/init.vim ${HOME}/.config/nvim/init.vim

# ssh
mkdir -p ${HOME}/.ssh
cp ${PRV_DIR}/ssh/zasdaym.id_rsa ${HOME}/.ssh/id_rsa
cp ${PRV_DIR}/ssh/zasdaym.id_rsa.pub ${HOME}/.ssh/id_rsa.pub
ln -nfs ${PRV_DIR}/ssh/ssh_config ${HOME}/.ssh/config
sudo chmod -R 700 ${HOME}/.ssh

# user directory
ln -nfs ${DATA_DIR}/codes ${HOME}/Codes
rm -rf ${HOME}/Documents && ln -nfs ${DATA_DIR}/doc ${HOME}/Documents
rm -rf ${HOME}/Downloads && ln -nfs ${DATA_DIR}/dwn ${HOME}/Downloads
rm -rf ${HOME}/Pictures && ln -nfs ${DATA_DIR}/pic ${HOME}/Pictures
rm -rf ${HOME}/Videos && ln -nfs ${DATA_DIR}/vid ${HOME}/Videos

echo -e "Done"
