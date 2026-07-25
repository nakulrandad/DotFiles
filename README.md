# DotFiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Managed Files

- `~/.zshrc`
- `~/.tmux.conf`
- `~/.gitconfig`
- `~/.config/nvim/init.lua`
- VS Code user settings

VS Code config is stored in both platform-specific locations:

- macOS: `~/Library/Application Support/Code/User/`
- Linux: `~/.config/Code/User/`

`.chezmoiignore` keeps only the current OS path active during `chezmoi apply`.
VS Code keybindings are not managed by chezmoi. `vscode-keybindings.reference.json` is kept as a reference only, so each machine can keep local keybindings.

## Machine-Local Customization

For shell commands, aliases, and environment variables that should exist on only one machine, create:

```sh
~/.zshrc.local
```

`~/.zshrc` sources this file when it exists. Do not commit machine-specific shell commands to the shared `dot_zshrc`.

## Manifests

- `Brewfile`: macOS packages and apps.
- `packages-linux.txt`: Linux package checklist. Package names can vary by distro.
- `vscode-extensions.txt`: VS Code extensions installed by the chezmoi helper script when `code` is on `PATH`.

## New Machine Setup

Install chezmoi first.

macOS:

```sh
brew install chezmoi
```

Linux:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
```

Initialize this repo:

```sh
chezmoi init git@github.com:nakulrandad/DotFiles.git
chezmoi diff
chezmoi apply
```

Without SSH keys configured:

```sh
chezmoi init https://github.com/nakulrandad/DotFiles.git
chezmoi diff
chezmoi apply
```

Install macOS packages:

```sh
brew bundle --file "$(chezmoi source-path)/Brewfile"
```

For Linux, use `packages-linux.txt` as the package checklist for your distro.

After apply:

```sh
exec zsh
tmux source-file ~/.tmux.conf
```

## Existing Checkout

For an existing local checkout:

```sh
chezmoi init --source "$PWD"
chezmoi diff
chezmoi apply
```

## Updating This Setup

Edit files through chezmoi when possible:

```sh
chezmoi edit ~/.zshrc
chezmoi edit ~/.tmux.conf
chezmoi edit ~/.config/nvim/init.lua
chezmoi diff
chezmoi apply
```

Refresh VS Code extensions after editing `vscode-extensions.txt`:

```sh
chezmoi apply
```

## Common Commands

```sh
chezmoi status
chezmoi diff
chezmoi apply
chezmoi edit ~/.zshrc
```

## Notes

- Oh My Zsh must exist before `.zshrc` loads. The zsh plugin helper installs `zsh-autosuggestions` and `zsh-syntax-highlighting` into the Oh My Zsh custom plugin directory when possible.
- VS Code Neovim paths are templated with the current machine's home directory, so Linux usernames do not need to be fixed in the repo.
- Neovim plugins are installed by Neovim's built-in package manager when `~/.config/nvim/init.lua` loads.
