#!/bin/bash
# Install Claude Code configuration using GNU Stow
#
# Usage:
#   ./install.sh          # Install (create symlinks)
#   ./install.sh --adopt  # Adopt existing files and replace with symlinks
#   ./install.sh --remove # Remove symlinks
#
# Prerequisites:
#   - GNU Stow: brew install stow
#
# This script symlinks the claude/ directory contents into ~/.claude/
# Existing files in ~/.claude/ that aren't managed here are left untouched.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Check for stow
if ! command -v stow &> /dev/null; then
    echo "Error: GNU Stow is not installed."
    echo "Install with: brew install stow"
    exit 1
fi

# Ensure ~/.claude exists
mkdir -p ~/.claude

if [[ "$1" == "--remove" || "$1" == "-r" ]]; then
    echo "Removing symlinks..."
    stow -D -t ~/.claude claude
    echo "Done. Symlinks removed."
elif [[ "$1" == "--adopt" || "$1" == "-a" ]]; then
    echo "Adopting existing files and creating symlinks..."
    echo "(Existing files will be moved into this repo)"
    stow --adopt -t ~/.claude claude
    echo "Done. Files adopted and symlinked."
    echo ""
    echo "Note: Check 'git diff' to see if adopted files differ from repo versions."
else
    echo "Installing Claude Code configuration..."
    echo ""
    # Check for conflicts first
    if ! stow -n -t ~/.claude claude 2>&1 | grep -q "would cause conflicts"; then
        stow -t ~/.claude claude
        echo "Done. Configuration symlinked to ~/.claude/"
    else
        echo "Conflicts detected! Existing files in ~/.claude/ would be overwritten."
        echo ""
        echo "Options:"
        echo "  ./install.sh --adopt   # Adopt existing files into this repo"
        echo "  rm ~/.claude/{CLAUDE.md,agents,commands} && ./install.sh"
        echo ""
        stow -n -t ~/.claude claude 2>&1 || true
        exit 1
    fi
    echo ""
    echo "Installed:"
    echo "  - CLAUDE.md (global instructions)"
    echo "  - agents/ (6 custom agents)"
    echo "  - commands/ (3 custom commands)"
fi
