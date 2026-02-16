# Musen Migration Plan

This document tracks the phased migration from the current Ubuntu-based EmComm Tools workflow to a lightweight Arch-based `musen` distribution.

## Phase 0: Foundation and Scope
- [x] Create and maintain this plan as the source of truth.
- [x] Define `musen` goals: lightweight, monochrome UI, radio-first workflow.
- [ ] Freeze initial feature scope as `core` vs `optional`.
- [ ] Decide naming strategy (`musen-*` commands, compatibility aliases).
- [ ] Capture architecture decisions (Arch + Xorg + FVWM + monochrome theme).

## Phase 1: Repository and Workspace Structure
- [x] Create base directory layout:
  - [x] `musen/musen-iso/`
  - [x] `musen/musen-runtime/`
  - [x] `musen/musen-packaging/`
  - [x] `musen/musen-tests/`
- [x] Add top-level docs:
  - [x] `musen/ARCHITECTURE.md`
  - [x] `musen/PACKAGES.md`
  - [x] `musen/MIGRATION-NOTES.md`
- [x] Initialize an `archiso` profile workspace in `musen/musen-iso/` (from shipped profile or manual scaffold).
- [ ] Start from `baseline` profile for minimum footprint and only add what musen requires.

## Phase 2: Feature Parity Mapping
- [x] Inventory current runtime flows from ETC (`et-radio`, `et-mode`, wrappers, services).
- [x] Build parity matrix (current behavior -> musen target behavior).
- [x] Tag each feature as:
  - [x] `core` (required for first usable ISO)
  - [x] `optional` (deferred modules)
  - [x] `drop` (intentionally removed)

## Phase 3: Minimal Arch ISO Base
- [x] Create `archiso` profile for `musen-core`.
- [x] Define and maintain profile files:
  - [x] `packages.x86_64` (explicit package list)
  - [x] `profiledef.sh` (image/profile behavior and file permissions)
  - [x] `pacman.conf` (build-time repositories and priority)
  - [x] `airootfs/` (files copied into live root filesystem)
- [x] Define required `profiledef.sh` identity fields (`iso_name`, `iso_label`, `iso_version`, `install_dir`, `arch`).
- [x] Ensure `install_dir` is Archiso-compliant (max 8 chars, lowercase alnum only).
- [x] Set explicit `buildmodes` and `bootmodes` in `profiledef.sh` for musen targets.
- [ ] Boot to a minimal userland with:
  - [ ] Xorg
  - [ ] xinit
  - [ ] FVWM
  - [ ] xterm
- [x] Apply monochrome defaults:
  - [x] black background
  - [x] white primary text
  - [x] gray hint text
- [x] Exclude image/theme-heavy assets by default.
- [x] Configure bootloader support for both BIOS and UEFI.
- [x] Keep bootloader config directories aligned to selected bootmodes:
  - [x] `syslinux/` for `bios.syslinux`
  - [x] `grub/` for `uefi.grub` and/or `efiboot/` for `uefi.systemd-boot`
- [x] Verify boot config templates correctly use Archiso placeholders (`%ARCHISO_LABEL%`, `%INSTALL_DIR%`, `%ARCH%`).
- [ ] Ensure required systemd symlinks are present in `airootfs` for enabled services.
- [x] Define canonical `mkarchiso` build command and defaults for musen:
  - [x] `-v` verbose builds by default
  - [x] `-w` dedicated work directory
  - [x] `-o` dedicated output directory
  - [x] `-r` cleanup policy for successful builds
  - [x] `-m` explicit build modes instead of implicit defaults
- [x] Decide whether to override metadata at build time (`-A`, `-L`, `-P`, `-D`) or only via `profiledef.sh`.

## Phase 4: Runtime Port (ETC -> Musen)
- [ ] Port wrapper scripts from `/opt/emcomm-tools` to `/opt/musen`.
- [ ] Port templates (Direwolf/Winlink/BBS) into musen runtime tree.
- [ ] Port and review udev rules for radio/audio/gps/sdr aliases.
- [ ] Port systemd units (system and user services).
- [ ] Fix known defects during port (script path bugs, udev syntax issues, naming inconsistencies).

## Phase 5: Package Strategy and Inclusion
- [x] Build package manifest for `musen-core`.
- [ ] Build package manifest for `musen-extended`.
- [x] Ensure mandatory Archiso boot image packages are present (`mkinitcpio`, `mkinitcpio-archiso`).
- [ ] Define source per package:
  - [ ] Arch repo
  - [ ] AUR
  - [ ] manually packaged binary
- [ ] Pin versions or establish compatibility baselines for critical radio apps.
- [ ] Define local custom repository flow for non-repo packages (repo-add + build-time pacman.conf).
- [ ] Add runtime repository/keyring files in `airootfs/etc/pacman*` only when explicitly required.

## Phase 6: Arch-Native Reproducibility
- [ ] Keep packaging fully Arch-native (`pacman` + curated AUR + local PKGBUILDs when needed).
- [ ] Define package version/pinning strategy for critical radio tooling.
- [ ] Add package manifests and lock snapshots for reproducible ISO builds.
- [ ] Document mirror/cache strategy for repeatable offline or low-bandwidth builds.

## Phase 7: Testing and Validation
- [ ] Replace simple presence checks with functional tests.
- [ ] Validate mode transitions and service orchestration end-to-end.
- [ ] Validate udev alias behavior on supported hardware.
- [ ] Validate clean startup on low-resource hardware.
- [ ] Add CI for shell linting, static checks, and smoke boot tests.
- [ ] Test each ISO build with `run_archiso` in QEMU (BIOS and UEFI paths).
- [ ] Validate build process cleanup and safe handling of `mkarchiso` work directories.

## Phase 8: Release Engineering
- [ ] Produce `musen-core.iso` (minimal profile).
- [ ] Produce `musen-extended.iso` (optional packages).
- [ ] Write release notes and upgrade notes.
- [ ] Document operator quick-start for field usage.
- [ ] Decide and implement signing strategy for release artifacts:
  - [ ] GPG signing for rootfs/images (`-g`, `-G`) if required
  - [ ] Optional code-signing certificate flow (`-c`) for netboot/rootfs artifacts

## Ongoing Risk Register
- [ ] Track package availability risks (especially AUR dependencies).
- [ ] Track rolling-release breakage risks and mitigation strategy.
- [ ] Track binary compatibility risks for proprietary/vendor tools.
- [ ] Track footprint regressions (ISO size and RAM usage).

## Definition of Done (v1)
- [ ] `musen-core.iso` boots reliably.
- [ ] Core radio workflows function end-to-end.
- [ ] Monochrome FVWM UX is stable and readable.
- [ ] Documentation is sufficient for new contributors/operators.
