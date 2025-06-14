# Installation

## Quick install

```bash
curl -sSL https://raw.githubusercontent.com/yourusername/dotfiles/main/install.sh | bash
```


# Structure

```text
dotfiles/
├── install.sh                  # Main installation script
├── config/                     # symlinks to .config
│   ├── nvim/            
│   ├── zsh/
│   ├── tmux/
│   └── starship.toml           # Custom prompt
├── home/                       # Symlinks to ~
│   └── .zshrc       
├── windows-home/               # Copies to current user home dir if ran in wsl
│   └── .wizterm.lua            # Wizterm config
├── fonts/
└── README.md                   # This file
```
