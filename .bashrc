# shellcheck shell=bash
# shellcheck disable=SC1091
[ -n "$PS1" ] && source "$HOME/.bash_profile";

[ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
