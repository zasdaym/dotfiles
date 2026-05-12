#!/usr/bin/env bash

set -eou pipefail

main() {
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply zasdaym
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  curl https://mise.run | sh
}

main
