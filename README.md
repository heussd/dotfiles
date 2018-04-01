# dotfiles
In the great tradition of sharing dotfiles this repository contains various configuration files for Unix and Linux software. 



	git clone github.com:heussd/dotfiles .dotfiles
	# HTTPS
	# git clone https://github.com/heussd/dotfiles .dotfiles
	cd ~/.dotfiles
	mkdir ~/.scripts
	source "$(uname -s).md"
	
	
	brew bundle install -v
	./stow-dotfiles dotfiles
	