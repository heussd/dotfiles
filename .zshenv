# shellcheck shell=bash
# shellcheck disable=SC2034
SHELL_SESSIONS_DISABLE=1

# Remove duplicate PATH entries
typeset -U path PATH

source "$HOME/.shell-environment"
