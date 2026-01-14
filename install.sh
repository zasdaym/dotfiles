#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

programs=("curl" "git" "openssl")
for program in "${programs[@]}"; do
	if [[ ! -x $(command -v "${program}") ]]; then
		echo "Please install ${program} first"
		exit 1
	fi
done

touch "${HOME}/.null"
sudo chmod 600 "${HOME}/.null"

if [[ "$(uname -s)" == "Darwin" ]]; then
	./darwin.sh
fi

if [[ ! -f "/opt/homebrew/bin/brew" ]]; then
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi
