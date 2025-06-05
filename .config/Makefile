SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
MAKEFLAGS	+= -s
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)


macos-login-items: ## Configure macOS login items
	osascript -e 'tell application "System Events"' \
		-e 'repeat with i in (get the name of every login item)' \
		-e 'delete login item i' \
		-e 'end repeat' \
		-e 'end tell'
	sudo xattr -cr "$$HOME/Library/startup.command"
	osascript -e "tell application \"System Events\" to make login item at end with properties {path:  POSIX path of (path to home folder) & \"/Library/startup.command\", hidden:false}"


macos-lock-autostart: ## Lock auto start items
	@-SetFile -a L "$$HOME/Library/LaunchAgents"
	@-sudo rm /Library/LaunchAgents/*
	@-sudo SetFile -a L "/Library/LaunchAgents"
	@-sudo rm /Library/LaunchDaemons/*
	@-sudo SetFile -a L "/Library/LaunchDaemons"


macos-lockscreen: ## Configure macOS lockscreen
	@sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "If you found this device, please contact $$(osascript -e 'tell application "Contacts" to get value of email 1 of my card') / $$(osascript -e 'tell application "Contacts" to get value of phone 1 of my card')"
	#@tccutil reset AddressBook


git-over-ssh: ## Configure git to prefer SSH
	@ln -s $(HOME)/.git-over-ssh $(HOME)/.git-over-ssh-enabled


zsh-as-default: ## Configure ZSH as default shell
	@chsh -s $(which zsh) $(whoami)


reset-firefox-permissions:
	tccutil reset Microphone org.mozilla.firefox
	tccutil reset Camera org.mozilla.firefox
	

linux-install-docker: ## Install Docker
	@curl -fsSL https://get.docker.com/ -o - | sh
	@sudo usermod -aG docker $(USER)


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
macos-reset-privacy-perms: ## Resets privacy settings
	@tccutil reset Accessibility
	@tccutil reset AddressBook
	@tccutil reset AppleEvents
	@tccutil reset Calendar
	@killall SystemUIServer
	@killall Finder
	@killall Dock


.PHONY: macos-fix-brew
macos-fix-brew: ## Fixes brew warnings, https://github.com/Homebrew/brew/issues/4388#issuecomment-401364773
	@brew cleanup 2>&1 | grep "Warning: Skipping" | awk -F: '{print $$2}' | awk '{print $$2}' | xargs brew upgrade
	@brew cleanup


.PHONY: macos-disable-timemachine-throttling-temporarily
macos-disable-timemachine-throttling-temporarily:
	@sudo sysctl debug.lowpri_throttle_enabled=0


config-wallpaper: .esoc0932a.jpg config-wallpaper-$(OS_NAME) ## Set my default wallpaper
.esoc0932a.jpg:
	@wget https://cdn.eso.org/images/large/eso0932a.jpg -O ~/.esoc0932a.jpg
config-wallpaper-linux:
	@feh --bg-scale .esoc0932a.jpg
config-wallpaper-darwin:
	@osascript -e 'tell application "System Events" to tell every desktop to set picture to ((path to home folder as text) & ".esoc0932a.jpg")'


linux-apt-no-sudo-passwd: ## Allow apt without admin password
	echo "%sudo   ALL=(ALL:ALL) NOPASSWD:/usr/bin/apt" | sudo tee /etc/sudoers.d/010_apt-nopasswd


linux-disable-unattended-updates: ## Disable unattended updates
	sudo cp /usr/share/unattended-upgrades/20auto-upgrades-disabled /etc/apt/apt.conf.d/


hyperkey:
	hidutil property --set \
 		'{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000006D}]}'
 

touchid-sudo:
	# https://apple.stackexchange.com/questions/259093/can-touch-id-on-mac-authenticate-sudo-in-terminal
	sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local

