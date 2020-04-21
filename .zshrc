# ohmyzsh
export ZSH="/home/zasda/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
plugins=(
	asdf
	fzf
	git
)
source $ZSH/oh-my-zsh.sh

# user bin
[ -d "${HOME}/.local/bin" ] && export PATH=${HOME}/.local/bin:${PATH}

# editor
export EDITOR="nvim"

# libvirt
export LIBVIRT_DEFAULT_URI="qemu:///system"

# fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow -g '!{.git,node_modules}'"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="fd -t d"
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
