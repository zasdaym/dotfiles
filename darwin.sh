#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
readonly FONTS_DIR="${SCRIPT_DIR}/fonts"

log() {
	printf '[INFO] %s\n' "$1"
}

set_default() {
	defaults write "$@"
}

restart_app() {
	killall "$1" >/dev/null 2>&1 || true
}

configure_dock() {
	log "Configuring Dock..."
	set_default com.apple.dock autohide -bool true
	set_default com.apple.dock launchanim -bool false
	set_default com.apple.dock mineffect -string "scale"
	set_default com.apple.dock minimize-to-application -bool true
	set_default com.apple.dock mru-spaces -bool false
	set_default com.apple.dock persistent-apps -array
	set_default com.apple.dock show-recents -bool false
	set_default com.apple.dock tilesize -integer 32
	restart_app Dock
}

configure_trackpad() {
	log "Configuring Trackpad..."
	set_default com.apple.AppleBluetoothMultitouchTrackpad Clicking -bool true
	set_default com.apple.AppleBluetoothMultitouchTrackpad TrackpadRightClick -bool true
	set_default com.apple.AppleBluetoothMultitouchTrackpad TrackpadThreeFingerDrag -bool true
}

configure_keyboard() {
	log "Configuring Keyboard..."
	set_default NSGlobalDomain KeyRepeat -int 2
	set_default NSGlobalDomain InitialKeyRepeat -int 15
}

configure_menu_bar() {
	log "Configuring Menu Bar..."
	set_default com.apple.menuextra.battery ShowPercent -string "YES"
}

configure_finder() {
	log "Configuring Finder..."
	set_default NSGlobalDomain AppleShowAllExtensions -bool true
	set_default com.apple.finder AppleShowAllFiles -bool true
	set_default com.apple.finder ShowPathbar -bool true
	set_default com.apple.finder ShowStatusBar -bool true
	set_default com.apple.finder FXPreferredViewStyle -string "Nlsv"
	set_default com.apple.finder FXDefaultSearchScope -string "SCcf"
	set_default com.apple.finder FXEnableExtensionChangeWarning -bool false
	restart_app Finder
}

install_fonts() {
	local font_files=("${FONTS_DIR}"/*.otf)

	if [[ ! -e "${font_files[0]}" ]]; then
		log "No fonts to install"
		return
	fi

	log "Installing fonts..."
	cp "${font_files[@]}" "${HOME}/Library/Fonts/"
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
