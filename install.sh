#!/bin/bash

DATA_DIR="/mnt/data"
DOT_DIR="${DATA_DIR}/dot"
PRV_DIR="${DATA_DIR}/prv"

ln -sf ${DATA_DIR}/.alias ${HOME}/.alias
ln -sf ${DATA_DIR}/.bashrc ${HOME}/.bashrc
ln -sf ${DATA_DIR}/.inputrc ${HOME}/.inputrc

mkdir -p ${HOME}/.config/nvim
ln -sf ${DATA_DIR}/init.vim ${HOME}/.config/nvim/init.vim

# private
mkdir -p ${HOME}/.ssh
cat ${PRV_DIR}/zasdaym.osh | tee ${HOME}/.ssh/id_rsa
cat ${PRV_DIR}/zasdaym.pub | tee ${HOME}/.ssh/id_rsa.pub
cp ${PRV_DIR}/ssh_config | tee ${HOME}/.ssh/config
