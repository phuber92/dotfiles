#!/usr/bin/env bash

set -euo pipefail

log() { echo "==> $*"; }

rpm-ostree install --idempotent \
  gcc \
  gtk4-layer-shell
