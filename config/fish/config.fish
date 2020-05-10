set PATH $HOME/.Scripts/ $PATH
set PATH $HOME/.Scripts/statusbar $PATH
set PATH $HOME/.local/bin/ $PATH
set PATH /opt/texlive/2020/bin/x86_64-linux $PATH

export MANPAGER='nvim +Man!'
export MANWIDTH=999
export EDITOR='nvim'

PF_INFO="ascii title os kernel shell wm editor pkgs memory palette" PF_COL1=6 PF_COL2=7 PF_COL3=1 pfetch

fish_vi_key_bindings
