for f in /etc/X11/xinit/xinitrc.d/?*.sh; do [ -x "$f" ] && . "$f"; done
xrandr --output HDMI-1 --mode 1600x900 --rate 74.89
export QT_QPA_PLATFORMTHEME=qt6ct
xrdb -merge "$HOME/.Xresources"
xwallpaper --zoom "$HOME/Pictures/beadroom-black.jpg"
"$HOME/.local/bin/dwmbar" &
dunst &
udiskie &
clipmenud &
blueman-applet &
lxqt-policykit-agent &
redshift -l 32.6:-115.5 &
exec dwm
