    -- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
require("awful.autofocus")
    -- Custom libraries
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
    -- Widget and layout library
local wibox         = require("wibox")
    -- Theme handling library
local beautiful     = require("beautiful")
    -- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100
    -- Lain library
local lain          = require("lain")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility

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

local themes = {
    "gruvbox-dark"  -- 1
}
local chosen_theme = themes[1]
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)
beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))

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

awful.util.terminal = terminal

local editorgui         = "emacsclient -c -a 'emacs'"
local editor            = os.getenv("EDITOR") or "gvim"
local terminal          = "alacritty"
local filemanager       = "alacritty -e ./.config/vifm/scripts/vifmrun"
local filemanagergui    = "pcmanfm"
local audiomixer        = "alacritty -e pulsemixer"
local audiomixer2       = "alacritty -e alsamixer"
local browser           = "librewolf"
local browser2          = "qutebrowser"
local musicplayer       = "alacritty -e musikcube"
local musicplayergui    = "lollypop"
local emailclient       = "thunderbird"
local chat1             = "element-desktop"
local chat2             = "whatsapp-for-linux"
local notes             = "joplin-desktop"
local passwords         = "bitwarden-desktop"
local screenlocker      = "betterlockscreen -l"

-- Key bindings variables
local modkey       = "Mod4"
local altkey       = "Mod1"
local modkey1      = "Control"

awful.util.tagnames = { " CODE ", " WEB ", " MUSIC ", " CHAT ", " FILE ", " NOTES ", " WORK1 ", " WORK2 ", " GAME " }

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

-- Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Awesome things
globalkeys = my_table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
        {description="show help", group="awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),

-- Tag browsing arrow keys and escape
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),

--  Tag browsing alt + tab
    awful.key({ altkey,           }, "Tab",   awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ altkey, "Shift"   }, "Tab",  awful.tag.viewprev,
        {description = "view previous", group = "tag"}),

--  Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
        {description = "copy terminal to gtk", group = "hotkeys"}),

--  Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
        {description = "copy gtk to terminal", group = "hotkeys"}),

--  Client focus
    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),

--  Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
        {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
        {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
        {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
        {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
        {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
        {description = "select previous", group = "layout"}),

--  Terminal
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
        {description = "launch a terminal", group = "apps"}),

--  Rofi
    awful.key({ modkey }, "d", function () awful.spawn(string.format("rofi -show drun", beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus)) end,
        {description = "show rofi drun menu", group = "hotkeys"}),
    awful.key({ modkey }, "r", function () awful.spawn(string.format("rofi -show run", beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus)) end,
        {description = "show rofi run menu", group = "hotkeys"}),
    awful.key({ modkey }, "Tab", function () awful.spawn(string.format("rofi -show window", beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus)) end,
        {description = "show rofi window menu", group = "hotkeys"}),
    awful.key({ modkey }, "w", function () awful.util.spawn("/home/drk/.shell-scripts/./rofi-wifi-menu.sh") end,
        {description = "show rofi wifi menu", group = "hotkeys"}),

--  Keyboard Layouts
    awful.key({ modkey, "Shift" }, "e", function () awful.util.spawn("setxkbmap -layout es") end,
        {description = "switch to es keyboard layout", group = "keyboard"}),
    awful.key({ modkey, "Shift" }, "u", function () awful.util.spawn("setxkbmap -layout us") end,
        {description = "switch to us keyboard layout", group = "keyboard"}),

--  Apps
                -- code
    awful.key({ modkey }, "F1", function () awful.spawn(editorgui) end,
        {description = "launch emacs", group = "apps"}),
    awful.key({ modkey, "Shift" }, "F1", function () awful.spawn(editor) end,
        {description = "launch spacevim", group = "apps"}),
                -- web
    awful.key({ modkey }, "F2", function () awful.spawn(browser) end,
        {description = "launch firefox", group = "apps"}),
    awful.key({ modkey, "Shift" }, "F2", function () awful.spawn(browser2) end,
        {description = "launch qutebrowser", group = "apps"}),
                -- music
    awful.key({ modkey }, "F3", function () awful.spawn(musicplayer) end,
        {description = "launch musikcube", group = "apps"}),
    awful.key({ modkey, "Shift" }, "F3", function () awful.spawn(musicplayergui) end,
        {description = "launch lollypop", group = "apps"}),
                -- chat
    awful.key({ modkey }, "F4", function () awful.spawn(chat1) end,
        {description = "launch element", group = "apps"}),
    awful.key({ modkey, "Shift" }, "F4", function () awful.spawn(chat2) end,
        {description = "launch whatsapp", group = "apps"}),
                -- file
    awful.key({ modkey }, "F5", function () awful.spawn(filemanager) end,
        {description = "launch vifm", group = "apps"}),
    awful.key({ modkey, "Shift" }, "F5", function () awful.spawn(filemanagergui) end,
        {description = "launch pcmanfm", group = "apps"}),
                -- notes
    awful.key({ modkey }, "F6", function () awful.spawn(notes) end,
        {description = "launch joplin", group = "apps"}),
                -- tag agnostic
    awful.key({ modkey, "Shift" }, "m", function () awful.spawn(audiomixer) end,
        {description = "launch pulsemixer", group = "apps"}),
    awful.key({ modkey, altkey }, "m", function () awful.spawn(audiomixer2) end,
        {description = "launch alsamixer", group = "apps"}),
    awful.key({ modkey, altkey }, "p", function () awful.spawn(passwords) end,
        {description = "launch bitwarden", group = "apps"}),
                -- game
    awful.key({ modkey }, "F9", function () awful.util.spawn("retroarch") end,
        {description = "launch retroarch", group = "apps"}),

-- Volume Control
    awful.key({}, "XF86AudioRaiseVolume", function() volume_widget:inc(5) end,
        {description = "increase volume", group = "volume"}),
    awful.key({}, "XF86AudioLowerVolume", function() volume_widget:dec(5) end,
        {description = "decrease volume", group = "volume"}),
    awful.key({}, "XF86AudioMute", function() volume_widget:toggle() end,
        {description = "mute volume", group = "volume"}),

-- Screenshot
    awful.key({}, "Print", function() awful.util.spawn("scrot") end,
        {description = "take a complete screenshot", group = "screenshot"}),
    awful.key({"Control"}, "Print", function() awful.util.spawn("scrot -s") end,
        {description = "take an area screenshot", group = "screenshot"}),

-- Brightness
    awful.key({}, "XF86MonBrightnessUp", function () brightness_widget:inc(5) end,
        {description = "increase brightness", group = "brightness"}),
    awful.key({}, "XF86MonBrightnessDown", function () brightness_widget:dec(5) end,
        {description = "decrease brightness", group = "brightness"}),

-- Screen configuration
    awful.key({ modkey }, "p", function() awful.util.spawn("arandr") end,
        {description = "launch screen configuration tool", group = ("screen")}),

-- Screen Lock
    awful.key({ modkey }, "l", function() awful.spawn(screenlocker) end,
        {description = "lock the screen", group = "screen"}),

-- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

-- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "j", function () lain.util.useless_gaps_resize(1) end,
        {description = "increment gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "l", function () lain.util.useless_gaps_resize(-1) end,
        {description = "decrement gaps", group = "tag"}),

-- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
        {description = "add new tag", group = "tag"}),
    awful.key({ modkey, "Control" }, "r", function () lain.util.rename_tag() end,
        {description = "rename tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
        {description = "move tag to the left", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
        {description = "move tag to the right", group = "tag"}),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
        {description = "delete tag", group = "tag"}),

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
              {description = "restore minimized", group = "client"})
)
clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f", function (c) c.fullscreen = not c.fullscreen c:raise() end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey }, "q",      function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
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

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.util.spawn_with_shell("nitrogen --restore")
awful.util.spawn_with_shell("lxpolkit")
awful.util.spawn_with_shell("picom --experimental-backend --config ~/.config/picom.conf")
awful.util.spawn_with_shell("/usr/bin/emacs --daemon &")
