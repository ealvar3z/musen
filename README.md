# Musen

![Musen logo](./logo.png)

Musen is an Arch-native, lightweight radio operations distribution.

## Current Direction
- Archiso-based image build pipeline
- Minimal desktop stack: Xorg + FVWM + xterm
- Monochrome visual style
- Bash builtins-first runtime scripting
- `s6-*` hardware/runtime naming for comms interfaces

## Repository Layout
- `musen-iso/`: archiso profile and build helpers
- `musen-runtime/`: runtime scripts and config templates
- `musen-packaging/`: package manifests and packaging assets
- `musen-tests/`: functional and integration tests
- `PLAN.md`: active execution plan
- `PHASE2-PARITY.md`: parity mapping from ETC to Musen

## Build (planned baseline)
Use the canonical wrapper once `archiso` is installed:

```bash
./musen-iso/build-musen-core.sh
```

