#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

log() {
	echo "[INFO] $1"
}

configure_dock() {
	log "Configuring Dock..."
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock launchanim -bool false
	defaults write com.apple.dock mineffect -string "scale"
	defaults write com.apple.dock minimize-to-application -bool true
	defaults write com.apple.dock mru-spaces -bool false
	defaults write com.apple.dock persistent-apps -array
	defaults write com.apple.dock show-recents -bool false
	defaults write com.apple.dock tilesize -integer 32
	killall Dock || true
}

configure_trackpad() {
	log "Configuring Trackpad..."
	defaults write com.apple.AppleBluetoothMultitouchTrackpad Clicking -bool true
	defaults write com.apple.AppleBluetoothMultitouchTrackpad TrackpadRightClick -bool true
	defaults write com.apple.AppleBluetoothMultitouchTrackpad TrackpadThreeFingerDrag -bool true
}

configure_keyboard() {
	log "Configuring Keyboard..."
	defaults write NSGlobalDomain KeyRepeat -int 2
	defaults write NSGlobalDomain InitialKeyRepeat -int 15
}

configure_menu_bar() {
	log "Configuring Menu Bar..."
	defaults write com.apple.menuextra.battery ShowPercent -string "YES"
}

configure_finder() {
	log "Configuring Finder..."
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true
	defaults write com.apple.finder AppleShowAllFiles -bool true
	defaults write com.apple.finder ShowPathbar -bool true
	defaults write com.apple.finder ShowStatusBar -bool true
	defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	killall Finder || true
}

install_fonts() {
	local script_dir
	script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	local fonts_dir="${script_dir}/fonts"

	if [[ -d "${fonts_dir}" ]] && compgen -G "${fonts_dir}/*.otf" >/dev/null; then
		log "Installing fonts..."
		cp "${fonts_dir}"/*.otf ~/Library/Fonts/
	else
		log "No fonts to install"
	fi
}

main() {
	log "Configuring macOS defaults..."

	configure_dock
	configure_trackpad
	configure_keyboard
	configure_menu_bar
	configure_finder
	install_fonts

	log "macOS configuration complete!"
	log "Note: Some changes may require a logout/restart to take effect"
}

main "$@"
