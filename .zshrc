# shellcheck shell=bash
# shellcheck disable=SC1072,SC1090

#zmodload zsh/zprof

source ~/.shell-aliases
source ~/.container-aliases
source ~/.shell-motd



# https://mijndertstuij.nl/posts/life-is-too-short-for-a-slow-terminal/
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#`source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
source ~/.zsh/zsh-fzf-history-search/zsh-fzf-history-search.zsh


if type brew &>/dev/null; then
     FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# Case insensitive matching
# https://stackoverflow.com/a/69014927
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

autoload -Uz compinit
# shellcheck disable=SC1009,SC1036,SC1073
if [[ -n $HOME/.zcompdump(#qNmh-24) ]]; then
  compinit -C
else
  compinit
fi


autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


bindkey '^[[A'  up-line-or-beginning-search    # Arrow up
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search  # Arrow down
bindkey '^[OB'  down-line-or-beginning-search

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word


_hasFile ~/.fzf.zsh && source ~/.fzf.zsh
export FZF_COMPLETION_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_COMPLETION_TRIGGER='**'


export PATH="$PATH:/opt/homebrew/bin/"
# Alt Arrow to move by word
# https://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh#16411270
bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word


fpath+=$HOME/.zsh/pure

autoload -U promptinit; promptinit
prompt pure
