# Software I like
#
# When changing this file, you might also want to change these files:
# ~/.macos-dock
#

tap "homebrew/bundle"


brew "gh" # GitHub cli
brew "neovim"
brew "fzf" # Needed because apt version is too old for vim
brew "ripgrep" # Also needed for vim


## ARM vs. i386

if system 'uname -p | grep "i386" > /dev/null'
  cask "macfuse" # macfuse is still the best choice for non-arm Macs
end

if system 'uname -p | grep "arm" > /dev/null'
  # userspace implementation of FUSE, replaces macfuse
  tap "macos-fuse-t/homebrew-cask"
  cask "fuse-t"
end


if system 'hostname | grep "kabylake" > /dev/null'
  cask "thunderbird"
  brew "podman"
  #cask "betterzip"
  cask "steam"
  #brew "podman"
  #cask "balenaetcher" # USB Flash tool
  #cask "raspberry-pi-imager"
  #brew "figlet"
  #cask "sweet-home3d"
  #cask "playonmac"
  #cask "teamviewer"
  #cask "qgis"
  ## Games
  #cask "discord"
  #cask "epic-games"
  #cask "battle-net"
end


if system 'uname -s | grep "Darwin" > /dev/null'

#brew "bat"
#brew "brew-cask-completion"
#brew "glow" # Render markdown on the CLI
#brew "howdoi"
#brew "sqlite"
#brew "svn" ## Dependency of font-open-sans
#brew "terminal-notifier"
#brew "transcrypt"
#mas "AdGuard for Safari", id: 1440147259
#mas "Ka-Block!", id: 1335413823
#mas "OwlOCR", id: 1499181666
#mas "SleepTime", id: 465772885
brew "bat"
brew "btop"
brew "choose-gui"
brew "coreutils"
brew "ctop"
brew "eza" # a fork of the discontinued exa
brew "git"
brew "git-delta"
brew "git-gui"		# gitk
brew "git-lfs"
brew "gnupg"
brew "htop"
brew "jq"	# jq is a lightweight and flexible command-line JSON processor.
brew "lazygit"
brew "markdownlint-cli"
brew "newsboat"
brew "p7zip"
brew "pipx"
brew "rclone"
brew "the_silver_searcher"
#brew "thefuck"
brew "watch"
brew "wget"
brew "yq"
brew "yt-dlp"
brew "zsh-completions"
cask "appcleaner"
cask "cryptomator"
cask "dupeguru"
cask "easy-move-plus-resize"
cask "firefox"
cask "fluor"
cask "font-humor-sans"
cask "font-monaspace"
cask "font-monaspace"
cask "font-open-sans"
cask "font-sauce-code-pro-nerd-font"
cask "hammerspoon"
cask "keepassxc"
cask "keka"
cask "kitty"
cask "knockknock"
cask "maccy"
cask "macdown"
cask "maestral"
cask "signal"
cask "sourcetree"
cask "syntax-highlight", greedy: true
cask "tiles"
cask "tor-browser"
cask "transmission"
cask "visual-studio-code"
cask "vlc"
mas "Disk Graph", id: 697942581

tap "marwanhawari/tap"
brew "stew"

cask "onedrive"
brew "glow"


if system 'hostname | grep -v "kabylake" > /dev/null'

cask "finicky"
cask "dozer"
cask "fluor"
 
#mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
cask "itsycal"
#cask "google-drive"
cask "microsoft-edge"
cask "microsoft-edge@beta"
cask "clockify"
mas "MeetingBar", id: 1532419400
cask "libreoffice"
cask "microsoft-teams"
 
 
 ## Image
cask "gimp"
brew "imagemagick"
cask "inkscape"
mas "GIPHY CAPTURE", id: 668208984
cask "imageoptim"


cask "stolendata-mpv" # https://github.com/orgs/Homebrew/discussions/5270
cask "handbrake"
cask "adapter" # General purpose video converter
## Developer
#brew "go"
cask "docker"
brew "dive"
brew "az"
brew "k9s"
brew "kubectx"
#brew "node"
brew "nvm"
brew "sops"
brew "yarn"
#cask "azure-data-studio"
cask "camunda-modeler"
cask "google-cloud-sdk"
cask "jetbrains-toolbox"
#cask "microsoft-azure-storage-explorer"
#cask "postman" # RIP, replaced by bruno
cask "bruno"
cask "insomnia"
mas "Xcode", id: 497799835
cask "cyberduck"
cask "db-browser-for-sqlite"
cask "gephi"
cask "hex-fiend"
#cask "meld" # deprecated, replaced with kdiff
cask "kdiff3"
#cask "yed"
mas "CotEditor", id: 1024640650
#brew "helm"
cask "devtoys"
mas "Boop", id: 1518425043
brew "terraform"
brew "shellcheck"
brew "hadolint"
#cask "dotnet-sdk"
cask "1password"


tap "Azure/kubelogin"
brew "kubelogin"


## nats
tap "nats-io/nats-tools"
brew "nats-io/nats-tools/nats"


end

end

