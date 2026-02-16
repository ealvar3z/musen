# Musen ISO Build Conventions

This file defines the canonical `mkarchiso` invocation for Musen.

## Profile
- Profile path: `musen-iso/musen-core`
- Build modes: explicit (`iso`)

## Directories
- Working directory: `musen-iso/work/musen-core`
- Output directory: `musen-iso/out`

## Canonical Command
Run from repository root (`musen/`):

```bash
sudo mkarchiso \
  -v \
  -r \
  -m "iso" \
  -w "$(pwd)/musen-iso/work/musen-core" \
  -o "$(pwd)/musen-iso/out" \
  "$(pwd)/musen-iso/musen-core"
```

## Metadata Policy
Musen ISO metadata defaults are controlled in `musen-iso/musen-core/profiledef.sh`.
Do not override metadata at build time with `-A`, `-L`, `-P`, or `-D` unless explicitly testing a temporary variant.

## Notes
- `-r` removes the work directory only on successful builds when created by `mkarchiso`.
- If a build is interrupted, inspect bind mounts before deleting work dir.
- Use the wrapper script `musen-iso/build-musen-core.sh` for consistency.
