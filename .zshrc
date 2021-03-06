#if [ -z $TMUX ]; then;
#	tmux -u;
#	exit
#fi


[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

# Set the default plugin repo to be zsh-utils
antigen use belak/zsh-utils

# Specify completions we want before the completion module
antigen bundle zsh-users/zsh-completions

# Specify plugins we want
antigen bundle editor
antigen bundle history
antigen bundle utility
antigen bundle completion
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Specify additional external plugins we want
antigen bundle smallhadroncollider/antigen-git-rebase
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle hchbaw/auto-fu.zsh

auto-ls-ls-extended() {
  ls -ltr
}

AUTO_LS_COMMANDS=(ls-extended)
antigen bundle desyncr/auto-ls
antigen bundle Cloudstek/zsh-plugin-appup
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zdharma/fast-syntax-highlighting

antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
export SPACESHIP_KUBECTL_SHOW=false
export SPACESHIP_KUBECTL_VERSION_SHOW=false
export SPACESHIP_KUBECONTEXT_SHOW=false

# Load everything
antigen apply

# Better completion, taken from https://meabed.com/zsh-oh-my-zsh-up-and-running/
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' verbose true
zstyle ':completion:*' menu yes select=1
zstyle ':completion:*' substitute 0
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*' original true
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' file-sort links reverse
zstyle ':completion:*:commands' rehash true
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' matcher-list '' '+m:{a-z}={A-Z} r:|[._-]=* r:|=*' '' 'l:|=* r:|=*'
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==36=36}:${(s.:.)LS_COLORS}")';

zstyle ':filter-select:highlight' matched fg=red
zstyle ':filter-select' max-lines 1000
zstyle ':filter-select' rotate-list yes
zstyle ':filter-select' case-insensitive yes # enable case-insensitive searchhttps://github.com/tideflow-io/tideflow



export PATH=$PATH:~/.scripts

source ~/.shell-aliases
source ~/.docker-aliases

_hasFile ~/.fzf.zsh && source ~/.fzf.zsh

# https://gist.github.com/phette23/5270658#gistcomment-1265682
precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

# https://www.arp242.net/zshrc.html
hash -d p="$TH_PROJECTS_FOLDER" # use ~p in commands, e.g. ls ~p

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A'  up-line-or-beginning-search    # Arrow up
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search  # Arrow down
bindkey '^[OB'  down-line-or-beginning-search


# Suffix aliases
#alias -s {sh,css,js,ts,html,md,txt}=code


# https://dev.to/ecologic/using-keyboard-shortcuts-with-zsh-16b

# Hotkey for git pull (ctrl-p)
function gitpull() {
  gitcmd="git"
  if [ "$PWD" = "$HOME" ]; then
    gitcmd="git --git-dir=$HOME/.dotfiles-bare-repo/ --work-tree=$HOME/"
  fi
  gitcmd="$gitcmd pull --tags --recurse-submodules"
  echo $gitcmd
  eval ${gitcmd}
  zle reset-prompt;
  zle redisplay
}
zle -N gitpull
bindkey '^p' gitpull

# Hotkey for git push (ctrl-o)
function gitpush() {
  gitcmd="git"
  if [ "$PWD" = "$HOME" ]; then
    gitcmd="git --git-dir=$HOME/.dotfiles-bare-repo/ --work-tree=$HOME/"
  fi
  gitcmd="$gitcmd push"
  echo $gitcmd
  eval ${gitcmd}
  zle reset-prompt;
  zle redisplay
}
zle -N gitpush
bindkey '^o' gitpush

function openThis() {
	open .
	zle reset-prompt
	zle redisplay
}
zle -N openThis
bindkey '^f' openThis


function openCode() {
	code .
	zle reset-prompt
	zle redisplay
}
zle -N openCode
bindkey '^k' openCode

export NVM_DIR="/usr/local/opt/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


[ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/ ] && (
  export CLOUDSDK_PYTHON="/usr/local/opt/python@3.8/libexec/bin/python"
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
)


# Set Kitty tab name automatically
# https://github.com/kovidgoyal/kitty/issues/610

function set-title-precmd() {
  printf "\e]2;%s\a" "${PWD/#$HOME/~}"
}

function set-title-preexec() {
  printf "\e]2;%s\a" "$1"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-title-precmd
add-zsh-hook preexec set-title-preexec


# Alt Arrow to move by word
# https://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh#16411270
bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word


function homesync() {
  home sync
}
zle -N homesync
bindkey "^s" homesync


source ~/.shell-motd
# Avoid recursive calls by checking the pane number
#if (( $(tmux list-panes | wc -l) == 1)); then
#	tmux split-window -p 30 \; send-keys 'source ~/.shell-motd; sleep 3; exit' C-m \; last-pane;
#fi
