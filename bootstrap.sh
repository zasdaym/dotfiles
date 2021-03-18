#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

# check required programs
programs=("curl" "git" "zsh")
for program in ${programs[@]}; do
	if [[ ! -x "$(command -v ${program})" ]]; then
		echo "Please install ${program} first"
		exit 1
	fi
done

# ssh setup
if [[ ! -f ${HOME}/.ssh/id_rsa ]]; then
	mkdir -p ${HOME}/.ssh
	openssl enc -d -aes-256-cbc -iter 6 -in ssh/ssh.tar.gz.encrypted | tar -xz -C ${HOME}/.ssh/
fi

# check zsh
if [[ ${SHELL} != "/bin/zsh" ]]; then
	chsh -s /bin/zsh
fi

# check oh-my-zsh
if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi

# check asdf
if [[ ! -d ${HOME}/.asdf ]]; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
fi

# check tpm
if [[ ! -d "${HOME}/.tmux/plugins/tpm" ]]; then
	git clone https://github.com/tmux-plugins/tpm.git "${HOME}/.tmux/plugins/tpm"
fi

# symlink config files
ln -fsn "${PWD}/.zshrc" "${HOME}/.zshrc"
ln -fsn "${PWD}/alacritty" "${HOME}/.config/alacritty"
ln -fsn "${PWD}/git" "${HOME}/.config/git"
ln -fsn "${PWD}/nvim" "${HOME}/.config/nvim"
ln -fsn "${PWD}/rofi" "${HOME}/.config/rofi"
ln -fsn "${PWD}/tmux" "${HOME}/.config/tmux"

echo OK
