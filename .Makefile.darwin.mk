ifneq ("$(OS_NAME)","darwin")
$(error This Makefile is supposed to be included on darwin systems only)
endif

FIREFOX_PROFILES_LOCATION=$$HOME/Library/Application\ Support/Firefox/Profiles/


.auto-install-darwin: .Brewfile | check-time-last-installed
	@export HOMEBREW_CASK_OPTS="--no-quarantine"
	@printf "\e[1;34m[Home Makefile]\e[0m Brew bundle install...\n"
	@brew bundle install -v --cleanup --force --file=.Brewfile
	@touch .auto-install-darwin


config-darwin: config-darwin-coteditor
	# Set key-repeat to "quite fast"
	defaults write NSGlobalDomain InitialKeyRepeat -int 2

	# Native window drag and drop with Ctrl+Cmd
	defaults write -g NSWindowShouldDragOnGesture -bool true

	defaults write com.apple.screencapture location $(HOME)/Downloads; killall SystemUIServer 

	defaults write com.apple.Dock autohide-delay -float 0.0001
	defaults write com.apple.dock autohide-time-modifier -float 0.25
	killall Dock

	defaults write com.sempliva.Tiles MenuBarIconEnabled 0
	defaults write org.dmarcotte.Easy-Move-Resize ModifierFlags SHIFT,CMD
	defaults write org.vim.MacVim MMTitlebarAppearsTransparent 1
	defaults write com.TorusKnot.SourceTreeNotMAS windowRestorationMethod 1
	defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2/"
	defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool YES


.PHONY: config-darwin-coteditor
config-darwin-coteditor:
	defaults write com.coteditor.CotEditor showNavigationBar 0
	defaults write com.coteditor.CotEditor lineHeight 1.1
	defaults write com.coteditor.CotEditor fontName SauceCodePowerline-Regular
	defaults write com.coteditor.CotEditor fontSize 13
	defaults write com.coteditor.CotEditor highlightCurrentLine 1
	defaults write com.coteditor.CotEditor enablesAutosaveInPlace 0
	defaults write com.coteditor.CotEditor documentConflictOption 1
	@ln -vfs /Applications/CotEditor.app/Contents/SharedSupport/bin/cot /usr/local/bin/cot


wallpaper-darwin:
	@osascript -e 'tell application "System Events" to tell every desktop to set picture to ((path to home folder as text) & ".esoc0932a.jpg")'


########################################################################


hyper-key: ## Map CAPSLOCK to F18 (Hyper)
# https://www.naseer.dev/post/hidutil/
	@hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000006D}]}'


lockscreen: ## Set a lost and found message and contact info on the lockscreen
	@sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "If you found this device, please contact $$(osascript -e 'tell application "Contacts" to get value of email 1 of my card') / $$(osascript -e 'tell application "Contacts" to get value of phone 1 of my card')"
	@tccutil reset AddressBook


xcode: ## Repair Xcode installation
	@sudo rm -rf /Library/Developer/CommandLineTools
	@sudo xcode-select --install


reset-privacy-permissions: ## Resets privacy settings
	@tccutil reset Accessibility
	@tccutil reset AddressBook
	@tccutil reset AppleEvents
	@tccutil reset Calendar
	@killall SystemUIServer
	@killall Finder
	@killall Dock


# https://github.com/Homebrew/brew/issues/4388#issuecomment-401364773
.PHONY: fix-brew
fix-brew: ## Fixes brew warnings, https://github.com/Homebrew/brew/issues/4388#issuecomment-401364773
	@brew cleanup 2>&1 | grep "Warning: Skipping" | awk -F: '{print $$2}' | awk '{print $$2}' | xargs brew upgrade
	@brew cleanup


.PHONY: disable-timemachine-throttling-temporarily
disable-timemachine-throttling-temporarily:
	@sudo sysctl debug.lowpri_throttle_enabled=0


.PHONY: empty-dock
empty-dock:
	@defaults write com.apple.dock persistent-apps -array
	@killall Dock
