local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local theme = require("beautiful")

-- Create a textbox widget
local brightness_widget = wibox.widget.textbox()

-- Function to update the brightness value
local function update_brightness()
    awful.spawn.easy_async_with_shell(
        "brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}'",
        function(stdout)
            local brightness = stdout:gsub("\n", "")
            local icon

            local bval = tonumber(brightness) or 0

            if bval == 100 then
                icon = "󰛨"
            elseif bval >= 90 then
                icon = "󱩖"
            elseif bval >= 80 then
                icon = "󱩕"
            elseif bval >= 70 then
                icon = "󱩔"
            elseif bval >= 60 then
                icon = "󱩓"
            elseif bval >= 50 then
                icon = "󱩒"
            elseif bval >= 40 then
                icon = "󱩑"
            elseif bval >= 30 then
                icon = "󱩐"
            elseif bval >= 20 then
                icon = "󱩏"
            else
                icon = "󱩎"
            end

            brightness_widget:set_markup(string.format(
                '<span font="%s">%s</span> <span font="%s">%d%%</span>',
                theme.icon_font, icon,
                theme.font, math.floor(bval)
            ))
        end
    )
end

-- Update the brightness initially
update_brightness()

-- Refresh the widget every 5 seconds
gears.timer.start_new(5, function()
    update_brightness()
    return true
end)

return {
    widget = brightness_widget,
    update = update_brightness
}
