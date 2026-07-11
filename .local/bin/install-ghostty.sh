#!/usr/bin/env bash

set -euo pipefail

log() { echo "==> $*"; }

CONTAINERFILE="$HOME/git/containers/build_ghostty/Containerfile"
CONTAINERNAME="build-ghostty"

if [ ! -f "$CONTAINERFILE" ]; then
  log "ERROR: $CONTAINERFILE not found"
  exit 1
fi

if ! rpm -q gtk4-layer-shell >/dev/null; then
  log "ERROR: gtk4-layer-shell not installed"
  exit 1
fi

log "Building build-ghostty image"
podman build -t $CONTAINERNAME "$(dirname "$CONTAINERFILE")"

log "Installing ghostty"
podman run -d --rm localhost/$CONTAINERNAME
