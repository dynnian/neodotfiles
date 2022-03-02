--  ____  ____  _  _
-- |  _ \|  _ \| |/ /
-- | | | | |_) | ' /    Clay Gomera (Drake)
-- | |_| |  _ <| . \    My custom awesome config
-- |____/|_| \_\_|\_\
--

-- BEGINNING OF LIBRARIES --
-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
require("awful.autofocus")
    -- Widget and layout library
local wibox         = require("wibox")
    -- Theme handling library
local beautiful     = require("beautiful")
    -- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100
    -- Lain library
local lain          = require("lain")
-- END OF LIBRARIES --

-- BEGINNING OF VIM HOTKEYS --
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
-- END OF VIM HOTKEYS --

-- BEGINNNG OF ERROR HANDLING --
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors }) end
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end
run_once({ "unclutter -root" }) -- entries must be comma-separated
-- END OF ERROR HANDLING --

-- BEGINNIG OF THEMES --
local themes = {
    "gruvbox-dark"  -- 1
}
local chosen_theme = themes[1]
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)
beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))
-- END OF THEMES -- 

-- BEGINNING OF LAYOUTS
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}
lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2
-- END OF LAYOUTS --

-- BEGINNING OF VARIABLES --
awful.util.terminal = terminal
-- Terminal
local terminal                  = "alacritty"
-- Standard Apps
local edit                      = "emacsclient -c -a emacs"
local file                      = "alacritty -e ./.config/vifm/scripts/vifmrun"
local web                       = "qutebrowser"
local music                     = "alacritty -e mocp"
local games                     = "retroarch"
-- Key bindings variables
local modkey                    = "Mod4"
local altkey                    = "Mod1"
local modkey1                   = "Control"
-- screenlocker
local screenlocker              = "betterlockscreen -l"
-- END OF VARIABLES --

-- BEGINNING OF TAG NAMES --
awful.util.tagnames = 
{ 
" EDIT ",   -- F1
" FILE ",   -- F2
" WEB ",    -- F3
" MUSIC ",  -- F4
" WORK ",   -- XX
" MISC ",   -- XX
" GAMES "   -- F7
}
-- END OF TAG NAMES --

-- BEGINNIG OF WIBOX STUFF --
awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)
awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = 250}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)
screen.connect_signal("property::geometry", function(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- END OF WIBOX STUFF --

-- BEGINNIG OF BINDINGS --
-- Awesome things
globalkeys = my_table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
        {description="Show this help menu", group="Quick Actions"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "Reload WM", group = "Quick Actions"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
        {description = "Log Out", group = "Quick Actions"}),
-- Tag browsing arrow keys and escape
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "Tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "Tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "Tag"}),
--  Tag browsing alt + tab
    awful.key({ altkey,           }, "Tab",   awful.tag.viewnext,
        {description = "view next", group = "Tag"}),
    awful.key({ altkey, "Shift"   }, "Tab",  awful.tag.viewprev,
        {description = "view previous", group = "Tag"}),
--  Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
        {description = "Copy terminal to gtk", group = "Hotkeys"}),
--  Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
        {description = "Copy gtk to terminal", group = "Hotkeys"}),
--  Client focus
    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,
        {description = "Focus next by index", group = "Client"}),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,
        {description = "Focus previous by index", group = "Client"}),
--  Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
        {description = "Swap with next client by index", group = "Client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
        {description = "Swap with previous client by index", group = "Client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
        {description = "Focus the next screen", group = "Screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
        {description = "Focus the previous screen", group = "Screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
        {description = "Jump to urgent client", group = "Cient"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "Go back", group = "client"}),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
        {description = "Increase master width factor", group = "Layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
        {description = "Decrease master width factor", group = "Layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "Increase the number of master clients", group = "Layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "Decrease the number of master clients", group = "Layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
        {description = "Increase the number of columns", group = "Layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
        {description = "Decrease the number of columns", group = "Layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
        {description = "Select next", group = "Layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
        {description = "Select previous", group = "Layout"}),
--  Terminal
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
        {description = "Launch a terminal", group = "Hotkeys"}),
--  Dmenu
    awful.key({ modkey }, "r", function () awful.util.spawn_with_shell("dmenu_run -l 10 -b -i -p Launch:") end,
        {description = "Show Run Launcher", group = "Hotkeys"}),
    awful.key({ modkey }, "d", function () awful.util.spawn_with_shell("sh $HOME/.config/scripts/dmenu-drun.sh") end,
        {description = "Show App Launcher", group = "Hotkeys"}),
    awful.key({ modkey }, "w", function () awful.util.spawn_with_shell("sh $HOME/.config/scripts/dmenu-wifi.sh") end,
        {description = "Configure WiFi", group = "Hotkeys"}),
    awful.key({ modkey, modkey1 }, "q", function () awful.util.spawn_with_shell("sh $HOME/.config/scripts/dmenu-power.sh") end,
        {description = "Show Logout menu", group = "Hotkeys"}),
    awful.key({ modkey, modkey1 }, "w", function () awful.util.spawn_with_shell("sh $HOME/.config/scripts/dmenu-wall.sh") end,
        {description = "Show Logout menu", group = "Hotkeys"}),
    awful.key({}, "Print", function () awful.util.spawn_with_shell("sh $HOME/.config/scripts/dmenu-scrot.sh") end,
        {description = "Take screenshots", group = "Hotkeys"}),
--  Keyboard Layouts
    awful.key({ modkey, "Shift" }, "e", function () awful.util.spawn("setxkbmap -layout es") end,
        {description = "Switch to ES keyboard layout", group = "Quick Actions"}),
    awful.key({ modkey, "Shift" }, "u", function () awful.util.spawn("setxkbmap -layout us") end,
        {description = "Switch to US keyboard layout", group = "Quick Actions"}),
--  Apps
                -- edit
    awful.key({ modkey }, "F1", function () awful.spawn(edit) end,
        {description = "Launch text editor", group = "Apps"}),
                -- file
    awful.key({ modkey }, "F2", function () awful.spawn(file) end,
        {description = "Launch file manager", group = "Apps"}),
                -- web
    awful.key({ modkey }, "F3", function () awful.spawn(web) end,
        {description = "Launch web browser", group = "Apps"}),
                -- music
    awful.key({ modkey }, "F4", function () awful.spawn(music) end,
        {description = "Launch music player", group = "Apps"}),
                -- games
    awful.key({ modkey }, "F7", function () awful.util.spawn(games) end,
        {description = "Launch gaming app", group = "Apps"}),
-- Volume
    awful.key({}, "XF86AudioRaiseVolume", function() awful.spawn("amixer set Master 5%+") end,
        {description = "Increase volume", group = "Quick Actions"}),
    awful.key({}, "XF86AudioLowerVolume", function() awful.spawn("amixer set Master 5%-") end,
        {description = "Decrease volume", group = "Quick Actions"}),
    awful.key({}, "XF86AudioMute", function() awful.spawn("amixer set Master toggle") end,
        {description = "Mute volume", group = "Quick Actions"}),
-- Brightness
    awful.key({}, "XF86MonBrightnessUp", function () awful.spawn("xbacklight -inc 10") end,
        {description = "Increase brightness", group = "Quick Actions"}),
    awful.key({}, "XF86MonBrightnessDown", function () awful.spawn("xbacklight -dec 10") end,
        {description = "Decrease brightness", group = "Quick Actions"}),
-- Screenlocker
    awful.key({ modkey, modkey1 }, "l", function() awful.spawn(screenlocker) end,
        {description = "Lock the screen", group = "Quick Actions"}),
-- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "Toggle wibox", group = "Quick Actions"}),
-- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "j", function () lain.util.useless_gaps_resize(1) end,
        {description = "Increment gaps", group = "Tag"}),
    awful.key({ altkey, "Control" }, "l", function () lain.util.useless_gaps_resize(-1) end,
        {description = "Decrement gaps", group = "Tag"}),
-- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
        {description = "Add new tag", group = "Tag"}),
    awful.key({ modkey, "Control" }, "r", function () lain.util.rename_tag() end,
        {description = "Rename tag", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
        {description = "Move tag to the left", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
        {description = "Move tag to the right", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
        {description = "Delete tag", group = "Tag"}),
-- Minimize, maximize, moving clients, fullscreen, etc
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "Restore minimized", group = "Client"})
)
clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f", function (c) c.fullscreen = not c.fullscreen c:raise() end,
        {description = "Toggle fullscreen", group = "Client"}),
    awful.key({ modkey }, "q",      function (c) c:kill() end,
              {description = "Close window", group = "Client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle,
              {description = "Toggle floating", group = "Client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "Move to master", group = "Client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "Move to screen", group = "Client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "Toggle keep on top", group = "Client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            c.minimized = true
        end ,
        {description = "Minimize", group = "Client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(Un)maximize", group = "Client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(Un)maximize vertically", group = "Client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(Un)maximize horizontally", group = "Client"})
)
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "Wiew tag #", group = "Tag"}
        descr_toggle = {description = "Toggle tag #", group = "Tag"}
        descr_move = {description = "Move focused client to tag #", group = "Tag"}
        descr_toggle_focus = {description = "Toggle focused client on tag #", group = "Tag"}
    end
    globalkeys = my_table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end
-- Other mouse bindings
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)
-- Set keys
root.keys(globalkeys)
-- END OF BINDINGS --

-- BEGINNING OF RULES --
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     callback = awful.client.setslave
     }
    },
    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
       --   "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},
}
-- END OF RULES --

-- BEGINNING OF SIGNALS --
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
-- END OF SIGNALS --

-- BEGINNING OF MOUSE FOCUS SETTINGS --
-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- END OF MOUSE FOCUS SETTINGS --

-- BEGINNING OF AUTOSTART --
awful.util.spawn_with_shell("sh $HOME/.fehbg &")
awful.util.spawn_with_shell("lxpolkit &")
awful.util.spawn_with_shell("/usr/bin/emacs --daemon &")
awful.util.spawn_with_shell("pulseaudio &")
awful.util.spawn_with_shell("picom --config $HOME/.config/picom/picom.conf &")
-- END OF AUTOSTART --
