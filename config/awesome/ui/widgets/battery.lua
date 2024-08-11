local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

-- Create a text widget to display the battery percentage and power profile
local battery_text = wibox.widget.textbox()

local function update_battery_widget()
    awful.spawn.easy_async("acpi", function(stdout)
        -- Variables to accumulate total battery percentage and charging status
        local total_percentage = 0
        local total_batteries = 0
        local ac_adapter_status = "0"

        -- Iterate over each battery line in the output
        for battery in stdout:gmatch("[^\r\n]+") do
            local battery_percentage = tonumber(string.match(battery, "(%d?%d?%d)%%"))
            local battery_status = battery:match("Charging") and "1" or "0"

            -- Sum up the battery percentages and determine the overall charging status
            total_percentage = total_percentage + battery_percentage
            total_batteries = total_batteries + 1
            if battery_status == "1" then
                ac_adapter_status = "1"
            end
        end

        -- Calculate the average battery percentage
        local average_percentage = total_percentage / total_batteries

        -- Get the current power profile
        local currntpwr = io.popen("powerprofilesctl get"):read("*line")

        -- Set the appropriate power profile symbol based on the current power profile
        local pwr_symbol = ""
        if currntpwr == "performance" then
            pwr_symbol = " 󰓅 "
        elseif currntpwr == "balanced" then
            pwr_symbol = " 󰾅 "
        elseif currntpwr == "power-saver" then
            pwr_symbol = " 󰾆 "
        end

        -- Set the appropriate battery icon based on the average battery percentage and charging status
        local icon = "󰁹"
        if ac_adapter_status == "1" then
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
        else
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

        -- Set the text of the battery_text widget with the battery icon, average battery percentage, and power profile symbol
        battery_text:set_markup(icon .. pwr_symbol .. string.format("%.0f", average_percentage) .. "%")
    end)
end

-- Update the battery widget initially
update_battery_widget()

-- Refresh the battery widget every 10 seconds
local timer = gears.timer.start_new(10, function()
    update_battery_widget()
    return true
end)

-- Create a battery widget that contains the text widget
local battery_widget = wibox.widget {
    battery_text,
    layout = wibox.layout.align.horizontal
}

return battery_widget
