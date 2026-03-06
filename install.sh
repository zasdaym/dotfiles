#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

trap 'echo "Error: Script failed on line ${LINENO}: ${BASH_COMMAND}" >&2' ERR

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR

log() {
	printf '[INFO] %s\n' "$1"
}

error() {
	printf '[ERROR] %s\n' "$1" >&2
}

find_brew() {
	local brew_path
	brew_path="$(command -v brew 2>/dev/null || true)"

	if [[ -n "${brew_path}" ]]; then
		printf '%s\n' "${brew_path}"
	elif [[ -x /opt/homebrew/bin/brew ]]; then
		printf '%s\n' /opt/homebrew/bin/brew
	elif [[ -x /usr/local/bin/brew ]]; then
		printf '%s\n' /usr/local/bin/brew
	fi
}

check_dependencies() {
	local program
	for program in curl git openssl; do
		if ! command -v "${program}" >/dev/null 2>&1; then
			error "Please install ${program} first"
			exit 1
		fi
	done
	log "All dependencies are installed"
}

install_homebrew() {
	local brew_path
	brew_path="$(find_brew)"
	if [[ -z "${brew_path}" ]]; then
		log "Installing Homebrew..."
		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		brew_path="$(find_brew)"
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
	local brewfile_path="${SCRIPT_DIR}/Brewfile"
	if [[ -f "${brewfile_path}" ]]; then
		log "Installing packages from Brewfile..."
		brew bundle install --file "${brewfile_path}"
	else
		log "No Brewfile found, skipping"
	fi
}

setup_null_file() {
	install -m 600 /dev/null "${HOME}/.null"
	log "Created secure ~/.null file"
}

ensure_stow() {
	if command -v stow >/dev/null 2>&1; then
		return
	fi

	if ! command -v brew >/dev/null 2>&1; then
		log "stow not found. Please install stow to symlink dotfiles."
		return 1
	fi

	log "Installing stow via Homebrew..."
	brew install stow
}

run_darwin_setup() {
	local darwin_script="${SCRIPT_DIR}/darwin.sh"

	if [[ "$(uname -s)" != "Darwin" ]]; then
		error "This script only supports macOS"
		exit 1
	fi

	if [[ ! -x "${darwin_script}" ]]; then
		error "Missing or non-executable ${darwin_script}"
		exit 1
	fi

	"${darwin_script}"
}

symlink_dotfiles() {
	if ! ensure_stow; then
		return
	fi

	log "Symlinking dotfiles with stow..."
	stow --dir "${SCRIPT_DIR}" --no-folding --target "${HOME}" .
}

main() {
	log "Starting dotfiles installation..."

	check_dependencies
	setup_null_file
	install_homebrew
	install_brewfile
	run_darwin_setup
	symlink_dotfiles

	log "Installation complete!"
}

main "$@"
