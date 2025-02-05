-- imports
local beautiful = require("beautiful")
local awful = require("awful")

beautiful.init(string.format("%s/.config/awesome/theme/theme.lua", os.getenv("HOME"))) -- selected theme
require("config.signals")   -- some aditional code for signals & error handling
require("config.rules")     -- window manager rules
require("config.keys")      -- keyboard shortcuts
require("ui.layouts")       -- predifined tiling layouts
require("ui.bar")           -- the bar on the top
require("ui.notif")         -- the notification manager

awful.util.spawn_with_shell("$XDG_CONFIG_HOME/awesome/misc/scripts/autostart &")
