local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local naughty = require("naughty")
local wibox = require("wibox")
local ruled = require("ruled")

naughty.config.defaults.ontop = true
naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.border_width = 2
naughty.config.defaults.position = "top_right"
naughty.config.defaults.title = "Notification"

ruled.notification.connect_signal("request::rules",
    function()
        -- Critical
        ruled.notification.append_rule {
            rule = { urgency = "critical" },
            properties = {
                bg = beautiful.notification_bg,
                fg = beautiful.notification_critical,
                timeout = 0
            }
        }
        -- Normal
        ruled.notification.append_rule {
            rule = { urgency = "normal" },
            properties = {
                bg = beautiful.notification_bg,
                fg = beautiful.notification_fg,
                timeout = 5
            }
        }
        -- Low
        ruled.notification.append_rule {
            rule = { urgency = "low" },
            properties = {
                bg = beautiful.notification_bg,
                fg = beautiful.notification_fg,
                timeout = 5
            }
        }
    end
)

naughty.connect_signal("request::display",
    function(n)
        -- Default icons (change the paths to your actual icons)
        local default_icons = {
            low = gears.color.recolor_image(string.format("%s/.config/awesome/theme/icons/normal.png", os.getenv("HOME")), beautiful.notification_fg),
            normal = gears.color.recolor_image(string.format("%s/.config/awesome/theme/icons/normal.png", os.getenv("HOME")), beautiful.notification_fg),
            critical = gears.color.recolor_image(string.format("%s/.config/awesome/theme/icons/critical.png", os.getenv("HOME")), beautiful.notification_fg)
        }

        -- If no icon is provided, assign one based on urgency
        if not n.icon then
            if n.urgency == "critical" then
                n.icon = default_icons.critical
            elseif n.urgency == "normal" then
                n.icon = default_icons.normal
            else
                n.icon = default_icons.low
            end
        end

        -- Define icon widget with forced size
        local icon_widget = wibox.widget {
            {
                naughty.widget.icon,
                forced_width = dpi(20),   -- Set icon width
                forced_height = dpi(20),  -- Set icon height
                widget = wibox.container.constraint
            },
            margins = dpi(10),  -- Add spacing around icon
            widget = wibox.container.margin
        }

        -- Check if the notification has a title or an icon
        local has_header = (n.title and n.title ~= "") or (n.icon and n.icon ~= "")

        -- Header widget (only created if needed)
        local header_widget = has_header and {
            {
                {
                    icon_widget,   -- Use the resized icon
                    naughty.widget.title,
                    layout = wibox.layout.align.horizontal
                },
                left = dpi(5),
                right = dpi(15),
                widget = wibox.container.margin
            },
            bg = beautiful.notification_bg_alt,
            widget = wibox.container.background
        } or nil

        -- Message body widget
        local message_widget = {
            {
                {
                    naughty.widget.message,
                    left = dpi(15),
                    right = dpi(15),
                    top = dpi(15),
                    bottom = dpi(15),
                    widget = wibox.container.margin
                },
                strategy = "min",
                height = dpi(60),
                widget = wibox.container.constraint
            },
            strategy = "max",
            width = dpi(400),
            widget = wibox.container.constraint
        }

        -- Define notification layout
        naughty.layout.box {
            notification = n,
            type = "notification",
            bg = beautiful.bg_normal,
            minimum_width = dpi(300),
            minimum_height = dpi(18),
            widget_template = {
                {
                    -- Only include header if needed
                    header_widget,
                    message_widget,
                    layout = wibox.layout.align.vertical
                },
                id = "background_role",
                widget = naughty.container.background
            }
        }
    end
)
