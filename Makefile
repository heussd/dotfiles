# Home Makefile
# Timm's dirty little bootstrapping, configuring, cleaning, routing job doer.

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
	@docker ps --format "table {{.ID}}  {{.Image}}\t{{.Status}}\t{{.Ports}}" | tail -n +2
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


say-hi:
	@echo "OHHAI"
	@echo $(realpath $(MAKEFILE_LIST))
.PHONY: say-hi


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


install:	$(DOTFILES_BARE_REPO)/ install-$(OS_NAME) $(HOME)/.ssh/id_rsa.pub firefox vs-code 
install-linux:
# https://stackoverflow.com/questions/25391307/pipes-with-apt-package-manager#25391412
	@xargs -d '\n' -- sudo apt-get install -y < .apt-packages-base
install-darwin: homebrew finder macvim
.PHONY: setup setup-linux setup-darwin


homebrew:
ifndef BREW
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif
	@brew bundle install -v --file=.Brewfile

.PHONY: homebrew


$(HOME)/.ssh/id_rsa.pub:
	ssh-keygen -f $(HOME)/.ssh/id_rsa -P "" -v


finder:
	# Check for software updates daily, not just once per week
	defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
	# Text selection in QuickView
	defaults write com.apple.finder QLEnableTextSelection -bool TRUE
	# Set default Finder location to home folder (~/)
	defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
	# Expand save panel by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	# Disable ext change warning
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	# Use current directory as default search scope in Finder
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
	# Show Path bar in Finder
	defaults write com.apple.finder ShowPathbar -bool true
	# Show Status bar in Finder
	defaults write com.apple.finder ShowStatusBar -bool true
	# Show absolute path in Finder's title bar
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
	@killall Finder
.PHONY: finder


vs-code:
ifneq (, $(shell which code))
	@echo "dotfiles @ $$(git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ log --oneline | head -n 1)"
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
.PHONY: vs-code


macvim: homebrew
	defaults write org.vim.MacVim MMTitlebarAppearsTransparent 1
.PHONY: macvim


git-over-ssh:
	@ln -s $(HOME)/.git-over-ssh $(HOME)/.git-over-ssh-enabled


firefox:
	@for profile in $(FIREFOX_PROFILES_LOCATION)/*/; do ln -sFf $$HOME/.mozilla/firefox/user.js "$$profile"; done
.PHONY: firefox


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
