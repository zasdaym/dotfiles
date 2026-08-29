# dotfiles

Managed with [mise](https://mise.jdx.dev/dotfiles.html). Bootstrap a fresh
macOS or Linux x64 or arm64 machine. The installer installs mise, clones to
`~/.dotfiles`, and runs `mise bootstrap`:

```sh
curl -L https://s.id/zasdaym | bash
```

Once set up, re-apply changes with:

```sh
mise dotfiles apply   # symlink config files
```

Use the bootstrap command for your operating system:

```sh
mise -E macos bootstrap   # macOS setup
mise -E linux bootstrap   # Linux setup
```
