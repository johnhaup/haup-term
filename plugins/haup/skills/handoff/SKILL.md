---
name: handoff
description: Turn the current session into a short prompt a fresh agent can paste in to pick up the work where it stopped — state, what is done and verified, the next step, open questions and the rules learned along the way. Use when the user says "handoff", "write a handoff", "hand this off", "continue this in a new session", or when context is running low on long work.
---

## Invocation

```
/handoff                # whole session, then open a new tab running it
/handoff <focus>        # only the named thread of work, e.g. /handoff PROJ-123
/handoff --no-launch    # write the prompt only
```

## Goal

The reader is an agent with no memory of this session, the same tools, and the same machine. It needs enough to take the next step correctly. It does not need the story of how you got here. Aim for **under 300 words**, never over 500.

## Steps

1. **Check the live state first.** Do not write from memory.
   - For each repo or worktree touched: `git -C <path> status -sb`, `git log --oneline -3`, and unpushed commits (`git log @{u}..`).
   - Open PRs: `gh pr view <n> --json state,reviewDecision,statusCheckRollup,url`, plus unresolved review threads.
   - Ticket status for every ticket worked on.
   - Background processes still running: Metro, simulators, recorders, dev servers. Say which ones and on which ports, or stop them first.
   - The board thread, if one exists (`board` output at session start).
2. **Pick what carries over.** Keep:
   - **Goal.** One sentence on what the work is for.
   - **Where things are.** Absolute paths for repos and worktrees, the branch, PR and ticket links, and the harness or spec paths.
   - **Done and verified.** What is finished, and how it was verified (tests, typecheck, device run). Mark anything unverified as unverified.
   - **Next step.** The single next action, specific enough to start without asking.
   - **Model.** The model ID the next session should run, such as `claude-opus-5-5`. Default to the model this session runs on. Pick a different one only when the next step clearly calls for it (for example a mechanical follow-up that a smaller model handles), and give the reason in a few words.
   - **Open items.** Remaining work and questions waiting on the user, in order.
   - **Rules learned this session.** Corrections and preferences the user gave that are not already in CLAUDE.md or memory, for example "mute the mic in automated streams" or "ask before pushing".
   - **Traps.** Things that cost time and will again, for example "Maestro CLI can't drive a real iPhone, use `--phone`" or "revert `types.ts` after codegen".

   Drop:
   - Narrative ("first we tried…").
   - Tool output.
   - File contents. Point to the file instead.
   - Settled decisions the reader won't revisit.
   - Anything already in CLAUDE.md or memory. Link to it instead of repeating it.

3. **Write the prompt** in the shape below. Use plain sentences and short bullets. Write it in the second person, addressed to the agent.
4. **Hand it over.** Print the prompt in one fenced block so it can be copied. Also write it to `~/.claude/handoffs/<yyyy-mm-dd>-<slug>.md` and give that path. Also copy it to the clipboard (`pbcopy < <file>` on macOS).
5. **Launch it,** unless `--no-launch` was passed. Run `claude-continue --model <model> <handoff file> <primary working directory>`, where the directory is the repo or worktree named first under **Where**. It opens a WezTerm tab there, names the tab after the file, and starts `claude` with the handoff as its first prompt. If `wezterm` or `claude-continue` is missing, or `$WEZTERM_PANE` is unset, skip this step and say so.
6. If an item on the board changed, run `board set` with the open items, so the board and the handoff agree.

## Shape

```markdown
Continue <goal, one line>.

**Where:** <repo/worktree abs path> on `<branch>` · PR <url> · <PROJ-123> · harness <path if any>

**Done (verified):**

- <item> — <how verified>

**Next:** <the one next action>

**Model:** `<model id>` <reason, only if it differs from this session>

**Open:**

1. <item, owner if it waits on the user>

**Rules:** <user preferences learned this session, one line each>

**Traps:** <one line each>

**Running:** <processes and ports, or "nothing">

Read first: <2–4 files or docs, absolute paths>
```

Leave out any section that would be empty, except **Next** and **Model**.

## Don't

- Don't paste secrets, tokens, or the contents of `.env` files. Name the file instead.
- Don't claim something is done or verified unless this session checked it.
- Don't give the reader instructions that only the user can approve, such as pushing, deploying or going live. List them under **Open** as waiting on the user.
