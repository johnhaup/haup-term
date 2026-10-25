---
name: init-repo
description: Set up Claude Code in a repo that has none, or tighten an existing setup, by writing a short CLAUDE.md from what the repo actually does and optionally committing shared standards as .claude/rules. Use when starting in a new repo, a new job or client project, or when asked to "set up Claude here", "write a CLAUDE.md" or "add our coding standards to this repo".
---

# Init repo

Give the next session in this repo what it cannot learn quickly from the code. Keep it short: every line loads into every session.

## 1. Read before writing

- `README`, `package.json` / `Package.swift` / `project.yml` / `pyproject.toml`, lockfile, CI workflows, lint and format config, existing `CLAUDE.md`, `AGENTS.md`, `.cursor/rules`, `.github/copilot-instructions.md`.
- `git log --oneline -20` for commit message style.
- If a `CLAUDE.md` already exists, edit it rather than replacing it.

## 2. Write CLAUDE.md

Include only what is true and not obvious:

- **Commands:** install, dev server, build, type check, lint, test, and how to run one test. Copy them from scripts and CI, and run each one you list.
- **Layout:** the few folders that matter and anything generated (never edit generated files; name the command that regenerates them).
- **Conventions that differ from defaults:** shared components to use (text, buttons, inputs), theme and spacing constants, state management, import alias, commit style.
- **Verification:** how to see a change working (simulator script, storybook, local URL).

Leave out generic advice, anything a linter already enforces, and long code samples.

## 3. Shared standards (optional)

The `rules/` folder next to this plugin's `skills/` folder (`../../rules/` from this skill) holds the standards that `term-refresh` installs in `~/.claude/rules/`: `git.md`, `react-native.md`, `expo.md`.

Ask before adding any of them to the repo: at a job or client, the team may not want them committed. If they do, copy the ones that match the stack into `.claude/rules/`, then delete lines that conflict with the repo's own conventions or lint config. The repo's conventions win.

## 4. Handoff doc (optional)

For a repo where several sessions work over days, offer the handoff kit: `claude-handoff <repo>` from haup-term adds `docs/AGENT_CONTEXT.md` and a Stop hook that keeps it current. Skip it for small or short-lived repos.

## 5. Finish

Show the user the CLAUDE.md you wrote. Do not commit unless asked.
