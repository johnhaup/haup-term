#!/bin/bash
# One-liner bootstrap for haup-term on a fresh machine.
# Usage: curl -fsSL https://raw.githubusercontent.com/johnhaup/haup-term/main/bootstrap.sh | bash

set -euo pipefail

REPO="https://github.com/johnhaup/haup-term.git"
DEST="$HOME/Projects/haup-term"

# --- Ensure git is available ---
if ! command -v git &>/dev/null; then
  echo "Installing git..."
  case "$(uname -s)" in
    Darwin)
      # Triggers Xcode Command Line Tools install
      xcode-select --install 2>/dev/null || true
      echo "Xcode CLT install prompted. Re-run this script after it finishes."
      exit 0
      ;;
    Linux)
      if command -v apt-get &>/dev/null; then
        sudo apt-get update -qq && sudo apt-get install -y git
      elif command -v dnf &>/dev/null; then
        sudo dnf install -y git
      elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm git
      fi
      ;;
  esac
fi

# --- Clone or update ---
mkdir -p "$(dirname "$DEST")"
if [[ -d "$DEST" ]]; then
  echo "haup-term already cloned, pulling latest..."
  git -C "$DEST" pull
else
  echo "Cloning haup-term..."
  git clone "$REPO" "$DEST"
fi

# --- Add bin/ to PATH ---
cd "$DEST"
./setup.sh

# --- Install tools ---
export PATH="$DEST/bin:$PATH"
term-refresh

echo ""
echo "Done! Open a new terminal or run: source ~/.zshrc"
