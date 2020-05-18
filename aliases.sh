# bat
alias cat='bat'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# prettyping
alias ping='prettyping --nolegend'

# fzf
alias preview="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

# htop
top='htop'

# exa
alias ls="exa"
# I usually use this command instead
alias l="exa -lahF"
