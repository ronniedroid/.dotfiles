local key = require("awful").key
local button = require("awful").button

local utils = {}

function utils.map(mod, k, func)
    local modifiers = {}
    if mod == "M" then
        modifiers = {modkey}
    elseif mod == "M-C" then
        modifiers = {modkey, "Control"}
    elseif mod == "M-S" then
        modifiers = {modkey, "Shift"}
    elseif mod == "M-S-C" then
        modifiers = {modkey, "Shift", "Control"}
    else
        return nil, "please enter one of the follwong, M, M-C, M-S, M-S-C" 
    end
    return key(modifiers, k, func)
end

function utils.button(mod, b, func)
    return button({mod}, b, func)
end

return utils