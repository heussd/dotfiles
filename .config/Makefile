SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
MAKEFLAGS	+= -s
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)


$(HOME)/.ssh/id_rsa.pub:
	ssh-keygen -f $(HOME)/.ssh/id_rsa -P "" -v


macos-settings:
	defaults write com.apple.universalaccess reduceMotion 1
	sudo tmutil addexclusion -p /Applications
	sudo tmutil addexclusion -p ~/data
	sudo tmutil addexclusion -p ~/Downloads
	# Homebrew folders
	sudo tmutil addexclusion -p /usr/local/Caskroom
	sudo tmutil addexclusion -p /usr/local/Cellar
	sudo tmutil addexclusion -p /usr/local/Homebrew

	sudo tmutil addexclusion -p "~/Library/Application Support/Steam"
		
	open "Apple Settings.mobileconfig"
	open -b com.apple.systempreferences /System/Library/PreferencePanes/Profiles.prefPane

	# Required to apply keyboard settings
	#osascript -e 'tell application "System Events" to log out'


reset-firefox-permissions:
	tccutil reset Microphone org.mozilla.firefox
	tccutil reset Camera org.mozilla.firefox
	

.PHONY: linux-install-docker
linux-install-docker: ## Install Docker and docker-compose
	@curl -fsSL https://get.docker.com/ -o - | sh
	@sudo usermod -aG docker $(USER)
	@sudo apt-get install -y python3-pip python3-dev
	@sudo pip3 install docker-compose
	docker-compose --version

.PHONY: linux-install-veracrypt
linux-install-veracrypt: ## Install Veracrypt from a PPA
	sudo add-apt-repository ppa:unit193/encryption
	sudo apt update
	sudo apt-get install veracrypt 

.PHONY: linux-install-cryptomator
linux-install-cryptomator: ## Install Cryptomator from a PPA
	sudo add-apt-repository ppa:sebastian-stenzel/cryptomator
	sudo apt update
	sudo apt-get install cryptomator


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
