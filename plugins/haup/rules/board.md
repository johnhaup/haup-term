# The board

`board` (haup-term `bin/`) is John's one view of every piece of work open across Claude sessions on this machine. A thread is a piece of work with open items; it outlives the session. Keep it current, it costs one command.

- **When a turn changes state** (a new piece of work started, something merged or shipped, a question raised for John, a blocker hit, an item closed), end the turn with one `board set`. Not on every turn, and never for a question John asked that you answered.
- **One thread per piece of work**, not per session. The default thread is the repo. Use `--thread <short-name>` when the repo holds several unrelated efforts, and keep using the same name.
- **Fields:** `--title` once (what this is, five words), `--doing` every time (where it stands, one line, present tense), `--open <item>` for each unresolved item (the list replaces the old one, so pass all of them), `--blocked <why>` when it waits on someone, `--link` for every ticket key, PR number or URL the work touches.
- **Close it** with `board set --done` when the work is finished and verified, or when John says it is resolved. Do not close threads you did not open unless John asks.
- At session start the open threads for the repo are shown to you. Pick up the matching one; do not create a second thread for the same work.

```sh
board set --thread payments-retry --title "Retry failed payments job" --doing "PR up, waiting on review" --open "load test on staging" --link PROJ-412 --link 88
board set --thread payments-retry --done
```
