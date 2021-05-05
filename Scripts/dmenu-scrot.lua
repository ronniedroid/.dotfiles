#!/bin/lua

package.path = package.path .. ';/home/ronnie/.Scripts/?.lua'
local utils = require('utils')
local menu = utils.menu
local switch = utils.switch

function screenshot(name, opt, time)
    os.execute(('maim %s %s ~/Pictures/%s.png'):format(opt, time, name))
    os.execute([[notify-send "Screenshot taken"]])
end

function take_screenshot()
    local name = menu('screenshot_name', 0, 'name')
    if name == nil then
        name = os.date():sub(9)
        print (os.data():sub(9))
    end
    local mode = menu('mode', 3, [[echo -e 'quick\ndelay\nselection']])
    switch(mode).case(
        'quick',
        function()
            screenshot(name, '-d', '1')
        end
    ).case(
        'delay',
        function()
            local time = menu('delay_time', 0, 'delay')
            if tonumber(time) == nil then return end
            screenshot(name, '-d', time)
        end
    ).case(
        'selection',
        function()
            screenshot(name, '-s', '')
        end
    ).default(
        function()
            os.execute([[notify-send "you did not make a choice"]])
        end
    ).process()
end

take_screenshot()
