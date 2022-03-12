SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
MAKEFLAGS	+= -s
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)
DOTFILES_REPO 	 := https://github.com/heussd/dotfiles.git
DOTFILES_BARE 	 := $(HOME)/.dotfiles-bare-repo/


FONT	:= Source Code Pro
SIZE	:= 13
CSS	:= Timm's Way to View Things


auto-config: Makefile
	$(MAKE) $(OS_NAME)
	$(MAKE) vscode 
	$(MAKE) $(HOME)/.ssh/id_rsa.pub

	touch auto-config
	@-~/Library/startup.command

#ifneq ("$(wildcard Makefile.$(OS_NAME))","")
#"include Makefile.$(OS_NAME)
#endif


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


$(HOME)/.ssh/id_rsa.pub:
	ssh-keygen -f $(HOME)/.ssh/id_rsa -P "" -v


vscode:
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


transcrypt: ## Setup transcrypt for dotfiles
	@cd $(DOTFILES_BARE) && transcrypt -c aes-256-cbc -p '$(shell stty -echo; read -p "Password: " pwd; stty echo; echo $$pwd)'
.PHONY: transcrypt


wallpaper: .esoc0932a.jpg wallpaper-$(OS_NAME) ## Set up wallpaper
.PHONY: wallpaper wallpaper-linux wallpaper-darwin
.esoc0932a.jpg:
	@wget https://cdn.eso.org/images/large/eso0932a.jpg -O .esoc0932a.jpg
wallpaper-linux:
	@feh --bg-scale .esoc0932a.jpg
wallpaper-darwin:
	@osascript -e 'tell application "System Events" to tell every desktop to set picture to ((path to home folder as text) & ".esoc0932a.jpg")'


add-ssh-key-pass: $(HOME)/.ssh/id_rsa.pub ## Adds a passphrase to local ssh keys
	@ssh-keygen -p -f ~/.ssh/id_rsa
.PHONY: add-ssh-key-pass


.PHONY: git-over-ssh
git-over-ssh: ## Tells git to use SSH connections for GitHub / GitLab / BitBucket
	@ln -s $(HOME)/.git-over-ssh $(HOME)/.git-over-ssh-enabled


zsh-default: ## Set ZSH as default
	@chsh -s $(which zsh) $(whoami)
.PHONY: zsh-default




darwin: \
	prep-darwin \
	login-items \
	reset-firefox-permissions \
	maccy \
	coteditor \
	easy-move-resize \
	macdown \
	macvim \
	sourcetree \
	tiles \
	keka \
	dock \
	macos-lockscreen \
	macos-settings \


prep-darwin:
	@-killall "System Preferences" > /dev/null
	@echo "Requesting sudo password"
	@sudo echo

macos-settings:
	defaults write com.apple.universalaccess reduceMotion 1

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
	# Homebrew folders
	sudo tmutil addexclusion -p /usr/local/Caskroom
	sudo tmutil addexclusion -p /usr/local/Cellar
	sudo tmutil addexclusion -p /usr/local/Homebrew

	sudo tmutil addexclusion -p "~/Library/Application Support/Steam"
		
	open "Apple Settings.mobileconfig"
	open -b com.apple.systempreferences /System/Library/PreferencePanes/Profiles.prefPane

	# Required to apply keyboard settings
	#osascript -e 'tell application "System Events" to log out'



define openApp
	@echo "We'll open $(1) to create initial config file, then kill it again."
	@open --background -a $(1)
	@sleep 3
	@killall $(1)
endef


maccy:
	$(call openApp,Maccy)
	defaults write org.p0deje.Maccy showInStatusBar 0
	defaults write org.p0deje.Maccy avoidTakingFocus 1
	# Configure hotkey Command-Shift-V
	defaults write org.p0deje.Maccy KeyboardShortcuts_popup -string "{\"carbonModifiers\":768,\"carbonKeyCode\":9}"


macdown:
	$(call openApp,MacDown)
	defaults write com.uranusjr.macdown editorBaseFontInfo -dict-add name "$(FONT)"
	defaults write com.uranusjr.macdown editorBaseFontInfo -dict-add size "$(SIZE)"
	defaults write com.uranusjr.macdown htmlStyleName "$(CSS)"
	defaults write com.uranusjr.macdown htmlSyntaxHighlighting 1
	defaults write com.uranusjr.macdown htmlDetectFrontMatter 1


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

keka:
	defaults write com.aone.keka FinderAfterExtraction 1
	defaults write com.aone.keka FinderAfterCompression 1


easy-move-resize:
	defaults write org.dmarcotte.Easy-Move-Resize ModifierFlags SHIFT,CMD


define make_dock_app
	if [ -d "$(1).app" ]; then \
	defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$(1).app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"; fi
endef

dock:
	defaults write com.apple.dock persistent-apps -array
	$(call make_dock_app,/Applications/Firefox)
	$(call make_dock_app,/Applications/Safari)
	$(call make_dock_app,/Applications/Google Chrome)
	$(call make_dock_app,/Applications/Slack)
	$(call make_dock_app,/Applications/Microsoft Teams)
	$(call make_dock_app,/Applications/Clockify Desktop)
	$(call make_dock_app,/Applications/Microsoft Edge)
	$(call make_dock_app,/System/Applications/Mail)
	$(call make_dock_app,/Applications/Signal)
	$(call make_dock_app,/Applications/Discord)
	$(call make_dock_app,/System/Applications/Calendar)
	$(call make_dock_app,/System/Applications/Notes)
	$(call make_dock_app,/System/Applications/Reminders)
	$(call make_dock_app,/System/Applications/Photos)
	$(call make_dock_app,/System/Applications/Music)
	$(call make_dock_app,/Applications/KeePassXC)
	$(call make_dock_app,/Applications/Cryptomator)
	$(call make_dock_app,/Applications/kitty)
	defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}';
	$(call make_dock_app,/Applications/Keka)
	$(call make_dock_app,/Applications/VLC)
	$(call make_dock_app,/Applications/mpv)
	$(call make_dock_app,/Applications/MacVim)
	$(call make_dock_app,/Applications/CotEditor)
	$(call make_dock_app,/Applications/Visual Studio Code)
	$(call make_dock_app,/System/Applications/Preview)
	$(call make_dock_app,/Applications/Boop)
	defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}';
	$(call make_dock_app,/Applications/Meld)
	$(call make_dock_app,/Applications/Sourcetree)
	$(call make_dock_app,/Applications/Postman)
	$(call make_dock_app,/Applications/Camunda Modeler)
	$(call make_dock_app,$(HOME)/Applications/JetBrains Toolbox/IntelliJ IDEA Ultimate)
	$(call make_dock_app,$(HOME)/Applications/JetBrains Toolbox/PyCharm Professional)
	$(call make_dock_app,$(HOME)/Applications/JetBrains Toolbox/WebStorm)
	$(call make_dock_app,/Applications/MacDown)
	$(call make_dock_app,/Applications/LibreOffice)
	$(call make_dock_app,/Applications/Pages)
	$(call make_dock_app,/Applications/Numbers)
	$(call make_dock_app,/Applications/Microsoft Powerpoint)
	$(call make_dock_app,/Applications/Microsoft Excel)
	$(call make_dock_app,/Applications/Microsoft Word)
	$(call make_dock_app,/Applications/krita)
	$(call make_dock_app,/Applications/ColorSlurp)
	$(call make_dock_app,/Applications/Steam)
	$(call make_dock_app,/Applications/Epic Games Launcher)
	defaults write com.apple.Dock size-immutable -bool true
	defaults write com.apple.Dock contents-immutable -bool true
	killall Dock


.PHONY: macos-lockscreen
macos-lockscreen: ## Set a lost and found message and contact info on the lockscreen
	@sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "If you found this device, please contact $$(osascript -e 'tell application "Contacts" to get value of email 1 of my card') / $$(osascript -e 'tell application "Contacts" to get value of phone 1 of my card')"
	@tccutil reset AddressBook


reset-firefox-permissions:
	tccutil reset Microphone org.mozilla.firefox
	tccutil reset Camera org.mozilla.firefox
	

login-items:
	osascript -e 'tell application "System Events"' \
		-e 'repeat with i in (get the name of every login item)' \
		-e 'delete login item i' \
		-e 'end repeat' \
		-e 'end tell'
	sudo xattr -cr "$$HOME/Library/startup.command"
	osascript -e "tell application \"System Events\" to make login item at end with properties {path:  POSIX path of (path to home folder) & \"/Library/startup.command\", hidden:false}"


openwith:
	git clone https://github.com/jdek/openwith openwith-git
	cd openwith-git && make
	mv openwith-git/openwith .
	rm -Rfv openwith-git/

filetypes: openwith
	./openwith io.mpv mkv mov mp4 avi webm m3u
	./openwith com.coteditor.CotEditor txt
	./openwith org.libreoffice.script csv xls xlsx
	./openwith com.aone.keka 7z zip zipx rar tar gzip bzip2 xz lzip brotli zstd lrzip lzma cab wim msi pax 


linux:
	@:

.PHONY: linux-install-docker
linux-install-docker: ## Install Docker and docker-compose
	@curl -fsSL https://get.docker.com/ -o - | sh
	@sudo usermod -aG docker $(USER)
	@sudo apt-get install -y python3-pip python3-dev
	@sudo pip3 install docker-compose
	docker-compose --version

.PHONY: linux-install-veracrypt
linux-install-veracrypt: ## Install Veracrypt from a PPA
	sudo add-apt-repository ppa:unit193/encryption
	sudo apt update
	sudo apt-get install veracrypt 

.PHONY: linux-install-cryptomator
linux-install-cryptomator: ## Install Cryptomator from a PPA
	sudo add-apt-repository ppa:sebastian-stenzel/cryptomator
	sudo apt update
	sudo apt-get install cryptomator

.PHONY: linux-apt-no-sudo-passwd
linux-apt-no-sudo-passwd: ## Allow using apt without a sudo password
	echo "%sudo   ALL=(ALL:ALL) NOPASSWD:/usr/bin/apt" | sudo tee /etc/sudoers.d/010_apt-nopasswd

.PHONY: linux-disable-unattended-updates
linux-disable-unattended-updates: ## Disable unattended updates on Linux hosts
	sudo cp /usr/share/unattended-upgrades/20auto-upgrades-disabled /etc/apt/apt.conf.d/
