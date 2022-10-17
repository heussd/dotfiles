SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
DOTFILES_BARE 	 := $(HOME)/.dotfiles-bare-repo/
HOST          	 := $$(hostname | cut -d"." -f 1)
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)


default: auto-pull-dotfiles install
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
	@if [ -e $(1) ]; then find "$(1)" -mmin +$$((999*24*60)) \
		-exec bash -c 'echo -e "\033[0;34m[Home Makefile]\033[0m$(2)"; $(3)' \; ;\
	fi
endef

auto-pull-dotfiles: ## Pulls from dotfiles remote repository, if last pull is old enough
	$(call if-old,$(DOTFILES_BARE)/FETCH_HEAD, \
		Pulling dotfiles...,\
		git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ pull --recurse-submodules --quiet; touch $(DOTFILES_BARE)/FETCH_HEAD)
.PHONY: auto-pull-dotfiles

check-time-last-installed:
	$(call if-old,$(HOME)/.install-$(OS_NAME),\
		install will be executed on next run,\
		 make remove-stat-files --no-print-directory)
.PHONY: check-time-last-installed


.PHONY: install
install: .install-$(OS_NAME) firefox-policies 
	@touch .install-$(OS_NAME)

.install-darwin: .Brewfile.state .Stewfile.state .requirements.txt.state .docker-compose.yml-state .vscode-packages-state | check-time-last-installed .macos-dock-state .macos-defaults-state
.install-linux: .Brewfile.state .Stewfile.state .requirements.txt.state .docker-compose.yml-state .apt-package-state .vscode-packages-state | check-time-last-installed

.Brewfile.state: .Brewfile
	HOMEBREW_CASK_OPTS="--no-quarantine" \
		brew bundle install -v --cleanup --force --file=.Brewfile
	@touch .Brewfile.state

.Stewfile.state: .Stewfile
	stew install .Stewfile
	@touch .Stewfile.state

.requirements.txt.state: .requirements.txt
	pip3 install --upgrade --requirement .requirements.txt
	@touch .requirements.txt.state

.docker-compose.yml-state:
	docker-compose -f .docker-compose.yml pull
	@touch .docker-compose.yml-state

.apt-package-state: .apt-packages
	xargs -d '\n' -- sudo apt-get install -y < .apt-packages
	@touch .apt-package-state

.PHONY: remove-stat-files
remove-stat-files:
	@rm .Brewfile.state .Stewfile.state .requirements.txt-state .docker-compose.yml-state .apt-package-state 2> /dev/null || true

.PHONY: update
update: remove-stat-files install



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
	@-rm -rf ~/Library/Caches/com.apple.dt.Xcode
	@-rm -rf ~/Library/Developer/Xcode/DerivedData
	@-rm -rf ~/Library/Developer/Xcode/Archives
	@-rm -rf ~/Library/Developer/Xcode/iOS DeviceSupport/
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
#	$(call rsync,maya:~/,~/,$(HOST),)

push:
	@gita push
#	$(call rsync,~/,maya:~/,$(HOST),)

force-push:
	@gita push
	$(call rsync,~/,maya:~/,$(HOST),--delete)

rsync: 
	$(call rsync,kabylake:~/,~/,$(HOST),)
	$(call rsync,~/,kabylake:~/,$(HOST),)



backup:
	sudo sysctl debug.lowpri_throttle_enabled=0
	BORG_PASSCOMMAND='keepasspw-fzf' \
	borg create \
		--stats \
		--progress \
		--compression lz4 \
		/Volumes/Backup/borg::{hostname}-{user}-{now:%Y-%m-%dT%H:%M:%S} \
		~/Archive	\
		~/Documents/	\
		~/Dropbox/	\
		~/OneDrive/	\
		~/Pictures/	\
		~/data/		\
		~/Library/Thunderbird/	\
		~/Library/Application\ Support/Firefox/
	cd ~/Documents && git bundle create /Volumes/Backup/Documents-git-bundle --all
	tmutil startbackup --rotation

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



.vscode-packages-state: .vscode-packages
	@while read -r package; do \
		code --install-extension "$$package"; \
	done < .vscode-packages
	@touch .vscode-packages-state


config-macos-dock:
	@rm .macos-dock-state
	$(MAKE) .macos-dock-state
.macos-dock-state: .macos-dock
	defaults write com.apple.dock persistent-apps -array
	@while read -r package; do \
		[[ -d "$$package.app" ]] && echo "$$package.app" && defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$$package.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" || true; \
	done < .macos-dock
	defaults write com.apple.Dock size-immutable -bool true
	defaults write com.apple.Dock contents-immutable -bool true
	killall Dock
	@touch .macos-dock-state

config-macos-defaults:
	@rm .macos-defaults-state
	$(MAKE) .macos-defaults-state
.macos-defaults-state: .macos-defaults
	@source .macos-defaults
	@touch .macos-defaults-state
