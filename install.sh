#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

readonly REPO_URL="https://github.com/zasdaym/dotfiles.git"
readonly SCRIPT_PATH="${BASH_SOURCE[0]}"
readonly SCRIPT_DIR="$(cd "$(dirname "${SCRIPT_PATH}")" && pwd)"

print_error() {
	echo "$*" >&2
}

find_command() {
	command -v "$1" || true
}

check_dependencies() {
	for program in bash curl git; do
		if [[ -z "$(find_command "${program}")" ]]; then
			print_error "Please install ${program} first"
			exit 1
		fi
	done
}

is_repo_checkout() {
	[[ -f "${SCRIPT_DIR}/scripts/install-local.sh" ]] && git -C "${SCRIPT_DIR}" rev-parse --show-toplevel >/dev/null 2>&1
}

determine_target_dir() {
	if is_repo_checkout; then
		printf '%s\n' "${SCRIPT_DIR}"
		return
	fi

	printf '%s\n' "${PWD}/dotfiles"
}

clone_repo() {
	local target_dir="$1"

	if [[ "${target_dir}" == "${SCRIPT_DIR}" ]] && is_repo_checkout; then
		echo "Using existing checkout at ${target_dir}"
		return
	fi

	if [[ -e "${target_dir}" ]]; then
		print_error "${target_dir} already exists. Remove it or run the installer from inside that repo."
		exit 1
	fi

	echo "Cloning dotfiles into ${target_dir}"
	git clone "${REPO_URL}" "${target_dir}"
}

run_local_installer() {
	local target_dir="$1"

	echo "Running local installer"
	bash "${target_dir}/scripts/install-local.sh"
}

main() {
	local target_dir

	check_dependencies
	target_dir="$(determine_target_dir)"
	clone_repo "${target_dir}"
	run_local_installer "${target_dir}"
}

main "$@"
