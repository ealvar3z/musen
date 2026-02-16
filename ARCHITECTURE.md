# Musen Architecture (Draft)

## Overview
Musen is an Arch-native, lightweight radio operations distribution.

Primary goals:
- Minimal footprint and fast boot
- Monochrome UI (black background, white text, gray hints)
- Reliable field workflows for radio operations
- Arch-native packaging and image build process

## High-Level Components
- `musen-iso/`: Archiso profile and image build artifacts
- `musen-runtime/`: Runtime scripts, service units, udev rules, templates
- `musen-packaging/`: PKGBUILDs and package manifests
- `musen-tests/`: Functional and integration tests

## Build Model
- Base OS/image build: Archiso + mkarchiso
- Package sources: Arch repos + curated AUR + local packages
- Release artifacts: `musen-core.iso` and `musen-extended.iso`

## Runtime Model
- Hardware aliases via udev (radio/audio/gps/sdr)
- Service orchestration via systemd (system + user units)
- Operator-facing wrappers for mode/radio workflows

## UI Model
- Xorg + xinit + FVWM + xterm
- No wallpaper/image-heavy theme dependencies
- Accessibility through high-contrast defaults
