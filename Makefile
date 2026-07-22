SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
#MAKEFLAGS     	 += --silent
HOST          	 := $$(hostname | cut -d"." -f 1)
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)
DOTFILES_BARE 	 := $(HOME)/.dotfiles-bare-repo/

ifneq ("$(wildcard .auto-lock)", "")
locked:
	$(info Auto Makefile operation is locked through file .auto-lock)
endif


auto: \
	lock \
	delete-old-states \
	pull-dotfiles \
	.Brewfile.auto
	@[ -f ".auto-lock" ] && rm .auto-lock || true

lock:
	@touch .auto-lock

pull-dotfiles:
	@find "$(DOTFILES_BARE)/FETCH_HEAD" -mmin +$$((7*24*60)) \
 		-exec bash -c "git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ pull --recurse-submodules ; touch $(DOTFILES_BARE)/FETCH_HEAD" \; ;\


.Brewfile.auto: .config/homebrew/Brewfile
	@-command -v brew &> /dev/null && \
		HOMEBREW_CASK_OPTS="--require-sha" \
		brew update && \
		brew bundle install --jobs=4 --force --global --verbose && \
		brew bundle cleanup --all --zap --force --global && \
		command -v uv &> /dev/null && uv tool upgrade --all || true && \
		command -v npm &> /dev/null && npm update -g || true && \
		command -v code &> /dev/null && code --update-extensions || true && \
		touch .Brewfile.auto


delete-old-states:
	@find "$$HOME" \
		-maxdepth 1 -mmin +$$((2*24*60)) \
		\( \
		-name ".Brewfile.auto" \
		\) \
		-delete


clean-all:
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


clean-downloads:
	@find ~/Downloads -maxdepth 1 -mtime +30 -exec mv -v {} ~/.Trash/ \;
.PHONY: clean-downloads


vpn:
	togglevpn


kill:
	@sudo -v
	@-pkill -f "DisplayLink Manager"
	@-pkill -f "printscout-ui"
	@-sudo pkill -f "OneDrive"

stop:
	@-container stop --all
	@-container rm --all --force
	@-podman stop --all
	@-podman rm --all --force
	@-podman machine stop

