# shellcheck shell=bash

# Homebrew
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
fi
export HOMEBREW_BUNDLE_DUMP_NO_FLATPAK=true

# Starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

# User specific PATH
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi
export PATH

# XDG paths
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Editors
export EDITOR="nvim"
export VISUAL="nvim"

# History
export HISTCONTROL=ignoreboth:erasedups

# Configure bitwarden ssh agent
export SSH_AUTH_SOCK=$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock

# Aliases
alias ll="ls -lah"
alias venv="source .venv/bin/activate"
