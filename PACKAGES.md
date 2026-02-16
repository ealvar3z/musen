# Musen Package Plan (Draft)

## musen-core (initial target)
Base/boot/build-critical:
- base
- linux
- linux-firmware
- mkinitcpio
- mkinitcpio-archiso
- systemd

Minimal UI:
- xorg-server
- xorg-xinit
- xorg-xsetroot
- xorg-xrandr
- xorg-xinput
- fvwm
- xterm

Core runtime utilities:
- bash
- parallel
- coreutils
- grep
- sed
- gawk
- findutils
- tar
- gzip
- xz
- less
- which
- procps-ng
- util-linux

Operational/network/admin:
- networkmanager
- openssh
- sudo
- iproute2
- curl
- wget
- rsync
- vim

Radio/tooling foundations:
- hamlib
- direwolf
- ax25-tools
- ax25-apps
- gpsd
- chrony
- alsa-utils
- jq
- dialog
- expect
- socat
- bluez
- bluez-utils

## musen-extended (deferred)
Candidate packages:
- pat
- fldigi
- js8call
- rtl-sdr
- dump1090
- qgis
- gpsbabel

## Source Policy
- Prefer official Arch repositories.
- Use curated AUR only where necessary.
- Build local packages for items not suitable for direct AUR/repo consumption.

## Shell/Runtime Policy
- Prefer Bash builtins and Bash-native constructs over unnecessary subprocesses.
- Use `gnu parallel` and Bash `coproc` for controlled concurrency where needed.
