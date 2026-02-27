# .dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

- `zsh`
  - `~/.zshrc`
  - `~/.config/zsh/alias.sh`
- `ghostty`
  - `~/.config/ghostty/config`
- `zed`
  - `~/.config/zed/settings.json`
  - `~/.config/zed/keymap.json`
  - `~/.config/zed/tasks.json`

## Prerequisites

- `git`
- `zsh`
- `stow`

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

   If `stow` reports conflicts, it means you already have files/directories at the target paths.
   Move them aside (or remove them) and re-run `bootstrap.sh`.

3. Restart your shell:

   ```bash
   exec zsh
   ```

## Notes

- `zsh/.zshrc` sets `ZSH_THEME="corn"`. If you don't have that theme, either add
  `~/.oh-my-zsh/custom/themes/corn.zsh-theme` or change `ZSH_THEME` to an existing one.

## Update

```bash
git pull
zsh install.sh
zsh bootstrap.sh
```

## Uninstall

From the repo root:

```bash
stow --target="$HOME" -D zsh ghostty zed
```
