#!/bin/bash
# Adds haup-term/bin to your PATH by updating your shell rc file.
# Run once after cloning. Scripts are added directly to PATH,
# so any new scripts you add are immediately available.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$SCRIPT_DIR/bin"

# Detect shell rc file
if [[ -n "${ZSH_VERSION:-}" ]] || [[ "$SHELL" == */zsh ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ -n "${BASH_VERSION:-}" ]] || [[ "$SHELL" == */bash ]]; then
  SHELL_RC="$HOME/.bashrc"
else
  echo "Unsupported shell: $SHELL"
  echo "Manually add this to your shell config:"
  echo "  export PATH=\"$BIN_DIR:\$PATH\""
  exit 1
fi

# Make all scripts in bin/ executable
chmod +x "$BIN_DIR"/*

# Check if already in PATH
if grep -qF "$BIN_DIR" "$SHELL_RC" 2>/dev/null; then
  echo "haup-term/bin is already in your PATH."
else
  echo "" >> "$SHELL_RC"
  echo "# haup-term - global shell scripts" >> "$SHELL_RC"
  echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$SHELL_RC"
  echo "Added haup-term/bin to PATH in $SHELL_RC"
  echo "Run: source $SHELL_RC (or open a new terminal)"
fi
