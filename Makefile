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

BREW    := $(shell command -v brew 2> /dev/null)

define rsync-folder
	rsync -auip --progress --safe-links --exclude=.DS_Store $(1) $(2)
endef

ifeq ("$(OS_NAME)","darwin")
	FIREFOX_PROFILES_LOCATION=$$HOME/Library/Application\ Support/Firefox/Profiles/
else
	FIREFOX_PROFILES_LOCATION=$$HOME/.mozilla/firefox/
endif


default:	$(DOTFILES_BARE_REPO)/ motd
.PHONY: default


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


motd: hostname version
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


version: version-$(OS_NAME)
	@echo "dotfiles @ $$(git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ log --oneline | head -n 1)"
	@echo -e "\033[31m$$(git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ status --porcelain)\033[0m"
version-linux:
	@lsb_release --short --description
version-darwin:
	@echo $$(sw_vers -productName) $$(sw_vers -productVersion) $$(sw_vers -buildVersion)
.PHONY: version version-linux version-darwin


clean:
	@-rm -rf ~/.tmp/*
	@-rm -rf ~/.Trash/*
very-clean-darwin:
	@-rm -rf ~/Library/Caches/*
# Maybe redundant to the line above
	@-rm -rf "$(brew --cache)"
	@-brew cleanup -s
very-clean: clean very-clean-$(OS_NAME)
	@-docker system prune --all --force
	@-rm -rf ~/.m2/*
.PHONY: clean very-clean very-clean-darwin


update: update-$(OS_NAME)
	@-apm update --confirm=false
	@-npm update -g
update-darwin: update-homebrew
	@-sudo softwareupdate -i -a
update-homebrew: homebrew
	@brew upgrade
	@brew cask upgrade --greedy
.PHONY: update update-linux update-darwin


install:	$(DOTFILES_BARE_REPO)/ install-$(OS_NAME) config
install-linux:
# https://stackoverflow.com/questions/25391307/pipes-with-apt-package-manager#25391412
	@xargs -d '\n' -- sudo apt-get install -y < .apt-packages-base
install-darwin: homebrew config-darwin
.PHONY: install install-linux install-darwin


homebrew:
ifndef BREW
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif
	@export HOMEBREW_CASK_OPTS="--no-quarantine"
	@brew bundle install -v --file=.Brewfile
	@brew cleanup -s
.PHONY: homebrew

	
config: config-$(OS_NAME) $(HOME)/.ssh/id_rsa.pub config-firefox
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
config-linux:
	@echo "No config!"
config-darwin:
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

.PHONY: config config-darwin config-linux

.PHONY: config-firefox
config-firefox:
	@for profile in $(FIREFOX_PROFILES_LOCATION)/*/; do \
		ln -sFf $$HOME/.mozilla/firefox/user.js "$$profile"; \
		mkdir -p "$$profile/chrome"; \
		ln -sFf $$HOME/.mozilla/firefox/chrome/userChrome.css "$$profile/chrome/"; \
	done

config-linux-disable-unattended-updates:
	sudo cp /usr/share/unattended-upgrades/20auto-upgrades-disabled /etc/apt/apt.conf.d/


$(HOME)/.ssh/id_rsa.pub:
	ssh-keygen -f $(HOME)/.ssh/id_rsa -P "" -v


git-over-ssh:
	@ln -s $(HOME)/.git-over-ssh $(HOME)/.git-over-ssh-enabled


docker-linux:
	@curl -fsSL https://get.docker.com/ -o - | sh
	@sudo usermod -aG docker $(USER)
	@sudo apt-get install -y python3-pip python3-dev
	@sudo pip3 install docker-compose
	docker-compose --version
.PHONY: docker-linux


sync-maya:
	@echo "Uploading..."
	@$(call rsync-folder,~/data/,maya:~/data/)

	@if ssh maya "test ! -e ~/data/news-retrieval/news.db.lock"; then echo "Downloading..."; $(call rsync-folder,maya:~/data/,~/data/); fi
.PHONY: sync-maya


fix-add-ssh-key-passphrase:
	@ssh-keygen -p -f ~/.ssh/id_rsa