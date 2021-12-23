SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)
DOTFILES_REPO 	 := https://github.com/heussd/dotfiles.git
DOTFILES_BARE 	 := $(HOME)/.dotfiles-bare-repo/


FONT	:= Source Code Pro
SIZE	:= 13
CSS	:= Timm's Way to View Things


default: \
	vscode \
	$(OS_NAME) \
	$(HOME)/.ssh/id_rsa.pub

ifneq ("$(wildcard Makefile.$(OS_NAME))","")
include Makefile.$(OS_NAME)
endif


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


