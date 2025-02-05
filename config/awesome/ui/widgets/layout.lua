local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local theme = require("beautiful")

-- Create a textbox widget
local keyboard_layout_widget = wibox.widget.textbox()

-- Function to update the layout value
local function update_keyboard_layout_widget()
    awful.spawn.easy_async_with_shell("setxkbmap -query | grep -oP 'layout:\\s*\\K\\w+'", function(stdout)
        local layout = stdout:gsub("\n", "")
        keyboard_layout_widget:set_markup(string.format(
            '<span font="%s">%s</span> <span font="%s">%s</span>',
            theme.icon_font, "󰌌",
            theme.font, layout:upper()
        ))
    end)
end

-- Update the widget initially
update_keyboard_layout_widget()

-- Refresh the widget every 10 seconds
gears.timer.start_new(10, function()
    update_keyboard_layout_widget()
    return true
end)

return {
    widget = keyboard_layout_widget,
    update = update_keyboard_layout_widget
}
