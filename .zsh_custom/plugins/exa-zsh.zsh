# Project:  exa-zsh
# File:     exa-zsh-plugin.zsh
# Author:   Mohamed Elashri
# Email:    muhammadelashri@gmail.com


if ! (( $+commands[exa] )); then
  print "zsh-exa-plugin: exa not found on path. Please install exa before using this plugin." >&2
  return 1
fi

# general use aliases
alias exa='exa --icons' 
#alias ls='exa' # just replace ls by exa and allow all other exa arguments
alias l='exa -lbF' #   list, size, type
alias ll='exa -la' # long, all
alias llm='ll --sort=modified' # list, long, sort by modification date
alias la='exa -lbhHigUmuSa' # all list
alias lx='exa -lbhHigUmuSa@' # all list and extended
alias tree='exa -a --tree' # tree view
alias lS='exa -1' # one column by just names

