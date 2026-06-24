#!/usr/bin/env bash

set -eou pipefail

main() {
  command -v brew >/dev/null 2>&1 ||
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  command -v mise >/dev/null 2>&1 || curl https://mise.run | sh

  [ -d "${HOME}/.dotfiles" ] ||
    git clone https://github.com/zasdaym/dotfiles.git "${HOME}/.dotfiles"

  cd "${HOME}/.dotfiles"
  "$(command -v mise || echo "${HOME}/.local/bin/mise")" bootstrap --yes
}

main
