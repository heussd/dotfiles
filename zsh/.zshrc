[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

[[ ! -d "$HOME/.zsh-git-prompt" ]] && git clone https://github.com/olivierverdier/zsh-git-prompt "$HOME/.zsh-git-prompt"
source "$HOME/.zsh-git-prompt/zshrc.sh"
PROMPT='%B%m%~%b$(git_super_status) '

# Set the default plugin repo to be zsh-utils
antigen use belak/zsh-utils

# Specify completions we want before the completion module
antigen bundle zsh-users/zsh-completions

# Specify plugins we want
antigen bundle editor
antigen bundle history
antigen bundle prompt
antigen bundle utility
antigen bundle completion
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found


# Specify additional external plugins we want
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle smallhadroncollider/antigen-git-rebase
antigen bundle zsh-users/zsh-autosuggestions

antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

# Load everything
antigen apply

export PATH=$PATH:~/.dotfiles:~/.scripts
source ~/.shell-installs
source ~/.shell-aliases
source ~/.shell-motd
