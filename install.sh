#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

trap 'echo "Error: Script failed on line $LINENO" >&2' ERR

log() {
	echo "[INFO] $1"
}

error() {
	echo "[ERROR] $1" >&2
}

check_dependencies() {
	local programs=("curl" "git" "openssl")
	for program in "${programs[@]}"; do
		if [[ ! -x $(command -v "${program}") ]]; then
			error "Please install ${program} first"
			exit 1
		fi
	done
	log "All dependencies are installed"
}

install_homebrew() {
	if [[ ! -f "/opt/homebrew/bin/brew" ]]; then
		log "Installing Homebrew..."
		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	else
		log "Homebrew already installed"
	fi
	eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_brewfile() {
	if [[ -f "Brewfile" ]]; then
		log "Installing packages from Brewfile..."
		brew bundle install
	else
		log "No Brewfile found, skipping"
	fi
}

setup_null_file() {
	touch "${HOME}/.null"
	sudo chmod 600 "${HOME}/.null"
	log "Created secure ~/.null file"
}

symlink_dotfiles() {
	if command -v stow &>/dev/null; then
		log "Symlinking dotfiles with stow..."
		stow .
	else
		log "stow not found, skipping dotfiles symlink"
	fi
}

main() {
	log "Starting dotfiles installation..."

	check_dependencies
	setup_null_file

	if [[ "$(uname -s)" == "Darwin" ]]; then
		install_homebrew
		install_brewfile
		./darwin.sh
	else
		error "This script only supports macOS"
		exit 1
	fi

	symlink_dotfiles

	log "Installation complete!"
}

main "$@"
