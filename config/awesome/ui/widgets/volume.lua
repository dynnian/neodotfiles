local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("beautiful")

-- Create text widget
local volume_widget = wibox.widget.textbox()

-- Function to update the text widget
local function update_volume_widget()
    awful.spawn.easy_async_with_shell("pamixer --get-mute", function(mute_stdout)
        local mute = mute_stdout:match("^%s*(.-)%s*$") -- Trim leading/trailing whitespaces

        if mute == "true" then
            volume_widget:set_markup(string.format(
                '<span font="%s">%s</span>',
                theme.icon_font, "󰖁"
            ))
        else
            awful.spawn.easy_async_with_shell("pamixer --get-volume", function(vol_stdout)
                local vol = tonumber(vol_stdout:match("^%s*(.-)%s*$"))
                local icon

                if vol > 50 then
                    icon = "󰕾"
                elseif vol > 10 then
                    icon = "󰖀"
                elseif vol > 0 then
                    icon = "󰕿"
                else
                    volume_widget:set_markup(string.format(
                        '<span font="%s">%s</span>',
                        theme.icon_font, "󰖁"
                    ))
                    return
                end

                volume_widget:set_markup(string.format(
                    '<span font="%s">%s</span> <span font="%s">%d%%</span>',
                    theme.icon_font, icon, theme.font, vol
                ))
            end)
        end
    end)
end

-- Update the widget initially
update_volume_widget()

-- Refresh the widget every 5 seconds
gears.timer.start_new(5, function()
    update_volume_widget()
    return true
end)

return {
    widget = volume_widget,
    update = update_volume_widget
}
