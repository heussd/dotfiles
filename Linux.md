# Linux / APT

## Update / Upgrade
	sudo apt update 
	sudo apt upgrade -y 

## Install packages

	sudo apt install -y \
		feh \
		glipper \
		gmrun \
		liferea \
		putty \
		rar \
		redshift \
		rxvt-unicode \
		seahorse \
		stow \
		tint2 \
		trayer \
		unrar \
		vim \
		vim-gtk3


## Remove

	sudo apt remove -y \
		flashplugin-installer \
		parole \
		pidgin \
		xfburn
## Clean up

	sudo apt autoremove -y

## Refresh font cache
	fc-cache -fv
