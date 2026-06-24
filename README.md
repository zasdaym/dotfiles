# dotfiles

Managed with [mise](https://mise.jdx.dev/dotfiles.html). Bootstrap a fresh
machine (installs Homebrew + mise, clones to `~/.dotfiles`, runs `mise bootstrap`):

```sh
curl -L https://s.id/zasdaym | bash
```

Once set up, re-apply changes with:

```sh
mise dotfiles apply   # symlink config files
mise bootstrap        # full setup: packages, dotfiles, macOS defaults, tools
```
