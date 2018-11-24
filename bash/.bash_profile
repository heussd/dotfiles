# Try to resume screen session - currently disabled
#if [ $TERM != 'screen' ]; then
#  if [[ ! `screen -r` ]]; then
#    #exit
#    echo "Screen resume not implemented"
#  fi
#fi

# https://github.com/rizumu/rizumu-dotfiles/blob/master/bash/env.sh
_has() { which "$1" &>/dev/null; }


_hasFolder() { if [ -d "$1" ]; then return 0; fi; return 1; }


# Commonly used programs
export BROWSER="firefox"
export TERM=xterm-color


# https://github.com/mathiasbynens/dotfiles/blob/master/.exports
# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';


export EDITOR='vim'
export LC_ALL=C


# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;


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
alias SRM='sudo rm -Rfv'
alias cp='cp -v'
alias df='df -h'
alias du='du -h'
alias grep='grep --color'
alias halt='sudo halt'
alias l='ls -lh'
alias ll='l --sort=time'
alias la='l -A'
alias ls='ls -G'
alias lsd='ls -l | egrep -e "^d"'
alias mv='mv -v'
alias reboot='sudo reboot'


# Docker shortcuts
alias dc-UP='docker-compose up --abort-on-container-exit'
alias dc-DOWN='docker-compose down --volumes --remove-orphans'
alias dcl='dc-UP; dc-DOWN'


# Git 
alias g="git"
# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;
git-cosh() { git commit $1 -m "$2"; git push; }
git-submodule-rm() { git submodule deinit -f "$1"; git rm -f "$1"; rm -rf .git/modules/$1; }
git-ROLLBACK() { git fetch origin; git reset --hard origin/master; git clean -fdx; }
git-head-stat() { pushd $1 > /dev/null ; git log --oneline | head -n 1; popd > /dev/null; }
alias gk='gitk --all'
alias gs='git status'
alias gca='git commit --ammend'
alias gb='git branch -v && git remote show origin'
alias gru='git remote update'
alias gp='git pull --rebase origin'


source-if-exist() { [[ -e $1 ]] && source "$1"; }

# http://www.open-source-blog.de/2014/11/17/apple-spezifische-dateien-wie-appledouble-ds_store-etc-loeschen-mittels-find/
rm-macos-temp-files() { find \( -name ".AppleDouble" -or -name ".DS_Store" -or -name ".Trashes" -or -name "._*" -or -name ".TemporaryItems" \) -execdir rm -Rv {} \;; }

# Path additions
 [[ -d $(dirname "${BASH_SOURCE[0]}")/.scripts/ ]] && export PATH=$PATH:$(dirname "${BASH_SOURCE[0]}")/.scripts


# Tiny tools
alias rmEmtpyFolders='find . -type d -empty -exec rmdir "{}" \;'
alias rmdsstore="find . -name '*.DS_Store' -type f -delete"
alias rmsvn="find . -name '*.svn' -type f -delete"
alias noftchcks="du -akx | sort -nr | less"
alias mvn-upgrade='mvn versions:use-next-releases'
alias java-list-imports='find . -iname "*.java" | xargs cat | grep -e "^import" | sort -r | uniq'


# Third party commands
_has rsync && alias gentlecp='rsync --update --progress --human-readable'
_has thefuck && eval "$(thefuck --alias)"
_has stow && alias stow='stow --dir="$HOME/dotfiles/" --ignore=README.md -v'

_hasFolder ".bash-git-prompt" && GIT_PROMPT_ONLY_IN_REPO=1 && source ~/.bash-git-prompt/gitprompt.sh

# Enable and configure bash completion
# Taken from https://gist.github.com/holywarez/578695
bind "set completion-ignore-case on"
bind "set bell-style none"
bind "set show-all-if-ambiguous On"


# Load OS specific bash settings
source-if-exist "${BASH_SOURCE[0]}."`uname -s`


# Load Host specific bash settings
SHORTHOSTNAME=`hostname | cut -d"." -f 1`
source-if-exist "${BASH_SOURCE[0]}.$SHORTHOSTNAME"


# Console prints may be skipped
if [ "$1" != "silent" ]; then

	echo
	figlet -c $SHORTHOSTNAME 2>/dev/null || echo "$SHOTHOSTNAME"
	echo

	# Print status of important folders
	stat-folders() { _hasFolder $1 && printf " %-9s @ %s\n" "$1" "$(git-head-stat $1)"; }
	stat-folders .dotfiles
	echo
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"



# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;


# Shortcuts
alias h="cd ~/"
alias d="cd ~/Documents"
alias dl="cd ~/Downloads"
alias p="cd ~/projects"
