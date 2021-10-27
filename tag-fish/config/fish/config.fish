function fish_greeting
    pfetch
end


set -x PF_INFO "ascii title os kernel uptime memory shell"
set -x PF_COL1 "5"
set -x PF_COL2 "9"
set -x PF_COL3 "4"
set -x PF_ALIGN "10"
set -x EDITOR = nvim

if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

fundle plugin 'PatrickF1/fzf.fish'
fundle plugin 'jethrokuan/z'
fundle plugin 'jorgebucaran/hydro'
fundle plugin 'ryotako/fish-vimcolor'

fundle init
