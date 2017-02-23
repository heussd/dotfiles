# Try to resume screen session
if [ $TERM != 'screen' ]; then
  if [[ ! `screen -r` ]]; then
    #exit
    echo "Screen resume not implemented"
  fi
fi

# https://github.com/rizumu/rizumu-dotfiles/blob/master/bash/env.sh
_has() { which "$1" &>/dev/null; }

# Commonly used programs
export BROWSER="firefox"
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export HISTCONTROL=ignoredups
export EDITOR='vim'
export LC_ALL=C
shopt -s checkwinsize


# Setup some colors to use later in interactive shell or scripts
# Source: http://github.com/twerth/dotfiles/blob/master/etc/bashrc
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'


# Colorize the Terminal
export CLICOLOR=1;
export LSCOLORS=ExFxCxDxBxegedabagacad
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "


# Fine-tuning basic Unix commands
alias ...='cd ../..'
alias ..='cd ..'
alias KILL='sudo kill -9'
alias RM='rm -Rfv'
alias cp='cp -v'
alias df='df -h'
alias du='du -h'
alias grep='grep --color'
alias halt='sudo halt'
alias l='ls -lh'
alias la='l -A'
alias ls='ls -G'
alias lsd='ls -l | egrep -e "^d"'
alias mv='mv -v'
alias reboot='sudo reboot'
alias top='top -o cpu'


# Path additions
 [[ -d $(dirname "${BASH_SOURCE[0]}")/scripts/ ]] && export PATH=$PATH:$(dirname "${BASH_SOURCE[0]}")/scripts/


# Tiny tools
alias rmEmtpyFolders='find . -type d -empty -exec rmdir "{}" \;'
alias rmdsstore="find . -name '*.DS_Store' -type f -delete"


# Third party commands
_has rsync && alias gentlecp='rsync --update --progress --human-readable'
_has thefuck && eval "$(thefuck --alias)"
_has stow && alias stow='stow --dir="$HOME/dotfiles/" --ignore=README.md -v'


# Enable and configure bash completion
# Taken from https://gist.github.com/holywarez/578695
bind "set completion-ignore-case on"
bind "set bell-style none"
bind "set show-all-if-ambiguous On"


# Load OS specific bash settings
[[ -e "${BASH_SOURCE[0]}."`uname -s` ]] && source "${BASH_SOURCE[0]}.`uname -s`"
# Load Host specific bash settings
[[ -e ${BASH_SOURCE[0]}.$HOSTNAME ]] && source "${BASH_SOURCE[0]}.$HOSTNAME"


echo
figlet -c `hostname | cut -d"." -f 1`
echo

