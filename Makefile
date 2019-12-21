SHELL:=bash
# xcode-select --install 

OS_NAME := $(shell uname -s | tr A-Z a-z)
DOTFILES = $(HOME)/.dotfiles

DOTFILES_BARE_REPO := $(HOME)/MAKE-dotfiles-bare-repo/

RSYNC_OPTIONS  := -auip --progress --safe-links
RSYNC_EXCLUDES := --exclude=.DS_Store

default:	$(DOTFILES_BARE_REPO)/ say-hi $(OS_NAME)-install


$(DOTFILES_BARE_REPO)/:
	@git clone --bare git@github.com:heussd/dotfiles.git $(DOTFILES_BARE_REPO)/
	@cd $(HOME)/MAKE-dotfiles
	@git --git-dir=$(DOTFILES_BARE_REPO) --work-tree=$(HOME)/MAKE-dotfiles checkout -f git-alias --recurse-submodules


say-hi:
	@echo "OHHAI"
	@echo $(realpath $(MAKEFILE_LIST))


darwin-install:
	@echo "DARWIN INSTALL"


install-docker-linux:
	@curl -fsSL https://get.docker.com/ -o - | sh


sync-maya:
	@echo "Uploading..."
	@rsync $(RSYNC_OPTIONS) $(RSYNC_EXCLUDES) ~/data/ maya:~/data/
	
	@if ssh maya "test ! -e ~/data/news-retrieval/news.db.lock"; then echo "Downloading..."; rsync $(RSYNC_OPTIONS) $(RSYNC_EXCLUDES) maya:~/data/ ~/data/; fi
