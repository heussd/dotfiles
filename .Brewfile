# Software I like
#
# When changing this file, you might also want to change these files:
# ~/.macos-dock
#

brew "git"
brew "fzf"	# Needed because apt version is too old for vimwiki
brew "ripgrep"	# Also needed for vim
uv "slmd"

if system 'uname -s | grep "Darwin" > /dev/null'
  brew "bat"
  brew "coreutils"
  brew "dive"
  brew "eza" # a fork of the discontinued exa
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
  brew "rclone"
  brew "shellcheck"
  brew "the_silver_searcher"
  brew "yq"
  brew "zsh-completions"
  cask "font-sauce-code-pro-nerd-font"
  cask "onedrive"
  cask "sourcetree"
  
  #tap "marwanhawari/tap"
  #brew "stew"
  #brew "go"		# Required for go bundle
  #go "github.com/marwanhawari/stew"
  brew "duti"

  uv "pre-commit"
  uv "gita"
  uv "uv"

  cask "visual-studio-code"
  vscode "anweber.httpbook"
  vscode "anweber.vscode-httpyac"
  vscode "dakara.transformer"
  vscode "davidanson.vscode-markdownlint"
  vscode "donjayamanne.githistory"
  vscode "dotjoshjohnson.xml"
  vscode "esbenp.prettier-vscode"
  vscode "exiasr.hadolint"
  vscode "file-icons.file-icons"
  vscode "formulahendry.auto-close-tag"
  vscode "formulahendry.auto-rename-tag"
  vscode "github.copilot-chat"
  vscode "github.vscode-github-actions"
  vscode "github.vscode-pull-request-github"
  vscode "hashicorp.hcl"
  vscode "hediet.vscode-drawio"
  vscode "johnpapa.vscode-peacock"
  vscode "mhutchie.git-graph"
  vscode "ms-azuretools.vscode-containers"
  vscode "ms-azuretools.vscode-docker"
  vscode "ms-python.debugpy"
  vscode "ms-python.python"
  vscode "ms-python.vscode-pylance"
  vscode "ms-python.vscode-python-envs"
  vscode "ms-vscode-remote.remote-containers"
  vscode "nhoizey.gremlins"
  vscode "oderwat.indent-rainbow"
  vscode "pflannery.vscode-versionlens"
  vscode "redhat.vscode-xml"
  vscode "redhat.vscode-yaml"
  vscode "rooveterinaryinc.roo-cline"
  vscode "shd101wyy.markdown-preview-enhanced"
  vscode "streetsidesoftware.code-spell-checker"
  vscode "timonwong.shellcheck"
  vscode "usernamehw.errorlens"
  vscode "yzhang.markdown-all-in-one"

  vscode "charliermarsh.ruff"
  vscode "anthropic.claude-code"

end

if system 'hostname | grep "^.._" > /dev/null'
  cask "1password"
  cask "google-chrome"
  cask "microsoft-teams"
end

if system 'hostname | grep "DE_" > /dev/null'
  brew "gnupg"
  brew "imagemagick"
  cask "appcleaner"
  cask "cryptomator"
  cask "iina"
  cask "maestral"
  brew "podman"
  brew "podman-compose"

elsif system 'hostname | grep "AU_" > /dev/null'
  cask "bruno"
  cask "claude-code"
  cask "docker-desktop"

elsif system 'hostname | grep "kabylake" > /dev/null'
  brew "podman"
  cask "steam"
  cask "thunderbird"

  cask "gimp"
  cask "inkscape"

  if system 'uname -p | grep "i386" > /dev/null'
    cask "macfuse" # macfuse is still the best choice for non-arm Macs
  end
  if system 'uname -p | grep "arm" > /dev/null'
    # userspace implementation of FUSE, replaces macfuse
    tap "macos-fuse-t/homebrew-cask"
    cask "fuse-t"
  end

end

