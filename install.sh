#!/bin/bash

DATA_DIR="/mnt/data"
DOT_DIR="${DATA_DIR}/dot"
PRV_DIR="${DATA_DIR}/prv"

ln -sf ${DOT_DIR}/.alias ${HOME}/.alias
ln -sf ${DOT_DIR}/.bashrc ${HOME}/.bashrc
ln -sf ${DOT_DIR}/.inputrc ${HOME}/.inputrc

mkdir -p ${HOME}/.config/nvim
ln -sf ${DOT_DIR}/init.vim ${HOME}/.config/nvim/init.vim

if [[ ! -d ${HOME}/.asdf ]]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.6
fi

# private
mkdir -p ${HOME}/.ssh
cat ${PRV_DIR}/zasdaym.osh > ${HOME}/.ssh/id_rsa
cat ${PRV_DIR}/zasdaym.pub > ${HOME}/.ssh/id_rsa.pub
cp ${PRV_DIR}/ssh_config ${HOME}/.ssh/config

echo -e "Done"
