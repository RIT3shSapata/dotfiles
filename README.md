# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Requirements

Install Git, GNU Stow, Zsh, Neovim, tmux, tmuxifier, Yazi, Lazygit, Git Delta, Posting, Ghostty, and AeroSpace. Git Delta provides the diff pager that Lazygit uses in the Changes tab. Ghostty and AeroSpace are macOS applications; the other tools can be installed using your platform's package manager.

On macOS with Homebrew:

```bash
brew install git stow zsh neovim tmux tmuxifier yazi lazygit git-delta posting
brew install --cask ghostty aerospace
```

## Install

```bash
git clone <repository-url> ~/.dotfiles
cd ~/.dotfiles
./install
```

The installer links home-directory packages into `$HOME` and links Yazi and Ghostty into `$XDG_CONFIG_HOME` (or `~/.config` when it is not set). Run `./install` again after pulling changes.

## Selective installation

From the repository directory:

```bash
stow --target="$HOME" zsh
stow --target="${XDG_CONFIG_HOME:-$HOME/.config}/yazi" yazi
stow --target="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty" ghostty
```

Back up existing real files before Stow creates links. `zsh/old.zshrc` is intentionally ignored and kept only as a reference.

## Uninstall

```bash
stow --delete --target="$HOME" aerospace lazyvim lazygit posting tmux tmuxifier zsh
stow --delete --target="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty" ghostty
stow --delete --target="${XDG_CONFIG_HOME:-$HOME/.config}/yazi" yazi
```

## Personal agent instructions

The `agent-configs` package stores explanation preferences for Codex and Claude Code.
The main installer links these preferences into their user directories with GNU Stow.
Both agents use one canonical `AGENTS.md` and the same instruction modules.

To install only this package, run these commands from the repository root:

```bash
./agent-configs/scripts/stow.sh --dry-run
./agent-configs/scripts/stow.sh
```

To remove its links, run `./agent-configs/scripts/stow.sh --delete`.
The preferences apply across local projects that use those user directories.
See [agent-configs/README.md](agent-configs/README.md) for the layout, module loading, and custom directory configuration.
