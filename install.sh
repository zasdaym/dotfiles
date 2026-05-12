#!/usr/bin/env bash

set -eou pipefail

main() {
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply zasdaym
}

main
