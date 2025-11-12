# Software I like
#
# When changing this file, you might also want to change these files:
# ~/.macos-dock
#
tap "homebrew/bundle"

brew "git"
brew "fzf" # Needed because apt version is too old for vim
brew "ripgrep" # Also needed for vim

if system 'uname -s | grep "Darwin" > /dev/null'
  brew "bat"
  brew "block-goose-cli"
  brew "coreutils"
  brew "dive"
  brew "eza" # a fork of the discontinued exa
  brew "fzf"
  brew "gh" # GitHub cli
  brew "git-delta"
  brew "git-gui"		# gitk
  brew "git-lfs"
  brew "hadolint"
  brew "jq"	# jq is a lightweight and flexible command-line JSON processor.
  brew "lazygit"
  brew "lazydocker"
  brew "markdownlint-cli"
  brew "nvm"
  brew "pipx"
  brew "rclone"
  brew "shellcheck"
  brew "the_silver_searcher"
  brew "uv"
  brew "yarn"
  brew "yq"
  brew "zsh-completions"
  cask "font-sauce-code-pro-nerd-font"
  cask "onedrive"
  cask "sourcetree"
  cask "visual-studio-code"
  tap "marwanhawari/tap"
  brew "stew"
end

if system 'hostname | grep "^.._" > /dev/null'
  cask "1password"
  cask "microsoft-edge"
  cask "microsoft-teams"
end

if system 'hostname | grep "DE_" > /dev/null'
  brew "gnupg"
  brew "imagemagick"
  cask "appcleaner"
  cask "cryptomator"
  cask "iina"
  cask "keepassxc"
  cask "maestral"
  cask "ollama-app"
  brew "podman"
  brew "podman-compose"

elsif system 'hostname | grep "AU_" > /dev/null'
  cask "cursor"
  cask "bruno"
  cask "docker-desktop"
  cask "microsoft-azure-storage-explorer"

elsif system 'hostname | grep "kabylake" > /dev/null'
  brew "podman"
  cask "steam"
  cask "thunderbird"

  cask "gimp"
  cask "inkscape"

  vscode "dakara.transformer"
  vscode "dotjoshjohnson.xml"
  vscode "esbenp.prettier-vscode"
  vscode "exiasr.hadolint"
  vscode "file-icons.file-icons"
  vscode "formulahendry.auto-close-tag"
  vscode "formulahendry.auto-rename-tag"
  vscode "github.copilot"
  vscode "github.copilot-chat"
  vscode "github.vscode-github-actions"
  vscode "johnpapa.vscode-peacock"
  vscode "ms-azuretools.vscode-docker"
  vscode "ms-vscode-remote.remote-containers"
  vscode "nhoizey.gremlins"
  vscode "redhat.vscode-xml"
  vscode "redhat.vscode-yaml"
  vscode "streetsidesoftware.code-spell-checker"
  vscode "timonwong.shellcheck"
  vscode "yzhang.markdown-all-in-one"

  if system 'uname -p | grep "i386" > /dev/null'
    cask "macfuse" # macfuse is still the best choice for non-arm Macs
  end
  if system 'uname -p | grep "arm" > /dev/null'
    # userspace implementation of FUSE, replaces macfuse
    tap "macos-fuse-t/homebrew-cask"
    cask "fuse-t"
  end

end
