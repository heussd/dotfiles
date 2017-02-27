# dotfiles
In the great tradition of sharing dotfiles, this repository contains configuration files for third party software to meet my demands. 


## Initial Setup

	git clone https://github.com/heussd/dotfiles .
	git submodule update --init --remote _externals/
	brew bundle -v --file="brew/Brewfile"
	stow -v --dir=$(pwd) --target=../../. --ignore=README.md [^_]*/

## Updating
	git fetch --all && 	git reset --hard origin/master
	git submodule update --init --remote _externals/
	stow -v --dir=$(pwd) --target=../../. --ignore=README.md [^_]*/