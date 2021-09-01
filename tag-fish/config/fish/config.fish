function fish_greeting
    pfetch
end

if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end


fundle plugin 'PatrickF1/fzf.fish'
fundle plugin 'jethrokuan/z'
fundle plugin 'jorgebucaran/hydro'
fundle plugin 'ryotako/fish-vimcolor'

fundle init
