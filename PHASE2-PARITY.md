# Phase 2 Parity Matrix

This document maps current ETC runtime behavior to Musen targets and classifies each feature for initial migration planning.

## Scope Labels
- `core`: required for first usable `musen-core.iso`
- `optional`: useful but deferred until core path is stable
- `drop`: not migrated (or replaced with a simpler path)

## Command Parity

| ETC Command | Current Purpose | Musen Target | Scope | Notes |
|---|---|---|---|---|
| `et-common` | shared vars/functions (`/dev/et-*`, service wait, download retries) | `musen-common` | core | Foundation for all wrappers |
| `et-log` | logging helper | `musen-log` | core | Keep simple stdout + log file behavior |
| `et-radio` | active radio selection + operator notes | `musen-radio` | core | Keep active-radio symlink model |
| `et-mode` | mode/menu orchestration | `musen-mode` | core | Primary operator workflow |
| `et-kill-all` | stop all running mode services | `musen-kill-all` | core | Required for clean mode switches |
| `et-system-info` | status introspection for radio/audio/gps/mode/release | `musen-system-info` | core | Needed by wrappers + UX |
| `et-user` | callsign/grid/winlink user config | `musen-user` | core | Keep JSON config model |
| `et-audio` | ALSA tuning by detected radio profile | `musen-audio` | core | Needed by Direwolf/JS8/fldigi/VARA |
| `et-direwolf` | packet modem wrapper + config generation | `musen-direwolf` | core | Keep 1200/300/9600 + digi modes |
| `et-winlink` | pat config generation + launch | `musen-winlink` | core | Core path includes ARDOP + AX.25 |
| `et-ardop` | ARDOP modem wrapper | `musen-ardop` | core | Needed for HF Winlink core path |
| `et-yaac` | APRS client wrapper | `musen-yaac` | optional | Useful but not required for first core ISO |
| `et-paracon` | BBS terminal wrapper | `musen-paracon` | optional | Defer until packet base stable |
| `et-qttermtcp` | BBS terminal wrapper (QtTermTCP) | `musen-qttermtcp` | optional | Defer due packaging/runtime complexity |
| `et-bbs-server` | LinBPQ wrapper | `musen-bbs-server` | optional | Defer to extended profile |
| `et-chattervox` | chat client wrapper | `musen-chattervox` | optional | Defer to extended profile |
| `et-js8call` | JS8Call wrapper + config mutation | `musen-js8call` | optional | Important later, not first-core blocker |
| `et-fldigi` | fldigi wrapper + config mutation | `musen-fldigi` | optional | Important later, not first-core blocker |
| `et-mbtileserver` | raster tile server wrapper | `musen-mbtileserver` | optional | GIS stack deferred |
| `et-dump1090` | ADS-B server wrapper | `musen-dump1090` | optional | SDR stack deferred |
| `et-aircraft` | aircraft UI launcher wrapper | `musen-aircraft` | optional | Depends on dump1090 + app package |
| `et-time` | GPS time-sync check | `musen-time` | core | Keep for field confidence checks |
| `et-term` | GNOME terminal palette helper | drop | drop | FVWM + xterm monochrome replaces this |
| `et-conky` | conky launcher | drop | drop | Out of scope for minimal monochrome UI |
| `et-device-info` | capture USB/udev diagnostics | `musen-device-info` | optional | Useful for hardware enablement work |
| `et-user-backup` | backup selected user config/data | `musen-user-backup` | optional | Defer |
| `et-user-restore` | restore selected backup | `musen-user-restore` | optional | Defer |
| `et-mirror.sh` | offline website mirror helper | optional replacement | optional | Keep later as `musen-mirror` |
| `et-th-d74` | Bluetooth TNC utility | `musen-th-d74` | optional | Defer with BT profile pack |
| `et-uv-pro` | Bluetooth TNC utility | `musen-uv-pro` | optional | Defer with BT profile pack |
| `et-vr-n76` | Bluetooth TNC utility | `musen-vr-n76` | optional | Defer with BT profile pack |
| `et-vara-hf` | VARA HF launcher | `musen-vara-hf` | optional | Deferred; non-FOSS packaging constraints |
| `et-vara-fm` | VARA FM launcher | `musen-vara-fm` | optional | Deferred; non-FOSS packaging constraints |
| `et-voacap` | VOACAP wrapper | optional replacement | optional | Defer to extended RF tools |
| `et-kill-bt` | stop BT-related packet processes | `musen-kill-bt` | optional | Needed when BT stack enabled |

## Service Parity

| ETC User Service | Purpose | Musen Target | Scope |
|---|---|---|---|
| `et-service-direwolf-simple.service` | 1200 packet modem | `musen-service-direwolf-simple.service` | core |
| `et-service-direwolf-300.service` | 300 baud modem | `musen-service-direwolf-300.service` | core |
| `et-service-direwolf-9600.service` | 9600 baud modem | `musen-service-direwolf-9600.service` | core |
| `et-service-direwolf-aprs-digipeater.service` | APRS digi mode | `musen-service-direwolf-aprs-digipeater.service` | optional |
| `et-service-direwolf-packet-digipeater.service` | packet digi mode | `musen-service-direwolf-packet-digipeater.service` | optional |
| `et-service-ardop.service` | ARDOP modem service | `musen-service-ardop.service` | core |
| `et-service-winlink-ardop.service` | pat over ARDOP | `musen-service-winlink-ardop.service` | core |
| `et-service-winlink-packet.service` | pat over AX.25 AGW | `musen-service-winlink-packet.service` | core |
| `et-service-winlink-native-packet.service` | pat over native AX.25 | `musen-service-winlink-native-packet.service` | optional |
| `et-service-et-api.service` | local API service | deferred | optional |
| `et-service-mbtileserver.service` | tile service | deferred | optional |
| `et-service-dump1090.service` | ADS-B service | deferred | optional |

## udev Parity

| Current Rule Group | Musen Plan | Scope |
|---|---|---|
| Radio CAT/audio rules (`77`-`91`) | port and normalize into `musen-runtime/udev/rules.d` | core for selected radios |
| GPS rules (`92-et-u-blox.rules`) | port with syntax fixes + gpsd integration | core |
| SDR rules (`99-et-sdr.rules`) | defer to SDR optional pack | optional |
| generic remove (`75-et-generic-remove.rules`) | port for clean rigctl teardown | core |
| brltty suppression (`85-brltty.rules`) | keep if conflicts appear on Arch targets | optional |

## Template Parity

| Template Set | Musen Plan | Scope |
|---|---|---|
| `template.d/packet/*.conf` | port all Direwolf templates | core (simple/300/9600), optional (digipeater templates) |
| `template.d/winlink/*.json` | port ARDOP + AX25 templates first | core |
| `template.d/bbs/bpq32.simple.cfg` | defer with BBS stack | optional |

## First Core Slice (execution order)

1. Runtime foundation: `musen-common`, `musen-log`, `musen-user`, `musen-system-info`.
2. Radio/mode control: `musen-radio`, `musen-kill-all`, `musen-mode`.
3. Packet + modem: `musen-audio`, `musen-direwolf`, `musen-ardop`, service units.
4. Winlink core: `musen-winlink` + core template set.
5. udev baseline: selected radio rules + GPS + generic remove.

## Explicit Drops for `musen-core`

- GNOME-specific UX helpers (`et-term`, GNOME tuning scripts).
- Conky/autostart desktop telemetry path.
- Heavy GIS/SDR/map stacks in first deliverable.

