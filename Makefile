# Timm's home Makefile
# xcode-select --install 

SHELL   := bash
BREW    := $(shell command -v brew 2> /dev/null)
OS_NAME := $(shell uname -s | tr A-Z a-z)

DOTFILES_WORK_DIR  := $(HOME)/
DOTFILES_BARE_REPO := $(HOME)/.dotfiles-bare-repo/

RSYNC_OPTIONS  := -auip --progress --safe-links
RSYNC_EXCLUDES := --exclude=.DS_Store



default:	$(DOTFILES_BARE_REPO)/ version say-hi


$(DOTFILES_BARE_REPO)/: 
	@git clone --bare git@github.com:heussd/dotfiles.git $(DOTFILES_BARE_REPO)/
	@git --git-dir=$(DOTFILES_BARE_REPO) config --local status.showUntrackedFiles no
	@git --git-dir=$(DOTFILES_BARE_REPO) config --local core.sparseCheckout true
# Include everything
	@echo "/*" > $(DOTFILES_BARE_REPO)/info/sparse-checkout
# Exclude readme
	@echo "!Readme.md" >> $(DOTFILES_BARE_REPO)/info/sparse-checkout
# Ignore Library folder on Linux
ifeq ($(OS_NAME),"linux")
	@echo "!Library" >> $(DOTFILES_BARE_REPO)/info/sparse-checkout
endif
	
	@cd $(DOTFILES_WORK_DIR)/
# recursive-submodules is limited to git >= 2.13
# We are doing it the old way here to increase compatibility
#@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ checkout -f --recurse-submodules
	@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ checkout -f
	@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ submodule update --init --recursive


say-hi:
	@echo "OHHAI"
	@echo $(realpath $(MAKEFILE_LIST))


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


update: update-$(OS_NAME)
	@-apm update --confirm=false
	@-npm update -g
update-darwin:
	@-sudo softwareupdate -i -a
	@-brew update
	@-brew upgrade
	@-brew bundle install -v --file=.Brewfile


version: version-$(OS_NAME)
	@echo "dotfiles @ $$(git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ log --oneline | head -n 1)"
version-linux:
	@lsb_release --short --description
version-darwin:
	@echo $$(sw_vers -productName) $$(sw_vers -productVersion) $$(sw_vers -buildVersion)


setup:	$(DOTFILES_BARE_REPO)/ setup-$(OS_NAME)
setup-linux:
	sudo apt install -y \
    vim \
    figlet
setup-darwin: 
ifndef BREW
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif
	@brew bundle install -v --file=.Brewfile
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
	@killall Dock


vs-code:
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


install-docker-linux:
	@curl -fsSL https://get.docker.com/ -o - | sh
	@sudo usermod -aG docker $(USER)
	@sudo apt-get install -y python3-pip python3-dev
	@sudo pip3 install docker-compose
	docker-compose --version


sync-maya:
	@echo "Uploading..."
	@rsync $(RSYNC_OPTIONS) $(RSYNC_EXCLUDES) ~/data/ maya:~/data/
	
	@if ssh maya "test ! -e ~/data/news-retrieval/news.db.lock"; then echo "Downloading..."; rsync $(RSYNC_OPTIONS) $(RSYNC_EXCLUDES) maya:~/data/ ~/data/; fi
