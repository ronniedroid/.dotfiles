---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require('beautiful.theme_assets')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local gears = require('gears')

local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local roundness = 6

local theme = {}

local colors = {
    offwhite = '#ffffff',
    black = '#191a1b',
    red = '#ff8059',
    green = '#00fc50',
    yellow = '#eecc00',
    blue = '#29aeff',
    purple = '#b6a0ff',
    magenta = '#feacd0',
    cyan = '#00d3d0',
    white = '#dddddd',
    grey = '#323232'
}

theme.font = 'Cascadaia Code 10'

theme.bg_normal = colors.black
theme.bg_focus = colors.offwhite
theme.bg_urgent = colors.red
theme.bg_minimize = colors.yellow
theme.bg_systray = theme.bg_normal

theme.fg_normal = colors.purple
theme.fg_focus = colors.black
theme.fg_urgent = colors.black
theme.fg_minimize = colors.black

theme.gap_single_client = true
theme.useless_gap = dpi(5)
theme.border_width = dpi(3)
theme.border_normal = colors.grey
theme.border_focus = colors.purple
theme.border_marked = colors.blue

theme.systray_icon_spacing = 3

theme.taglist_fg_focus = colors.purple
theme.taglist_bg_focus = colors.black
theme.taglist_fg_empty = colors.offwhite
theme.taglist_fg_occupied = colors.grey
theme.taglist_spacing = 3
theme.taglist_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, roundness)
end

theme.tasklist_disable_icon = true
theme.tasklist_align = "center"
theme.tasklist_bg_focus = colors.grey
theme.tasklist_bg_normal = colors.grey
theme.tasklist_fg_normal = colors.offwhite
theme.tasklist_fg_focus = colors.purple
theme.tasklist_spacing = 5
theme.tasklist_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, roundness)
end

theme.menu_submenu_icon = themes_path .. 'default/submenu.png'
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

theme.wallpaper = '~/.config/wall.png'

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. 'default/layouts/fairhw.png'
theme.layout_fairv = themes_path .. 'default/layouts/fairvw.png'
theme.layout_floating = themes_path .. 'default/layouts/floatingw.png'
theme.layout_magnifier = themes_path .. 'default/layouts/magnifierw.png'
theme.layout_max = themes_path .. 'default/layouts/maxw.png'
theme.layout_fullscreen = themes_path .. 'default/layouts/fullscreenw.png'
theme.layout_tilebottom = themes_path .. 'default/layouts/tilebottomw.png'
theme.layout_tileleft = themes_path .. 'default/layouts/tileleftw.png'
theme.layout_tile = themes_path .. 'default/layouts/tilew.png'
theme.layout_tiletop = themes_path .. 'default/layouts/tiletopw.png'
theme.layout_spiral = themes_path .. 'default/layouts/spiralw.png'
theme.layout_dwindle = themes_path .. 'default/layouts/dwindlew.png'
theme.layout_cornernw = themes_path .. 'default/layouts/cornernww.png'
theme.layout_cornerne = themes_path .. 'default/layouts/cornernew.png'
theme.layout_cornersw = themes_path .. 'default/layouts/cornersww.png'
theme.layout_cornerse = themes_path .. 'default/layouts/cornersew.png'

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
