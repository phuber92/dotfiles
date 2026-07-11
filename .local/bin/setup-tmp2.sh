#!/usr/bin/env bash

set -euo pipefail

log() { echo "==> $*"; }

log "Confirming TPM2 support"
systemd-analyze has-tpm2

log "Finding crypto_LUKS partition"
LUKS_DEV="$(lsblk -rpo NAME,FSTYPE | awk '$2=="crypto_LUKS"{print $1}' | head -n1)"

if [[ -z "$LUKS_DEV" ]]; then
  log "ERROR: No LUKS device found"
  exit 1
fi

log "Enrolling LUKS device with TPM2"
sudo systemd-cryptenroll --tpm2-device=auto "$LUKS_DEV"

log "Adding TPM2 unlock kernel argument"
sudo rpm-ostree kargs --append-if-missing=rd.luks.options=tpm2-device=auto
