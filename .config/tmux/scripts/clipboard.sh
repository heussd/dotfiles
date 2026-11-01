#!/bin/sh
# Cross-platform copy-to-clipboard wrapper.
#   Usage: clipboard.sh  [<text>]
# Without args it copies stdin; with args it echoes them.

case "$(uname -s 2>/dev/null)" in
  Darwin)
    pbcopy ;;
  Linux)
    if command -v wl-copy >/dev/null 2>&1; then
      wl-copy
    elif command -v xclip >/dev/null 2>&1; then
      xclip -selection clipboard
    else
      echo "clipboard.sh: no clipboard tool found (need wl-copy or xclip)" >&2
      exit 1
    fi ;;
  *)
    cat ;;  # fallback: just stdout passthrough
esac
