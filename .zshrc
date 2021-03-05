# oh-my-zsh
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(ansible aws docker fzf git golang kubectl minikube vagrant vault)
source $ZSH/oh-my-zsh.sh

# aliases
alias vim="nvim"

# exported variables
export EDITOR="nvim"
export FZF_DEFAULT_OPTS="--no-color"
