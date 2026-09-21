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

Fresh machine? One command does everything:

```bash
curl -fsSL https://raw.githubusercontent.com/johnhaup/haup-term/main/bootstrap.sh | bash
```

Or step by step:

```bash
git clone https://github.com/johnhaup/haup-term.git ~/Projects/haup-term
cd ~/Projects/haup-term
./setup.sh           # adds bin/ to your PATH
source ~/.zshrc      # or ~/.bashrc
term-refresh         # installs tools and configures your shell
```

## Scripts

| Command | Description |
|---|---|
| `term` | Terminal cheatsheet. Run `term` for everything, or `term fzf`, `term yazi`, etc. for a specific tool. |
| `term-refresh` | Installs dev tools and configures the shell. Detects OS (macOS/Linux) and package manager (Homebrew, apt, dnf, pacman). Idempotent. |

## What `term-refresh` installs

| Tool | Description |
|---|---|
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder for files, history, and anything piped in |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart `cd` that learns your most-used directories |
| [yazi](https://github.com/sxyazi/yazi) | Terminal file manager with vim-style navigation |
| [lazygit](https://github.com/jesseduffield/lazygit) | Terminal UI for git |
| [fd](https://github.com/sharkdp/fd) | Fast, user-friendly alternative to `find` |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting and git diffs |
| [eza](https://github.com/eza-community/eza) | Modern `ls` with tree view, git status, and icons |
| [htop](https://htop.dev) | Interactive process viewer |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Blazing fast `grep` alternative |
| [jq](https://github.com/jqlang/jq) | JSON processor for the command line |
| [posting](https://github.com/darrenburns/posting) | Keyboard-driven TUI API client |
| [starship](https://starship.rs) | Cross-shell prompt |
| [fnm](https://github.com/Schniz/fnm) | Fast Node version manager |
| [bun](https://bun.sh) | Fast JavaScript runtime and package manager |
| [rbenv](https://github.com/rbenv/rbenv) | Ruby version manager (macOS only) |
| [trash](https://github.com/ali-rantakari/trash) | Move files to Trash instead of `rm` (macOS only) |

## Supported Platforms

- **macOS** — Homebrew
- **Linux** — apt (Debian/Ubuntu), dnf (Fedora), pacman (Arch)
