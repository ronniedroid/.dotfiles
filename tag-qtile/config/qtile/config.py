from typing import List  # noqa: F401
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, EzKey as Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"

colors = {
    "black": "191a1b",
    "red": "ff8059",
    "green": "00fc50",
    "yellow": "eecc00",
    "blue": "29aeff",
    "purple": "b6a0ff",
    "magenta": "feacd0",
    "cyan": "00d3d0",
    "white": "dddddd",
    "grey": "323232",
}

keys = [
    Key("M-h", lazy.layout.shrink()),
    Key("M-l", lazy.layout.grow()),
    Key("M-j", lazy.layout.down()),
    Key("M-k", lazy.layout.up()),
    Key("M-n", lazy.next_screen()),
    Key("M-p", lazy.prev_screen()),
    Key("M-C-j", lazy.layout.shuffle_down()),
    Key("M-C-k", lazy.layout.shuffle_up()),
    Key("M-<Tab>", lazy.next_layout()),
    Key("M-q", lazy.window.kill()),
    Key("M-C-r", lazy.restart()),
    Key("M-C-<Return>", lazy.layout.flip()),
    Key("M-f", lazy.window.toggle_floating()),
    Key("M-C-f", lazy.window.toggle_fullscreen()),
    Key("M-e", lazy.window.toggle_maximize()),
    Key("M-i", lazy.to_screen(0)),
    Key("M-o", lazy.to_screen(1)),
]

groups = [
    Group(name="1", label=""),
    Group(name="2", label=""),
    Group(name="3", label=""),
    Group(name="4", label=""),
    Group(name="5", label=""),
    Group(name="6", label=""),
]

for i in groups:
    keys.extend(
        [
            Key("M-{}".format(i.name), lazy.group[i.name].toscreen()),
            Key(
                "M-S-{}".format(i.name), lazy.window.togroup(i.name, switch_group=True)
            ),
            Key("M-C-{}".format(i.name), lazy.window.togroup(i.name)),
        ]
    )

layouts = [
    layout.MonadTall(
        border_width=1,
        single_border_width=0,
        margin=0,
        border_normal=colors["black"],
        border_focus=colors["purple"],
    ),
    layout.Max(),
]

widget_defaults = dict(
    font="Hack Nerd Font",
    fontsize=16,
    padding=6,
    margin=0,
    foreground=colors["purple"],
    background=colors["black"],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentScreen(
                    active_text="",
                    inactive_text="",
                    active_color=colors["purple"],
                    inactive_color=colors["grey"],
                    padding=4,
                ),
                widget.CurrentLayoutIcon(
                    scale=0.5,
                    custom_icon_paths=["/home/ronnie/.config/qtile/icons"],
                ),
                widget.GroupBox(
                    highlight_method="line",
                    highlight_color=[colors["black"], colors["black"]],
                    borderwidth=2,
                    hide_unused=True,
                    this_current_screen_border=colors["purple"],
                    this_screen_border=colors["grey"],
                    other_current_screen_border=colors["red"],
                    other_screen_border=colors["white"],
                    active=colors["purple"],
                    inactive=colors["grey"],
                    fontsize=20,
                    padding=0,
                    margin=3,
                ),
                widget.Spacer(),
                widget.Systray(),
                widget.Spacer(length=5),
                widget.TextBox(
                    text="墳",
                ),
                widget.Volume(),
                widget.Battery(
                    format="{char} {percent:2.0%}",
                    full_char="",
                    charge_char="",
                    discharge_char="",
                    empty_char="",
                    show_short_text=False,
                ),
                widget.TextBox(text=""),
                widget.Clock(format="%Y-%m-%d %a %H:%M"),
            ],
            24,
        ),
    ),
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentScreen(
                    active_text="",
                    inactive_text="",
                    active_color=colors["purple"],
                    inactive_color=colors["grey"],
                    padding=4,
                ),
                widget.CurrentLayoutIcon(
                    scale=0.5,
                    custom_icon_paths=["/home/ronnie/.config/qtile/icons"],
                ),
                widget.GroupBox(
                    highlight_method="line",
                    highlight_color=[colors["black"], colors["black"]],
                    borderwidth=2,
                    hide_unused=True,
                    this_current_screen_border=colors["purple"],
                    this_screen_border=colors["grey"],
                    other_current_screen_border=colors["red"],
                    other_screen_border=colors["white"],
                    active=colors["purple"],
                    inactive=colors["grey"],
                    fontsize=20,
                    padding=0,
                    margin=3,
                ),
                widget.Spacer(),
                widget.TextBox(
                    text="墳",
                ),
                widget.Volume(),
                widget.Battery(
                    format="{char} {percent:2.0%}",
                    full_char="",
                    charge_char="",
                    discharge_char="",
                    empty_char="",
                ),
                widget.TextBox(text=""),
                widget.Clock(format="%Y-%m-%d %a %H:%M"),
            ],
            24,
        ),
    ),
]

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
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

wmname = "LG3D"
