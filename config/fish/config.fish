function fish_greeting
end

fish_add_path ~/.local/bin
fish_add_path ~/.local/bin/graalvm-ce-java17-22.1.0/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/go/bin

set -gx RCRC ~/.config
set -gx JAVA_HOME ~/.local/bin/graalvm-ce-java17-22.1.0
set XDG_CURRENT_DESKTOP Unity
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end

if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

fundle plugin 'jorgebucaran/hydro'

fundle init
