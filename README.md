# dotfiles

Personal dotfiles and configurations.

## Structure

- `nvim/`: Neovim configuration based on [LazyVim](https://www.lazyvim.org/)

## Installation / Sync

### Neovim

**Windows (PowerShell):**
```powershell
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target "$HOME\dotfiles\nvim"
```

**Linux / macOS:**
```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
```
