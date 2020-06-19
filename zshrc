# oh-my-zsh
export ZSH="/home/zasda/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"

# fzf
export FZF_BASE="${HOME}/.config/nvim/plugged/fzf"

# plugins
plugins=(
	asdf
	aws
	docker
	docker-compose
	doctl
	fzf
	git
	minikube
	terraform
)
source $ZSH/oh-my-zsh.sh

export EDITOR=nvim

# snap
[ -d "/snap/bin" ] && export PATH="/snap/bin:${PATH}"

# user bin
[ -d "${HOME}/.local/bin" ] && export PATH="${HOME}/.local/bin:${PATH}"
