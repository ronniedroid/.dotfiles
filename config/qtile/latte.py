# Copyright (c) 2021 elParaguayo
# Copyright (c) 2022 ronniedroid
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
from __future__ import annotations

import shutil
import subprocess
import math
import re

from libqtile import bar
from libqtile.command.base import expose_command
from libqtile.log_utils import logger
from libqtile.widget import base

class LatteWidget(base._Widget):
    """
    The widget allows you to control whether the screen can sleep or not.

    The settings are handled by running the appropriate xset command.

    The widget displays the screen saver state via an icon, empty cup
    means screen can go to sleep, full cap mean it will stay awake.
    """

    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ("icon_size", None, "Size of the icon"),
        ("padding", 0, "Padding before icon"),
        ("background_colour_active", '804000', "Colour when latte is active"),
        ("background_colour_inactive", '404040', "Colour when latte is inactive"),
        ("padding", 0, "Padding before icon"),
    ]

    def __init__(self, **config):
        base._Widget.__init__(self, bar.CALCULATED, **config)
        self.add_defaults(LatteWidget.defaults)

        self.add_callbacks(
            {
                "Button1": self.toggle_awake,
            }
        )

        # Set up necessary variables
        self.awake = self.status()
        self.first_run = True

        # Variable to store icons
        self.surfaces = {}

        # Define some variables to prevent early errors
        self._icon_size = self.icon_size if self.icon_size is not None else self.bar.height - 1

    def calculate_length(self):
        width = self._icon_size + self.padding

        return width

    def status(self):

        if not shutil.which("xset"):
            logger.warning("'xset' is not installed.")
            return

        # Run the xset command
        proc = subprocess.run(["xset", "q"], capture_output=True, text=True).stdout
        matched = re.compile(r'Enabled').findall(proc)
        is_enabled = True if len(matched) > 0 and matched == 'Enabled' else False

        return is_enabled

    def status_change(self):
        # Something's changed so let's update display

        self.awake = not self.awake
        
        # Draw
        self.bar.draw()

    def draw(self):
        # Define an offset for x placement
        x_offset = 0

        # Clear the widget
        self.drawer.clear(self.background or self.bar.background)

        # Which icon do we need?
        x_offset += self.padding

        fill = self.foreground
        if self.awake:
            background = self.background_colour_active
        else:
            background = self.background_colour_inactive
            
        x = (self._icon_size + self.padding) / 2
        y = self.bar.height / 2
        circle_size = self._icon_size

        self.drawer.ctx.new_sub_path()
        self.drawer.ctx.move_to(x, y)
        self.drawer.ctx.line_to(x + circle_size, y)
        self.drawer.set_source_rgb(fill)
        self.drawer.ctx.stroke()
        self.drawer.ctx.new_sub_path()
        self.drawer.ctx.arc(x, y, circle_size / 2, 0, 2*math.pi)
        self.drawer.set_source_rgb(background)
        self.drawer.ctx.fill()
        self.drawer.ctx.new_sub_path()
        self.drawer.ctx.arc(x, y, circle_size / 2, 0, 2*math.pi)
        self.drawer.set_source_rgb(fill)
        self.drawer.ctx.stroke()
        if self.awake:
            self.drawer.ctx.new_sub_path()
            self.drawer.ctx.set_line_width(1.0)
            self.drawer.ctx.arc(x, y, circle_size / 3, 0, 2*math.pi)
            self.drawer.set_source_rgb(fill)
            self.drawer.ctx.stroke()
            self.drawer.ctx.new_sub_path()
            self.drawer.ctx.set_line_width(1.0)
            self.drawer.ctx.arc(x, y, circle_size / 5, 0, 2*math.pi)
            self.drawer.set_source_rgb(fill)
            self.drawer.ctx.stroke()

        # Increase offset
        x_offset += self._icon_size

        self.drawer.draw(offsetx=self.offset, offsety=self.offsety, width=self.length)

    def _run(self, cmd):

        if not shutil.which("xset"):
            logger.warning("'xset' is not installed.")
            return

        # Run the xset command
        subprocess.run(cmd.split())

        if not self.first_run:
            self.status_change()
        else:
            self.first_run = False
            
    @expose_command()
    def toggle_awake(self, *args, **kwargs):
        """Toggle between keeping and not keeping the screen awake"""
        if self.awake:
            cmd = "xset +dpms s on"
        else:
            cmd = "xset -dpms s off"
        self._run(cmd)

    @expose_command()
    def info(self):
        info = base._Widget.info(self)
        info["awake"] = self.awake
        return info
