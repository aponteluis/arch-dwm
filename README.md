# arch-dwm

My Arch setup: dwm, st, dmenu and slock, with a black and gray theme.

## Follow dis

| # | Step | Command |
|---|---|---|
| 1 | archinstall | profile minimal, kernel linux-lts, audio pipewire, bluetooth on, printing on, NetworkManager, extra packages `git base-devel nano htop`, English locale |
| 2 | Xorg and libs | `sudo pacman -S xorg-server xorg-xinit xorg-xrandr libxinerama libxft` |
| 3 | Get dwm and st | `git clone https://git.suckless.org/dwm` and `.../st` |
| 4 | Build them | `cd dwm && sudo make clean install`, same in `st` |
| 5 | Start dwm | `nano ~/.xinitrc` with `exec dwm` |
| 6 | startx on login | `nano ~/.bash_profile` |
| 7 | Fonts | `sudo pacman -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd` |
| 8 | Bar | `sudo pacman -S xorg-xsetroot` |
| 9 | dmenu and slock from source | clone, `sudo make install`, `sudo pacman -R dmenu` |
| 10 | File manager | `sudo pacman -S dolphin qt6ct papirus-icon-theme ffmpegthumbs kdegraphics-thumbnailers qt6-imageformats` |
| 11 | Screenshots, wallpaper | `sudo pacman -S scrot xwallpaper` |
| 12 | Apps | `sudo pacman -S librewolf fastfetch krita reaper` |
| 13 | Desktop helpers | `sudo pacman -S dunst udiskie clipmenu redshift blueman pavucontrol lxqt-policykit timeshift unzip 7zip` |
| 14 | Work apps | `sudo pacman -S obsidian libreoffice-fresh thunderbird keepassxc zathura zathura-pdf-mupdf mpv nsxiv` |
| 15 | Timeshift schedule | `sudo systemctl enable --now cronie` |
| 16 | Timeshift setup | open `timeshift-launcher`: RSYNC, sda2, daily 5, weekly 3, home excluded, then Create |
| 17 | Dark theme | `gsettings set org.gnome.desktop.interface color-scheme prefer-dark`, and for Timeshift (runs as root) `sudo mkdir -p /root/.config && sudo cp -r ~/.config/gtk-3.0 /root/.config/` |
| 18 | Printer (HP Laser 107w) | `git clone https://aur.archlinux.org/hpuld.git ~/.local/src/hpuld`, then `makepkg -si` in it, then add it in `system-config-printer` with the HP Laser 10x Series driver |
| 19 | Clean old packages weekly | `sudo pacman -S pacman-contrib` and `sudo systemctl enable --now paccache.timer` |
| 20 | Music plugins | `sudo pacman -S dragonfly-reverb-vst3 surge-xt-vst3 lsp-plugins-vst3 sfizz-vst3 guitarix gxplugins.lv2`, then Re-scan VST and LV2 in REAPER's Plug-ins settings |
| 21 | OpenUtau | `git clone https://aur.archlinux.org/openutau-bin.git ~/.local/src/openutau-bin`, then `makepkg -si` in it |
| 22 | MIDI keyboard | REAPER, Preferences, Audio, MIDI Inputs: right-click the MPK, Enable input |

Only `make install` and `pacman` need sudo. Files in home are mine, so `nano config.h` is enough.

## Install

On a new machine, do the steps above, then:

```
cp -r .xinitrc .Xresources .bashrc .bash_profile .config .local .icons ~/
./papirus-grey.sh
```

The script links the grey Papirus folders into `~/.local/share/icons/Papirus-Grey`.

Suckless tools are upstream plus my config.h and a diff. Sources live in `~/.local/src`:

```
mkdir -p ~/.local/src && cd ~/.local/src
git clone https://git.suckless.org/dwm && cd dwm
git checkout 1563572
git apply ~/arch-dwm/suckless/dwm/local.diff
cp ~/arch-dwm/suckless/dwm/config.h .
sudo make clean install
```

Same for st (`fdaadd5`), dmenu (`bfb0716`) and slock (`65cb721`, no diff).

The wallpaper is not in the repo; `.xinitrc` expects it at `~/Pictures/beadroom-black.jpg`.

`qt6ct.conf` has `/home/apo` in it, change it if your user is different.

## Keys

Mod key is Super (the Windows key). Tags 1-9 are the workspaces. Master is the big window on the left, the rest stack on the right.

### Apps

| Key | Does |
|---|---|
| Super+p | dmenu |
| Super+Shift+Return | terminal |
| Super+e | dolphin |
| Super+w | wifi menu |
| Super+Shift+x | lock |
| Super+r | librewolf |
| Super+o | obsidian |
| Super+n | thunderbird |
| Super+Shift+k | keepassxc |
| Super+a | audio settings |
| Super+Shift+b | bluetooth |
| Super+v | clipboard history |
| Super+` | last notification again |
| Print | screenshot |
| Shift+Print | screenshot of an area |
| volume keys | volume up / down / mute |

### Windows

| Key | Does |
|---|---|
| Super+j / Super+k | focus next / previous window |
| Super+Return | swap focused window with master |
| Super+h / Super+l | master smaller / bigger |
| Super+i / Super+d | more / fewer windows in master |
| Super+Shift+space | float / unfloat window |
| Super+Shift+c | close window |
| Super+b | hide / show bar |
| Super+Shift+o | quit dwm |

### Layouts

| Key | Does |
|---|---|
| Super+t | tile |
| Super+f | floating |
| Super+m | monocle (one window full screen) |
| Super+space | back to last layout |

### Tags

| Key | Does |
|---|---|
| Super+1..9 | go to tag |
| Super+Shift+1..9 | move window to tag |
| Super+Ctrl+1..9 | also show that tag |
| Super+Ctrl+Shift+1..9 | also put window on that tag |
| Super+0 | show all tags |
| Super+Shift+0 | put window on all tags |
| Super+Tab | back to last tag |

### Monitors

| Key | Does |
|---|---|
| Super+, / Super+. | focus previous / next monitor |
| Super+Shift+, / Super+Shift+. | move window to previous / next monitor |

### Mouse

| Where | Does |
|---|---|
| Super+left drag | move window (makes it float) |
| Super+right drag | resize window |
| Super+middle click | float / unfloat window |
| click tag | go to tag |
| right click tag | also show that tag |
| Super+click tag | move window to tag |
| Super+right click tag | also put window on that tag |
| click layout icon | back to last layout |
| right click layout icon | monocle |
| middle click title | swap with master |
| middle click status | terminal |

### st

| Key | Does |
|---|---|
| Ctrl+Shift+c / v | copy / paste |
| Shift+Insert, middle click | paste selection |
| Shift+PgUp / PgDn, mouse wheel | scroll back |
| Ctrl+Shift+PgUp / PgDn | font bigger / smaller |
| Ctrl+Shift+Home | font reset |

### dmenu

| Key | Does |
|---|---|
| type, Return | run |
| Tab | complete |
| Shift+Return | run exactly what you typed |
| Esc | cancel |

## Patches

- st: scrollback (Shift+PgUp/PgDn, mouse wheel)
- dmenu: centered, border
- dwm: window title not highlighted, empty tags hidden (hide_vacant_tags)

## Music

Not in the repo, download again on a new machine.

- Guitar: Emilyguitar (SFZ, free from Karoryfer) in `~/Music/samples/`. Chain in REAPER: sfizz, Guitarix amp, GxCabinet, Dragonfly.
- Teto: `TETO-OUset240323.zip` (Japanese, all voices) and `TETO-English-150401.zip` from kasaneteto.jp/utau. Install in OpenUtau with Tools, Install Singer. Free for non-commercial use, no redistribution.

| Language | Teto bank | Phonemizer |
|---|---|---|
| Japanese | OU integrated | JA VCV & CVVC |
| English | English | EN X-SAMPA |
| Spanish | OU integrated | ES to JA |
