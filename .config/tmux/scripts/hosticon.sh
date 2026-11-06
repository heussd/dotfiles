#!/bin/sh
# Derive a stable symbol + colour from the hostname (CRC32 via cksum).
#   hosticon.sh [host]  ->  #[fg=...]SYM#[default]

host=${1:-$(hostname -s)}
h=$(printf '%s' "$host" | cksum | cut -d' ' -f1)

# single-width glyphs only (no emoji-presentation chars, they break cell widths)
set -- ◆ ● ▲ ■ ★ ✦ ✚ ✱ ❖ ◉ ◈ ♠ ♣ ♥ ♦ ♞ ✿ ⬢ λ Ω Ψ Σ Δ φ ∞ § ¤ ⌘
n=$#
shift $((h % n))
sym=$1

set -- '#f38ba8' '#fab387' '#f9e2af' '#a6e3a1' '#94e2d5' '#89b4fa' '#cba6f7' '#f5c2e7'
shift $((h / n % $#))

printf '#[fg=%s]%s#[default]\n' "$1" "$sym"
