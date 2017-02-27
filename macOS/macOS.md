
## Dock Hiding Animation Speed 
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock autohide-time-modifier -float 0
	defaults write com.apple.dock autohide-delay -float 0

## Lower delay between moving windows from space to space
	defaults write com.apple.dock workspaces-edge-delay -float 0.1

## Text selection in QuickView
	defaults write com.apple.finder QLEnableTextSelection -bool TRUE


# https://gist.github.com/saetia/1623487

## Faster key repeat settings
	defaults write NSGlobalDomain InitialKeyRepeat -int 10
	defaults write NSGlobalDomain KeyRepeat -int 0

## No .DS_Store files on network volumes
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

## Set default Finder location to home folder (~/)
	defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

## Expand save panel by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

## Disable ext change warning
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

## Check for software updates daily, not just once per week
	defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

## Use current directory as default search scope in Finder
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

## Show Path bar in Finder
	defaults write com.apple.finder ShowPathbar -bool true

## Show Status bar in Finder
	defaults write com.apple.finder ShowStatusBar -bool true
	
## Show absolute path in Finder's title bar
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES



# Aggressive Speed up settings

## opening and closing windows and popovers
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

## smooth scrolling
defaults write -g NSScrollAnimationEnabled -bool false

## showing and hiding sheets, resizing preference windows, zooming windows
# float 0 doesn't work
defaults write -g NSWindowResizeTime -float 0.001

## opening and closing Quick Look windows
defaults write -g QLPanelAnimationDuration -float 0

## scrolling column views
defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0

## showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0

## showing and hiding Mission Control, command+numbers
defaults write com.apple.dock expose-animation-duration -float 0.001

## showing and hiding Launchpad
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0



# Restart
	killall Finder
	killall Dock
