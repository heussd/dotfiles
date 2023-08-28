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

brew "exa"
brew "git"
brew "git-lfs"
brew "git-delta"
brew "lazygit"
brew "markdownlint-cli"
brew "newsboat"
brew "p7zip"
brew "the_silver_searcher"
brew "transcrypt"
cask "coteditor"
cask "cryptomator", greedy: true
cask "firefox"
cask "hammerspoon"
cask "keepassxc"
cask "keka"
cask "kitty"
cask "maccy"
cask "maestral"
cask "mpv"
cask "tiles"
cask "signal"
cask "appcleaner"
brew "jq"
cask "vlc"

tap "homebrew/cask-fonts"
cask "font-open-sans"
cask "font-sauce-code-pro-nerd-font"

tap "homebrew/cask-drivers"
cask "logitech-options"

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
cask "macvim"
cask "keepassxc"
cask "keka"
cask "visual-studio-code"
brew "watch"


## Command line tools
brew "bat"
brew "glow" # Render markdown on the CLI
brew "exa"
brew "w3m"
brew "yq"
brew "brew-cask-completion"
brew "choose-gui"
brew "coreutils"
brew "ctop"
brew "gnupg"
brew "htop"
brew "howdoi"
brew "newsboat"
brew "the_silver_searcher"
brew "thefuck"
brew "transcrypt"
brew "wget"
brew "p7zip"
brew "sqlite"
brew "jq"	# jq is a lightweight and flexible command-line JSON processor.
brew "terminal-notifier"
brew "markdownlint-cli"
brew "lazygit"
brew "rclone"


## Cloud File Sync
cask "maestral"
cask "cryptomator", greedy: true


## Power Tools
cask "finicky"
brew "btop"
brew "zsh-completions"
cask "appcleaner"
cask "betterzip"
brew "vale"
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
mas "Ka-Block!", id: 1335413823
mas "OwlOCR", id: 1499181666
mas "SleepTime", id: 465772885

tap "marwanhawari/tap"
brew "stew"


## Fonts
tap "homebrew/cask-fonts"
brew "svn" ## Dependency of font-open-sans
cask "font-open-sans"
cask "font-sauce-code-pro-nerd-font"
cask "font-humor-sans"


## Drivers
tap "homebrew/cask-drivers"
cask "logitech-options"


## Office
#mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
cask "itsycal"
cask "google-drive"
cask "microsoft-edge"
cask "adobe-acrobat-reader"
cask "clockify"
mas "MeetingBar", id: 1532419400
cask "libreoffice"
brew "pandoc"

#cask "mactex"


## Voice / Com
cask "signal"
cask "slack"
cask "microsoft-teams"


## Image
cask "gimp"
cask "inkscape"
mas "GIPHY CAPTURE", id: 668208984
mas "ColorSlurp", id: 1287239339
cask "krita"
cask "imageoptim"


## Audio / Video
cask "mpv"
cask "vlc"
cask "handbrake"


## QuickLook
cask "syntax-highlight", greedy: true


## Developer
brew "buildkit"
brew "hugo"
brew "go"
brew "aspell"
cask "docker"
brew "dive"
brew "az"
brew "gradle"
brew "k9s"
brew "kubectx"
brew "maven"
brew "node"
brew "nvm"
brew "sops"
brew "yarn"
cask "azure-data-studio"
cask "camunda-modeler"
cask "google-cloud-sdk"
cask "jetbrains-toolbox"
cask "microsoft-azure-storage-explorer"
cask "postman"
cask "insomnia"
cask "rapidapi"
mas "Xcode", id: 497799835
cask "cyberduck"
cask "db-browser-for-sqlite"
cask "gephi"
cask "hex-fiend"
cask "meld"
brew "glab"
cask "yed"
mas "CotEditor", id: 1024640650
brew "helm"
cask "devtoys"
mas "Boop", id: 1518425043
brew "terraform"


## nats
tap "nats-io/nats-tools"
brew "nats-io/nats-tools/nats"

tap "azure/functions"
brew "azure-functions-core-tools@4"

end

end



#brew "podman"
#cask "balenaetcher" # USB Flash tool
#cask "steam"
#cask "raspberry-pi-imager"
#brew "figlet"
#cask "discord"
#cask "epic-games"
#cask "battle-net"
#cask "sweet-home3d"
#cask "playonmac"
#cask "teamviewer"
#cask "qgis"
