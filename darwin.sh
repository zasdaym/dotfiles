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

echo "Enable four fingers swipe"
echo "Enable two fingers secondary click"
echo "Enable three finger drag (Accessibility)"
echo "Show battery percentage in menu bar"
echo "Set max keyboard repeat rate"
echo "Set minimal initial keyboard repeat delay"

# Copy fonts
cp fonts/*.ttf ~/Library/Fonts/
