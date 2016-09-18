# dotfiles
In the great tradition of sharing dotfiles, this repository contains configuration files for third party software to meet my demands. 


## Initial Setup

	mkdir -p ~/dotfiles
	cd ~/dotfiles
	git clone https://github.com/heussd/dotfiles .
	git submodule update --init --remote _externals/
	brew bundle -v --file="brew/Brewfile"
	stow -Rv [^_]*/

## Updating
	cd ~/dotfiles
	git fetch --all && 	git reset --hard origin/master
	git submodule update --init --remote _externals/
	stow -Rv [^_]*/