SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
DOTFILES_BARE 	 := $(HOME)/.dotfiles-bare-repo/
HOST          	 := $$(hostname | cut -d"." -f 1)
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)


default: auto-pull-dotfiles auto-install 
.PHONY: default


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
		-exec bash -c 'echo -e "\033[0;34m[Home Makefile]\033[0m$(2)"; $(3)' \; ;\
	fi
endef

auto-pull-dotfiles: ## Pulls from dotfiles remote repository, if last pull is old enough
	$(call if-old,$(DOTFILES_BARE)/FETCH_HEAD, \
		Pulling dotfiles...,\
		git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ pull --recurse-submodules --quiet; touch $(DOTFILES_BARE)/FETCH_HEAD)
.PHONY: auto-pull-dotfiles

check-time-last-installed:
	$(call if-old,$(HOME)/.auto-install-$(OS_NAME),\
		Triggering auto install...,\
		rm -f "$(HOME)/.auto-install-$(OS_NAME)")
.PHONY: check-time-last-installed


auto-install: .auto-install-$(OS_NAME) firefox-policies
.PHONY: auto-install

.auto-install-darwin: .Brewfile .pip-global-requirements.txt .docker-cli-images.yml | check-time-last-installed
	@touch .auto-install-darwin
	
	$(call exec,Brew bundle install,\
		export HOMEBREW_CASK_OPTS="--no-quarantine"; \
		brew bundle install -v --cleanup --force --file=.Brewfile)

	$(call exec,PIP install,\
		pip3 install -U -r .pip-global-requirements.txt)

	$(call exec,Pulling Docker CLI images,\
		docker-compose -f .docker-cli-images.yml pull)


.auto-install-linux: .apt-packages-base .pip-global-requirements.txt .docker-cli-images.yml | check-time-last-installed
	@touch .auto-install-linux

#	# https://stackoverflow.com/questions/25391307/pipes-with-apt-package-manager#25391412
	$(call exec,APT install,\
		xargs -d '\n' -- sudo apt-get install -y < .apt-packages-base)

	$(call exec,PIP install,\
		pip3 install -U -r .pip-global-requirements.txt)

	$(call exec,Pulling Docker CLI images,\
		docker-compose -f .docker-cli-images.yml pull)


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



# rsyncs a remote location with this user's home
# $1 - Source machine
# $2 - Target machine
# $3 - Filter name to apply (.rsync-filter-$2)
# $4 - Additional options
define rsync
	@rsync -auip --progress --safe-links \
		--filter=". $$HOME/.rsync-filters/$(3)" --exclude=/* \
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
	sudo sysctl debug.lowpri_throttle_enabled=0

	@echo "Mounting VeraCrypt volume..."
	@keepassxc-cli show "$$(find "$$HOME/Documents" -name "*.kdbx")" \
		"Backup: VeraCrypt / rsync" --attributes Password --show-protected | \
		/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt \
			--text --non-interactive --stdin /dev/rdisk2s3 /Volumes/VeraCryptBackup/
			
	@rsync --archive --delete --delete-excluded --progress --human-readable --stats \
		-F --filter=". $$HOME/.rsync-filters/backup" --exclude=/*	   \
		"$$HOME/" /Volumes/VeraCryptBackup/

	@echo "Dismounting VeraCrypt volume..."
	@/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt --dismount
	
	tmutil startbackup --auto


# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
.PHONY: help


.PHONY: linux-lock-keyring
linux-lock-keyring:
	@kill -9 $$(pgrep gnome-keyring-d)


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

