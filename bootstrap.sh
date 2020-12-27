#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

programs=(curl git vim zsh)
for program in ${programs[@]}; do
	if [[ ! -x "$(command -v ${program})" ]]; then
		echo "Please install ${program} first"
		exit 1
	fi
done

if [[ ${SHELL} != "/bin/zsh" ]]; then
	chsh -s /bin/zsh
fi

if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

ln -fs ${PWD}/.tmux.conf ${HOME}/.tmux.conf
ln -fs ${PWD}/.vimrc ${HOME}/.vimrc
ln -fs ${PWD}/.zshrc ${HOME}/.zshrc
