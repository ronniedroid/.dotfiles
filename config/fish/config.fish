function fish_greeting
end

set -gx RUSTUP_HOME ~/.local/bin/rustup
set -gx CARGO_HOME ~/.local/bin/cargo
set -gx GOPATH ~/.local/bin/go
set -gx GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx GHCUP_USE_XDG_DIRS true

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/bin/cargo/bin
fish_add_path $HOME/.local/bin/go/bin
fish_add_path $HOME/.composer/vendor/bin
fish_add_path $HOME/.cabal/bin
fish_add_path $HOME/.ghcup/bin

set -gx JAVA_HOME ~/.local/bin/graalvm-ce-java17-22.1.0
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share
set XDG_CURRENT_DESKTOP sway
set XDG_SESSION_TYPE wayland

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end

if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

fundle plugin 'jorgebucaran/hydro'

fundle init
