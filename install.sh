#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR

OS="$(uname -s)"
readonly OS

is_macos() {
	[[ "${OS}" == "Darwin" ]]
}

is_linux() {
	[[ "${OS}" == "Linux" ]]
}

find_command() {
	command -v "$1" || true
}

check_dependencies() {
	local program
	for program in curl git openssl; do
		if [[ -z "$(find_command "${program}")" ]]; then
			echo "Please install ${program} first" >&2
			exit 1
		fi
	done
	echo "All dependencies are installed"
}

setup_null_file() {
	install -m 600 /dev/null "${HOME}/.null"
	echo "Created secure ~/.null file"
}

install_zerobrew() {
	if [[ -z "$(find_command zb)" ]]; then
		echo "Installing Zerobrew"
		curl -fsSL https://zerobrew.rs/install | bash -s -- --no-modify-path
	else
		echo "Zerobrew already installed"
	fi
}

install_mise() {
	if [[ -n "$(find_command mise)" ]]; then
		echo "Mise already installed"
		return
	fi

	echo "Installing mise"
	curl -fsSL https://mise.run | sh
}

install_stow() {
    $HOME/.bin/zb install stow
}

symlink_dotfiles() {
	if [[ -z "$(find_command stow)" ]]; then
		echo "Please make sure stow is installed"
		return
	fi

	echo "Symlinking dotfiles with stow"
	stow --dir "${SCRIPT_DIR}" --no-folding --target "${HOME}" .
}

run_darwin_setup() {
	if ! is_macos; then
		return
	fi

	local darwin_script="${SCRIPT_DIR}/darwin.sh"

	if [[ ! -x "${darwin_script}" ]]; then
		echo "Missing or non-executable ${darwin_script}" >&2
		exit 1
	fi

	"${darwin_script}"
}

main() {
	echo "Starting dotfiles installation on ${OS}"

	check_dependencies
	setup_null_file
	install_mise
	install_zerobrew
	install_stow
	symlink_dotfiles
	run_darwin_setup

	echo "Bootstrap completed, run these commands to finish:"
	echo "export PATH=$PATH:$HOME/.local/bin"
	echo "zb bundle"
	echo "mise install"
}

main "$@"
