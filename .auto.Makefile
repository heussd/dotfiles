SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
MAKEFLAGS     	 += --silent
HOST          	 := $$(hostname | cut -d"." -f 1)
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)
DOTFILES_BARE 	 := $(HOME)/.dotfiles-bare-repo/


auto: \
	.auto-pull-dotfiles \
	.auto-Brewfile \
	.auto-Stewfile \
	.auto-pipx \
	.auto-compose.yml \
	.auto-vscode-packages \
	.auto-vscode-settings \
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

.auto-Stewfile: .config/stew/Stewfile
	@-command -v stew &> /dev/null && \
		stew install .config/stew/Stewfile && \
		touch .auto-Stewfile

.auto-requirements.txt: .requirements.txt
	@-command -v pip3 &> /dev/null && \
		pip3 install --user --upgrade --requirement .requirements.txt && \
		touch .auto-requirements.txt

.auto-compose.yml: .compose.yml
	@-command -v docker &> /dev/null && \
		docker compose -f .compose.yml pull && \
		touch .auto-compose.yml

.auto-vscode-packages: .vscode-packages
	@-command -v code &> /dev/null && \
		while read -r package; do \
			code --install-extension "$$package"; \
		done < .vscode-packages && \
		touch .auto-vscode-packages

$(HOME)/Library/Application\ Support/Code/User/settings.json:
	@echo "{}" > "$$HOME/Library/Application Support/Code/User/settings.json"

.auto-vscode-settings: .vscode-settings $(HOME)/Library/Application\ Support/Code/User/settings.json
	@-command -v code &> /dev/null && \
		while read setting; do \
			jq "$$setting" "$$HOME/Library/Application Support/Code/User/settings.json" > tmp; \
			mv tmp "$$HOME/Library/Application Support/Code/User/settings.json"; \
		done < .vscode-settings
	@touch .auto-vscode-settings

.auto-pipx: .pipx-packages
	@-command -v pipx &> /dev/null && \
		while read -r package; do \
			pipx install "$$package" > /dev/null ; \
		done <".pipx-packages" && \
		touch .auto-pipx

delete-old-states:
	@find "$$HOME" \
		-maxdepth 1 -mmin +$$((7*24*60)) \
		\( \
		-name ".auto-Brewfile" -o \
		-name ".auto-compose" -o \
		-name ".auto-pipx" \
		\) \
		-delete \
		-exec echo "{} was outdated and has been removed." \;

