# arch-lxqt

Arch & LXQt (Openbox, SDDM) for a low-spec PC. The dwm setup is on main.

## archinstall

Profile Desktop → LXQt, GRUB (BIOS), ext4, zram, linux-lts, Intel graphics, user `apo`.
Only select the SSD.

## Packages

    sudo pacman -S --needed breeze-icons oxygen-icons rofi xscreensaver slock redshift \
      ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-dejavu ttf-liberation \
      noto-fonts noto-fonts-cjk noto-fonts-emoji fastfetch htop vim git wget nodejs \
      mpv librewolf thunderbird obsidian krita libreoffice-fresh l3afpad flatpak \
      bluez bluez-utils cups cups-pk-helper system-config-printer ghostscript \
      intel-media-driver libva-intel-driver vpl-gpu-rt vulkan-intel \
      reaper sfizz-vst3 surge-xt-vst3 guitarix gxplugins.lv2 \
      pipewire-jack realtime-privileges
    sudo usermod -aG realtime $USER
    flatpak install --user flathub org.vinegarhq.Sober com.openutau.OpenUtau

## Install

Copy the dotfiles into ~ and log out! The MonoDark LXQt theme links to
`/usr/share/lxqt/themes/system`, which comes with lxqt-themes.

    git clone -b lxqt https://github.com/aponteluis/arch-dwm ~/arch-dwm
    cd ~/arch-dwm && cp -a .bashrc .xscreensaver .config .local .themes ~/

## Restore the USB backup

The `XLQT BACKUP` folder on the APONTE USB has the files that aren't in git
(documents, REAPER with the JSFX packs, OpenUtau singers, mail, browser, Claude).

    B="/run/media/apo/APONTE/XLQT BACKUP"
    for f in "$B"/*.tar.zst; do tar --zstd -xf "$f" -C ~; done
    sudo pacman -S --needed - < "$B/pkglist.txt"
