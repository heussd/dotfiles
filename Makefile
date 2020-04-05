#   _____ _                     _       _   _
#  |_   _(_)_ __ ___  _ __ ___ ( )___  | | | | ___  _ __ ___   ___
#    | | | | '_ ` _ \| '_ ` _ \|// __| | |_| |/ _ \| '_ ` _ \ / _ \
#    | | | | | | | | | | | | | | \__ \ |  _  | (_) | | | | | |  __/
#    |_| |_|_| |_| |_|_| |_| |_| |___/ |_| |_|\___/|_| |_| |_|\___|
#                 __  __       _         __ _ _
#                |  \/  | __ _| | _____ / _(_) | ___
#                | |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#                | |  | | (_| |   <  __/  _| | |  __/
#                |_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
# xcode-select --install 

SHELL   := bash
.SHELLFLAGS := -eu -o pipefail -c  
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

SHORTHOSTNAME=$(shell hostname | cut -d"." -f 1)
OS_NAME := $(shell uname -s | tr A-Z a-z)

DOTFILES_WORK_DIR  := $(HOME)/
DOTFILES_BARE_REPO := $(HOME)/.dotfiles-bare-repo/

define rsync-folder
	rsync -auip --progress --safe-links --exclude=.DS_Store $(1) $(2)
endef

.PHONY: default
default:	$(DOTFILES_BARE_REPO)/ motd


$(DOTFILES_BARE_REPO)/: 
	@git clone --bare https://github.com/heussd/dotfiles.git $(DOTFILES_BARE_REPO)/
	@git --git-dir=$(DOTFILES_BARE_REPO) config --local status.showUntrackedFiles no
	@git --git-dir=$(DOTFILES_BARE_REPO) config --local core.sparseCheckout true
# Include everything
	@echo "/*" > $(DOTFILES_BARE_REPO)/info/sparse-checkout
# Exclude readme
	@echo "!Readme.md" >> $(DOTFILES_BARE_REPO)/info/sparse-checkout
# Ignore Library folder on Linux
ifeq ("$(OS_NAME)","linux")
	@echo "!Library" >> $(DOTFILES_BARE_REPO)/info/sparse-checkout
endif	
	@cd $(DOTFILES_WORK_DIR)/
# recursive-submodules is limited to git >= 2.13
# We are doing it the old way here to increase compatibility
#@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ checkout -f --recurse-submodules
	@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ checkout -f
	@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ submodule update --init --recursive


motd: hostname version	## Show ZPool status and parameters of Docker containers
ifneq (, $(shell which zpool))
	@zpool status && echo
endif
ifneq (, $(shell which docker))
	@docker ps --format "table {{.ID}}  {{.Image}}\t{{.Status}}\t{{.Ports}}" | tail -n +2 && echo
endif
.PHONY: motd


hostname:
	@echo
ifeq (, $(shell which figlet))
	@echo '  ' $(SHORTHOSTNAME)
else
	@figlet '  ' $(SHORTHOSTNAME)
endif
	@echo
.PHONY: hostname


version: version-$(OS_NAME)	## Print OS version + dotfiles revision and status
	@echo "dotfiles @ $$(git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ log --oneline | head -n 1)"
	@echo -e "\033[31m$$(git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ status --porcelain)\033[0m"
version-linux:
	@lsb_release --short --description
version-darwin:
	@echo $$(sw_vers -productName) $$(sw_vers -productVersion) $$(sw_vers -buildVersion)
.PHONY: version version-linux version-darwin


clean:	## Cleans various places
	@-rm -rf ~/.tmp/*
	@-rm -rf ~/.Trash/*
very-clean-darwin:
	@-rm -rf ~/Library/Caches/*
# Maybe redundant to the line above
	@-rm -rf "$(brew --cache)"
	@-brew cleanup -s
very-clean: clean very-clean-$(OS_NAME) ## Cleans various places (desperate mode)
	@-docker system prune --all --force
	@-rm -rf ~/.m2/*
.PHONY: clean very-clean very-clean-darwin


update: update-$(OS_NAME)	## Updates OS applications and various package managers
	@-apm update --confirm=false
	@-npm update -g
update-darwin: update-homebrew
	@-sudo softwareupdate -i -a
update-homebrew: install-homebrew
	@brew upgrade
	@brew cask upgrade --greedy
.PHONY: update update-linux update-darwin


install:	$(DOTFILES_BARE_REPO)/ install-$(OS_NAME) config ## Installs and configures stuff after fresh installs
install-linux:
# https://stackoverflow.com/questions/25391307/pipes-with-apt-package-manager#25391412
	@xargs -d '\n' -- sudo apt-get install -y < .apt-packages-base
	touch ~/.last-install
install-darwin: install-homebrew
	touch ~/.last-install

.PHONY: install install-linux install-darwin


.PHONY: install-homebrew
install-homebrew: ## Installs homebrew and all bundled apps
ifeq (, $(shell which brew))
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif
	@export HOMEBREW_CASK_OPTS="--no-quarantine"
	@brew bundle install -v --file=.Brewfile
	@brew cleanup -s

.PHONY: install-veracrypt
install-linux-veracrypt: ## Installs Veracrypt from a PPA
	sudo add-apt-repository ppa:unit193/encryption
	sudo apt update
	sudo apt-get install veracrypt 



.PHONY: config config-darwin config-linux
config: config-$(OS_NAME) $(HOME)/.ssh/id_rsa.pub config-firefox ## Configures host
	chsh -s $$(which zsh) $$(whoami) 
ifneq (, $(shell which code))
	@for extension in {\
	dakara.transformer,\
	eamodio.gitlens,\
	esbenp.prettier-vscode,\
	formulahendry.auto-close-tag,\
	formulahendry.auto-rename-tag,\
	ms-azuretools.vscode-docker,\
	ms-python.python,\
	streetsidesoftware.code-spell-checker,\
	VisualStudioExptTeam.vscodeintellicode,\
	Zignd.html-css-class-completion,\
	}; do code --install-extension $$extension --force; done
endif
config-linux: ## Configures Linux-based hosts
	@echo "No config!"
config-darwin: config-darwin-coteditor ## Configures macOS-based hosts
	defaults write com.apple.finder QLEnableTextSelection -bool TRUE
	defaults write com.apple.finder NewWindowTarget -string "PfLo"
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	defaults write com.apple.finder ShowStatusBar -bool true
	defaults write com.apple.finder ShowPathbar -bool true
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true	
	defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
	defaults write NSGlobalDomain KeyRepeat -int 1
	defaults write NSGlobalDomain AppleInterfaceTheme Dark
	defaults write com.apple.dock autohide-delay -int 0
	defaults write com.apple.dock autohide-time-modifier -float 0
	
	@killall Finder; killall Dock;killall SystemUIServer

	defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
	
	defaults write com.sempliva.Tiles MenuBarIconEnabled 0
	defaults write org.dmarcotte.Easy-Move-Resize ModifierFlags SHIFT,CMD
	defaults write org.vim.MacVim MMTitlebarAppearsTransparent 1
	defaults write com.TorusKnot.SourceTreeNotMAS windowRestorationMethod 1
	defaults write io.masscode.app NSNavLastRootDirectory "~/projects/masscode-snippets"
	defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2/"
	defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool YES


.PHONY: config-firefox
ifeq ("$(OS_NAME)","darwin")
FIREFOX_PROFILES_LOCATION=$$HOME/Library/Application\ Support/Firefox/Profiles/
else
FIREFOX_PROFILES_LOCATION=$$HOME/.mozilla/firefox/
endif
config-firefox: ## Symlinks Firefox user config files to all Firefox profiles
	@for profile in $(FIREFOX_PROFILES_LOCATION)/*/; do \
		echo "$$profile"; \
		ln -sFf $$HOME/.mozilla/firefox/user.js "$$profile"; \
		mkdir -p "$$profile/chrome"; \
		ln -sFf $$HOME/.mozilla/firefox/chrome/userChrome.css "$$profile/chrome/"; \
	done

config-linux-disable-unattended-updates: ## Disable unattended updates on Linux hosts
	sudo cp /usr/share/unattended-upgrades/20auto-upgrades-disabled /etc/apt/apt.conf.d/

config-linux-apt-no-sudo-passwd:
	echo "%sudo   ALL=(ALL:ALL) NOPASSWD:/usr/bin/apt" | sudo tee /etc/sudoers.d/010_apt-nopasswd



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


$(HOME)/.ssh/id_rsa.pub:
	ssh-keygen -f $(HOME)/.ssh/id_rsa -P "" -v


config-git-over-ssh: ## Tells git to use SSH connections for GitHub / GitLab / BitBucket
	@ln -s $(HOME)/.git-over-ssh $(HOME)/.git-over-ssh-enabled


install-linux-docker: ## Installs Docker and docker-compose on Linux hosts
ifeq ("$(OS_NAME)","linux")
	@curl -fsSL https://get.docker.com/ -o - | sh
	@sudo usermod -aG docker $(USER)
	@sudo apt-get install -y python3-pip python3-dev
	@sudo pip3 install docker-compose
	docker-compose --version
else
	$(error Unsupported OS)
endif
.PHONY: install-linux-docker


.PHONY: sync-maya
sync-maya: ## Syncs stuff from maya ❤️
	@echo "Uploading..."
	@$(call rsync-folder,~/data/,maya:~/data/)

	@if ssh maya "test ! -e ~/data/news-retrieval/news.db.lock"; then echo "Downloading..."; $(call rsync-folder,maya:~/data/,~/data/); fi


.PHONY: fix-add-ssh-key-passphrase 
fix-add-ssh-key-passphrase: $(HOME)/.ssh/id_rsa.pub ## Adds a passphrase to local ssh keys
	@ssh-keygen -p -f ~/.ssh/id_rsa


.PHONY: help
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Displays this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-40s\033[0m %s\n", $$1, $$2}'
