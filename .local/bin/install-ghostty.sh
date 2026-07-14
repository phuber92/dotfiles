#!/usr/bin/env bash

set -euo pipefail

log() { echo "==> $*"; }

BUILD_DIR=/tmp

GHOSTTY_VERSION="1.3.1"
MINISIGN_VERSION="0.12"
ZIG_VERSION="0.15.2"

GHOSTTY_MINISIGN_PUB_KEY="RWQlAjJC23149WL2sEpT/l0QKy7hMIFhYdQOFy0Z7z7PbneUgvlsnYcV"
ZIG_MINISIGN_PUB_KEY="RWSGOq2NVecA2UPNdBUZykf1CCb147pkmdtYxgb3Ti+JO/wCYvhbAb/U"

MINISIGN_BIN="$BUILD_DIR/minisign-linux/x86_64/minisign"
ZIG_BIN="$BUILD_DIR/zig-x86_64-linux-$ZIG_VERSION/zig"

if [ ! -f /run/.toolboxenv ]; then
  log "ERROR: not in toolbox container"
  exit 1
fi

if ! rpm -q gtk4-layer-shell; then
  log "ERROR: gtk4-layer-shell not installed"
  exit 1
fi

sudo dnf install -y \
  curl \
  gettext \
  gtk4-devel \
  gtk4-layer-shell-devel \
  libadwaita-devel \
  tar &&
  dnf clean all

cd "$BUILD_DIR"

log "Fetching minisign tarball"
curl -LO "https://github.com/jedisct1/minisign/releases/download/$MINISIGN_VERSION/minisign-$MINISIGN_VERSION-linux.tar.gz"

log "Fetching zig tarball and minisign signature"
curl -LO "https://ziglang.org/download/$ZIG_VERSION/zig-x86_64-linux-$ZIG_VERSION.tar.xz"
curl -LO "https://ziglang.org/download/$ZIG_VERSION/zig-x86_64-linux-$ZIG_VERSION.tar.xz.minisig"

log "Fetching ghostty tarball and minisign signature"
curl -LO "https://release.files.ghostty.org/$GHOSTTY_VERSION/ghostty-$GHOSTTY_VERSION.tar.gz"
curl -LO "https://release.files.ghostty.org/$GHOSTTY_VERSION/ghostty-$GHOSTTY_VERSION.tar.gz.minisig"

log "Extracting minisign binary"
tar -xf "minisign-$MINISIGN_VERSION-linux.tar.gz"

log "Verifying zig tarball signature"
"$MINISIGN_BIN" -Vm "zig-x86_64-linux-$ZIG_VERSION.tar.xz" -P "$ZIG_MINISIGN_PUB_KEY"

log "Verifying ghostty tarball signature"
"$MINISIGN_BIN" -Vm "ghostty-$GHOSTTY_VERSION.tar.gz" -P "$GHOSTTY_MINISIGN_PUB_KEY"

log "Extracting zig tarball"
tar -xf "zig-x86_64-linux-$ZIG_VERSION.tar.xz"

log "Extracting ghostty tarball"
tar -xf "ghostty-$GHOSTTY_VERSION.tar.gz"

log "Building ghostty"
cd "ghostty-$GHOSTTY_VERSION"
"$ZIG_BIN" build -p "$HOME/.local" -Doptimize=ReleaseFast

log "Cleaning up artifacts"
rm -rf \
  "$HOME/.cache/zig" \
  "$BUILD_DIR"/ghostty* \
  "$BUILD_DIR"/minisign* \
  "$BUILD_DIR"/zig*
