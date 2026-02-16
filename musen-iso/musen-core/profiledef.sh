#!/usr/bin/env bash

iso_name="musen"
iso_label="MUSEN_$(date +%Y%m)"
iso_publisher="Musen Project"
iso_application="Musen Arch Radio Distribution"
iso_version="0.1.0"
install_dir="musen"

buildmodes=('iso')
bootmodes=('bios.syslinux' 'uefi.grub')

arch="x86_64"
pacman_conf="pacman.conf"

airootfs_image_type="squashfs"
airootfs_image_tool_options=(
  -comp xz
  -Xbcj x86
  -b 1M
  -Xdict-size 1M
)

file_permissions=(
  ["/etc/shadow"]="0:0:0400"
  ["/etc/gshadow"]="0:0:0400"
)
