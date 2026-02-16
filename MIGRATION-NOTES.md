# Migration Notes (Ubuntu ETC -> Arch Musen)

## Current Status
- Musen workspace scaffold created.
- Initial Archiso profile scaffold created at `musen/musen-iso/musen-core`.
- Archiso baseline profile was not copied from host path because it is unavailable in this environment.

## Immediate Priorities
1. Validate Archiso profile files against a real Arch build host.
2. Port runtime scripts from `/opt/emcomm-tools` to `/opt/musen`.
3. Define first functional parity slice (radio select + one mode path).

## Known Porting Considerations
- Replace Ubuntu package/install assumptions with Arch-native package flow.
- Keep runtime shell logic where distro-agnostic.
- Revalidate udev rules and systemd units under Arch.
