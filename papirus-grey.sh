#!/bin/bash
# grey folders for Papirus-Dark, run after installing papirus-icon-theme
cd /usr/share/icons/Papirus || exit 1
for f in */places/*-grey*.svg; do
	[[ $f == 16x16* ]] && continue  # 16px folders already follow the color scheme
	d=$HOME/.local/share/icons/Papirus-Grey/${f%/*}
	n=${f##*/}
	mkdir -p "$d" && ln -sf "$PWD/$f" "$d/${n/-grey/}"
done
