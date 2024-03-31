SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
HOST          	 := $$(hostname | cut -d"." -f 1)
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)


# https://gist.github.com/prwhite/8168133?permalink_comment_id=3456785#gistcomment-3456785
help: 
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)



clean-all:	## Cleans various places
	@-rm -rf ~/.tmp/*
	@-rm -rf ~/.Trash/*
	@-rm -rf ~/Library/Caches/*
	@-rm -rf ~/Library/Caches/com.apple.dt.Xcode
	@-rm -rf ~/Library/Developer/Xcode/DerivedData
	@-rm -rf ~/Library/Developer/Xcode/Archives
	@-rm -rf ~/Library/Developer/Xcode/iOS DeviceSupport/
	@-rm -rf "$$(brew --cache)"
	@-brew cleanup -s
	@-docker system prune --all --force
	@-docker volume prune
	@-rm -rf ~/.m2/*


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




config-git-over-ssh:
	@ln -s $(HOME)/.git-over-ssh $(HOME)/.git-over-ssh-enabled

config-zsh-as-default:
	@chsh -s $(which zsh) $(whoami)

config-wallpaper: .esoc0932a.jpg config-wallpaper-$(OS_NAME) ## Set my default wallpaper
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


#include .config/Makefile
