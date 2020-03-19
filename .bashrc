# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# prompt
PS1='[\u@\h \W]\$ '

# alias
alias ls='ls --color=auto'
alias vim='nvim'

# editor
EDITOR=nvim
export EDITOR

# user bin
PATH=${HOME}/.local/bin:${PATH}

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.git,node_modules}"'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'
