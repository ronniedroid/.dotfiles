import os
import subprocess
from libqtile import bar, layout, widget, hook, extension
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

theme = {
    "background": "#000000",
    "foreground": "#ffffff"
}

dmenu_theme = dict(
    dmenu_font="JetBrainsMono Nerd Font Mono",
    background=theme["background"],
    foreground=theme["foreground"],
    selected_background=theme["foreground"],
    selected_foreground=theme["background"],
    dmenu_bottom=True,
    dmenu_ignorecase=True,
)

keys = [
    Key([mod], "n", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "p", lazy.layout.up(), desc="Move focus up"),
    Key([mod, "control"], "n", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "control"], "p", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "p", lazy.layout.grow(), desc="Grow window to the left"),
    Key([mod, "shift"], "n", lazy.layout.shrink(), desc="Grow window to the right"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    # volume and brightness controlls using the appropriate keys
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%-"), desc="Lower Volume by 5%"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+"), desc="Raise Volume by 5%"),
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master 1+ toggle"), desc="Mute/Unmute Volume"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 5"), desc="Brightness up"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 5"), desc="Brightness down"),
    # vulume and brightnes controlls using the arrow keys
    Key([mod], "Left", lazy.spawn("amixer sset Master 5%-"), desc="Lower Volume by 5%"),
    Key([mod], "Right", lazy.spawn("amixer sset Master 5%+"), desc="Raise Volume by 5%"),
    Key([mod], "Up", lazy.spawn("light -A 5"), desc="Brightness up"),
    Key([mod], "Down", lazy.spawn("light -U 5"), desc="Brightness down"),
    # switch keyboard layouts
    Key([mod], "Space", lazy.spawn("switchKbdLayout.sh")),
    # take a screenshot
    Key([mod], "t", lazy.spawn("dmenu-scrot.sh")),
    # extentions
    Key([mod], "x", lazy.run_extension(extension.DmenuRun(
        dmenu_prompt=">",
        **dmenu_theme
    ))),
    Key([mod], "b", lazy.run_extension(extension.WindowList(
        dmenu_prompt="Windows",
        **dmenu_theme
    ))),
    Key([mod], "e", lazy.run_extension(extension.CommandSet(
        commands={
            'exit': 'qtile cmd-obj -o cmd -f shutdown',
            'reload': 'qtile cmd-obj -o cmd -f reload_config',
            'restart': 'systemctl reboot',
            'poweroff': 'systemctl poweroff'
        },
        dmenu_prompt="PowerMenu",
        **dmenu_theme
    )))
]

groups = [Group(i) for i in "asdfhjkl"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "control"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.MonadTall(
        border_focus=theme["background"],
        border_normal=theme["foreground"],
        border_width=2,
        margin=5,
        new_client_position="bottom",
        ratio=0.5),
    layout.Max(),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=15,
    padding=6,
    foreground=theme["foreground"]
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.Spacer(length=10),
                widget.GroupBox(
                    highlight_method='block',
                    block_highlight_text_color=theme["background"],
                    this_current_screen_border=theme["foreground"],
                    rounded=True,
                ),
                widget.WindowName(),
                widget.Spacer(),
                widget.Systray(icon_size=14, padding=10),
                widget.Spacer(length=10),
                widget.Sep(size_percent=50),
                widget.Battery(
                    charge_char="🔌",
                    discharge_char="🔋",
                    full_char="🔋",
                    empty_char="🪫",
                    notify_below=10,
                    format='{char}{percent:2.0%}'
                ),
                widget.Sep(size_percent=50),
                widget.Backlight(
                    backlight_name="intel_backlight",
                    format='🔅{percent:2.0%}'
                ),
                widget.Sep(size_percent=50),
                widget.Volume(emoji=False, fmt='📢{}'),
                widget.Sep(size_percent=50),
                widget.KeyboardLayout(fmt='🖮 {}', configured_keyboards=['us','ara']),
                widget.Sep(size_percent=50),
                widget.OpenWeather(location="Erbil", format='{location_city}: {temp}℃'),
                widget.Sep(size_percent=50),                
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.Spacer(length=10),
            ],
            24,
            background=theme["background"],
            border_width=[2, 0, 2, 0],
            border_color=[theme["background"], theme["background"], theme["background"], theme["background"]]
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])
