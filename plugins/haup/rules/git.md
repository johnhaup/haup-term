# Git safety

- Commit or push only when asked. Push to `main` only when asked in so many words; otherwise use a branch.
- Other agents or people may be working in the same checkout. Never `git checkout -- .`, `git reset --hard`, `git clean`, or `git stash`. Revert only files you changed, one path at a time, after checking the diff is yours.
- Before committing, stage only your own files by path. If the tree holds someone else's work, leave it unstaged and say so.
- Never commit secrets: `.env*`, `credentials.json`, `*.key`, `*.p8`, `*.mobileprovision`.
