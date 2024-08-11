--- {{{ Imports
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local theme = require("theme.theme")
local battery = require("ui.widgets.battery")
local brightness = require("ui.widgets.brightness")
local layout = require("ui.widgets.layout")
local wifi = require("ui.widgets.wifi")
local volume = require("ui.widgets.volume")

-- Function to show or hide the right-hand widgets based on screen focus
local function update_right_widgets_visibility()
    for s in screen do
        if s.right_widgets_container then
            s.right_widgets_container.visible = (s == awful.screen.focused())
        end
    end
end

-- Textclock widget
screen.connect_signal("request::desktop_decoration", function(s)
    -- Tag names for each screen
    awful.tag(
        {
            "󰅩", -- EDITOR
            "󰉖", -- FILE MANAGER
            "󰖟", -- WEB BROWSER
            "󰻞", -- CHAT
            "󰲹", -- MUSIC
            "󰯜", -- VIDEO
            "󱇤", -- IMAGE/EDIT TOOLS
            "󰧮", -- OFFICE
            "󰸶", -- GAMES
        },
        s,
        awful.layout.layouts[1]
    )

    --  Layoutbox widget
    s.mylayoutbox = {
        widget = wibox.container.background,
        shape = gears.shape.circle,
        awful.widget.layoutbox {
            screen  = s,
            buttons = {
                awful.button(
                    {},
                    1,
                    function()
                        awful.layout.inc(1)
                    end
                ),
                awful.button(
                    {},
                    3,
                    function()
                        awful.layout.inc(-1)
                    end
                ),
                awful.button(
                    {},
                    4,
                    function()
                        awful.layout.inc(-1)
                    end
                ),
                awful.button(
                    {},
                    5,
                    function()
                        awful.layout.inc(1)
                    end
                ),
            }
        }
    }

    --  Taglist widget
    s.mytaglist = {
        widget = wibox.widget.background,
        awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = {
                awful.button(
                    {},
                    1,
                    function(t)
                        t:view_only()
                    end
                ),
                awful.button(
                    { modkey },
                    1,
                    function(t)
                        if client.focus then
                            client.focus:move_to_tag(t)
                        end
                    end
                ),
                awful.button(
                    {},
                    3,
                    awful.tag.viewtoggle
                ),
                awful.button(
                    { modkey },
                    3,
                    function(t)
                        if client.focus then
                            client.focus:toggle_tag(t)
                        end
                    end
                ),
                awful.button(
                    {},
                    4,
                    function(t)
                        awful.tag.viewprev(t.screen)
                    end
                ),
                awful.button(
                    {},
                    5,
                    function(t)
                        awful.tag.viewnext(t.screen)
                    end
                ),
            }
        }
    }

    -- Prepare custom widgets container
    local custom_widget_container = {
        -- Keyboard layout widget
        wibox.container.background(wibox.widget.textbox(" "), theme.bar_bg_one),
        wibox.container.background(layout, theme.bar_bg_one),
        wibox.container.background(wibox.widget.textbox(" "), theme.bar_bg_one),
        -- Volume widget
        wibox.container.background(wibox.widget.textbox(" "), theme.bar_bg_two),
        wibox.container.background(volume, theme.bar_bg_two),
        wibox.container.background(wibox.widget.textbox(" "), theme.bar_bg_two),
        -- Brightness widget
        wibox.container.background(wibox.widget.textbox(" "), theme.bar_bg_tre),
        wibox.container.background(brightness, theme.bar_bg_tre),
        wibox.container.background(wibox.widget.textbox(" "), theme.bar_bg_tre),
        -- Battery widget
        wibox.container.background(wibox.widget.textbox(" "), theme.bar_bg_for),
        wibox.container.background(battery, theme.bar_bg_for),
        wibox.container.background(wibox.widget.textbox(" "), theme.bar_bg_for),
        -- Wifi widget
        wibox.container.background(wibox.widget.textbox(" "), theme.bar_bg_fiv),
        wibox.container.background(wifi, theme.bar_bg_fiv),
        layout = wibox.layout.fixed.horizontal,
    }

    -- Main right widget container with pill shape
    s.right_widgets_container = wibox.widget {
        custom_widget_container,
        widget = wibox.container.background,
        shape = gears.shape.rounded_rect,
    }

    --  Wibar
    s.mywibox = awful.wibar {
        position     = "top",
        height       = (20),
        border_width = (6),
        border_color = theme.bg_normal,
        screen       = s,
        widget       = {
            layout = wibox.layout.stack,
            {
                layout = wibox.layout.align.horizontal,
                {
                    -- [[ Left widgets ]]
                    layout = wibox.layout.fixed.horizontal,
                    -- Layoubox widget
                    s.mylayoutbox,
                    wibox.container.background(wibox.widget.textbox(" "), theme.bg_normal),
                    -- Taglist widget
                    s.mytaglist,
                },
                nil,
                {
                    -- [[ Right widgets ]]
                    layout = wibox.layout.fixed.horizontal,
                    s.right_widgets_container
                },
            },
            {
                -- [[ Center widgets ]]
                -- Clock widget
                wibox.widget.textclock(),
                valign = "center",
                halign = "center",
                layout = wibox.container.place,
            }
        }
    }

    -- Update the visibility of right-hand widgets on startup
    update_right_widgets_visibility()
end)

-- Connect signal to update visibility when screen focus changes
client.connect_signal("focus", update_right_widgets_visibility)
client.connect_signal("unfocus", update_right_widgets_visibility)
screen.connect_signal("removed", update_right_widgets_visibility)
screen.connect_signal("added", update_right_widgets_visibility)
screen.connect_signal("screen::focus", update_right_widgets_visibility)
