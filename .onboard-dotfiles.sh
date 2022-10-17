#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

OS_NAME=$( uname -s | tr '[:upper:]' '[:lower:]')

function installHomebrew {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
}

function coGitBare {
	DOTFILES_REPO="$1"
	DOTFILES_WORKDIR="$2"
	DOTFILES_BARE="$2/$3"

	echo "$DOTFILES_REPO"
	echo "$DOTFILES_WORKDIR"
	echo "$DOTFILES_BARE"
	echo "$OS_NAME"

	git clone --bare "$DOTFILES_REPO" "$DOTFILES_BARE/"
	git --git-dir="$DOTFILES_BARE" config --local status.showUntrackedFiles no
	git --git-dir="$DOTFILES_BARE" config --local core.sparseCheckout true

	# Include everything
	echo "/*" > "$DOTFILES_BARE/info/sparse-checkout"
	# Exclude readme
	echo "!Readme.md" >> "$DOTFILES_BARE/info/sparse-checkout"

	# Ignore Library folder on Linux
	if [ "$OS_NAME" = "darwin" ]; then
		echo "!Library" >> "$DOTFILES_BARE/info/sparse-checkout"
	fi

	cd "$DOTFILES_WORKDIR"
	# recursive-submodules is limited to git >= 2.13
	# We are doing it the old way here to increase compatibility
	# git --git-dir="$DOTFILES_BARE" --work-tree="$DOTFILES_WORK_DIR/" checkout -f --recurse-submodules
	git --git-dir="$DOTFILES_BARE" --work-tree="$DOTFILES_WORKDIR/" checkout -f
	git --git-dir="$DOTFILES_BARE" --work-tree="$DOTFILES_WORKDIR/" submodule update --init --recursive

	# Manual pull to create FETCH_HEAD
	git --git-dir="$DOTFILES_BARE" --work-tree="$DOTFILES_WORKDIR/" pull
	touch "$DOTFILES_BARE/FETCH_HEAD"
}

case "$OS_NAME" in
  darwin*)
	xcode-select --install || true
	;; 
  linux*)
  	sudo apt install -y curl make git
  	;;
  *)
	echo "Unsupported OS: $(uname)"
	exit 1
	;;
esac


cd "$HOME" || exit 1

installHomebrew
coGitBare "https://github.com/heussd/dotfiles.git" "$HOME/" ".dotfiles-bare-repo/"
coGitBare "https://github.com/heussd/dotfiles-private" "$HOME/" ".dotfiles-private-bare-repo/"
