local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local wifi_widget = wibox.widget.textbox()

local function update_wifi_widget()
    local cmd = [[nmcli -t -f DEVICE,TYPE,STATE dev]]
    awful.spawn.easy_async_with_shell(cmd, function(output)
        local connected = false
        local icon = "󰤮  "  -- Default to disconnected icon

        for line in output:gmatch("[^\r\n]+") do
            local device, dev_type, state = line:match("([^:]+):([^:]+):([^:]+)")
            if state == "connected" then
                if dev_type == "wifi" then
                    icon = "󰤨  "  -- Wi-Fi connected icon
                elseif dev_type == "ethernet" then
                    icon = "󰈀  "  -- Ethernet connected icon
                end
                connected = true
                break
            end
        end

        wifi_widget:set_text(icon)
    end)
end

-- Update the widget initially
update_wifi_widget()

-- Refresh the widget every 5 seconds
local timer = gears.timer.start_new(5, function()
    update_wifi_widget()
    return true
end)

return wifi_widget
