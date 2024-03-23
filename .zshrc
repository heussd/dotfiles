# profile zsh with zprof
# zmodload zsh/zprof

#if [ -z $TMUX ]; then;
#	tmux -u;
#	exit
#fi

[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

antigen use oh-my-zsh


# Specify plugins we want
antigen bundle editor
antigen bundle history
antigen bundle utility
antigen bundle command-not-found

# Specify additional external plugins we want
antigen bundle zsh-users/zsh-autosuggestions

auto-ls-ls-extended() {
	ls-extended;
	echo ""; # For some reason this is needed to not truncate previous commands output
}
AUTO_LS_COMMANDS=(ls-extended)

antigen bundle desyncr/auto-ls
antigen bundle Cloudstek/zsh-plugin-appup
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zdharma-continuum/fast-syntax-highlighting

antigen theme spaceship-prompt/spaceship-prompt


antigen bundle joshskidmore/zsh-fzf-history-search


export SPACESHIP_KUBECTL_SHOW=false
export SPACESHIP_KUBECTL_VERSION_SHOW=false
export SPACESHIP_KUBECTL_CONTEXT_SHOW=false
export SPACESHIP_GCLOUD_SHOW=false
export SPACESHIP_AZURE_SHOW=false
export SPACESHIP_TERRAFORM_SHOW=false
export SPACESHIP_HOST_SHOW=false
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8a7575"

# Load everything
antigen apply


zstyle ':filter-select:highlight' matched fg=red
zstyle ':filter-select' max-lines 1000
zstyle ':filter-select' rotate-list yes
zstyle ':filter-select' case-insensitive yes # enable case-insensitive searchhttps://github.com/tideflow-io/tideflow



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

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Suffix aliases
#alias -s {sh,css,js,ts,html,md,txt}=code



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



source ~/.shell-aliases
source ~/.container-aliases
source ~/.shell-motd

# Avoid recursive calls by checking the pane number
#if (( $(tmux list-panes | wc -l) == 1)); then
#	tmux split-window -p 30 \; send-keys 'source ~/.shell-motd; sleep 3; exit' C-m \; last-pane;
#fi


_hasFile ~/.fzf.zsh && source ~/.fzf.zsh
export FZF_COMPLETION_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_COMPLETION_TRIGGER='**'

# https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C




export PATH="$PATH:/opt/homebrew/bin/"
