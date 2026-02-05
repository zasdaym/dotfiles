export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"
export GIT_EXTERNAL_DIFF="difft"

# History configuration
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Shell options
setopt AUTO_CD
setopt CORRECT
setopt NO_BEEP

# Lazy-load compinit (only rebuild once per day)
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
	compinit
else
	compinit -C
fi

if command -v mise &>/dev/null; then
	eval "$(mise activate zsh)"
	eval "$(mise completion zsh)"
fi

if command -v starship &>/dev/null; then
	eval "$(starship init zsh)"
fi
