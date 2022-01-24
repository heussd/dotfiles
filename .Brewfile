tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"
tap "homebrew/cask-versions"

## Essentials
cask "kitty"
brew "imagemagick"

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
brew "borgbackup"
cask "vorta"


## Command line tools
brew "bat"
brew "exa"
brew "w3m"
brew "brew-cask-completion"
brew "choose-gui"
brew "coreutils"
brew "ctop"
brew "figlet"
brew "fzf"
brew "gnupg"
brew "htop"
brew "howdoi"
brew "mas"
brew "newsboat"
brew "ripgrep"
brew "the_silver_searcher"
brew "thefuck"
brew "transcrypt"
brew "wget"
brew "pandoc"
brew "p7zip"
brew "sqlite"
brew "jq"	# jq is a lightweight and flexible command-line JSON processor.
brew "terminal-notifier"
cask "cyberduck"
cask "db-browser-for-sqlite"
cask "xbar"
cask "gephi"
cask "hex-fiend"
cask "meld"
cask "yed"
mas "CotEditor", id: 1024640650
brew "glab"
brew "gh"			# GitHub-cli
brew "markdownlint-cli"
brew "lazygit"


## Cloud File Sync
cask "dropbox"
cask "cryptomator", greedy: true
cask "macfuse", greedy: true
mas "OneDrive", id: 823766827


## Power Tools
brew "zsh-completions"
cask "appcleaner"
cask "balenaetcher"
cask "betterzip"
cask "bibdesk"
cask "dozer"
cask "dupeguru"
cask "easy-move-plus-resize"
cask "hammerspoon"
cask "knockknock"
cask "maccy"
cask "itsycal"
cask "mendeley"
cask "tabula" 
cask "tiles"
cask "tor-browser"
cask "transmission"
cask "raspberry-pi-imager"
mas "Disk Graph", id: 697942581
mas "Ka-Block!", id: 1335413823
mas "OwlOCR", id: 1499181666
mas "SleepTime", id: 465772885


## Fonts
tap "homebrew/cask-fonts"
brew "svn" ## Dependency of font-open-sans
cask "font-fira-code"
cask "font-fontawesome"
cask "font-jetbrains-mono"
cask "font-open-sans"
cask "font-source-code-pro"
cask "font-sauce-code-pro-nerd-font", greedy: true


## Office
#mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
mas "Pages", id: 409201541
mas "MeetingBar", id: 1532419400
cask "libreoffice-still"


## Voice / Com
cask "discord"
cask "signal"


## Image
cask "pika"
cask "gimp"
cask "imageoptim"
cask "inkscape"
mas "GIPHY CAPTURE", id: 668208984


## Audio / Video
cask "mpv"
cask "vlc"
cask "handbrake"


## QuickLook
cask "syntax-highlight", greedy: true



brew "buildkit"

if system 'hostname | grep "kabylake" > /dev/null'
    cask "Thunderbird"
    cask "steam"
    cask "epic-games"
    cask "sweet-home3d"

    cask "multipass"
    brew "podman"
    brew "lima"
end

if system 'hostname | grep "coffeelake" > /dev/null'
	cask "finicky"
	cask "google-chrome"
	cask "google-drive"
	cask "lens"
	cask "microsoft-edge"
	cask "adobe-acrobat-reader"
	cask "mactex"
	cask "qgis"
	cask "docker"
	cask "webex-meetings"
	brew "dive"
	brew "lazydocker"
	brew "az"
	brew "gradle"
	brew "k9s"
	brew "kubectx"
	brew "maven"
	brew "node"
	brew "sops"
	brew "yarn"
	cask "azure-data-studio"
	cask "camunda-modeler"
	cask "clockify"
	cask "google-cloud-sdk"
	cask "jetbrains-toolbox"
	cask "microsoft-azure-storage-explorer"
	cask "microsoft-teams"
	cask "postman"
	cask "slack"
	mas "Xcode", id: 497799835
end
