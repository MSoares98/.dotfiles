# PATH
export PATH="$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.scripts"
export PATH="$PATH:/opt/TurboVNC/bin"
export PATH="$PATH:/sw/nvim/bin"
export PATH="$PATH:$HOME/.tmuxifier/bin"

# QOL exports
export SQUEUE_FORMAT="%.7i %9P %35j %.8u %.2t %.12M %.12L %.5C %.7m %.4D %R"
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'
export ZSH_COLORIZE_STYLE="catppuccin-mocha"
export EZA_COLORS="$(vivid generate catppuccin-mocha)"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# Set NeoVim as default editor
export EDITOR=nvim
export VISUAL="$EDITOR"

# Catppuccin Mocha FZF colors
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Rust Cargo Env
. "$HOME/.cargo/env"
