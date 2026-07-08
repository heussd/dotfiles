all: \
	finder \
	dock \
	screenshots \
	terminal
	@-


dock:
	#defaults write com.apple.Dock autohide -bool true
	#defaults write com.apple.Dock autohide-delay -float 0.0001
	#defaults write com.apple.dock autohide-time-modifier -float 0.25
	#defaults write com.apple.dock magnification -bool false
	#defaults write com.apple.dock tilesize -int 42
	#defaults write com.apple.dock largesize -float 128
	#defaults write com.apple.Dock size-immutable -bool true
	#defaults write com.apple.Dock contents-immutable -bool true
	#defaults write com.apple.dock show-recents -bool true
	#defaults write com.apple.dock show-recent-count -int 3
	
	defaults write com.apple.dock persistent-apps -array
	@while read -r package; do \
		app="$${package/#\~/$$HOME}"; \
		[[ -d "$$app.app" ]] && echo "$$app.app" && defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$$app.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" || true; \
	done < dock.txt
	killall Dock


hotcorners:
	defaults write com.apple.dock wvous-bl-corner -int 2 # Mission Control
	defaults write com.apple.dock wvous-br-corner -int 4 # Show Desktop
	killall Dock


screenshots:
	defaults write com.apple.screencapture location "$$HOME/Downloads"


terminal:
	@open $(HOME)/.config/macos/Timm.terminal
	
	# Profile must have been opened before
	defaults write com.apple.Terminal "Default Window Settings" "Timm"
	defaults write com.apple.Terminal "Startup Window Settings" "Timm"
	
	# Do not restore previous sessions
	defaults write com.apple.Terminal NSQuitAlwaysKeepsWindows -bool false
	defaults write com.apple.TextEdit RichText -int 0


finder:
	defaults write -g AppleShowAllExtensions -bool true
	defaults write com.apple.finder AppleShowAllFiles false
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
	defaults write com.apple.finder ShowPathbar -bool true
	killall Finder


touchid-sudo: # https://apple.stackexchange.com/questions/259093/can-touch-id-on-mac-authenticate-sudo-in-terminal
	sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local


filetypes:
	#openwith com.colliderli.iina mkv mov mp4 avi webm m3u mp3
	#openwith org.libreoffice.script csv xls xlsx
	#openwith com.aone.keka 7z zip zipx rar tar gzip bzip2 xz lzip brotli zstd lrzip lzma cab wim msi pax
	duti -s com.microsoft.VSCode xml
	duti -s com.microsoft.VSCode yml
	duti -s com.microsoft.VSCode yaml
	duti -s com.microsoft.VSCode Dockerfile
	duti -s com.microsoft.VSCode Makefile
	duti -s com.microsoft.VSCode java
	duti -s com.microsoft.VSCode kt
	duti -s com.microsoft.VSCode js
	duti -s com.microsoft.VSCode jsx
	duti -s com.microsoft.VSCode log
	duti -s com.microsoft.VSCode tex
	duti -s com.microsoft.VSCode txt
	duti -s com.microsoft.VSCode json
	duti -s com.microsoft.VSCode cls
	duti -s com.microsoft.VSCode sh
	duti -s com.microsoft.VSCode md
	duti -s com.microsoft.VSCode public.plain-text all
	duti -s com.microsoft.VSCode public.text all

sourcetree:
	defaults write com.TorusKnot.SourceTreeNotMAS bookmarksWindowOpen -int 0
	defaults write com.TorusKnot.SourceTreeNotMAS allowForcePush -int 1
	defaults write com.TorusKnot.SourceTreeNotMAS createBookmarksOnOpenRepo -int 0
	defaults write com.TorusKnot.SourceTreeNotMAS bookmarksClosedOnStartup -int 1
	defaults write com.TorusKnot.SourceTreeNotMAS windowRestorationMethod -int 1
	defaults write com.TorusKnot.SourceTreeNotMAS completedWelcomeWizardVersion 3
	defaults write com.TorusKnot.SourceTreeNotMAS loadGravatarImages -int 0
	defaults write com.TorusKnot.SourceTreeNotMAS agreedToUpdateConfig -int 0
	defaults write com.TorusKnot.SourceTreeNotMAS AtlassianAccountEmail "me@my.atlassian.com"



iina:
	defaults write com.colliderli.iina SUHasLaunchedBefore 1
	defaults write com.colliderli.iina actionAfterLaunch 2
	defaults write com.colliderli.iina quitWhenNoOpenedWindow 1
	defaults write com.colliderli.iina themeMaterial 4
	defaults write com.colliderli.iina recordPlaybackHistory 0
	defaults write com.colliderli.iina recordRecentFiles 0


coteditor:
	defaults write com.coteditor.CotEditor showNavigationBar 0
	defaults write com.coteditor.CotEditor lineHeight 1.1
	defaults write com.coteditor.CotEditor fontName SauceCodePowerline-Regular
	defaults write com.coteditor.CotEditor fontSize 13
	defaults write com.coteditor.CotEditor highlightCurrentLine 1
	defaults write com.coteditor.CotEditor enablesAutosaveInPlace 0
	defaults write com.coteditor.CotEditor documentConflictOption 1
#ln -vfs /Applications/CotEditor.app/Contents/SharedSupport/bin/cot /usr/local/bin/cot


sidebar:
	defaults write -g NSSplitViewItemSidebarDefaultsToFloatingAppearance -bool false
	defaults write -g NSConvolutionOverride1 -float 15
	killall Finder

keyboard:
	cp -rv *.bundle "$$HOME/Library/Keyboard Layouts"

