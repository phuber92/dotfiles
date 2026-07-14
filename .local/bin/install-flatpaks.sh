#!/usr/bin/env bash

set -euo pipefail

log() { echo "==> $*"; }

log "Adding flathub remote"
flatpak remote-add --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo

log "Uninstalling fedora flatpaks"
flatpak uninstall --delete-data --noninteractive \
  org.kde.kmahjongg \
  org.kde.kmines ||
  true

log "Installing fedora flatpaks"
flatpak install --or-update --noninteractive fedora \
  org.videolan.vlc

log "Installing flathub flatpaks"
flatpak install --or-update --noninteractive flathub \
  com.bitwarden.desktop \
  com.discordapp.Discord \
  com.orama_interactive.Pixelorama \
  com.valvesoftware.Steam \
  org.godotengine.Godot
