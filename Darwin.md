# macOS tweaks

	# Partly taken from https://gist.github.com/saetia/1623487

## System

### Check for software updates daily, not just once per week
	defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1


## Finder


### Text selection in QuickView
	defaults write com.apple.finder QLEnableTextSelection -bool TRUE


### Set default Finder location to home folder (~/)
	defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

### Expand save panel by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

### Disable ext change warning
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false


### Use current directory as default search scope in Finder
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

### Show Path bar in Finder
	defaults write com.apple.finder ShowPathbar -bool true

### Show Status bar in Finder
	defaults write com.apple.finder ShowStatusBar -bool true
	
### Show absolute path in Finder's title bar
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES


# Restart
	killall Finder
	killall Dock



# Brew stuff

	brew bundle -v 
