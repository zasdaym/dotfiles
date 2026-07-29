#!/usr/bin/env bash

set -eou pipefail

main() {
  xcode-select --print-path >/dev/null 2>&1 || xcode-select --install

  command -v mise >/dev/null 2>&1 || curl https://mise.run | sh

  [ -d "${HOME}/.dotfiles" ] ||
    git clone https://github.com/zasdaym/dotfiles.git "${HOME}/.dotfiles"

  cd "${HOME}/.dotfiles"
  "$(command -v mise || echo "${HOME}/.local/bin/mise")" bootstrap --yes
}

main
