# Musen Runtime

This directory holds runtime assets installed onto the target system.

Current layout:
- `opt/musen/bin/`: operator-facing and shared shell scripts
- `etc/skel/.config/musen/`: default per-user configuration templates

Implementation policy:
- Bash builtins-first
- Avoid unnecessary subprocesses/pipelines
- Use external commands only where they provide required capability

