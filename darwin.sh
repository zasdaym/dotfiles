#!/usr/bin/env bash

set -o errexit

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -integer 32
killall Dock

# Trackpad
defaults write com.apple.AppleBluetoothMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleBluetoothMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.AppleBluetoothMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Fast keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Show battery percentage in menu bar

# Remove Spotlight in menu bar

# Copy fonts
cp fonts/*.ttf ~/Library/Fonts/
