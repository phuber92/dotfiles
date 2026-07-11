#!/usr/bin/env bash

set -euo pipefail

log() { echo "==> $*"; }

log "Installing brave browser"
curl -fsS https://dl.brave.com/install.sh | sh
