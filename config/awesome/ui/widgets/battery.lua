local wibox = require("wibox")
local gears = require("gears")
local theme = require("beautiful")

-- Create a text widget to display the battery percentage and power profile
local battery_widget = wibox.widget.textbox()

-- Function to read a file and return its content as a string
local function read_file(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = file:read("*all")
    file:close()
    return content and content:gsub("\n", "") -- Remove newline characters
end

local function update_battery_widget()
    local battery_paths = io.popen("ls -d /sys/class/power_supply/BAT* 2>/dev/null"):lines()
    local total_percentage = 0
    local total_batteries = 0
    local ac_adapter_status = "0" -- Default to "not charging"

    for battery_path in battery_paths do
        local capacity = read_file(battery_path .. "/capacity")
        local status = read_file(battery_path .. "/status")

        if capacity then
            local battery_percentage = tonumber(capacity)
            total_percentage = total_percentage + battery_percentage
            total_batteries = total_batteries + 1
        end

        if status and status == "Charging" then
            ac_adapter_status = "1" -- Set as charging
        end
    end

    -- If no battery was found, do nothing
    if total_batteries == 0 then return end

    -- Calculate the average battery percentage
    local average_percentage = total_percentage / total_batteries

    -- Get the current power profile
    local currntpwr = io.popen("powerprofilesctl get"):read("*line")

    -- Set power profile symbol
    local pwr_symbol = ""
    if currntpwr == "performance" then
        pwr_symbol = "󰓅"
    elseif currntpwr == "balanced" then
        pwr_symbol = "󰾅"
    elseif currntpwr == "power-saver" then
        pwr_symbol = "󰾆"
    end

    -- Set battery icon based on percentage and charging status
    local icon = "󰁹"
    if ac_adapter_status == "1" then -- Charging Icons
        if average_percentage >= 100 then
            icon = "󰂅"
        elseif average_percentage >= 90 then
            icon = "󰂋"
        elseif average_percentage >= 80 then
            icon = "󰂊"
        elseif average_percentage >= 70 then
            icon = "󰢞"
        elseif average_percentage >= 60 then
            icon = "󰂉"
        elseif average_percentage >= 50 then
            icon = "󰢝"
        elseif average_percentage >= 40 then
            icon = "󰂈"
        elseif average_percentage >= 30 then
            icon = "󰂇"
        elseif average_percentage >= 20 then
            icon = "󰂆"
        else
            icon = "󰢜"
        end
    else -- Discharging Icons
        if average_percentage >= 100 then
            icon = "󰁹"
        elseif average_percentage >= 90 then
            icon = "󰂂"
        elseif average_percentage >= 80 then
            icon = "󰂁"
        elseif average_percentage >= 70 then
            icon = "󰂀"
        elseif average_percentage >= 60 then
            icon = "󰁿"
        elseif average_percentage >= 50 then
            icon = "󰁾"
        elseif average_percentage >= 40 then
            icon = "󰁽"
        elseif average_percentage >= 30 then
            icon = "󰁼"
        elseif average_percentage >= 20 then
            icon = "󰁻"
        else
            icon = "󰂃"
        end
    end

    -- Update widget text using markup:
    -- - The power profile symbol and battery icon use the icon font.
    -- - The battery percentage uses the regular font.
    battery_widget:set_markup(string.format(
        '<span font="%s">%s</span> <span font="%s">%s</span> <span font="%s">%.0f%%</span>',
        theme.icon_font, pwr_symbol,
        theme.icon_font, icon,
        theme.font, average_percentage
    ))
end

-- Update battery widget initially
update_battery_widget()

-- Refresh battery widget every 10 seconds
gears.timer.start_new(10, function()
    update_battery_widget()
    return true
end)

return battery_widget
