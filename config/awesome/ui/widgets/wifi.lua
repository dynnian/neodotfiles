local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("beautiful")

local wifi_widget = wibox.widget.textbox()

local function update_wifi_widget()
    local cmd = [[nmcli -t -f TYPE,STATE dev]]
    awful.spawn.easy_async_with_shell(cmd, function(output)
        local default_icon = "󰤮"  -- Disconnected icon
        local foundConnected = false

        -- Iterate through each line of nmcli output.
        for line in output:gmatch("[^\r\n]+") do
            local dev_type, state = line:match("([^:]+):([^:]+)")
            if state == "connected" then
                foundConnected = true
                if dev_type == "wifi" then
                    local wifi_cmd = "nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi | grep '^yes'"
                    awful.spawn.easy_async_with_shell(wifi_cmd, function(wifi_output)
                        local ssid, strength = wifi_output:match("yes:([^:]+):([^:]+)")
                        local signal_strength = tonumber(strength) or 0
                        local icon

                        if signal_strength <= 30 then
                            icon = "󰤟"
                        elseif signal_strength <= 60 then
                            icon = "󰤢"
                        elseif signal_strength <= 90 then
                            icon = "󰤥"
                        else
                            icon = "󰤨"
                        end

                        if ssid and ssid ~= "" then
                            wifi_widget:set_markup(string.format(
                                '<span font="%s">%s</span> <span font="%s">%s </span>',
                                theme.icon_font, icon, theme.font, ssid
                            ))
                        else
                            wifi_widget:set_markup(string.format(
                                '<span font="%s">%s</span> <span font="%s">Wi-Fi </span>',
                                theme.icon_font, icon, theme.font
                            ))
                        end
                    end)
                elseif dev_type == "ethernet" then
                    wifi_widget:set_markup(string.format(
                        '<span font="%s">󰈀</span> <span font="%s">Ethernet </span>',
                        theme.icon_font, theme.font
                    ))
                end
                break  -- Exit the loop once a connected device is found.
            end
        end

        -- Only update with the default disconnected icon if no connection was found.
        if not foundConnected then
            wifi_widget:set_markup(string.format(
                '<span font="%s">%s  </span>',
                theme.icon_font, default_icon
            ))
        end
    end)
end

-- Initial update.
update_wifi_widget()

-- Refresh the widget every 5 seconds.
gears.timer.start_new(5, function()
    update_wifi_widget()
    return true
end)

return wifi_widget
