###################################################
##################### My qTile ####################
###################################################

# Importing python/qtile libraries:

import os
import subprocess
import re
import socket
import os.path
from libqtile.config import  EzKey as Key, Screen, Group, Match, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, extension, hook
from libqtile.widget import Spacer, base
from typing import List  # noqa: F401

# Set Default modkey:
keys = [
    # Change Focus:
    Key("M-<Left>", lazy.layout.left()),
    Key("M-<Right>", lazy.layout.right()),
    Key("M-j", lazy.layout.down()),
    Key("M-k", lazy.layout.up()),
    # Swap places:
    Key("M-S-h", lazy.layout.swap_left()),
    Key("M-S-l", lazy.layout.swap_right()),
    Key("M-S-j", lazy.layout.shuffle_down()),
    Key("M-S-k", lazy.layout.shuffle_up()),
    Key("M-w", lazy.to_screen(0)),
    Key("M-y", lazy.to_screen(1)),
    Key("M-S-w", lazy.window.to_screen(0)),
    Key("M-S-y", lazy.window.to_screen(1)),


    # Resize keys:
    Key("M-h", lazy.layout.grow()),
    Key("M-l", lazy.layout.shrink()),
    Key("M-n", lazy.layout.normalize()),
    Key("M-m", lazy.layout.maximize()),
    # Move the master pane Left/Right:
    Key("M-<space>", lazy.layout.flip()),
    # Toggel fullscreen on/off:
    Key("M-f", lazy.window.toggle_fullscreen()),

    # Change Layout:
    Key("M-<Tab>", lazy.next_layout()),
    # Close focused window:
    Key("M-q", lazy.window.kill()),

    # Restart qtile in place:
    Key("M-C-r", lazy.restart()),

    # Open a run prompt:
    #Key("M- "r", lazy.spawncmd()),

    Key("M-r", lazy.run_extension(extension.WindowList(
        item_format="{id}: {window}",
        dmenu_ignorecase=True,
        dmenu_prompt=" Avilable Windows"
    ))),
]

groups = [
    Group(
        "1",
        label=""
    ),
    Group(
        "2",
        matches=[Match(wm_class=["firefox"])],
        label=""
    ),
    Group(
        "3",
        matches=[Match(wm_class=["Emacs"])],
        label=""
    ),
    Group(
        "4",
        matches=[Match(wm_class=["libreoffice", "Discord"])],
        label=""
    ),
    Group(
        "5",
        matches=[Match(wm_class=["Thunderbird"])],
        label=""
    ),
    Group(
        "6",
        matches=[Match(wm_class=["code-oss"])],
        label=""
    ),
    ]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key("M-%s" % i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key("M-S-%s" % i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.MonadTall(
        border_focus = "56b6c2",
        border_normal = "abb2bf",
        border_width = 2,
        margin = 5,
    ),
    layout.MonadWide(
        border_focus = "56b6c2",
        border_normal = "abb2bf",
        border_width = 2,
        margin = 5,
    ),
]


widget_defaults = dict(
    font='Hack Nerd Font',
    fontsize=16,
    background="282c34",
    foreground="abb2bf",
    padding=6,
    margin=6,
)

def get_bar():
    return bar.Bar([
       widget.GroupBox(
           active = "98c379",
           inactive = "abb2bf",
           this_current_screen_border = "61afef",
           highlight_method = "text",
           highlight_color=["282c34", "282c34"],
           center_aligned=True,
           rounded=False,
           borderwidth=0,
           padding=6,
       ),
      widget.Spacer(bar.STRETCH),
       widget.Systray(
       ),
       widget.TextBox(
           text='',
           foreground="c678dd",
       ),
       widget.KeyboardLayout(
       ),
       widget.TextBox(
           text='',
           foreground="56b6c2",
       ),
       widget.Battery(
           format = '{percent:2.0%}'
       ),
       widget.TextBox(
           text='',
           foreground="e5c07b",
       ),
       widget.Volume(
       ),
       widget.TextBox(
           text='',
           foreground="61afef",
       ),
       widget.Backlight(
           backlight_name="intel_backlight",
           #padding=0,
           #margin=0,
           format='{percent: 2.0%}'
       ),
       widget.TextBox(
           text='',
           foreground="98c379",
       ),
       widget.Clock(
           format='%B %d (%a) %H:%M',
       ),
       widget.TextBox(
           text='',
           foreground="e06c75",
       ),
       widget.Wlan(
           interface="wlp5s0",
           format="{essid}",
       ),
    ], 28, margin=0)

screens = [
    Screen(),
    Screen(),
]

# Drag floating layouts.
mouse = [
    Drag(["mod4"], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag(["mod4"], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click(["mod4"], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
],border_width=0)
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])
