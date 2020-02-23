# global
[ -f /etc/bashrc ] && source /etc/bashrc

# user
if ! [[ ${PATH} =~ ${HOME}/.local/bin ]]; then
	PATH=${HOME}/.local/bin:${PATH}
fi

# alias
test -s ~/.alias && . ~/.alias || true

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.git,node_modules}"'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# byobu
export BYOBU_NO_TITLE=1

# libvirt
export LIBVIRT_DEFAULT_URI=qemu:///system

