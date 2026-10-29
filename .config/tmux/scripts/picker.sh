#!/usr/bin/env bash
# fzf picker for tmux sessions / windows / panes (run inside display-popup)
#   enter   jump to selection
#   ctrl-s  sessions   ctrl-w  windows   ctrl-p  panes   ctrl-a  everything
#   ctrl-x  kill selection
#   ctrl-n  new session named after the query

self="$0"

# each line: <target-id> TAB <kind> TAB <display>
list() {
  local mode="${1:-all}" sess win pane
  sess='#{session_id}	session	#[s]#{session_name}#[r]  #{session_windows}w#{?session_attached, (attached),}'
  win='#{window_id}	window	  #[w]#{session_name}:#{window_index}#[r] #{window_name}#{?window_active, *,}'
  pane='#{pane_id}	pane	    #[p]#{session_name}:#{window_index}.#{pane_index}#[r] #{pane_current_command}  #{pane_current_path}#{?pane_active, *,}'
  case "$mode" in
    sessions) tmux list-sessions -F "$sess" ;;
    windows)  tmux list-windows -a -F "$win" ;;
    panes)    tmux list-panes -a -F "$pane" ;;
    *)
      tmux list-sessions -F '#{session_id}' | while read -r s; do
        tmux list-sessions -f "#{==:#{session_id},$s}" -F "$sess"
        tmux list-windows -t "$s" -F '#{window_id}' | while read -r w; do
          tmux display -p -t "$w" "$win"
          tmux list-panes -t "$w" -F "$pane"
        done
      done ;;
  esac | sed -e "s|$HOME|~|g" \
             -e $'s/#\\[s\\]/\033[1;34m/; s/#\\[w\\]/\033[33m/; s/#\\[p\\]/\033[90m/; s/#\\[r\\]/\033[0m/'
}

jump() {
  local id="$1"
  tmux switch-client -t "$id"
  case "$id" in
    @*) tmux select-window -t "$id" ;;
    %*) tmux select-window -t "$id"; tmux select-pane -t "$id" ;;
  esac
}

kill() {
  case "$1" in
    \$*) tmux kill-session -t "$1" ;;
    @*)  tmux kill-window -t "$1" ;;
    %*)  tmux kill-pane -t "$1" ;;
  esac
}

preview() {
  tmux capture-pane -ep -t "$1" | cat -s | tail -n "${FZF_PREVIEW_LINES:-40}"
}

case "$1" in
  list)    list "$2"; exit ;;
  kill)    kill "$2"; exit ;;
  preview) preview "$2"; exit ;;
esac

out=$(list all | fzf --ansi --reverse --no-sort --exact \
  --delimiter '\t' --with-nth 3 \
  --prompt 'all> ' \
  --header 'enter jump · ^s sessions · ^w windows · ^p panes · ^a all · ^x kill · ^n new' \
  --preview "'$self' preview {1}" \
  --preview-window 'right,55%,border-left' \
  --print-query --expect ctrl-n \
  --bind "ctrl-s:change-prompt(sessions> )+reload('$self' list sessions)" \
  --bind "ctrl-w:change-prompt(windows> )+reload('$self' list windows)" \
  --bind "ctrl-p:change-prompt(panes> )+reload('$self' list panes)" \
  --bind "ctrl-a:change-prompt(all> )+reload('$self' list all)" \
  --bind "ctrl-x:execute-silent('$self' kill {1})+reload('$self' list all)+change-prompt(all> )")

query=$(sed -n 1p <<<"$out")
key=$(sed -n 2p <<<"$out")
sel=$(sed -n 3p <<<"$out" | cut -f1)

if [[ "$key" == ctrl-n ]]; then
  [[ -n "$query" ]] || exit 0
  tmux has-session -t "=$query" 2>/dev/null || tmux new-session -d -s "$query" -c "$HOME"
  tmux switch-client -t "=$query"
elif [[ -n "$sel" ]]; then
  jump "$sel"
fi
