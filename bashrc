# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTFILESIZE=0
export HISTSIZE=0
unset HISTFILE
alias ls='ls --color=auto'
PS1="\[\e[32m\]\w\[\e[m\]\[\e[31m\]_>\[\e[m\]"

alias i3conf='vim ~/.config/i3/config'
alias sxconf='vim ~/.config/sxhkd/sxhkdrc'
alias bspconf='vim ~/.config/bspwm/bspwmrc'
alias polyconf='vim ~/.config/polybar/config'
alias h='cd ~/'
alias c='cd ~/.config'
alias D='cd ~/Downloads'
alias d='cd ~/Documents'
alias fuck='sudo !!'
alias ls='exa -al'


#bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

PF_COL1=6 PF_COL2=7 PF_COL3=1 PF_SEP=":" pfetch
