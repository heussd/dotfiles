# Try to resume screen session
if [ $TERM != 'screen' ]; then
  if [[ ! `screen -r` ]]; then
    exit
  fi
fi

# https://github.com/twerth/dotfiles/blob/master/etc/bash_profile
# Identify OS and Machine -----------------------------------------
export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export OSVERSION=`uname -r`; OSVERSION=`expr "$OSVERSION" : '[^0-9]*\([0-9]*\.[0-9]*\)'`
export MACHINE=`uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export PLATFORM="$MACHINE-$OS-$OSVERSION"

# https://github.com/rizumu/rizumu-dotfiles/blob/master/bash/env.sh
_have() { which "$1" &>/dev/null; }

# Path to this file
case $OS in
  "darwin")
    export PATH=$PATH:~/$(dirname "${BASH_SOURCE[0]}")
    [[ -d ~/$(dirname "${BASH_SOURCE[0]}")/scripts/ ]] && export PATH=$PATH:~/$(dirname "${BASH_SOURCE[0]}")/scripts/
    ;;
  "linux")
    export PATH=$PATH:$(dirname "${BASH_SOURCE[0]}")
    [[ -d $(dirname "${BASH_SOURCE[0]}")/scripts/ ]] && export PATH=$PATH:$(dirname "${BASH_SOURCE[0]}")/scripts/
    ;;
esac
[[ -d ~/scripts ]] && export PATH=$PATH:"~/scripts"
[[ -d ~/Dropbox/scripts/ ]] && export PATH=$PATH:"~/Dropbox/scripts/"

export EDITOR='vim'

case "$OS" in "linux")

  alias ls='ls --color=auto' # For linux, etc
  alias startx='exec startx'

  # Started within a X-Server?
  if [ `set | grep WINDOWID` ]; then
  	alias vim='gvim'
  fi
  
  # Gentoo only
  _have emerge && ( 
    alias emerge='emerge -vp'
    alias unmerge='emerge -va --unmerge'
    alias lsflaws='glsa-check -l affected'
    alias fixflaws='sudo glsa-check -f affected'
    # deprecated - use "euse -i" instead
    #alias descuse='cat /usr/portage/profiles/use.desc | grep '
  )
  
  _have trayer && alias trayer='trayer --edge top --align right --widthtype request --heighttype request --transparent true --alpha 255 --SetPartialStrut false --SetDockType false'
  ;;
  "darwin")
  
  alias grep='grep --color'
  alias ls='ls -G'
  alias say='say -v Vicki'
  alias top='top -o cpu'

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

  _have mpd && alias mpd='mpd ~/.mpd/mpd.conf'
  _have mvim && alias vim="mvim"
  [ -e '/Applications/VLC.app/Contents/MacOS/VLC' ] && alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

  ;;
  default) echo "unsupported os!"
esac

# Basic Unix commands
alias ...='cd ../..'
alias ..='cd ..'
alias KILL='sudo kill -9'
alias RM='rm -Rfv'
alias cd...='cd ../..'
alias cd..='cd ..'
alias cp='cp -v'
alias df='df -h'
alias df='df -h'
alias du='du -h'
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias f='find . -iname'
alias free='free -lm'
alias g='egrep --color=auto -i'
alias grep='g'
alias halt='sudo halt'
alias l='ls -lh'
alias la='ls -lAh'
alias lla='ls -lah'
alias lsd='ls -l | egrep -e "^d"'
alias m='more'
alias mv='mv -v'
alias path='echo $PATH'
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"
alias reboot='sudo reboot'
alias reloadbash="source ~/.bashrc"
alias systail='tail -f /var/log/system.log'

alias unmount='umount'

_have jmp && alias einfach='jmp chriz emo && jmp 24'
_have lynx && alias tv='lynx --dump --nolist http://text.hoerzu.de/tv-programm/jetz.php'
_have mpc && alias mpl='mpc playlist'
_have rdesktop && alias rdesktop='rdesktop -g 1280x1024'
alias gcp='rsync --update --progress --human-readable'
alias nofatcks='du -akx | sort -nr | less'
alias tarit='tar -cjfv'
alias un7zip='7z x'
alias vlc='vlc --advanced'
alias vlcrip="vlc --video-filter scene -V dummy --scene-ratio=3 --scene-path=Scenes"

# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

#export LC_ALL="de_DE.utf8"
#export LANG="de_DE.utf8@euro"
export MPD_HOST=localhost
export BROWSER="firefox"

export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export HISTCONTROL=ignoredups


# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab

shopt -s cdable_vars # set the bash option so that no '$' is required when using the above facility
shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns


# Turn on advanced bash completion if the file exists (get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# Teh end - enable host specific settings
[[ -e ${BASH_SOURCE[0]}.$HOSTNAME ]] && source ${BASH_SOURCE[0]}.$HOSTNAME

