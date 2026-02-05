#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

trap 'echo "Error: Script failed on line ${LINENO}: ${BASH_COMMAND}" >&2' ERR


log() {
	echo "[INFO] $1"
}

error() {
	echo "[ERROR] $1" >&2
}

check_dependencies() {
	local programs=("curl" "git" "openssl")
	for program in "${programs[@]}"; do
		if ! command -v "${program}" >/dev/null 2>&1; then
			error "Please install ${program} first"
			exit 1
		fi
	done
	log "All dependencies are installed"
}

install_homebrew() {
	local brew_path
	brew_path="$(command -v brew || true)"
	if [[ -z "${brew_path}" ]]; then
		log "Installing Homebrew..."
		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		brew_path="$(command -v brew || true)"
	else
		log "Homebrew already installed"
	fi

	if [[ -z "${brew_path}" ]]; then
		error "Homebrew installation failed or brew not found"
		exit 1
	fi

	eval "$("${brew_path}" shellenv)"
}

install_brewfile() {
	local brewfile_path="${PWD}/Brewfile"
	if [[ -f "${brewfile_path}" ]]; then
		log "Installing packages from Brewfile..."
		brew bundle install --file "${brewfile_path}"
	else
		log "No Brewfile found, skipping"
	fi
}

setup_null_file() {
	touch "${HOME}/.null"
	chmod 600 "${HOME}/.null"
	log "Created secure ~/.null file"
}

symlink_dotfiles() {
	if ! command -v stow >/dev/null 2>&1; then
		if command -v brew >/dev/null 2>&1; then
			log "Installing stow via Homebrew..."
			brew install stow
		else
			log "stow not found. Please install stow to symlink dotfiles."
			return
		fi
	fi

	log "Symlinking dotfiles with stow..."
	( cd "${PWD}" && stow --no-folding --target "${HOME}" .)
}

main() {
	log "Starting dotfiles installation..."

	check_dependencies
	setup_null_file
	install_homebrew
	install_brewfile

	if [[ "$(uname -s)" == "Darwin" ]]; then
		local darwin_script="${PWD}/darwin.sh"
		if [[ -x "${darwin_script}" ]]; then
			"${darwin_script}"
		else
			error "Missing or non-executable ${darwin_script}"
			exit 1
		fi
	else
		error "This script only supports macOS"
		exit 1
	fi

	symlink_dotfiles

	log "Installation complete!"
}

main "$@"
