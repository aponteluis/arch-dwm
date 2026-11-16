for f in /etc/X11/xinit/xinitrc.d/?*.sh; do [ -x "$f" ] && . "$f"; done
export QT_QPA_PLATFORMTHEME=qt6ct
xwallpaper --zoom "$HOME/Pictures/beadroom-black.jpg"
"$HOME/.local/bin/dwmbar" &
dunst &
udiskie &
clipmenud &
blueman-applet &
lxqt-policykit-agent &
redshift -l 32.6:-115.5 &
exec dwm
