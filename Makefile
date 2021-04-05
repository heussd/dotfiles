SHELL   := bash
.SHELLFLAGS := -eu -o pipefail -c  
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

DOTFILES_REPO := https://github.com/heussd/dotfiles.git
DOTFILES_BARE := $(HOME)/.dotfiles-bare-repo/

OS_NAME := $(shell uname -s | tr A-Z a-z)

default:	$(DOTFILES_BARE)/ auto-pull .auto-install-$(OS_NAME) firefox-policies
.PHONY: default

ifneq ("$(wildcard .Makefile.$(OS_NAME).mk)","")
include .Makefile.$(OS_NAME).mk
endif

ifneq ("$(wildcard .Makefile.firefox.mk)","")
include .Makefile.firefox.mk
endif


initial-setup:
	@echo $(DOTFILES_REPO)

$(DOTFILES_BARE)/: 
	@git clone --bare $(DOTFILES_REPO) $(DOTFILES_BARE)/
	@git --git-dir=$(DOTFILES_BARE) config --local status.showUntrackedFiles no
	@git --git-dir=$(DOTFILES_BARE) config --local core.sparseCheckout true
# Include everything
	@echo "/*" > $(DOTFILES_BARE)/info/sparse-checkout
# Exclude readme
	@echo "!Readme.md" >> $(DOTFILES_BARE)/info/sparse-checkout
# Ignore Library folder on Linux
ifeq ("$(OS_NAME)","linux")
	@echo "!Library" >> $(DOTFILES_BARE)/info/sparse-checkout
endif	
	@cd $(HOME)/
# recursive-submodules is limited to git >= 2.13
# We are doing it the old way here to increase compatibility
#@git --git-dir=$(DOTFILES_BARE) --work-tree=$(DOTFILES_WORK_DIR)/ checkout -f --recurse-submodules
	@git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ checkout -f
	@git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ submodule update --init --recursive
# Manual pull to create FETCH_HEAD
	@git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ pull
	@touch "$(DOTFILES_BARE)/FETCH_HEAD"


# Do things if $1 is too old
# $1 - File to check
# $2 - Message to print
# $3 - Commands to execute
define if-old
	@if [ -e $(1) ]; then find "$(1)" -mmin +$$((7*24*60)) \
		-exec bash -c 'echo -e "\033[0;34m[Home Makefile]\033[0m$(2)"; $(3); touch $(1)' \; ;\
	fi
endef

auto-pull: ## Pulls from dotfiles remote repository, if last pull is old enough
	$(call if-old,$(DOTFILES_BARE)/FETCH_HEAD, \
		Pulling dotfiles...,\
		git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ pull --recurse-submodules --quiet)
.PHONY: auto-pull

check-time-last-installed:
	$(call if-old,$(HOME)/.auto-install-$(OS_NAME),\
		Triggering auto install...,\
		rm -f "{}"; $(MAKE) .auto-install-$(OS_NAME))
.PHONY: check-time-last-installed


config: config-$(OS_NAME) $(HOME)/.ssh/id_rsa.pub firefox ## Configures user account and applications
.PHONY: config config-darwin config-linux

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
# $1 - Remote Location
# $2 - Filter name to apply (.rsync-filter-$2)
# $3 - Additional options
define rsync
	@echo "⬇️ $1..."
	@rsync -auip --progress --safe-links --filter=". $$HOME/.rsync-filter-$(2)" --exclude=/* $(1):~/ ~/ $(3)
	@echo "⬆️ $1..."
	@rsync -auip --progress --safe-links --filter=". $$HOME/.rsync-filter-$(2)" --exclude=/* ~/ $(1):~/ $(3)
endef

define gita
	@echo "⬇️ gita..."
	@gita pull
	@echo "⬆️ gita..."
	@gita push
endef
	

sync: ## Synchronize files with maya ❤️
	$(call gita)
	$(call rsync,maya,maya,)

full-sync: ## Synchronize completely with maya
	$(call gita)
	@if ssh maya "test -e ~/data/newsboat/news.db.lock"; then echo "maya is busy, cannot sync now. STOP."; exit 1; fi
	$(call rsync,maya,maya-full,)
	
sync-dry: ## Like sync, but as dry-run
	$(call rsync,maya,maya,--dry-run)



# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' .Makefile.firefox.mk | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
	@echo -e "$(OS_NAME) specific targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' .Makefile.$(OS_NAME).mk | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
.PHONY: help
