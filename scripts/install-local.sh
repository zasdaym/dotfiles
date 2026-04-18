#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
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

load_brew_shellenv() {
	local brew_bin

	brew_bin="$(command -v brew 2>/dev/null || true)"
	if [[ -n "${brew_bin}" && -x "${brew_bin}" ]]; then
		eval "$("${brew_bin}" shellenv)"
		return 0
	fi

	for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
		if [[ -x "${brew_bin}" ]]; then
			eval "$("${brew_bin}" shellenv)"
			return 0
		fi
	done

	return 1
}

print_error() {
	echo "$*" >&2
}

check_dependencies() {
	for program in curl git; do
		if [[ -z "$(find_command "${program}")" ]]; then
			print_error "Please install ${program} first"
			exit 1
		fi
	done
	echo "All dependencies are installed"
}

setup_null_file() {
	install -m 600 /dev/null "${HOME}/.null"
	echo "Created secure ~/.null file"
}

install_homebrew() {
	if load_brew_shellenv; then
		echo "Homebrew already installed"
		return
	fi

	echo "Installing Homebrew"
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	if ! load_brew_shellenv; then
		print_error "Homebrew installed but the brew executable was not found."
		print_error "Expected a standard install under /opt/homebrew, /usr/local, or Linuxbrew; add brew to PATH and retry."
		exit 1
	fi

	echo "Homebrew installation finished"
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
	if [[ -n "$(find_command stow)" ]]; then
		echo "Stow already installed"
		return
	fi

	if ! load_brew_shellenv; then
		print_error "Homebrew is required to install stow but brew could not be loaded"
		exit 1
	fi

	brew install stow
}

symlink_dotfiles() {
	if [[ -z "$(find_command stow)" ]]; then
		print_error "Please make sure stow is installed"
		exit 1
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
		print_error "Missing or non-executable ${darwin_script}"
		exit 1
	fi

	"${darwin_script}"
}

main() {
	echo "Starting dotfiles installation on ${OS}"

	check_dependencies
	setup_null_file
	install_homebrew
	install_mise
	install_stow
	symlink_dotfiles
	run_darwin_setup

	echo "Bootstrap completed, run these commands to finish:"
	echo "mise install"
	echo "brew bundle --file=\"${SCRIPT_DIR}/Brewfile\""
}

main "$@"
