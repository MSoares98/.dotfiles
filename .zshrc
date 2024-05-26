export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Show .hidden files as normal files and set extended glob
setopt globdots
setopt extended_glob

## history
setopt APPEND_HISTORY
## for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# LOAD TMUXIFIER
eval "$(tmuxifier init -)"

# LOAD STARSHIP
eval "$(starship init zsh)"

# LOAD ALIASES
source ~/.custom_aliases

# LOAD Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# LOAD PLUGINS
source ~/.zsh_custom/plugins/eza-zsh.zsh
source ~/.zsh_custom/plugins/colored-man-pages.plugin.zsh
source ~/.zsh_custom/plugins/colorize.plugin.zsh
fpath=(~/.zsh_custom/plugins/zsh-completions/src $fpath)
source ~/.zsh_custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.zsh_custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh_custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# END, HOME and DEL functionality
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[H"  beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[3~" delete-char
