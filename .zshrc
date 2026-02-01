export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"
export GIT_EXTERNAL_DIFF="difft"

autoload -Uz compinit
compinit

if command -v mise &>/dev/null; then
	eval "$(mise activate zsh)"
	eval "$(mise completion zsh)"
fi

if command -v starship &>/dev/null; then
	eval "$(starship init zsh)"
fi
