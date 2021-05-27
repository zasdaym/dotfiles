# path
path=("${HOME}/go/bin" $path)

# brew
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# oh-my-zsh
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(ansible aws brew docker fzf gh git gcloud golang kubectl minikube terraform vagrant vault z zsh_reload)
source $ZSH/oh-my-zsh.sh

# aliases
alias vim="nvim"

# exported variables
export EDITOR="nvim"
export FZF_DEFAULT_OPTS="--no-color"

# prune path
typeset -U path
