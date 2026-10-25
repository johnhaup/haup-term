# Agent Context

Running handoff document for anyone (human or agent) working in this repo. It is loaded into
every Claude Code session through CLAUDE.md and enforced by a Stop hook: a turn that changes
code cannot end until this file is touched too.

Keep it under ~150 lines. When "Recent work" grows past the last few batches, move the oldest
entries verbatim to `docs/AGENT_CONTEXT_ARCHIVE.md` (newest first; it is never loaded, only
grepped). Lessons and open follow-ups are never pruned for length, only when they stop being
true. Dates are absolute (YYYY-MM-DD).

## Current state (YYYY-MM-DD)

- What the project is, which version or branch is current, and anything in flight.

## Recent work

- YYYY-MM-DD: What changed, why, and where to look.

## Lessons and pitfalls (do not repeat)

- Things that cost time once and must not cost it again. Say what happened and what to do instead.

## Open follow-ups

- Known gaps, unverified changes, and deferred work.
