[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

source ~/.shell-aliases
source ~/.container-aliases
source ~/.shell-motd

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# profile zsh with zprof
# zmodload zsh/zprof

antigen theme romkatv/powerlevel10k

auto-ls-ls-extended() {
	ls-extended;
	echo ""; # For some reason this is needed to not truncate previous commands output
}
AUTO_LS_COMMANDS=(ls-extended)

antigen bundle editor
antigen bundle history
antigen bundle utility
antigen bundle command-not-found
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle desyncr/auto-ls
antigen bundle Cloudstek/zsh-plugin-appup
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle joshskidmore/zsh-fzf-history-search

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2025-02-01 14:07:48
export PATH="$PATH:/Users/theuss001/.local/bin"
