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
  brew "coreutils"
  brew "ctop"
  brew "eza" # a fork of the discontinued exa
  brew "git-delta"
  brew "git-gui"		# gitk
  brew "git-lfs"
  brew "lazygit"
  brew "markdownlint-cli"
  cask "appcleaner"
  cask "firefox"
  cask "finicky"
  cask "font-sauce-code-pro-nerd-font"
  cask "hammerspoon"
  cask "keka"
  cask "kitty"
  cask "iina"
  cask "onedrive"
  cask "sourcetree"
  cask "syntax-highlight"
  brew "rclone"
  brew "pipx"
  
  tap "marwanhawari/tap"
  brew "stew"
 
end


if system 'hostname | grep "DE_" > /dev/null'
 
  brew "dive"
  cask "1password"
  cask "1password-cli"
  cask "bruno"
  cask "docker"
  cask "visual-studio-code"
  cask "microsoft-teams"
  cask "keepassxc"
  cask "cryptomator"
  cask "maestral"
  brew "gh" # GitHub cli
  brew "gnupg"

elsif system 'hostname | grep "AU_" > /dev/null'

  brew "rclone"
  brew "jq"	# jq is a lightweight and flexible command-line JSON processor.
  brew "yq"
  brew "zsh-completions"
  cask "adapter" # General purpose video converter
  cask "hammerspoon"
  cask "handbrake"
  cask "maccy"
  cask "macdown"
  cask "clockify"
  brew "the_silver_searcher"
  mas "Disk Graph", id: 697942581
  
  brew "dive"
  brew "hadolint"
  brew "imagemagick"
  brew "nvm"
  brew "shellcheck"
  brew "yarn"
  cask "1password"
  cask "1password-cli"
  cask "bruno"
  cask "docker"
  cask "cursor"
  mas "Boop", id: 1518425043
  mas "Numbers", id: 409203825
  mas "Xcode", id: 497799835
  cask "clockify"
  cask "microsoft-teams"
  mas "MeetingBar", id: 1532419400

  cask "microsoft-azure-storage-explorer"

elsif system 'hostname | grep "kabylake" > /dev/null'

  brew "podman"
  cask "steam"
  cask "thunderbird"

else

if system 'uname -s | grep "Darwin" > /dev/null'
  brew "htop"
  brew "jq"	# jq is a lightweight and flexible command-line JSON processor.
  brew "newsboat"
  brew "p7zip"
  brew "rclone"
  brew "the_silver_searcher"
  brew "watch"
  brew "wget"
  brew "yq"
  brew "yt-dlp"
  brew "zsh-completions"
  cask "keepassxc"
  cask "keka"
  cask "kitty"
  cask "knockknock"
  cask "obs" # Open-source software for live streaming and screen recording.
  cask "sourcetree"
  cask "syntax-highlight"
  cask "tiles"
  #cask "tor-browser" # Unauthorised
  #cask "transmission" # Unauthorised 
  cask "visual-studio-code"
  #cask "whatsapp" # Unauthorised
  cask "zed"
  mas "Disk Graph", id: 697942581
  
  tap "marwanhawari/tap"
  brew "stew"
  
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

  #brew "node"
  #cask "azure-data-studio"
  #cask "dozer" # Replaced by ICE
  #cask "kdiff3" deprecated, replaced with vscode
  #cask "meld" # deprecated, replaced with kdiff
  #cask "microsoft-azure-storage-explorer"
  #cask "postman" # RIP, replaced by bruno
  brew "az"
  brew "dive"
  brew "hadolint"
  brew "imagemagick"
  brew "k9s"
  brew "kubectx"
  brew "nvm"
  brew "shellcheck"
  brew "sops"
  brew "yarn"
  cask "1password"
  cask "1password-cli"
  cask "bruno"
  cask "camunda-modeler"
  cask "cyberduck"
  cask "db-browser-for-sqlite"
  cask "devtoys"
  cask "docker"
  cask "gephi"
  cask "gimp"
  cask "google-cloud-sdk"
  cask "hex-fiend"
  cask "imageoptim"
  cask "inkscape"
  cask "jetbrains-toolbox"
  cask "jordanbaird-ice"
  cask "libreoffice"
  cask "cursor"
  mas "Boop", id: 1518425043
  mas "CotEditor", id: 1024640650
  mas "GIPHY CAPTURE", id: 668208984
  mas "Numbers", id: 409203825
  mas "Xcode", id: 497799835
  
  tap "Azure/kubelogin"
  brew "kubelogin"
  
  tap "nats-io/nats-tools"
  brew "nats-io/nats-tools/nats"
      
  
  cask "clockify"
  #cask "itsycal" replaced by Hammerspoons menu entry
  cask "microsoft-edge"
  cask "microsoft-teams"
  mas "MeetingBar", id: 1532419400
end

end
