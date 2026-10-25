---
name: done-check
description: Run the project's own type check, lint and tests and report the results before calling a task done. Use after making code changes, before saying work is finished, before committing, or when asked to "check", "verify the build" or "run the checks".
---

# Done check

Find the checks this project actually uses, run them, and report what happened. Never call work done while one fails.

## 1. Find the commands

Look in this order and use the first that exists:

1. Commands named in the repo's `CLAUDE.md`, `AGENTS.md`, `CONTRIBUTING.md` or CI config (`.github/workflows/*.yml`). CI is the best signal for what must pass.
2. Scripts in `package.json`: `typecheck`/`tsc`, `lint`, `test`, `check`. Run them with the lockfile's tool: `bun.lock` → `bun run`, `pnpm-lock.yaml` → `pnpm`, `yarn.lock` → `yarn`, `package-lock.json` → `npm run`.
3. Fallbacks by stack:
   - TypeScript with no typecheck script: `bunx tsc --noEmit` (or `npx`).
   - Swift / Xcode: `xcodebuild build` for the app scheme against a simulator destination; `xcodebuild test` only if the change touches tested code. Regenerate the project first if it comes from `project.yml` (XcodeGen) or `Package.swift`.
   - Python: `ruff check`, `mypy` or `pyright` if configured, `pytest`.
   - Go: `go vet ./...`, `go test ./...`. Rust: `cargo clippy`, `cargo test`.

Skip watch modes (`jest --watch`): pass `--watchAll=false` or the equivalent.

## 2. Run them

- Run the type check and lint on every change. Run tests when the change touches code with tests, or when CI runs them on every push.
- Coverage thresholds count: if CI runs coverage, run it too. A new file without tests can fail a folder's floor even when every test passes.
- Long suites: scope to the affected files first, then the full suite once before reporting done.

## 3. Report

- One line per check: command, pass or fail.
- For a failure, quote the actual error lines. Say whether your change caused it or it was already failing: check whether the failing file or test is in `git diff`. Never stash or reset to find out.
- Fix failures your change caused. Never silence them by disabling a lint rule, adding `@ts-ignore`, loosening a type, skipping a test or lowering a threshold unless the user agrees.
- If a check could not run (missing tool, needs a device, needs credentials), say so plainly instead of implying it passed.
