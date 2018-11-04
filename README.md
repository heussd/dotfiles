# dotfiles
In the great tradition of sharing dotfiles, this repository contains various configuration files for Unix and Linux software. 



## Terraform a system within seconds

	git clone --recursive github.com:heussd/dotfiles .dotfiles || git clone --recursive https://github.com/heussd/dotfiles .dotfiles
	
	cd ~/.dotfiles
	source "$(uname -s).md"
	
	for p in bash fonts scripts; do ./stow-dotfiles $p; done
	
	