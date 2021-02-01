
---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local theme_dir = gfs.get_configuration_dir() .. '/theme'
local titlebar_theme = 'win10'
local titlebar_icon_path = theme_dir .. '/icons/titlebar/' .. titlebar_theme .. '/'
local tip = titlebar_icon_path

local theme = {}

theme.font          = "Cascadaia Code 10"

theme.bg_normal     = "#282c34"
theme.bg_focus      = "#abb2bf"
theme.bg_urgent     = "#e06c75"
theme.bg_minimize   = "#e5c07b"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#abb2bf"
theme.fg_focus      = "#282c34"
theme.fg_urgent     = "#000000"
theme.fg_minimize   = "#fafafa"

theme.useless_gap   = dpi(3)
theme.border_width  = dpi(1)
theme.border_normal = "#282c34"
theme.border_focus  = "#abb2bf"
theme.border_marked = "#2fafff"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.titlebar_bg_focus = "#2b2c34"
theme.titlebar_bg_normal = "#2b2c34"

theme.taglist_fg_occupied = "#fafafa"
-- Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--    taglist_square_size, theme.fg_normal
-- )

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = tip.."close_normal.svg"
theme.titlebar_close_button_focus  = tip.."close_focus.svg"

theme.titlebar_minimize_button_normal = tip.."minimize_normal.svg"
theme.titlebar_minimize_button_focus  = tip.."minimize_focus.svg"

theme.titlebar_ontop_button_normal_inactive = tip.."ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = tip.."ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = tip.."ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active  = tip.."ontop_focus_active.svg"

theme.titlebar_sticky_button_normal_inactive = tip.."sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  = tip.."sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active = tip.."sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active  = tip.."sticky_focus_active.svg"

theme.titlebar_floating_button_normal_inactive = tip.."floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = tip.."floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = tip.."floating_normal_active.svg"
theme.titlebar_floating_button_focus_active  = tip.."floating_focus_active.svg"

theme.titlebar_maximized_button_normal_inactive = tip.."maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive  = tip.."maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = tip.."maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active  = tip.."maximized_focus_active.svg"

theme.wallpaper = "~/.config/wall.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
