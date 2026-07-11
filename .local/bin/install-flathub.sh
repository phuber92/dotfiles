#!/usr/bin/env bash

set -euo pipefail

log() { echo "==> $*"; }

log "Adding flathub remote"
flatpak remote-add --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo
