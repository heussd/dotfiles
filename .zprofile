# Duplicate PATH setup for homebrew for certain apps with ZSH-default.
#
# For example, MacVim cannot resolve rg if the following line is not set:

export PATH="/opt/homebrew/bin/:$PATH"

# https://github.com/b4winckler/macvim/wiki/Troubleshooting#for-zsh-users
