SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
HOST          	 := $$(hostname | cut -d"." -f 1)
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)


# https://gist.github.com/prwhite/8168133?permalink_comment_id=3456785#gistcomment-3456785
help: 
	@awk 'BEGIN {FS = ":.*##"; printf "\033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


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


include $(HOME)/.config/Makefile


fixreboot: kill hyperkey
	@while read -r app; do \
		osascript -e "id of application \"$$app\"" 2>/dev/null && \
			open --background -a "$$app" || true; \
	done < .macos-autostart


dark:
	#dark-mode
	defaults write -g NSRequiresAquaSystemAppearance -bool true

light:
	defaults write -g NSRequiresAquaSystemAppearance -bool false

toggle-color-mode:
	osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode"



vpn:
	togglevpn


kill:
	@sudo -v
	@-ps ax|grep -i docker|egrep -iv 'grep|com.docker.vmnetd'|awk '{print $$1}'|xargs kill
	@-pkill -f "Maestral"
	@-pkill -f "DisplayLink Manager"
	@-pkill -f "printscout-ui"
	@-pkill -f "FindMe"
	@-sudo pkill -f "OneDrive"
	@sudo launchctl stop com.vastlimits.uberAgent

update:
	rm .auto-*
	make -f .auto.Makefile
