# Global Claude Rules

## Core Principles

1. Don't assume. Don't hide confusion. Surface tradeoffs.
2. Minimum code that solves the problem. Nothing speculative.
3. Touch only what you must. Clean up only your own mess.
4. Define success criteria. Loop until verified.

## General

- **Package manager:** use the one the project's lockfile points to. With no lockfile, or in my own projects, use `bun` (`bun install`, `bun run`, `bun add`), never npm or yarn.
- **Delete files that are no longer used** — don't leave orphaned components, utilities, or types around. If a file is replaced or its functionality is absorbed elsewhere, remove it.
- Always run the project's type check and lint after making code changes before considering a task done.
- If a task or feature is implemented fresh, but has numerous bugs or does not work at all, before band-aiding it, take the time to reassess the ask and the implementation to validate the initial plan was not flawed.

Language-specific standards live in `~/.claude/rules/` and load only for matching files.
