# .dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

- `git`
- `zsh`
- `stow`
- Apps you want to manage here, such as `ghostty`, `zed`, and `zellij`

## Install

From the repo root:

1. Install (or update) Oh My Zsh and plugins:

   ```bash
   zsh install.sh
   ```

   This will clone/update:
   - `~/.oh-my-zsh`
   - `~/.oh-my-zsh/custom/plugins/zsh-completions`
   - `~/.oh-my-zsh/custom/plugins/zsh-autosuggestions`
   - `~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`

2. Symlink configs into `$HOME` using stow:

   ```bash
   zsh bootstrap.sh
   ```

   This will prompt for each available package and can now also install `zellij/.config/zellij/config.kdl`.

   If `stow` reports conflicts, it means you already have files/directories at the target paths.
   Move them aside (or remove them) and re-run `bootstrap.sh`.

3. Restart your shell:

   ```bash
   exec zsh
   ```

## Notes

- `zsh/.config/zsh/oh-my-zsh.sh` sets `ZSH_THEME="corn"`. If you don't have that theme, either add
  `~/.oh-my-zsh/custom/themes/corn.zsh-theme` or change `ZSH_THEME` to an existing one.
- `zed/.config/zed/bin/terminal-wrapper` will auto-attach to a per-project `zellij` session when
  `zellij` is installed. The default `zellij` config lives at `zellij/.config/zellij/config.kdl`.

## Update

```bash
git pull
zsh install.sh
zsh bootstrap.sh
```

## Uninstall

From the repo root:

```bash
stow --target="$HOME" -D zsh ghostty zed git zellij
```
