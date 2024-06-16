# Software I like
#
# When changing this file, you might also want to change these files:
# ~/.macos-dock
#

tap "homebrew/bundle"
#tap "homebrew/cask-versions"
#tap "buo/cask-upgrade" # CU command


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


## kabylake - pre decommissioning
if system 'hostname | grep "kabylake" > /dev/null'

brew "git"
brew "newsboat"
cask "cryptomator", greedy: true
cask "firefox"
cask "hammerspoon"
cask "keepassxc"
cask "kitty"
cask "maestral"
cask "appcleaner"
cask "vlc"
brew "lazygit"
brew "rclone"

cask "font-monaspace"

mas "Disk Graph", id: 697942581
brew "p7zip"
cask "thunderbird"

cask "signal"

else


## macOS apps
if system 'uname -s | grep "Darwin" > /dev/null'


## Essentials
cask "kitty"
brew "git"
brew "git-delta"
brew "git-lfs"
brew "git-gui"		# gitk
cask "macdown"
cask "sourcetree"
cask "firefox"
#cask "macvim"
cask "keepassxc"
cask "keka"
cask "visual-studio-code"
brew "watch"
brew "yt-dlp"
brew "bat"
brew "pipx"


## Command line tools
#brew "bat"
#brew "glow" # Render markdown on the CLI
brew "eza" # a fork of the discontinued exa
brew "w3m"
brew "yq"
#brew "brew-cask-completion"
brew "choose-gui"
brew "coreutils"
brew "ctop"
brew "gnupg"
brew "htop"
#brew "howdoi"
brew "newsboat"
brew "the_silver_searcher"
brew "thefuck"
#brew "transcrypt"
brew "wget"
brew "p7zip"
#brew "sqlite"
brew "jq"	# jq is a lightweight and flexible command-line JSON processor.
#brew "terminal-notifier"
brew "markdownlint-cli"
brew "lazygit"
brew "rclone"


## Cloud File Sync
cask "maestral"
cask "cryptomator", greedy: true


## Power Tools
cask "finicky"
cask "fluor"
brew "btop"
brew "zsh-completions"
cask "appcleaner"
cask "betterzip"
cask "dozer"
cask "dupeguru"
cask "easy-move-plus-resize"
cask "hammerspoon"
cask "knockknock"
cask "maccy"
cask "tiles"
cask "tor-browser"
cask "transmission"
brew "imagemagick"
mas "Disk Graph", id: 697942581
#mas "Ka-Block!", id: 1335413823
#mas "OwlOCR", id: 1499181666
#mas "SleepTime", id: 465772885

tap "marwanhawari/tap"
brew "stew"


## Fonts
brew "svn" ## Dependency of font-open-sans
cask "font-open-sans"
cask "font-sauce-code-pro-nerd-font"
cask "font-humor-sans"
cask "font-monaspace"

 
## Drivers
tap "homebrew/cask-drivers"
cask "logi-options-plus"
 
 
## Office
#mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
cask "itsycal"
cask "google-drive"
cask "microsoft-edge"
cask "clockify"
mas "MeetingBar", id: 1532419400
cask "libreoffice"

 
## Voice / Com
cask "signal"
cask "microsoft-teams"
 
 
 ## Image
cask "gimp"
cask "inkscape"
mas "GIPHY CAPTURE", id: 668208984

cask "imageoptim"


# # Audio / Video
cask "vlc"
cask "stolendata-mpv" # https://github.com/orgs/Homebrew/discussions/5270
cask "handbrake"
cask "adapter" # General purpose video converter


## QuickLook
cask "syntax-highlight", greedy: true

 
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
cask "yed"
mas "CotEditor", id: 1024640650
#brew "helm"
cask "devtoys"
mas "Boop", id: 1518425043
brew "terraform"
brew "shellcheck"
brew "hadolint"
#cask "dotnet-sdk"


tap "Azure/kubelogin"
brew "kubelogin"


## nats
tap "nats-io/nats-tools"
brew "nats-io/nats-tools/nats"

#tap "azure/functions"
#brew "azure-functions-core-tools@4"

end

end



#brew "podman"
#cask "balenaetcher" # USB Flash tool
#cask "raspberry-pi-imager"
#brew "figlet"
#cask "sweet-home3d"
#cask "playonmac"
#cask "teamviewer"
#cask "qgis"
#


## Games
#cask "steam"
#cask "discord"
#cask "epic-games"
#cask "battle-net"


## Safari
#mas "AdGuard for Safari", id: 1440147259
