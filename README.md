```
██╗  ██╗ █████╗ ██╗   ██╗██████╗        ████████╗███████╗██████╗ ███╗   ███╗
██║  ██║██╔══██╗██║   ██║██╔══██╗       ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
███████║███████║██║   ██║██████╔╝██████╗   ██║   █████╗  ██████╔╝██╔████╔██║
██╔══██║██╔══██║██║   ██║██╔═══╝ ╚═════╝   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
██║  ██║██║  ██║╚██████╔╝██║               ██║   ███████╗██║  ██║██║ ╚═╝ ██║
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝               ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
```

Cross-platform terminal setup for macOS and Linux.

## Quick Start

```bash
git clone https://github.com/johnhaup/haup-term.git ~/Projects/haup-term
cd ~/Projects/haup-term
./setup.sh        # adds bin/ to your PATH
setup              # installs tools and configures your shell
source ~/.zshrc    # or ~/.bashrc
```

## Scripts

| Command | Description |
|---|---|
| `setup` | Installs dev tools and configures the shell. Detects OS (macOS/Linux) and package manager (Homebrew, apt, dnf, pacman). Idempotent. |
| `term` | Terminal cheatsheet. Run `term` for everything, or `term fzf`, `term yazi`, etc. for a specific tool. |

## What `setup` installs

**CLI tools** (all platforms): fzf, zoxide, yazi, lazygit, fd, bat, eza, starship, fnm, bun

## Supported Platforms

- **macOS** — Homebrew
- **Linux** — apt (Debian/Ubuntu), dnf (Fedora), pacman (Arch)
