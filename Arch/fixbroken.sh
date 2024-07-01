!#/usr/bin/env sh

foot sudo pacman -S --no-confirm `pacman -Qk 2>/dev/null | grep -v ' 0 missing files' | cut -d: -f1`
