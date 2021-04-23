ifneq ("$(OS_NAME)","linux")
$(error This Makefile is supposed to be included on linux systems only)
endif

FIREFOX_PROFILES_LOCATION=$$HOME/.mozilla/firefox/



.auto-install-linux: .auto-install-apt .Brewfile.linux | check-time-last-installed
	@export HOMEBREW_CASK_OPTS="--no-quarantine"
	@printf "\e[1;34m[Home Makefile]\e[0m Brew bundle install...\n"
	@brew bundle install -v --cleanup --force --file=.Brewfile.linux
	@touch .auto-install-linux


.auto-install-apt: .apt-packages-base
# https://stackoverflow.com/questions/25391307/pipes-with-apt-package-manager#25391412
	@xargs -d '\n' -- sudo apt-get install -y < .apt-packages-base
	@touch .auto-install-apt

config-linux:
	@echo "No config!"


wallpaper-linux:
	@feh --bg-scale .esoc0932a.jpg


########################################################################


.PHONY: install-docker
install-docker: ## Install Docker and docker-compose
	@curl -fsSL https://get.docker.com/ -o - | sh
	@sudo usermod -aG docker $(USER)
	@sudo apt-get install -y python3-pip python3-dev
	@sudo pip3 install docker-compose
	docker-compose --version

.PHONY: install-veracrypt
install-veracrypt: ## Install Veracrypt from a PPA
	sudo add-apt-repository ppa:unit193/encryption
	sudo apt update
	sudo apt-get install veracrypt 

.PHONY: install-cryptomator
install-cryptomator: ## Install Cryptomator from a PPA
	sudo add-apt-repository ppa:sebastian-stenzel/cryptomator
	sudo apt update
	sudo apt-get install cryptomator


.PHONY: disable-unattended-updates
disable-unattended-updates: ## Disable unattended updates on Linux hosts
	sudo cp /usr/share/unattended-upgrades/20auto-upgrades-disabled /etc/apt/apt.conf.d/


.PHONY: apt-no-sudo-passwd
apt-no-sudo-passwd: ## Allow using apt without a sudo password
	echo "%sudo   ALL=(ALL:ALL) NOPASSWD:/usr/bin/apt" | sudo tee /etc/sudoers.d/010_apt-nopasswd


.PHONY: lock-keyring
lock-keyring:
	@kill -9 $$(pgrep gnome-keyring-d)
