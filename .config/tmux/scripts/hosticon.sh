#!/bin/sh
# Derive a stable symbol + colour from the hostname (CRC32 via cksum).
#   hosticon.sh [host]  ->  #[fg=...]SYM#[default]

host=${1:-$(hostname -s)}
h=$(printf '%s' "$host" | cksum | cut -d' ' -f1)

# Nerd Font md-* icons only (one icon family, so sizes match; no emoji-presentation chars, they break cell widths)
# only glyphs filling >=~740 units both ways; flat/thin/small ones (bat, bee, fire, ufo, ...) look undersized
# volcano unicorn google_downasaur yin_yang snail emoticon_devil spider mushroom pumpkin popcorn robot ninja
# death_star cupcake dice_d20 pokeball panda skull castle sheep jellyfish spider_web pig alien owl cow nuke
# cards_playing shield_sword brain virus emoticon_poop turtle snake rocket koala chili_hot sword_cross pirate
# bomb pac_man ghost duck flower_poppy bow_arrow radioactive star_shooting space_invaders penguin
set -- 󱪃 󱗂 󱍢 󰚀 󱙷 󰱯 󱇪 󰟟 󰮿 󰐢 󰚩 󰝴 󰣘 󰥚 󱅕 󰐝 󰏚 󰚌 󰄚 󰳆 󰼁 󰯊 󰐁 󰢚 󰏒 󰆚 󰚤 󱢡 󱢾 󰧑 󱎶 󰇷 󰳗 󱔎 󰑣 󱜿 󰞲 󰞇 󰨈 󰚑 󰮯 󰊠 󰇥 󰴈 󱡁 󰐼 󱝁 󰯉 󰻀
n=$#
shift $((h % n))
sym=$1

set -- '#f38ba8' '#fab387' '#f9e2af' '#a6e3a1' '#94e2d5' '#89b4fa' '#cba6f7' '#f5c2e7'
shift $((h / n % $#))

printf '#[fg=%s]%s#[default]\n' "$1" "$sym"
