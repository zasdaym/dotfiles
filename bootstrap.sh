#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

# Check required programs
programs=("curl" "git" "openssl")
for program in "${programs[@]}"; do
	if [[ ! -x $(command -v "${program}") ]]; then
		echo "Please install ${program} first"
		exit 1
	fi
done

# Create required directories
mkdir -p "${HOME}/.aws"
mkdir -p "${HOME}/.config/alacritty"
mkdir -p "${HOME}/.config/fish"
mkdir -p "${HOME}/.config/git"
mkdir -p "${HOME}/.config/nvim"
mkdir -p "${HOME}/.config/wezterm"
mkdir -p "${HOME}/.kube"
mkdir -p "${HOME}/.ssh"

# Symlink config files
ln -fns "${PWD}/alacritty/alacritty.yml" "${HOME}/.config/alacritty/alacritty.yml"
ln -fns "${PWD}/fish/config.fish" "${HOME}/.config/fish/config.fish"
ln -fns "${PWD}/fish/fish_plugins" "${HOME}/.config/fish/fish_plugins"
ln -fns "${PWD}/git/config" "${HOME}/.config/git/config"
ln -fns "${PWD}/nvim/init.lua" "${HOME}/.config/nvim/init.lua"
ln -fns "${PWD}/ssh/config" "${HOME}/.ssh/config"
ln -fns "${PWD}/starship/starship.toml" "${HOME}/.config/starship.toml"
ln -fns "${PWD}/wezterm/wezterm.lua" "${HOME}/.config/wezterm/wezterm.lua"

# Dummy file to hide additional prompt
touch "${HOME}/.null"
sudo chmod 600 "${HOME}/.null"

# SSH private key
if [[ ! -f "${HOME}/.ssh/id_ed25519" ]]; then
	openssl enc -d -aes-256-cfb8 -pbkdf2 -iter 650000 -in ssh/id_ed25519.enc -out "${HOME}/.ssh/id_ed25519"
	ssh-keygen -y -f "${HOME}/.ssh/id_ed25519" >"${HOME}/.ssh/id_ed25519.pub"
	sudo chmod -R 700 "${HOME}/.ssh"
fi

# Run macOS-specific script
if [[ "$(uname -s)" == "Darwin" ]]; then
	./darwin.sh
fi

# Install Homebrew if not installed
if [[ ! -f "/opt/homebrew/bin/brew" ]]; then
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"
	brew bundle
fi

# Make sure fish added to /etc/shells
if [[ ! $(grep -Fxq "/opt/homebrew/bin/fish" /etc/shells) ]]; then
	echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
fi
