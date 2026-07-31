# .dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/) and bootstrapped with Ansible.

## Profiles

- `cli`: shell and command-line tools.
- `desktop`: everything in `cli`, plus desktop apps managed by this repo.

## Install

From the repo root, run the full setup:

```bash
./setup.sh --profile desktop
```

For a CLI-only machine:

```bash
./setup.sh --profile cli
```

This will:

1. Install Ansible if it is missing.
2. Install tools for the selected profile.
3. Ask whether to make `zsh` your default shell.
4. Symlink configs into `$HOME` using `stow`.

You can also run the phases separately:

```bash
./install.sh --profile desktop
zsh bootstrap.sh
```

## Tools

The `cli` profile installs:

- `git`
- `zsh`
- `stow`
- `curl`
- `zoxide`
- `bat`
- `ripgrep`
- `starship`
- `zellij`
- `mise`
- standalone Zsh plugins used by `zsh/.config/zsh/plugins.sh`

The `desktop` profile also installs:

- `zed`
- `ghostty`

## Update

Refresh standalone tools and Zsh plugins:

```bash
./install.sh --profile desktop --update
```

Then refresh dotfile symlinks if needed:

```bash
zsh bootstrap.sh
```

Package-manager updates are still owned by each platform package manager, such as `brew`, `apt`, or `snap`.

## Notes

- `zsh/.config/zsh/plugins.sh` adds `zsh-completions` to `fpath`, runs `compinit`, and sources the standalone Zsh plugins.
- Machine-local Zsh config can live in `~/.config/zsh/local.sh`; see `zsh/.config/zsh/local.sh.example`.

## Uninstall

From the repo root:

```bash
stow --target="$HOME" -D zsh ghostty zed git zellij
```
