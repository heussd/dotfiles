# Say hi to your new home

	git clone https://github.com/heussd/dotfiles ~/dotfiles
	brew bundle -v --file="$HOME/dotfiles/brew/Brewfile"
	stow --dir="$HOME/dotfiles/" -vv bash