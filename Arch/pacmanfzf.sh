#!/usr/bin/env sh

sudo pacman -Scc --noconfirm
sudo pacman -Syyu "$(pacman -Slq | fzf --ansi --preview 'pacman -Si {} --layout=reverse')" 2>&1 /dev/null
