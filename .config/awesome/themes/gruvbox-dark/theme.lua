--     ____  ____  _  __
--    |  _ \|  _ \| |/ /
--    | | | | |_) | ' /  Clay Gomera (Drake)
--    | |_| |  _ <| . \  My custom awesomewm gruvbox-dark theme.
--    |____/|_| \_\_|\_\
--

--[[
  VARIABLES  
]]

local gears = require("gears")
local lain  = require("lain")
local lain_helpers = require("lain.helpers")
local awful = require("awful")
local wibox = require("wibox")
local lgi   = require("lgi")
local dpi   = require("beautiful.xresources").apply_dpi

-- Custom libraries
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.machine_name                              = lain_helpers.first_line("/sys/class/dmi/id/product_name")
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/gruvbox-dark"

-- fonts
local theme_font_type                       = "mononoki Nerd Font"
local theme_font_size                       = "9"
local hotkeys_font_type                     = "mononoki Nerd Font"
local hotkeys_font_size                     = "9"
theme.font                                  = theme_font_type .. " " .. theme_font_size
theme.hotkeys_font                          = hotkeys_font_type .. " " .. hotkeys_font_size
theme.hotkeys_description_font              = theme.font

theme.fg_normal                                 = "#ebdbb2"
theme.fg_focus                                  = "#FB4934"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#1d2021"
theme.bg_focus                                  = "#313131"
theme.bg_urgent                                 = theme.bg_normal
theme.border_width                              = dpi(1)
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#FB4934"
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = theme.bg_normal
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = "#FABD2F" -- gruvbox yellow
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_wireless_0                         = theme.dir .. "/icons/wireless_0.png"
theme.widget_wireless_1                         = theme.dir .. "/icons/wireless_1.png"
theme.widget_wireless_2                         = theme.dir .. "/icons/wireless_2.png"
theme.widget_wireless_3                         = theme.dir .. "/icons/wireless_3.png"
theme.widget_wireless_na                        = theme.dir .. "/icons/wireless_na.png"
theme.widget_wired                              = theme.dir .. "/icons/wired.png"
theme.widget_wired_na                           = theme.dir .. "/icons/wired_na.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(2)
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    "date +'%a %d %b %I:%M '", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)
-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

function theme.at_screen_connect(s)
    -- Tags
    awful.tag(awful.util.tagnames,
             s, awful.layout.layouts[1] -- Use first defined layout as default for initialized tags
            )

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))

    -- Keyboard map indicator and switcher
    mykeyboardlayout = awful.widget.keyboardlayout()
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.stack,
        {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.background(s.mylayoutbox, theme.bg_focus),
            spr,
            s.mytaglist,
        },
        nil,
        { -- Right widgets.
            layout = wibox.layout.fixed.horizontal,
            arrl_ld,
            wibox.container.background(mykeyboardlayout, theme.bg_focus),
            arrl_dl,
            arrl_ld,
            wibox.container.background(volume_widget{
            widget_type = 'icon_and_text',
            device = 'default'}, theme.bg_focus),
            arrl_dl,
            arrl_ld,
            wibox.container.background(battery_widget(), theme.bg_focus),
            arrl_dl,
            arrl_ld,
            wibox.container.background(brightness_widget{
            type = 'icon_and_text',
            program = 'xbacklight'}, theme.bg_focus),
            arrl_dl,
            arrl_ld,
            wibox.container.background(logout_menu_widget{
            font = 'mononoki Nerd Font'}, theme.bg_focus),
        },
        },
        {
            wibox.container.background(clock, theme.bg_normal),
            valign = "center",
            halign = "center",
            layout = wibox.container.place
        },
}
        end

return theme
