#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

# check required programs
programs=("curl" "git" "nvim" "zsh")
for program in ${programs[@]}; do
	if [[ ! -x "$(command -v ${program})" ]]; then
		echo "Please install ${program} first"
		exit 1
	fi
done

# check shell
if [[ ${SHELL} != "/bin/zsh" ]]; then
	chsh -s /bin/zsh
fi

# check oh-my-zsh
if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi

# check tpm
if [[ ! -d "${HOME}/.tmux/plugins/tpm" ]]; then
	git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
fi

# symlink config files
ln -fsn "${PWD}/tmux" "${HOME}/.config/tmux"
ln -fsn "${PWD}/nvim" "${HOME}/.config/nvim"
ln -fsn "${PWD}/alacritty" "${HOME}/.config/alacritty"
ln -fs "${PWD}/.zshrc" "${HOME}/.zshrc"
