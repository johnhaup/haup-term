---
name: pipeline
description: Print where every app is in the Linear-driven agent pipeline — what is in progress, in QA, merged and waiting for a build, in TestFlight, in App Review, live — plus what is running right now, build holds and the last events. Use when asked "status", "where are we", "what's in TestFlight", "what are the agents doing", or "/pipeline".
---

# Pipeline status

Run this and show the output verbatim in a fenced code block:

```bash
/Users/johnhaupenthal/Projects/linear-runner/linear.sh status
```

Then add at most three short lines of interpretation: anything that needs John (a `NEEDS JOHN` row, a `held` build, a `FAILED` build, an agent running far longer than usual), and nothing else. If the output is self-explanatory, add nothing.

## How to read it

- **Board**: one row per Linear project. `→TF` is merged to `main` and waiting for the next build; `IN TF`, `REVIEW`, `LIVE` map to the TestFlight, App Review and Released states.
- **IN FLIGHT**: every issue In Progress, QA or App Review with its age, who owns it (`agent` = labelled `claude`, `john` = unlabelled, `NEEDS JOHN` = the runner stopped and wants a decision) and the last QA verdict.
- **BUILDS**: per auto project, whether a build is running, whether builds are held behind an issue (`buildBlockedBy` in `apps.json`), and the last build's result.
- **RECENT**: the last pipeline events from `~/Library/Logs/linear-runner.log`.

The Linear equivalent is the shared **Pipeline** view (Board layout, columns = Status, swimlanes = Project): https://linear.app/haupenthal/view/23fea5fc1a24

## Doing something about it

- A `needs-john` issue: fix what it asks, then swap the label back to `claude` to re-enter it.
- Nudge an issue by hand: `linear.sh state HAU-n "<State>"`, `linear.sh label HAU-n claude`.
- Ask the agents a question on any issue: a comment containing `@claude`.
- Release: `release.sh "<project>"` to submit the newest TestFlight build (writes release notes with you), `release.sh "<project>" --live` when Apple releases it.
- Runner README: `/Users/johnhaupenthal/Projects/linear-runner/README.md`.
