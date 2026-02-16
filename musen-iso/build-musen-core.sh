#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE_DIR="${ROOT_DIR}/musen-iso/musen-core"
WORK_DIR="${ROOT_DIR}/musen-iso/work/musen-core"
OUT_DIR="${ROOT_DIR}/musen-iso/out"

if ! command -v mkarchiso >/dev/null 2>&1; then
  echo "mkarchiso not found. Install archiso first."
  exit 1
fi

mkdir -p "${OUT_DIR}"

exec sudo mkarchiso \
  -v \
  -r \
  -m "iso" \
  -w "${WORK_DIR}" \
  -o "${OUT_DIR}" \
  "${PROFILE_DIR}"
