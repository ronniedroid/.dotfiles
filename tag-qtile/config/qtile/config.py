from typing import List  # noqa: F401
from libqtile import bar, layout, widget
from libqtile.config import (
    EzClick as Click,
    EzDrag as Drag,
    Group,
    EzKey as Key,
    Match,
    Screen,
)
from libqtile.lazy import lazy

mod = "mod4"

colors = {
    "black": "000000",
    "red": "ff8059",
    "green": "184043",
    "yellow": "eecc00",
    "blue": "2544bb",
    "purple": "9a57a3",
    "magenta": "feacd0",
    "cyan": "00d3d0",
    "white": "ffffff",
    "grey": "d6d6d6",
}

keys = [
    Key("M-<minus>", lazy.layout.shrink()),
    Key("M-<plus>", lazy.layout.grow()),
    Key("M-n", lazy.layout.down()),
    Key("M-p", lazy.layout.up()),
    Key("M-C-n", lazy.layout.shuffle_down()),
    Key("M-C-p", lazy.layout.shuffle_up()),
    Key("M-<Tab>", lazy.next_layout()),
    Key("M-q", lazy.window.kill()),
    Key("M-C-r", lazy.restart()),
    Key("M-C-<Return>", lazy.layout.flip()),
    Key("M-C-e", lazy.window.toggle_floating()),
    Key("M-m", lazy.window.toggle_maximize()),
    Key("M-w", lazy.to_screen(0)),
    Key("M-e", lazy.to_screen(1)),
]


def format_match(wm_class):
    match = Match(wm_class=[wm_class])
    return match


def wmc(wm_classes):
    matched = map(format_match, wm_classes)
    return [item for item in matched]


groups = [
    Group(name="a", label="a", matches=wmc(["Firefox", "Brave-browser"])),
    Group(name="s", label="s", matches=wmc(["Emacs"])),
    Group(name="d", label="d"),
    Group(name="f", label="f", matches=wmc(["Thunderbird"])),
    Group(name="u", label="u"),
    Group(name="i", label="i", matches=wmc(["Virt-manager"])),
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
        border_focus=colors["blue"],
    ),
    layout.Max(),
]

widget_defaults = dict(
    font="Hack Nerd Font",
    fontsize=16,
    padding=6,
    margin=0,
    foreground=colors["black"],
    background=colors["grey"],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
         bottom=bar.Bar(
             [
                 widget.CurrentScreen(
                     active_text="ﮋ",
                     inactive_text="ﮋ",
                     active_color=colors["blue"],
                     inactive_color=colors["black"],
                     padding=-3,
                 ),
                 widget.GroupBox(
                     highlight_method="block",
                     borderwidth=2,
                     hide_unused=True,
                     center_aligned=True,
                     use_mouse_wheel=False,
                     block_highlight_text_color=colors["grey"],
                     this_current_screen_border=colors["blue"],
                     this_screen_border=colors["purple"],
                     other_current_screen_border=colors["purple"],
                     other_screen_border=colors["purple"],
                     active=colors["blue"],
                     fontsize=14,
                     padding_x=4,
                     padding_y=2,
                     margin_x=6,
                     margin_y=4,
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
             28,
         ),
    ),
    Screen(
         bottom=bar.Bar(
             [
                 widget.CurrentScreen(
                     active_text="ﮋ",
                     inactive_text="ﮋ",
                     active_color=colors["blue"],
                     inactive_color=colors["black"],
                     padding=-3,
                 ),
                 widget.CurrentLayoutIcon(
                     scale=0.5,
                     custom_icon_paths=["/home/ronnie/.config/qtile/icons"],
                 ),
                 widget.GroupBox(
                     highlight_method="block",
                     borderwidth=2,
                     hide_unused=True,
                     center_aligned=True,
                     use_mouse_wheel=False,
                     block_highlight_text_color=colors["grey"],
                     this_current_screen_border=colors["blue"],
                     this_screen_border=colors["purple"],
                     other_current_screen_border=colors["purple"],
                     other_screen_border=colors["purple"],
                     active=colors["blue"],
                     fontsize=14,
                     padding_x=4,
                     padding_y=2,
                     margin_x=6,
                     margin_y=4,
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
             28,
         ),
    ),
]

mouse = [
    Drag(
        "M-1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag("M-3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click("M-2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = False
bring_front_click = False
cursor_warp = True
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
    ],
    border_focus=colors["purple"],
    border_normal=colors["black"],
)
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "LG3D"
