#!/usr/bin/env bash

installHomebrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
}


# Taken from https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script/18434831#answer-18434831
case $(uname | tr '[:upper:]' '[:lower:]') in
  darwin*)
	xcode-select --install
	installHomebrew
	;; 
  linux*)
  	sudo apt install -y curl make git
  	installHomebrew
  	;;
  *)
	echo "Unsupported OS: $(uname)"
	exit 1
	;;
esac


cd "$HOME" || exit 1
curl -fsSL https://raw.githubusercontent.com/heussd/dotfiles/main/.config/Makefile | make -f - onboard
