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
| `term` | Terminal cheatsheet. Run `term` for everything, or `term fzf`, `term wezterm`, etc. for a specific tool. |
| `term-refresh` | Installs dev tools and configures the shell. Detects OS (macOS/Linux) and package manager (Homebrew, apt, dnf, pacman). Idempotent. |
| `claude-handoff [dir]` | Installs the Claude Code handoff kit into a project: `docs/AGENT_CONTEXT.md` (loaded every session), an archive for pruned entries, and a Stop hook that blocks ending a turn that changed code without updating the doc. Idempotent. |

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
| [ccache](https://ccache.dev) | Compiler cache for native iOS builds; `term-refresh` also exports `CCACHE_MAXSIZE`/`CCACHE_BASEDIR` so React Native builds share one 20 GB cache |
| [gh](https://cli.github.com) | GitHub CLI for PRs, issues, repos, and workflows |
| [gh-dash](https://github.com/dlvhdr/gh-dash) | GitHub dashboard TUI (`gh` extension) |
| [gh-enhance](https://github.com/dlvhdr/gh-enhance) | GitHub Actions monitor (`gh` extension) |
| [posting](https://github.com/darrenburns/posting) | Keyboard-driven TUI API client |
| [starship](https://starship.rs) | Cross-shell prompt |
| [fnm](https://github.com/Schniz/fnm) | Fast Node version manager |
| [bun](https://bun.sh) | Fast JavaScript runtime and package manager |
| [WezTerm](https://wezfurlong.org/wezterm/) | GPU-accelerated terminal (config linked to `~/.config/wezterm/wezterm.lua`) |
| [Handy](https://handy.computer) | Offline speech-to-text dictation, pastes into any app (plus `wtype`/`xdotool` on Linux) |
| [trash](https://github.com/ali-rantakari/trash) | Move files to Trash instead of `rm` (macOS only) |

## WezTerm

`term-refresh` links `config/wezterm.lua` to `~/.config/wezterm/wezterm.lua`, so every machine gets the same setup after a `git pull`. WezTerm reloads the config on save. Run `term wezterm` for the keys.

- **Theme:** Dracula (Official), a soft blue-black background.
- **Closing:** `Cmd+W` and closing a window never ask. Each tab has a × button, which closes without asking while a shell or a common program (Claude, `ssh`, `node`, editors, lazygit and others, listed in `skip_close_confirmation_for_processes_named`) is running, and asks for anything else.
- **Tabs:** at least 20 columns wide (up to 32). Each tab is labeled with the name you gave it (`Cmd+Shift+R`, or `Ctrl+Shift+R` on Linux; an empty name goes back to automatic), else the title the running program sets (Claude Code shows its current task, over `ssh` too), else the folder name.
- **Font:** Geist Mono, which `term-refresh` installs (Homebrew on macOS, the GitHub release on Linux). JetBrains Mono, built into WezTerm, is the fallback.
- **Trying fonts:** `Cmd+Shift+F` (`Ctrl+Shift+Alt+F` on Linux) lists popular coding fonts and applies one to the current window without saving it. Fonts missing on a machine fall back to JetBrains Mono, which WezTerm includes.
- **Tab colors:** each new tab takes the next Dracula accent (purple, pink, cyan, green, orange, yellow, red, then around again) and keeps it while it's open, so neighboring tabs differ even in the same repo. The active tab is filled with that color; inactive tabs show it as text.

## Claude Code

`term-refresh` links `config/claude/CLAUDE.md` to `~/.claude/CLAUDE.md`, links each file in `plugins/haup/rules/` into `~/.claude/rules/`, and installs the `haup` plugin from this repo's marketplace. Skills are read straight from this folder, so edits apply on the next session.

| Skill | What it does |
|---|---|
| `done-check` | Runs the project's own type check, lint and tests and reports results before work is called done |
| `verify-ui` | Builds and looks at a UI change on a dedicated simulator, emulator or browser |
| `init-repo` | Writes a short CLAUDE.md for a repo that has none |

Rules: `git.md` always loads; `react-native.md` and `expo.md` load only when Claude works on matching files.

Without the rest of haup-term:

```bash
claude plugin marketplace add johnhaup/haup-term
claude plugin install haup@haup-term
```

## Supported Platforms

- **macOS** — Homebrew
- **Linux** — Homebrew if installed (e.g. Bazzite/Fedora Atomic), otherwise apt (Debian/Ubuntu), dnf (Fedora), pacman (Arch)
