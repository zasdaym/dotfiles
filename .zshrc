# path
export PATH=${HOME}/go/bin:${PATH}

# oh-my-zsh
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(ansible asdf aws docker fzf git golang kubectl minikube terraform vagrant vault)
source $ZSH/oh-my-zsh.sh

# aliases
alias vim="nvim"

# exported variables
export EDITOR="nvim"
export FZF_DEFAULT_OPTS="--no-color"
