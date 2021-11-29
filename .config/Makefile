SHELL   := bash
.SHELLFLAGS := -eu -o pipefail -c  
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

OS_NAME := $(shell uname -s | tr A-Z a-z)
DOTFILES_REPO := https://github.com/heussd/dotfiles.git
DOTFILES_BARE := $(HOME)/.dotfiles-bare-repo/


FONT  := Source Code Pro
SIZE  := 13
CSS	  := Timm's Way to View Things


all: vscode $(OS_NAME) $(HOME)/.ssh/id_rsa.pub


onboard: ## Onboards the dotfiles repository on this machine
	@echo -e "\033[0;34m[Home Makefile]\033[0m Onboarding $(DOTFILES_REPO)..."

	@git clone --bare $(DOTFILES_REPO) $(DOTFILES_BARE)/
	@git --git-dir=$(DOTFILES_BARE) config --local status.showUntrackedFiles no
	@git --git-dir=$(DOTFILES_BARE) config --local core.sparseCheckout true
# 	# Include everything
	@echo "/*" > $(DOTFILES_BARE)/info/sparse-checkout
#	# Exclude readme
	@echo "!Readme.md" >> $(DOTFILES_BARE)/info/sparse-checkout
#	# Ignore Library folder on Linux
ifeq ("$(OS_NAME)","linux")
	@echo "!Library" >> $(DOTFILES_BARE)/info/sparse-checkout
endif	
	@cd $(HOME)/
#	# recursive-submodules is limited to git >= 2.13
#	# We are doing it the old way here to increase compatibility
#	# @git --git-dir=$(DOTFILES_BARE) --work-tree=$(DOTFILES_WORK_DIR)/ checkout -f --recurse-submodules
	@git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ checkout -f
	@git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ submodule update --init --recursive
#	# Manual pull to create FETCH_HEAD
	@git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ pull
	@touch "$(DOTFILES_BARE)/FETCH_HEAD"

	@echo -e "\033[0;34m[Home Makefile]\033[0m Onboarding complete!"


linux:
	@:

darwin: macdown coteditor sourcetree macvim tiles easy-move-resize
	defaults write -g NSWindowShouldDragOnGesture -bool true
	defaults write com.apple.screencapture location $(HOME)/Downloads
	killall SystemUIServer 
	defaults write com.apple.Dock autohide-delay -float 0.0001
	defaults write com.apple.dock autohide-time-modifier -float 0.25
	killall Dock
	defaults write NSGlobalDomain _HIHideMenuBar -bool true
	killall Finder
	defaults write NSGlobalDomain InitialKeyRepeat -int 12
	defaults write NSGlobalDomain KeyRepeat -int 4
	
	sudo tmutil addexclusion -p /Applications
	sudo tmutil addexclusion -p ~/data
	sudo tmutil addexclusion -p ~/Downloads
	sudo tmutil addexclusion -p "~/Library/Application Support/Steam"
		
	open "Apple Settings.mobileconfig"
	open -b com.apple.systempreferences /System/Library/PreferencePanes/Profiles.prefPane

	# Required to apply keyboard settings
	osascript -e 'tell application "System Events" to log out'


$(HOME)/.ssh/id_rsa.pub:
	ssh-keygen -f $(HOME)/.ssh/id_rsa -P "" -v


vscode:
	@code --install-extension coenraads.bracket-pair-colorizer-2
	@code --install-extension dakara.transformer
	@code --install-extension esbenp.prettier-vscode
	@code --install-extension formulahendry.auto-close-tag
	@code --install-extension formulahendry.auto-rename-tag
	@code --install-extension streetsidesoftware.code-spell-checker
	@code --install-extension ms-azuretools.vscode-docker
	@code --install-extension vomout.latex-syntax
	@code --install-extension redhat.vscode-xml
	@code --install-extension dotjoshjohnson.xml
	@code --install-extension deltaxml.xslt-xpath
	

define openApp
	@echo "We'll open $(1) to create initial config file, then kill it again."
	@open -a $(1)
	@sleep 3
	@killall $(1)
endef


macdown:
	$(call openApp,MacDown)
	defaults write com.uranusjr.macdown editorBaseFontInfo -dict-add name "$(FONT)"
	defaults write com.uranusjr.macdown editorBaseFontInfo -dict-add size "$(SIZE)"
	defaults write com.uranusjr.macdown htmlStyleName "$(CSS)"


coteditor:
	$(call openApp,CotEditor)
	defaults write com.coteditor.CotEditor showNavigationBar 0
	defaults write com.coteditor.CotEditor lineHeight 1.1
	defaults write com.coteditor.CotEditor fontName SauceCodePowerline-Regular
	defaults write com.coteditor.CotEditor fontSize 13
	defaults write com.coteditor.CotEditor highlightCurrentLine 1
	defaults write com.coteditor.CotEditor enablesAutosaveInPlace 0
	defaults write com.coteditor.CotEditor documentConflictOption 1
	@ln -vfs /Applications/CotEditor.app/Contents/SharedSupport/bin/cot /usr/local/bin/cot


sourcetree:
	$(call openApp,Sourcetree)
	defaults write com.TorusKnot.SourceTreeNotMAS allowForcePush 1
	defaults write com.TorusKnot.SourceTreeNotMAS createBookmarksOnOpenRepo 0
	defaults write com.TorusKnot.SourceTreeNotMAS bookmarksClosedOnStartup 1
	defaults write com.TorusKnot.SourceTreeNotMAS windowRestorationMethod 1
	defaults write com.TorusKnot.SourceTreeNotMAS DidShowGettingStarted 1
	defaults write com.TorusKnot.SourceTreeNotMAS AtlassianAccountEmail "me@my.atlassian.com"


macvim: /Applications/MacVim.app
	$(call openApp,MacVim)
	defaults write org.vim.MacVim MMTitlebarAppearsTransparent 1


iterm:
	$(call openApp,iTerm2)
	defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2/"
	defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool YES


tiles:
	defaults write com.sempliva.Tiles MenuBarIconEnabled 0
	defaults write com.sempliva.Tiles LaunchAtLoginEnabled 0
	defaults write com.sempliva.Tiles DidAskUserForLoginItem 1


easy-move-resize:
	defaults write org.dmarcotte.Easy-Move-Resize ModifierFlags SHIFT,CMD