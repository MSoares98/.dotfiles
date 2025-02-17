### :clipboard: NOTES:
Most of the dotfiles are based on *typecraft* videos.

# :computer: Terminal Configs:
- Windows Terminal
- Catppuccin Mocha
- SauceCode Pro Nerd Font

# :calling: Dependencies:
- Git
- GNU Stow (>= 2.4.0)
- Starship (>= 1.19.0)
- nodejs/npm (>= v22.2.0/10.8.0)
- Tmux (>= 3.3a)
- NeoVim (>= v0.9.0)
- Rust/Cargo (>= 1.72.0)
- Vivid [Cargo] (>= 0.9.0)
- Eza [Cargo] (>= v0.10.1)
- Bat [Cargo] (>= 0.23.0)
- Fzf (>= 0.52.1)
- Ripgrep (>= 13.0.0)
- Pygmentize & Catppuccin [PIP]

# :hammer: Installation:

First, make sure you have all the dependencies installed properly.

Next, clone the repository and respective submodules using:
```bash
git clone --recurse-submodules https://github.com/MSoares98/.dotfiles.git
cd .dotfiles
```

Use GNU Stow to create the symlinks:
```bash
# To create nvim symlinks
stow nvim
```

# :wrench: Troubleshooting:

If tmux plugins are not working properly, delete `.config/tmux/plugins/*` folders and re-install everything with TPM using <LEADER> + I. (Leader should be Ctrl + S)
