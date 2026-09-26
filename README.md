# dotfiles

Personal dotfiles and configurations.

## Structure

```text
dotfiles/
├── .gitignore
├── README.md
├── sync.ps1        # Windows 一键同步与软链接辅助脚本
└── nvim/           # Neovim (LazyVim) 配置文件
    ├── init.lua
    ├── lazy-lock.json
    ├── lazyvim.json
    └── lua/
```

## Installation & Sync

### Windows
1. **自动软链接绑定（推荐，先退出 Neovim）**：
   ```powershell
   cd ~/dotfiles
   .\sync.ps1 -Link
   ```
   *绑定后，编辑 Neovim 配置即可直接生效并进入 Git 跟踪，无需重复复制。*

2. **一键推送改动到 GitHub**：
   ```powershell
   cd ~/dotfiles
   .\sync.ps1 -Push "commit message"
   ```

### Linux / macOS
```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
```
