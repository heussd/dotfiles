#zmodload zsh/zprof

[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

source ~/.shell-aliases
source ~/.container-aliases
source ~/.shell-motd


antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle joshskidmore/zsh-fzf-history-search

antigen apply


zstyle ':filter-select:highlight' matched fg=red
zstyle ':filter-select' max-lines 1000
zstyle ':filter-select' rotate-list yes
zstyle ':filter-select' case-insensitive yes # enable case-insensitive searchhttps://github.com/tideflow-io/tideflow

zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'


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

 
_hasFile ~/.fzf.zsh && source ~/.fzf.zsh
export FZF_COMPLETION_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_COMPLETION_TRIGGER='**'
 
 
export PATH="$PATH:/opt/homebrew/bin/"
# Alt Arrow to move by word
# https://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh#16411270
bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word


bindkey -s '^gp' '~/.scripts/git-pull-helper\n'
bindkey -s '^gP' '~/.scripts/git-push-helper\n'
bindkey -s '^gü' '~/.scripts/git-push-helper\n'
bindkey -s '^o' '~/.scripts/oop\n'
bindkey -s '^p' '~/.scripts/goto\n'
bindkey -s '^h' 'vimwiki\n'
bindkey -s '^x' '~/.scripts/lazygit-helper\n'
bindkey -s '^y' '~/.scripts/snippets-fzf\n'
bindkey -s '^n' '~/.scripts/git-vimi-helper\n'
#bindkey -s '^e' 'open .\n'
bindkey -s '^k' 'code .\n'
bindkey -s '^s' '~/.scripts/snippets-fzf .\n'
bindkey -s '^f' '~/.scripts/op .\n'


setopt PROMPT_SUBST

git_prompt_simple() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

  local branch ahead=0 behind=0
  local status_icons=""
  local ab_counts

  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return

  # Staged changes
  git diff --cached --quiet --ignore-submodules 2>/dev/null || status_icons+=" ●"
  # Unstaged changes
  git diff --quiet --ignore-submodules 2>/dev/null || status_icons+=" ✚"
  # Untracked files
  [[ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]] && status_icons+=" …"

  ab_counts=$(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)
  if [[ -n "$ab_counts" ]]; then
    read -r behind ahead <<<"${ab_counts}"
    behind=${behind:-0}
    ahead=${ahead:-0}
    (( ahead > 0 )) && status_icons+=" ⇡${ahead}"
    (( behind > 0 )) && status_icons+=" ⇣${behind}"
  fi

  if [[ -z "$status_icons" ]]; then
    echo "@ ${branch} %F{green}✓%f "
  else
    echo "@ ${branch}${status_icons} "
  fi
}

precmd() {
  GIT_PROMPT_INFO="$(git_prompt_simple)"
}

NEWLINE=$'\n'
PROMPT='%F{blue}%~%f %F{red}${GIT_PROMPT_INFO}%f${NEWLINE}$ '

#zprof
