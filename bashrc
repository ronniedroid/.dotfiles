# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1="\[\e[32m\]\w\[\e[m\]\[\e[31m\]_>\[\e[m\]"

alias i3conf='sudo vim ~/.config/i3/config'
alias sxconf='sudo vim ~/.config/sxhkd/sxhkdrc'
alias berryconf='sudo vim ~/.config/berry/autostart'
alias bsxconf='sudo vim ~/.config/berry/sxhkdrc'
alias polyconf='sudo vim ~/.config/polybar/config'
alias h='cd ~/'
alias c='cd ~/.config'
alias D='cd ~/Downloads'
alias d='cd ~/Documents'
alias fuck='sudo !!'


#bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

PF_COL1=6 PF_COL2=7 PF_COL3=1 PF_SEP=":" pfetch
