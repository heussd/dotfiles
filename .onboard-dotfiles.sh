#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

OS_NAME=$( uname -s | tr '[:upper:]' '[:lower:]')
OS_ARCH=$( uname -m )


function installHomebrew {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
}

function coGitBare {
	DOTFILES_REPO="$1"
	DOTFILES_WORKDIR="$2"
	DOTFILES_BARE="$2/$3"

	git clone --bare "$DOTFILES_REPO" "$DOTFILES_BARE/"
	git --git-dir="$DOTFILES_BARE" config --local status.showUntrackedFiles no
	git --git-dir="$DOTFILES_BARE" config --local core.sparseCheckout true

	# Include everything
	echo "/*" > "$DOTFILES_BARE/info/sparse-checkout"
	# Exclude readme
	echo "!/Readme.md" >> "$DOTFILES_BARE/info/sparse-checkout"

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


if ! command -v "git" &> /dev/null; then
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
else
	echo "Skipping basics installation as they are already installed."
fi

cd "$HOME" || exit 1


if ! command -v "brew" &> /dev/null; then
	case "$OS_ARCH" in
		aarch64)
			echo "Skipping homebrew installation as it is unsupported on $OS_ARCH"
			echo "https://docs.brew.sh/Homebrew-on-Linux#arm-unsupported"
			;;
		*)
			installHomebrew
			;;
	esac
else
	echo "Skipping homebrew installation as it is already installed."
fi


if [ ! -d ".dotfiles-bare-repo/" ]; then
	coGitBare "https://github.com/heussd/dotfiles.git" "$HOME/" ".dotfiles-bare-repo/"
	echo "Onboarding complete. Re-execute for private dotfiles."
else
	echo "Skipping dotfiles onboarding as it is already onboarded"
fi


if [ ! -d ".dotfiles-private-bare-repo/" ]; then
	coGitBare "https://github.com/heussd/dotfiles-private" "$HOME/" ".dotfiles-private-bare-repo/"
else
	echo "Skipping private dotfiles onboarding as it is already onboarded"
fi
