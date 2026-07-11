# New Machine Setup

```bash
cd "$HOME"
git init
git remote add origin git@github.com:phuber92/dotfiles.git
git fetch origin main
git checkout -B main origin/main --force
git config --local status.showUntrackedFiles no
```
