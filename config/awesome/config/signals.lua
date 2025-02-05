local naughty = require("naughty")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

-- Track whether focus was changed by mouse movement
local focus_changed_by_mouse = false

-- Error handling
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message
    }
end)

-- Signals
-- Only set borders and rounded corners when there's more than 1 client on screen
screen.connect_signal("arrange", function(s)
    local max = s.selected_tag.layout.name == "max"
    local only_one = #s.tiled_clients == 1  -- use tiled_clients so that other floating windows don't affect the count
    for _, c in pairs(s.clients) do
        if (max or only_one) and not c.floating or c.maximized then
            c.border_width = 0
            c.shape = gears.shape.rectangle
        else
            c.border_width = beautiful.border_width
            c.shape = function(cr,w,h)
                gears.shape.rounded_rect(cr,w,h,10)
            end
        end
    end
end)

-- Enable sloppy focus (focus follows mouse)
client.connect_signal("mouse::enter", function(c)
    -- Mark that the focus change was triggered by the mouse
    focus_changed_by_mouse = true
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
    -- Reset flag after a short delay to allow other focus events to process
    gears.timer.start_new(0.1, function() focus_changed_by_mouse = false end)
end)

-- Keep floating windows on top
client.connect_signal("property::floating", function(c)
    if not c.fullscreen then
        c.ontop = c.floating
    end
end)

-- Forbid minimizing
client.connect_signal("property::minimized", function(c)
    c.minimized = false
end)

-- Forbid maximizing
client.connect_signal("property::maximized", function(c)
    c.maximized = false
end)

-- Function to move the mouse to the center of a given client
local function move_mouse_to_center(c)
    if not c or not c.valid then return end
    local g = c:geometry()
    -- Calculate center position
    local center_x = g.x + g.width / 2
    local center_y = g.y + g.height / 2
    -- Move the mouse cursor
    mouse.coords({ x = center_x, y = center_y }, true)
end

-- Mouse follows focus when switching windows (only if focus was NOT changed by the mouse)
client.connect_signal("focus", function(c)
    if not focus_changed_by_mouse then
        gears.timer.delayed_call(function() move_mouse_to_center(c) end)
    end
end)

-- Mouse follows focus when spawning a new window
client.connect_signal("request::manage", function(c)
    if c.floating then
        awful.placement.centered(c)
    end
    gears.timer.delayed_call(function() move_mouse_to_center(c) end)
end)

client.connect_signal("request::manage", function(c)
    local tag = c.first_tag
    if tag then
        awful.tag.viewonly(tag)
    end
end)
