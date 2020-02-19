# alias
test -s ~/.alias && . ~/.alias || true

# fzf
. /usr/share/bash-completion/completions/fzf
. /usr/share/bash-completion/completions/fzf-key-bindings
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.git,node_modules}"'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# byobu
export BYOBU_NO_TITLE=1
