SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
HOST          	 := $$(hostname | cut -d"." -f 1)
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)
DOTFILES_BARE 	 := $(HOME)/.dotfiles-bare-repo/


auto: \
	.auto-pull-dotfiles \
	.auto-Brewfile \
	.auto-Stewfile \
	.auto-requirements.txt \
	.auto-docker-compose.yml \
	.auto-vscode-packages \
	.auto-$(OS_NAME) \
	delete-old-states

.auto-pull-dotfiles:
	@find "$(DOTFILES_BARE)/FETCH_HEAD" -mmin +$$((7*24*60)) \
 		-exec bash -c "git --git-dir=$(DOTFILES_BARE) --work-tree=$(HOME)/ pull --recurse-submodules --quiet; touch $(DOTFILES_BARE)/FETCH_HEAD" \; ;\


.auto-linux: .auto-apt-packages

.auto-apt-packages: .apt-packages
	xargs -d '\n' -- sudo apt-get install -y < .apt-packages
	@touch .auto-apt-packages


.auto-darwin: .auto-macos-dock .auto-macos-defaults


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


.auto-Brewfile: .Brewfile
	@-command -v brew &> /dev/null && \
		HOMEBREW_CASK_OPTS="--no-quarantine --require-sha" \
		brew update && \
		brew bundle install -v --cleanup --force --file=.Brewfile && \
		brew upgrade && \
		touch .auto-Brewfile

.auto-Stewfile: .Stewfile
	@-command -v stew && \
		stew install .Stewfile && \
		touch .auto-Stewfile

.auto-requirements.txt: .requirements.txt
	@-command -v pip3 && \
		pip3 install --user --upgrade --requirement .requirements.txt && \
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


delete-old-states:
	@find "$$HOME" \( \
		-name ".auto-Brewfile" -o \
		-name ".auto-requirements.txt" \
		\) \
		-maxdepth 1 -mmin +$$((7*24*60)) \
		-delete \
		-exec echo "{} was outdated and has been removed." \;

