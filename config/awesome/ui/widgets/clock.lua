local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- Create a text widget to display the clock
local clock_widget = wibox.widget.textbox()

local styles = {}

local function rounded_shape(size, partial)
    if partial then
        return function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height,
                false, true, false, true, size)
        end
    else
        return function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, size)
        end
    end
end

styles.month = {
    padding = 5,
    bg_color = beautiful.bg_normal,
    border_width = beautiful.border_width,
    border_color = beautiful.border_focus,
    shape = rounded_shape(10)
}

styles.normal = {
    shape = rounded_shape(5)
}

styles.focus = {
    fg_color = beautiful.fg_normal,
    bg_color = beautiful.border_focus,
    markup = function(t) return '<b>' .. t .. '</b>' end,
    shape = rounded_shape(5, true)
}

styles.header = {
    fg_color = beautiful.fg_focus,
    bg_color = beautiful.bg_normal,
    markup = function(t) return '<b>' .. t .. '</b>' end,
    shape = rounded_shape(10)
}

styles.weekday = {
    fg_color = beautiful.taglist_fg_occupied,
    markup = function(t) return '<b>' .. t .. '</b>' end,
    shape = rounded_shape(5)
}

-- Function to apply styles to each calendar cell
local function decorate_cell(widget, flag, date)
    if flag == "monthheader" and not styles.monthheader then
        flag = "header"
    end

    local props = styles[flag] or {}

    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end

    -- Change bg color for weekends
    local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
    local weekday = tonumber(os.date("%w", os.time(d)))
    local default_bg = (weekday == 0 or weekday == 6) and beautiful.bar_clock or beautiful.bg_normal

    return wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget = wibox.container.margin
        },
        shape = props.shape,
        border_color = props.border_color or beautiful.border_normal,
        border_width = props.border_width or 0,
        fg = props.fg_color or beautiful.fg_normal,
        bg = props.bg_color or default_bg,
        widget = wibox.container.background
    }
end

-- Create the calendar widget (hidden by default)
local calendar_widget = wibox {
    visible = false,
    ontop = true,
    width = 184,
    height = 200,
    shape = gears.shape.rounded_rect,
    widget = wibox.container.margin(
        wibox.widget {
            widget = wibox.widget.calendar.month(os.date("*t")),
            fn_embed = decorate_cell,
            align = "center",
            valign = "center"
        }
    )
}

-- Function to update the clock widget
local function update_clock_widget()
    -- Get the current hour and formatted time
    local hour = os.date("%I") -- Gets hour in 12-hour format
    local formatted_time = tostring(os.date("%I:%M%p")):gsub("^0", "")

    -- Define clock icons for each hour
    local clock_icons = {
        ["01"] = "󱐿", ["02"] = "󱑀", ["03"] = "󱑁",
        ["04"] = "󱑂", ["05"] = "󱑃", ["06"] = "󱑄",
        ["07"] = "󱑅", ["08"] = "󱑆", ["09"] = "󱑇",
        ["10"] = "󱑈", ["11"] = "󱑉", ["12"] = "󱑊"
    }

    -- Get the icon based on the current hour
    local clock_icon = clock_icons[hour] or "󰥔" -- Default icon (fallback)

    -- Update the widget text using markup:
    -- The icon uses beautiful.icon_font, and the time uses beautiful.font.
    clock_widget:set_markup(string.format(
        '<span font="%s">%s</span> <span font="%s">%s</span>',
        beautiful.icon_font, clock_icon,
        beautiful.font, formatted_time
    ))
end

-- Update clock widget initially
update_clock_widget()

-- Refresh the clock every minute
gears.timer {
    timeout = 60,
    autostart = true,
    call_now = true,
    callback = update_clock_widget
}

-- Function to Position the Calendar at the Top-Center of the Screen
local function position_calendar()
    local screen_geometry = awful.screen.focused().geometry
    calendar_widget.x = screen_geometry.x + (screen_geometry.width / 2) - (calendar_widget.width / 2) -- Centered horizontally
    calendar_widget.y = screen_geometry.y + 40  -- 30px from the top
end

-- Show calendar on mouse hover
clock_widget:connect_signal("mouse::enter", function()
    gears.timer.start_new(1, function()
        position_calendar()
        calendar_widget.visible = true
        return false
    end)
end)

-- Hide calendar when mouse leaves both the clock widget and the calendar itself
clock_widget:connect_signal("mouse::leave", function()
    gears.timer.start_new(0.2, function()
        if not mouse.current_wibox or (mouse.current_wibox ~= calendar_widget) then
            calendar_widget.visible = false
        end
        return false
    end)
end)

calendar_widget:connect_signal("mouse::leave", function()
    gears.timer.start_new(0.2, function()
        if not mouse.current_wibox or (mouse.current_wibox ~= clock_widget) then
            calendar_widget.visible = false
        end
        return false
    end)
end)

-- Return the clock widget
return clock_widget
