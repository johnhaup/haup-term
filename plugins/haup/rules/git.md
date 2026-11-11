# Git safety

- Commit finished, verified work without being asked, and push it. In John's own repos push `main` directly; in a repo with a pull request workflow or a protected `main`, push a branch and open the PR. Never force-push.
- Other agents or people may be working in the same checkout. Never `git checkout -- .`, `git reset --hard`, `git clean`, or `git stash`. Revert only files you changed, one path at a time, after checking the diff is yours.
- Before committing, stage only your own files by path. If the tree holds someone else's work, leave it unstaged and say so.
- Never commit secrets: `.env*`, `credentials.json`, `*.key`, `*.p8`, `*.mobileprovision`.
