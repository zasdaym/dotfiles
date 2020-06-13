#!/usr/bin/env bash

# check command
if [[ "$(command -v curl git zsh | wc -l)" -ne 3 ]]; then
  echo "Please install curl, git, and zsh."
  exit 1
fi

# oh-my-zsh
if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
ln -nfs ${PWD}/.zshrc ${HOME}/.zshrc

# asdf
if [[ ! -d ${HOME}/.asdf ]]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
fi

# neovim
mkdir -p ${HOME}/.config/nvim
ln -nfs ${PWD}/init.vim ${HOME}/.config/nvim/init.vim

echo "Done"
