# arch-lxqt

Arch & LXQt (Openbox, SDDM) for a low-spec PC. The dwm setup is on main.

## System

| | |
|---|---|
| PC | i5-4570, 8 GB, Intel HD 4600, BIOS boot |
| Disks | sda 240 GB SSD = Arch (ext4). sdb 500 GB HDD = old Windows (NTFS), never format it |
| Base | Arch, linux-lts, GRUB, zram swap, NetworkManager |
| Desktop | LXQt on Openbox, SDDM login (stock Qt5 themes crash it, use a Qt6 theme) |
| Look | MonoDark everywhere: LXQt palette in `lxqt.conf`, LXQt theme, Openbox theme, QTerminal scheme, rofi. breeze-dark icons, JetBrains Mono Nerd 8 |
| Panel | top, full width, 22 px, icon-only grouped taskbar, menu button runs rofi |
| Keys | Super+P rofi, app keys in `globalkeyshortcuts.conf`, window keys in Openbox `rc.xml`, Alt+Space switches us/es |
| Audio | PipeWire with JACK at 256/48000 (`pipewire/jack.conf.d/latency.conf`), user in `realtime` group |
| Music | REAPER (vstpath has `/usr/lib/vst;/usr/lib/vst3`), sfizz, Surge XT, Guitarix, OpenUtau (Flatpak) with Teto English |
| Apps | LibreWolf, Thunderbird, Obsidian, Krita, LibreOffice (Qt6 UI via `SAL_USE_VCLPLUGIN=qt6` in `session.conf`), mpv, Sober (Roblox, Flatpak) |
| Autostart | monitor at 74.89 Hz, redshift (`-l 32.6:-115.5`) |

Rule: light setup, edit LXQt's own config files, no extra tools or `.bak` files.

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
(documents, sfz, REAPER settings, OpenUtau singers, Thunderbird, Obsidian, Claude).

    B="/run/media/apo/APONTE/XLQT BACKUP"
    for f in "$B"/*.tar.zst; do tar --zstd -xf "$f" -C ~; done
    sudo pacman -S --needed - < "$B/pkglist.txt"

Then download the chmaha JSFX packs again (.ReaperPkg files, 8 packs: Instruments,
Effects, Evangelina Symphonica, Metering, Break Room, Spatial Audio, Rosalina Curiosa,
Convolution Reverbs)
and drag them into REAPER. They aren't in the backup because they take 1.6 GB.

## REAPER ecosystem

All Linux native. Restoring `reaper.tar.zst` brings back `reaper.ini`, the plugin
scan cache and the `Indie Band` project template. `files.tar.zst` brings back `~/Music/sfz`.

| What | How to get it | Where it lives |
|---|---|---|
| REAPER | `pacman -S reaper` | `~/.config/REAPER` |
| 8 chmaha JSFX packs (171 plugins) | latest `.ReaperPkg` of each from https://github.com/chmaha/DSP-Ports-JSFX/releases, drag each onto REAPER | `Effects/DSP to JSFX/Plugin Ports` |
| Guitarix + 112 Gx amps/pedals (LV2) | `pacman -S guitarix gxplugins.lv2` | `/usr/lib/lv2` |
| sfizz (SFZ player, VST3) | `pacman -S sfizz-vst3` | `/usr/lib/vst3` |
| Surge XT synth + Effects (VST3) | `pacman -S surge-xt-vst3` | `/usr/lib/vst3` |
| Guitar SFZ: Karoryfer Emily (acoustic), Karoryfer Shiny (electric), Ovation | in `files.tar.zst`, else https://github.com/sfzinstruments | `~/Music/sfz` |

The chmaha packs are Instruments, Effects MIDI and Utility, Evangelina Symphonica,
Metering and Visualization, Break Room, Spatial Audio, Rosalina Curiosa, Convolution
Reverbs. Since 7.84
REAPER's installer no longer ships them.

Install the chmaha packs:
1. Open REAPER once so `~/.config/REAPER` exists, then close it.
2. Download the newest version of every pack (it also picks up packs released later):

       mkdir -p ~/Downloads/chmaha && cd ~/Downloads/chmaha
       curl -fsSL 'https://api.github.com/repos/chmaha/DSP-Ports-JSFX/releases?per_page=50' \
         | grep -o 'https://[^"]*\.ReaperPkg' \
         | awk -F/ '{n=$NF; sub(/-[0-9.]+\.ReaperPkg$/,"",n)} !seen[n]++' \
         | xargs -n1 curl -fLOs
       ls

3. Open REAPER and drag each `.ReaperPkg` from the file manager onto the REAPER
   window, one at a time. Accept the install prompt.
4. Check: `ls ~/.config/REAPER/Effects/"DSP to JSFX/Plugin Ports"/*.jsfx | wc -l`
   (171 with the 8 packs above).
5. If they don't show in Add FX, restart REAPER (it scans JSFX at start).
6. `rm -r ~/Downloads/chmaha`

Audio setup:
1. `sudo usermod -aG realtime $USER`, then log out and in.
2. REAPER → Preferences → Audio → Device: JACK. The buffer comes from
   `~/.config/pipewire/jack.conf.d/latency.conf` (256/48000, in git); REAPER's own
   block size is ignored under JACK.
3. Preferences → Plug-ins → VST: path `~/.vst;~/.vst3;/usr/lib/vst;/usr/lib/vst3`,
   then Re-scan. LV2 is found on its own.

`Indie Band` template (File → New project from template): Drums, Bass, Electric
Guitar, Acoustic Guitar, Keys, Synth, Vocals, plus a Reverb bus. MIDI tracks arm and
monitor on select, so a MIDI keyboard plays right away. VST3/LV2 state can't be
written by hand, so if the template is lost add Surge XT on Synth, GxAmplifier-X +
GxCabinet on Electric Guitar and sfizz (Ovation) on Acoustic Guitar, then save over it.

## OpenUtau + Teto English

    flatpak install --user flathub com.openutau.OpenUtau

`openutau.tar.zst` restores the singers into
`~/.var/app/com.openutau.OpenUtau/data/OpenUtau/Singers`. If it's lost, download
`TETO-English-150401.zip` from https://kasaneteto.jp/utau/ and install it with
OpenUtau → Tools → Install Singer (archive and text encoding: Shift-JIS). Pick the phonemizer **EN X-SAMPA**.
Teto is free for non-commercial use only.
