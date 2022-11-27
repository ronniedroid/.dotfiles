import os
import subprocess
from libqtile import bar, layout, hook, extension
from qtile_extras import widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras.widget.decorations import PowerLineDecoration

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
    Key([mod], "Space",  lazy.widget["keyboardlayout"].next_keyboard(), desc="Next keyboard layout."),
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

groups = [
    Group(name="a", label="ܐ", matches=[Match(wm_class="emacs")]),
    Group(name="s", label="ܣ", matches=[Match(wm_class="firefox"), Match(wm_class="librewolf")]),
    Group(name="d", label="ܕ", matches=[Match(wm_class="discord")]),
    Group(name="f", label="ܦ", matches=[Match(wm_class="Mail")]),
    Group(name="h", label="ܗ"),
    Group(name="j", label="ܥ"),
    Group(name="k", label="ܟ"),
    Group(name="l", label="ܠ", matches=[Match(wm_class="virt-manager")]),
]

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
    foreground=theme["foreground"],
    theme_path='/usr/share/icons/Papirus-Dark'
)
extension_defaults = widget_defaults.copy()

groupsWidget = dict(
    font="AramaicShimo",
    fontsize=24,
    highlight_method='block',
    block_highlight_text_color=theme["background"],
    this_current_screen_border=theme["foreground"],
    rounded=True,
)

kbdWidget= dict(
    configured_keyboards=['us','ara'],
    padding=10
)

powerWidget = dict(
    margin=10
)

alsaWidget = dict(
    mode="both",
    bar_width=20,
    icon_size=20,
    bar_colour_mute=theme["background"],
    bar_colour_normal=theme["background"],
    bar_colour_high=theme["background"],
    bar_colour_loud=theme["background"],
    margin=10,
    padding=0
)

lightWidget = dict(
    mode="both",
    bar_width=20,
    icon_size=20,
    bar_colour_low=theme["background"],
    bar_colour_normal=theme["background"],
    bar_colour_high=theme["background"],
    padding=10
)

systrayWidget = dict(
    icon_size=14,
    padding=10
)

clockWidget = dict(
    padding=1,
    format="%y-%m-%d %a %H:%M"
)

spacerWidget = dict(
    length=10,
)

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.Spacer(**spacerWidget),
                widget.GroupBox(**groupsWidget),
                widget.WindowName(),
                widget.Spacer(),
                widget.Systray(**systrayWidget),
                widget.LightControlWidget(**lightWidget),
                widget.UPowerWidget(**powerWidget),
                widget.ALSAWidget(**alsaWidget),
                widget.KeyboardLayout(**kbdWidget),
                widget.Clock(**clockWidget),
                widget.Spacer(**spacerWidget)
            ],
            30,
            background=theme["background"],
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
