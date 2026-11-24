[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[35m\]\W \[\e[34m\]\$\[\e[0m\] '
export PATH="$HOME/.local/bin:$PATH"
