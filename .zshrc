[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

source ~/.shell-aliases
source ~/.container-aliases
source ~/.shell-motd
antigen use oh-my-zsh


# Specify plugins we want
antigen bundle editor
antigen bundle history
antigen bundle utility
antigen bundle completion
antigen bundle command-not-found

# Specify additional external plugins we want
antigen bundle smallhadroncollider/antigen-git-rebase
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
antigen bundle zsh-users/zsh-completions

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

# Suffix aliases
#alias -s {sh,css,js,ts,html,md,txt}=code
 
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
# Alt Arrow to move by word
# https://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh#16411270
bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word


bindkey -s '^gp' '~/.scripts/git-pull-helper\n'
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

