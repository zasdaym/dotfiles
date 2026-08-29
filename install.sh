#!/usr/bin/env bash

set -eou pipefail

require_command_line_tools() {
  if xcode-select --print-path >/dev/null 2>&1; then
    return
  fi

  printf 'Apple Command Line Tools are required.\n' >&2
  printf 'Install them with: xcode-select --install\n' >&2
  return 1
}

install_mise() {
  local install_path="$1"

  curl --fail --show-error --silent --location https://mise.run |
    MISE_INSTALL_PATH="${install_path}" sh
}

main() {
  local mise_env
  local mise_bin="${HOME}/.local/bin/mise"
  local os

  os="$(uname -s)"
  case "${os}" in
  Darwin)
    mise_env="macos"
    require_command_line_tools
    ;;
  Linux)
    mise_env="linux"
    ;;
  *)
    printf 'This installer does not support %s.\n' "${os}" >&2
    return 1
    ;;
  esac

  if command -v mise >/dev/null 2>&1; then
    mise_bin="$(command -v mise)"
  else
    install_mise "${mise_bin}"
  fi

  if [[ ! -x "${mise_bin}" ]]; then
    printf 'Mise executable not found at %s.\n' "${mise_bin}" >&2
    return 1
  fi

  if ! command -v git >/dev/null 2>&1; then
    printf 'Git is required. Install Git and run this installer again.\n' >&2
    return 1
  fi

  [[ -d "${HOME}/.dotfiles" ]] ||
    git clone https://github.com/zasdaym/dotfiles.git "${HOME}/.dotfiles"

  cd "${HOME}/.dotfiles"
  "${mise_bin}" -E "${mise_env}" bootstrap --yes
}

main
