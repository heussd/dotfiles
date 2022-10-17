SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
MAKEFLAGS	+= -s
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)


FONT	:= Source Code Pro
SIZE	:= 13
CSS	:= Timm's Way to View Things


auto-config: Makefile
	$(MAKE) $(OS_NAME)
	$(MAKE) $(HOME)/.ssh/id_rsa.pub

	touch auto-config
	#@-~/Library/startup.command


$(HOME)/.ssh/id_rsa.pub:
	ssh-keygen -f $(HOME)/.ssh/id_rsa -P "" -v



transcrypt: ## Setup transcrypt for dotfiles
	@cd $(DOTFILES_BARE) && transcrypt -c aes-256-cbc -p '$(shell stty -echo; read -p "Password: " pwd; stty echo; echo $$pwd)'
.PHONY: transcrypt


wallpaper: .esoc0932a.jpg wallpaper-$(OS_NAME) ## Set up wallpaper
.PHONY: wallpaper wallpaper-linux wallpaper-darwin
.esoc0932a.jpg:
	@wget https://cdn.eso.org/images/large/eso0932a.jpg -O .esoc0932a.jpg
wallpaper-linux:
	@feh --bg-scale .esoc0932a.jpg
wallpaper-darwin:
	@osascript -e 'tell application "System Events" to tell every desktop to set picture to ((path to home folder as text) & ".esoc0932a.jpg")'


add-ssh-key-pass: $(HOME)/.ssh/id_rsa.pub ## Adds a passphrase to local ssh keys
	@ssh-keygen -p -f ~/.ssh/id_rsa
.PHONY: add-ssh-key-pass


.PHONY: git-over-ssh
git-over-ssh: ## Tells git to use SSH connections for GitHub / GitLab / BitBucket
	@ln -s $(HOME)/.git-over-ssh $(HOME)/.git-over-ssh-enabled


zsh-default: ## Set ZSH as default
	@chsh -s $(which zsh) $(whoami)
.PHONY: zsh-default




darwin: \
	prep-darwin \
	login-items \
	macos-lockscreen \
	macos-settings \


prep-darwin:
	@-killall "System Preferences" > /dev/null
	@echo "Requesting sudo password"
	@sudo echo

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



define openApp
	echo "opening app is disable right now..."
	#@echo "We'll open $(1) to create initial config file, then kill it again."
	#@open --background -a $(1)
	#@sleep 3
	#@killall $(1)
endef



.PHONY: macos-lockscreen
macos-lockscreen: ## Set a lost and found message and contact info on the lockscreen
	@sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "If you found this device, please contact $$(osascript -e 'tell application "Contacts" to get value of email 1 of my card') / $$(osascript -e 'tell application "Contacts" to get value of phone 1 of my card')"
	#@tccutil reset AddressBook


reset-firefox-permissions:
	tccutil reset Microphone org.mozilla.firefox
	tccutil reset Camera org.mozilla.firefox
	

login-items:
	osascript -e 'tell application "System Events"' \
		-e 'repeat with i in (get the name of every login item)' \
		-e 'delete login item i' \
		-e 'end repeat' \
		-e 'end tell'
	sudo xattr -cr "$$HOME/Library/startup.command"
	osascript -e "tell application \"System Events\" to make login item at end with properties {path:  POSIX path of (path to home folder) & \"/Library/startup.command\", hidden:false}"



linux:
	@:

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

.PHONY: linux-apt-no-sudo-passwd
linux-apt-no-sudo-passwd: ## Allow using apt without a sudo password
	echo "%sudo   ALL=(ALL:ALL) NOPASSWD:/usr/bin/apt" | sudo tee /etc/sudoers.d/010_apt-nopasswd

.PHONY: linux-disable-unattended-updates
linux-disable-unattended-updates: ## Disable unattended updates on Linux hosts
	sudo cp /usr/share/unattended-upgrades/20auto-upgrades-disabled /etc/apt/apt.conf.d/
