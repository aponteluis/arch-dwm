# arch-lxqt

Arch & LXQt (Openbox, SDDM) for a low-spec PC. The dwm setup is on main.

## Packages

    sudo pacman -S breeze-icons rofi xscreensaver redshift ttf-jetbrains-mono-nerd \
      mpv libreoffice-fresh thunderbird flatpak \
      reaper sfizz-vst3 guitarix pipewire-jack realtime-privileges
    sudo usermod -aG realtime $USER
    flatpak install --user flathub org.vinegarhq.Sober

## Install

Copy the dotfiles into ~ and log out! The MonoDark LXQt theme links to
`/usr/share/lxqt/themes/system`, which comes with lxqt-themes.
