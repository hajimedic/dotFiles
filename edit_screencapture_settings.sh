#! /bin/zsh

mkdir ~/Pictures/ScreenCaptures
defaults write com.apple.screencapture location ~/Pictures/ScreenCaptures
defaults write com.apple.screencapture name "SS"
killall SystemUIServer
