#!/usr/bin/env bash

set -eou pipefail

install_xcode_tools() {
  if xcode-select --print-path >/dev/null 2>&1; then
    return
  fi

  xcode-select --install

  if ! { exec 3<>/dev/tty; } 2>/dev/null; then
    printf 'Cannot wait for input because no terminal is available.\n' >&2
    return 1
  fi

  printf 'Complete the Command Line Tools installation, then press Enter.\n' >&3

  while true; do
    if ! IFS= read -r <&3; then
      exec 3>&-
      printf 'Could not read input from the terminal.\n' >&2
      return 1
    fi

    if xcode-select --print-path >/dev/null 2>&1; then
      exec 3>&-
      return
    fi

    printf 'Command Line Tools installation is not complete. Press Enter to check again.\n' >&3
  done
}

main() {
  local mise_bin="${HOME}/.local/bin/mise"

  if [[ "$(uname -s)" != "Darwin" ]]; then
    printf 'This installer supports macOS only.\n' >&2
    return 1
  fi

  install_xcode_tools

  if command -v mise >/dev/null 2>&1; then
    mise_bin="$(command -v mise)"
  else
    curl --fail --show-error --silent --location --proto '=https' --tlsv1.2 \
      https://mise.run | sh
  fi

  if [[ ! -x "${mise_bin}" ]]; then
    printf 'Mise executable not found at %s.\n' "${mise_bin}" >&2
    return 1
  fi

  [ -d "${HOME}/.dotfiles" ] ||
    git clone https://github.com/zasdaym/dotfiles.git "${HOME}/.dotfiles"

  cd "${HOME}/.dotfiles"
  "${mise_bin}" bootstrap --yes
}

main
