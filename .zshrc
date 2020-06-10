# oh-my-zsh
export ZSH="/home/zasda/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
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

# snap
[ -d "/snap/bin" ] && export PATH=/snap/bin:${PATH}

# user bin
[ -d "${HOME}/.local/bin" ] && export PATH=${HOME}/.local/bin:${PATH}

# editor
export EDITOR="nvim"

# libvirt
export LIBVIRT_DEFAULT_URI="qemu:///system"

# fzf
export FZF_DEFAULT_COMMAND="rg --files --follow -g '!{.git,node_modules}'"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="fdfind -t d"
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
