#!/usr/bin/env bash

set -euo pipefail

log() { echo "==> $*"; }

log "Installing iwd and removing wpa_supplicant"
rpm-ostree override remove wpa_supplicant --install iwd

log "Configuring NetworkManager to use iwd backend"
sudo mkdir -p /etc/NetworkManager/conf.d
sudo tee /etc/NetworkManager/conf.d/iwd.conf <<EOF
[device]
wifi.backend=iwd
EOF

log "Fixing selinux labels"
sudo restorecon -R /etc/NetworkManager

log "Post reboot run:"
echo "sudo systemctl enable iwd"
echo "sudo systemctl start iwd"
