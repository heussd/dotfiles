SHELL   := bash
.SHELLFLAGS := -eu -o pipefail -c  
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

DOTFILES_REPO := https://github.com/heussd/dotfiles.git
DOTFILES_BARE := $(HOME)/.dotfiles-bare-repo/

HOST = $$(hostname | cut -d"." -f 1)
OS_NAME := $(shell uname -s | tr A-Z a-z)


default: auto-pull-dotfiles auto-install 
.PHONY: default



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


LAUNCH_CMD = bash -c
ifdef KITTY
override LAUNCH_CMD=kitty @ launch --keep-focus --copy-env --no-response --type=tab zsh -c
endif

define exec
	@printf "\e[1;34m[Home Makefile]\e[0m $(1)...\n"
	@$(LAUNCH_CMD) "$(2) || read"
endef

# Do things if $1 is too old
# $1 - File to check
# $2 - Message to print
# $3 - Commands to execute
define if-old
	@if [ -e $(1) ]; then find "$(1)" -mmin +$$((7*24*60)) \
		-exec bash -c 'echo -e "\033[0;34m[Home Makefile]\033[0m$(2)"; $(3); touch $(1)' \; ;\
	fi
endef

auto-pull-dotfiles: ## Pulls from dotfiles remote repository, if last pull is old enough
	$(call if-old,$(DOTFILES_BARE)/FETCH_HEAD, \
		Pulling dotfiles...,\
		git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ pull --recurse-submodules --quiet)
.PHONY: auto-pull-dotfiles

check-time-last-installed:
	$(call if-old,$(HOME)/.auto-install-$(OS_NAME),\
		Triggering auto install...,\
		rm -f "$(HOME)/.auto-install-$(OS_NAME); $(MAKE) auto-install")
.PHONY: check-time-last-installed


auto-install: .auto-install-$(OS_NAME) firefox-policies
.PHONY: auto-install

.auto-install-darwin: .Brewfile .pip-global-requirements.txt .docker-cli-images.yml | check-time-last-installed
	
	$(call exec,Brew bundle install,\
		export HOMEBREW_CASK_OPTS="--no-quarantine"; \
		brew bundle install -v --cleanup --force --file=.Brewfile)

	$(call exec,PIP install,\
		pip3 install -U -r .pip-global-requirements.txt)

	$(call exec,Pulling Docker CLI images,\
		docker-compose -f .docker-cli-images.yml pull)

	@touch .auto-install-darwin


.auto-install-linux: .apt-packages-base .pip-global-requirements.txt .docker-cli-images.yml | check-time-last-installed
#	# https://stackoverflow.com/questions/25391307/pipes-with-apt-package-manager#25391412
	$(call exec,APT install,\
		xargs -d '\n' -- sudo apt-get install -y < .apt-packages-base)

	$(call exec,PIP install,\
		pip3 install -U -r .pip-global-requirements.txt)

	$(call exec,Pulling Docker CLI images,\
		docker-compose -f .docker-cli-images.yml pull)

	@touch .auto-install-linux



FIREFOX_PROFILES_LOCATION=$$HOME/Library/Application\ Support/Firefox/Profiles/
ifneq ("$(OS_NAME)","linux")
FIREFOX_PROFILES_LOCATION=$$HOME/.mozilla/firefox/
endif

firefox: ## Symlinks Firefox user config files to all Firefox profiles
	@for profile in $(FIREFOX_PROFILES_LOCATION)/*/; do \
		echo "$$profile"; \
		ln -sFf $$HOME/.mozilla/firefox/user.js "$$profile"; \
		mkdir -p "$$profile/chrome"; \
		ln -sFf $$HOME/.mozilla/firefox/chrome/userChrome.css "$$profile/chrome/"; \
	done
.PHONY: firefox


firefox-policies: firefox-policies-$(OS_NAME) ## Install Firefox policies
	@:
firefox-policies-darwin: /Applications/Firefox.app/Contents/Resources/distribution/policies.json
firefox-policies-linux:  /etc/firefox/policies/policies.json

/Applications/Firefox.app/Contents/Resources/distribution/policies.json: $(HOME)/.mozilla/firefox/policies.json
	@printf "\e[1;34m[Home Makefile]\e[0m Installing Firefox policies to $@...\n"
	@mkdir -p /Applications/Firefox.app/Contents/Resources/distribution/
	@cp $$HOME/.mozilla/firefox/policies.json /Applications/Firefox.app/Contents/Resources/distribution/policies.json
/etc/firefox/policies/policies.json: $(HOME)/.mozilla/firefox/policies.json
	@printf "\e[1;34m[Home Makefile]\e[0m Installing Firefox policies to $@...\n"
	@sudo mkdir -p /etc/firefox/policies/
	@sudo cp $$HOME/.mozilla/firefox/policies.json /etc/firefox/policies/policies.json

.PHONY: firefox-policies firefox-policies-darwin firefox-policies-linux



config: config-$(OS_NAME) $(HOME)/.ssh/id_rsa.pub firefox ## Configures user account and applications

.PHONY: config config-darwin config-darwin-apps config-linux
config-darwin: config-darwin-apps
	# Native window drag and drop with Ctrl+Cmd
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
		
	open .apple-os-settings.mobileconfig
	open -b com.apple.systempreferences /System/Library/PreferencePanes/Profiles.prefPane
	# Required to apply keyboard settings
	osascript -e 'tell application "System Events" to log out'
config-darwin-apps:
	defaults write com.sempliva.Tiles MenuBarIconEnabled 0
	defaults write org.dmarcotte.Easy-Move-Resize ModifierFlags SHIFT,CMD
	defaults write org.vim.MacVim MMTitlebarAppearsTransparent 1
	defaults write com.TorusKnot.SourceTreeNotMAS windowRestorationMethod 1
	defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2/"
	defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool YES
	defaults write com.coteditor.CotEditor showNavigationBar 0
	defaults write com.coteditor.CotEditor lineHeight 1.1
	defaults write com.coteditor.CotEditor fontName SauceCodePowerline-Regular
	defaults write com.coteditor.CotEditor fontSize 13
	defaults write com.coteditor.CotEditor highlightCurrentLine 1
	defaults write com.coteditor.CotEditor enablesAutosaveInPlace 0
	defaults write com.coteditor.CotEditor documentConflictOption 1
	@ln -vfs /Applications/CotEditor.app/Contents/SharedSupport/bin/cot /usr/local/bin/cot
config-linux:
	@echo "No config!"

$(HOME)/.ssh/id_rsa.pub:
	ssh-keygen -f $(HOME)/.ssh/id_rsa -P "" -v



add-ssh-key-pass: $(HOME)/.ssh/id_rsa.pub ## Adds a passphrase to local ssh keys
	@ssh-keygen -p -f ~/.ssh/id_rsa
.PHONY: add-ssh-key-pass


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



.PHONY: git-over-ssh
git-over-ssh: ## Tells git to use SSH connections for GitHub / GitLab / BitBucket
	@ln -s $(HOME)/.git-over-ssh $(HOME)/.git-over-ssh-enabled


zsh-default: ## Set ZSH as default
	@chsh -s $(which zsh) $(whoami)
.PHONY: zsh-default


clean:	## Cleans various places
	@-rm -rf ~/.tmp/*
	@-rm -rf ~/.Trash/*
	@-rm -rf ~/Library/Caches/*
	@-rm -rf "$(brew --cache)"
	@-brew cleanup -s
	@-docker system prune --all --force
	@-docker volume prune
	@-rm -rf ~/.m2/*
.PHONY: clean 

clean-downloads: ## Cleans old downloads
	@find ~/Downloads -maxdepth 1 -mtime +30 -exec mv -v {} ~/.Trash/ \;
.PHONY: clean-downloads


config-toggle-dark-mode: config-toggle-dark-mode-$(OS_NAME) ## Toggle Dark mode
config-toggle-dark-mode-linux:
	@echo "No config!"
config-toggle-dark-mode-darwin:
	@osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'



# rsyncs a remote location with this user's home
# $1 - Source machine
# $2 - Target machine
# $3 - Filter name to apply (.rsync-filter-$2)
# $4 - Additional options
define rsync
	@rsync -auip --progress --safe-links \
		--filter=". $$HOME/.rsync-filter-$(3)" --exclude=/* \
		$(1) $(2) \
		$(4)
endef

sync: pull push ## Synchronize files with maya ❤️
.PHONY: sync pull push force-push full-sync

pull:
	@gita pull
	$(call rsync,maya:~/,~/,$(HOST),)

push:
	@gita push
	$(call rsync,~/,maya:~/,$(HOST),)

force-push:
	@gita push
	$(call rsync,~/,maya:~/,$(HOST),--delete)

full-sync: ## Synchronize completely with maya
	@if ssh maya "test -e ~/data/newsboat/news.db.lock"; then echo "maya is busy, cannot sync now. STOP."; exit 1; fi
	$(call rsync,maya:~/,~/,$(HOST)-full,)
	$(call rsync,~/,maya:~/,$(HOST)-full,)



backup:
	@sudo echo # Request admin rights required for VeraCrypt

	@keepassxc-cli show "$$(find "$$HOME/Documents" -name "*.kdbx")" \
		"Backup: VeraCrypt / rsync" --attributes Password --show-protected | \
		/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt \
			--text --non-interactive --stdin /dev/rdisk2s3 /Volumes/VeraCryptBackup/
			
	@rsync --archive --delete --delete-excluded --progress --human-readable \
		-F --filter=". $$HOME/.rsync-filter-backup" --exclude=/*	   \
		"$$HOME/" /Volumes/VeraCryptBackup/
	
	tmutil startbackup


# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
.PHONY: help



.PHONY: linux-disable-unattended-updates
linux-disable-unattended-updates: ## Disable unattended updates on Linux hosts
	sudo cp /usr/share/unattended-upgrades/20auto-upgrades-disabled /etc/apt/apt.conf.d/

.PHONY: linux-lock-keyring
linux-lock-keyring:
	@kill -9 $$(pgrep gnome-keyring-d)

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



.PHONY: macos-lockscreen
macos-lockscreen: ## Set a lost and found message and contact info on the lockscreen
	@sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "If you found this device, please contact $$(osascript -e 'tell application "Contacts" to get value of email 1 of my card') / $$(osascript -e 'tell application "Contacts" to get value of phone 1 of my card')"
	@tccutil reset AddressBook


.PHONY: macos-xcode
macos-xcode: ## Repair Xcode installation
	@sudo rm -rf /Library/Developer/CommandLineTools
	@sudo xcode-select --install


.PHONY: macos-reset-privacy-permissions
macos-reset-privacy-permissions: ## Resets privacy settings
	@tccutil reset Accessibility
	@tccutil reset AddressBook
	@tccutil reset AppleEvents
	@tccutil reset Calendar
	@killall SystemUIServer
	@killall Finder
	@killall Dock


# https://github.com/Homebrew/brew/issues/4388#issuecomment-401364773
.PHONY: macos-fix-brew
macos-fix-brew: ## Fixes brew warnings, https://github.com/Homebrew/brew/issues/4388#issuecomment-401364773
	@brew cleanup 2>&1 | grep "Warning: Skipping" | awk -F: '{print $$2}' | awk '{print $$2}' | xargs brew upgrade
	@brew cleanup


.PHONY: macos-disable-timemachine-throttling-temporarily
macos-disable-timemachine-throttling-temporarily:
	@sudo sysctl debug.lowpri_throttle_enabled=0


.PHONY: macos-empty-dock
macos-empty-dock:
	@defaults write com.apple.dock persistent-apps -array
	@killall Dock
