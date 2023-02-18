SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
DOTFILES_BARE 	 := $(HOME)/.dotfiles-bare-repo/
DOTFILES_BARE_P  := $(HOME)/.dotfiles-private-bare-repo/
HOST          	 := $$(hostname | cut -d"." -f 1)
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)


all: hostname auto status-dotfiles delete-old-states

hostname:
	@-echo $(HOST)

status-dotfiles:
	@-echo "dotfiles @ $$(git --git-dir=$(DOTFILES_BARE) log --oneline | head -n 1)"
	@-echo -n -e "\033[31m"
	@-git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME) status --porcelain
	@-git --git-dir=$(DOTFILES_BARE_P) --work-tree=$(HOME) status --porcelain
	@-echo -n -e "\033[0m"

auto: \
	.auto-Brewfile \
	.auto-Stewfile \
	.auto-requirements.txt \
	.auto-docker-compose.yml \
	.auto-vscode-packages \
	.auto-$(OS_NAME)

.auto-linux: .auto-apt-packages
	@lsb_release --short --description

.auto-darwin: .auto-macos-dock .auto-macos-defaults
	@echo "$$(sw_vers -productName) $$(sw_vers -productVersion) $$(sw_vers -buildVersion)"


.auto-Brewfile: .Brewfile
	@-command -v brew && \
		brew bundle install -v --cleanup --force --file=.Brewfile && \
		touch .auto-Brewfile

.auto-Stewfile: .Stewfile
	@-command -v stew && \
		stew install .Stewfile && \
		touch .auto-Stewfile

.auto-requirements.txt: .requirements.txt
	@-command -v pip3 && \
		pip3 install --upgrade --requirement .requirements.txt && \
		touch .auto-requirements.txt

.auto-docker-compose.yml: .docker-compose.yml
	@-command -v docker-compose && \
		docker-compose -f .docker-compose.yml pull && \
		touch .auto-docker-compose.yml

.auto-vscode-packages: .vscode-packages
	@-command -v code && \
		while read -r package; do \
			code --install-extension "$$package"; \
		done < .vscode-packages && \
		touch .auto-vscode-packages



.auto-macos-dock: .macos-dock .Brewfile
	defaults write com.apple.dock persistent-apps -array
	@while read -r package; do \
		app="$${package/#\~/$$HOME}"; \
		[[ -d "$$app.app" ]] && echo "$$app.app" && defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$$app.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" || true; \
	done < .macos-dock
	defaults write com.apple.Dock size-immutable -bool true
	defaults write com.apple.Dock contents-immutable -bool true
	killall Dock
	@touch .auto-macos-dock

.auto-macos-defaults: .macos-defaults .Brewfile
	@source .macos-defaults
	@touch .auto-macos-defaults


.auto-apt-packages: .apt-packages
	xargs -d '\n' -- sudo apt-get install -y < .apt-packages
	@touch .auto-apt-packages


upgrade-all:
	@-rm .auto-*
	$(MAKE)

upgrade-software: redo-Brewfile

redo-%:
	rm .auto-$*
	$(MAKE) .auto-$*


clean-all:	## Cleans various places
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


sync: pull push
pull:
	@python3 -m gita pull
push:
	@killall newsboat
	@python3 -m gita push

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

rsync: 
	$(call rsync,kabylake:~/,~/,$(HOST),)
	$(call rsync,~/,kabylake:~/,$(HOST),)
rsync-geneva: 
	$(call rsync,geneva:~/,~/,geneva,)
	$(call rsync,~/,geneva:~/,geneva,)

force-push:
	@gita push
	$(call rsync,~/,maya:~/,$(HOST),--delete)




config-dock: redo-macos-dock
config-defaults: redo-macos-defaults

config-git-over-ssh:
	@ln -s $(HOME)/.git-over-ssh $(HOME)/.git-over-ssh-enabled

config-zsh-as-default:
	@chsh -s $(which zsh) $(whoami)

config-wallpaper: .esoc0932a.jpg config-wallpaper-$(OS_NAME)
.esoc0932a.jpg:
	@wget https://cdn.eso.org/images/large/eso0932a.jpg -O .esoc0932a.jpg
config-wallpaper-linux:
	@feh --bg-scale .esoc0932a.jpg
config-wallpaper-darwin:
	@osascript -e 'tell application "System Events" to tell every desktop to set picture to ((path to home folder as text) & ".esoc0932a.jpg")'

config-login-items:
	osascript -e 'tell application "System Events"' \
		-e 'repeat with i in (get the name of every login item)' \
		-e 'delete login item i' \
		-e 'end repeat' \
		-e 'end tell'
	sudo xattr -cr "$$HOME/Library/startup.command"
	osascript -e "tell application \"System Events\" to make login item at end with properties {path:  POSIX path of (path to home folder) & \"/Library/startup.command\", hidden:false}"

config-lock-autostart:
	@-SetFile -a L "$$HOME/Library/LaunchAgents"
	@-sudo rm /Library/LaunchAgents/*
	@-sudo SetFile -a L "/Library/LaunchAgents"
	@-sudo rm /Library/LaunchDaemons/*
	@-sudo SetFile -a L "/Library/LaunchDaemons"

config-lockscreen:
	@sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "If you found this device, please contact $$(osascript -e 'tell application "Contacts" to get value of email 1 of my card') / $$(osascript -e 'tell application "Contacts" to get value of phone 1 of my card')"
	#@tccutil reset AddressBook

config-ssh-key-pass:
	@ssh-keygen -p -f ~/.ssh/id_rsa

config-apt-no-sudo-passwd:
	echo "%sudo   ALL=(ALL:ALL) NOPASSWD:/usr/bin/apt" | sudo tee /etc/sudoers.d/010_apt-nopasswd

config-disable-unattended-updates:
	sudo cp /usr/share/unattended-upgrades/20auto-upgrades-disabled /etc/apt/apt.conf.d/


FIREFOX_PROFILES_LOCATION=$$HOME/Library/Application\ Support/Firefox/Profiles/
ifneq ("$(OS_NAME)","linux")
FIREFOX_PROFILES_LOCATION=$$HOME/.mozilla/firefox/
endif
config-firefox: firefox-policies
	@for profile in $(FIREFOX_PROFILES_LOCATION)/*/; do \
		echo "$$profile"; \
		ln -sFf $$HOME/.mozilla/firefox/user.js "$$profile"; \
		mkdir -p "$$profile/chrome"; \
		ln -sFf $$HOME/.mozilla/firefox/chrome/userChrome.css "$$profile/chrome/"; \
	done

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


delete-old-states:
	@find "$$HOME" \( -name ".auto-Brewfile" \
		-o -name ".auto-requirements.txt" \) \
		-maxdepth 1 -mmin +$$((7*24*60)) \
		-delete \
		-exec echo "{} was outdated and has been removed." \; 
