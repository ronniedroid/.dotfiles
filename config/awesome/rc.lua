-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local utils = require("utils")
local map = utils.map
local button = utils.button

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify(
    {
      preset = awful.key({modkey, "Shift"}, "p", awful.tag.viewprev, {description = "view previous", group = "tag"}),
      naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors
    }
  )
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal(
    "debug::error",
    function(err)
      -- Make sure we don't go into an endless error loop
      if in_error then
        return
      end
      in_error = true

      naughty.notify(
        {
          preset = naughty.config.presets.critical,
          title = "Oops, an error happened!",
          text = tostring(err)
        }
      )
      in_error = false
    end
  )
end
-- }}}

-- {{{ Variable definition
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Use correct status icon size
awesome.set_preferred_icon_size(32)

-- enable gaps for single clients
-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e nvim"

modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating
}
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons =
  gears.table.join(
  button(
    "",
    1,
    function(t)
      t:view_only()
    end
  ),
  button(
    modkey,
    1,
    function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end
  ),
  button("", 3, awful.tag.viewtoggle),
  button(
    modkey,
    3,
    function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end
  )
)

local tasklist_buttons =
  gears.table.join(
  button(
    "",
    1,
    function(c)
      if c == client.focus then
        c.minimized = true
      else
        c:emit_signal("request::activate", "tasklist", {raise = true})
      end
    end
  ),
  button(
    "",
    3,
    function()
      awful.menu.client_list({theme = {width = 250}})
    end
  )
)

local tags = {"  ", "  ", "  ", "  ", "  "}

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
awful.screen.connect_for_each_screen(
  function(s)
    -- Each screen has its own tag table.
    awful.tag(tags, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(
      gears.table.join(
        button(
          "",
          1,
          function()
            awful.layout.inc(1)
          end
        ),
        button(
          "",
          3,
          function()
            awful.layout.inc(-1)
          end
        )
      )
    )
    -- Create a taglist widget
    s.mytaglist =
      awful.widget.taglist {
      screen = s,
      filter = awful.widget.taglist.filter.all,
      buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist =
      awful.widget.tasklist {
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({position = "bottom", screen = s})

    -- Create systray
    s.systray = wibox.widget.systray()

    s.sep = wibox.widget.textbox(" ")

    -- Add widgets to the wiboxlocal key = require("awful").key

    s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      {
        -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.sep,
        s.mytaglist,
        s.sep
      },
      s.mytasklist, -- Middle widget
      {
        -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        s.sep,
        mykeyboardlayout,
        s.sep,
        s.systray,
        s.sep,
        mytextclock,
        s.sep,
        s.mylayoutbox,
        s.sep
      }
    }
  end
)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join())
-- }}}

-- {{{ Key bindings
globalkeys =
  gears.table.join(
  map("M-S", "p", awful.tag.viewprev),
  map("M-S", "n", awful.tag.viewnext),
  map(
    "M",
    "j",
    function()
      awful.client.focus.byidx(1)
    end
  ),
  map(
    "M",
    "k",
    function()
      awful.client.focus.byidx(-1)
    end
  ),
  -- Layout manipulation
  map(
    "M-S",
    "j",
    function()
      awful.client.swap.byidx(1)
    end
  ),
  map(
    "M-S",
    "k",
    function()
      awful.client.swap.byidx(-1)
    end
  ),
  map(
    "M",
    "n",
    function()
      awful.screen.focus_relative(1)
    end
  ),
  map(
    "M",
    "p",
    function()
      awful.screen.focus_relative(-1)
    end
  ),
  map(
    "M",
    "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end
  ),
  -- Standard program
  map("M-C", "r", awesome.restart),
  map("M-C", "q", awesome.quit),
  map(
    "M",
    "l",
    function()
      awful.tag.incmwfact(0.05)
    end
  ),
  map(
    "M",
    "h",
    function()
      awful.tag.incmwfact(-0.05)
    end
  ),
  map(
    "M-C",
    "space",
    function()
      awful.layout.inc(1)
    end
  )
)

clientkeys =
  gears.table.join(
  map(
    "M",
    "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end
  ),
  map(
    "M",
    "q",
    function(c)
      c:kill()
    end
  ),
  map("M-C", "f", awful.client.floating.toggle),
  map(
    "M-S",
    "Return",
    function(c)
      c:swap(awful.client.getmaster())
    end
  ),
  map(
    "M",
    "o",
    function(c)
      c:move_to_screen()
    end
  ),
  map(
    "M",
    "e",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end
  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys =
    gears.table.join(
    globalkeys,
    -- View tag only.
    map(
      "M",
      "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end
    ),
    map(
      "M-C",
      "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end
    ),
    -- Move client to tag.
    map(
      "M-S",
      "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end
    ),
    map(
      "M-S-C",
      "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end
    )
  )
end

clientbuttons =
  gears.table.join(
  -- awful.button({ }, 1, function (c)
  --     c:emit_signal("request::activate", "mouse_click", {raise = true})
  -- end),
  button(
    "",
    1,
    function(c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
    end
  ),
  --    awful.button({ modkey }, 1, function (c)
  --        c:emit_signal("request::activate", "mouse_click", {raise = true})
  --        awful.mouse.client.move(c)
  --    end),
  button(
    modkey,
    1,
    function(c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.move(c)
    end
  ),
  --    awful.button({ modkey }, 3, function (c)
  --        c:emit_signal("request::activate", "mouse_click", {raise = true})
  --        awful.mouse.client.resize(c)
  --    end)
  button(
    modkey,
    3,
    function(c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.resize(c)
    end
  )
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      client.connect_signal(
        "manage",
        function(c)
          c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 5)
          end
        end
      )
    }
  },
  {
    rule = {class = "discord"},
    properties = {tag = "5"}
  },
  -- Floating clients.
  {
    rule_any = {
      instance = {
        "TEST" -- Firefox addon DownThemAll.
      },
      class = {
        "TEST"
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "TEST" -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = {floating = true}
  },
  -- Add titlebars to normal clients and dialogs
  {
    rule_any = {
      type = {"normal", "dialog"}
    },
    properties = {titlebars_enabled = false}
  },
  {
    rule = {class = "discord"},
    properties = {tag = awful.screen.focused().tags[5]}
  }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal(
  "manage",
  function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end
)

client.connect_signal(
  "focus",
  function(c)
    c.border_color = beautiful.border_focus
  end
)
client.connect_signal(
  "unfocus",
  function(c)
    c.border_color = beautiful.border_normal
  end
)
-- }}}

awful.spawn.with_shell('~/.config/default.sh')
awful.spawn.with_shell('wall-d -f -r')
