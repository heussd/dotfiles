# Timm's home Makefile

SHELL:=bash
# xcode-select --install 

BREW := $(shell command -v brew 2> /dev/null)

OS_NAME := $(shell uname -s | tr A-Z a-z)
DOTFILES = $(HOME)/.dotfiles

DOTFILES_WORK_DIR  := $(HOME)/
DOTFILES_BARE_REPO := $(HOME)/.dotfiles-bare-repo/

RSYNC_OPTIONS  := -auip --progress --safe-links
RSYNC_EXCLUDES := --exclude=.DS_Store



default:	$(DOTFILES_BARE_REPO)/ show-os-version say-hi


$(DOTFILES_BARE_REPO)/:
	@git clone --bare git@github.com:heussd/dotfiles.git $(DOTFILES_BARE_REPO)/
	@cd $(DOTFILES_WORK_DIR)/
	# recursive-submodules is limited to git >= 2.13
	# We are doing it the old way here to increase compatibility
	#@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ checkout -f --recurse-submodules
	@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ checkout -f
	@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ submodule update --init --recursive
	@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ config --local status.showUntrackedFiles no


say-hi:
	@echo "OHHAI"
	@echo $(realpath $(MAKEFILE_LIST))


show-os-version: show-os-version-$(OS_NAME)
	@echo "dotfiles @ $$(git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(DOTFILES_WORK_DIR)/ log --oneline | head -n 1)"
show-os-version-darwin:
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
