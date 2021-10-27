#!/bin/lua

package.path = package.path .. ";/home/ronnie/.Scripts/?.lua"
local utils = require("utils")
local menu = utils.menu
local switch = utils.switch

function screenshot(name, opt, time)
  os.execute(("sleep %s && grim %s ~/Pictures/%s.png"):format(time, opt, name))
  os.execute([[notify-send "Screenshot taken"]])
end

function take_screenshot()
  local name = menu("screenshot_name", 0, "name")
  if name == nil then
    name = os.date():sub(9)
    print(os.date():sub(9))
  end
  local mode = menu("mode", 3, [[echo -e 'quick\ndelay\nscreen1\nscreen2\nwindow']])
  switch(mode).case(
    "quick",
    function()
      screenshot(name, "", "1")
    end
  ).case(
    "delay",
    function()
      local time = menu("delay_time", 0, "delay")
      if tonumber(time) == nil then
        return
      end
      screenshot(name, "", time)
    end
  ).case(
    "screen1",
    function()
      local current = os.execute("swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name'")
      screenshot(name, ("-o %s"):format(current), "0")
    end
  ).case(
    "screen2",
    function()
      screenshot(name, "-o HDMI-A-1", "0")
    end
  ).case(
    "window",
    function()
      screenshot(name, "-o HDMI-A-1", "0")
    end
  ).default(
    function()
      os.execute([[notify-send "you did not make a choice"]])
    end
  ).process()
end

take_screenshot()
