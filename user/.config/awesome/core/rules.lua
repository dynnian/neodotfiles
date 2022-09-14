local awful = require("awful")
local ruled = require("ruled")

-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
            callback = awful.client.setslave
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Galculator",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "Sxiv",
                "Tor Browser",
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
-- E TAG
    ruled.client.append_rule {
    rule_any = { class = {
               "Emacs",
               "Godot",
               "Virt-manager"
               }
            },
       properties = { tag = "" },
    }
-- F TAG
    ruled.client.append_rule {
    rule = { class = "vifm" },
       properties = { tag = "" },
    }
-- W TAG
    ruled.client.append_rule {
      rule_any = { class = {
                     "Brave-browser",
                     "librewolf",
                     "Firefox",
                     "Chromium",
                     "qutebrowser"
                 }
            },
       properties = { tag = "" }
    }
-- C TAG
    ruled.client.append_rule {
    rule = { class = "gomuks" },
       properties = { tag = "" }
    }
-- M TAG
    ruled.client.append_rule {
    rule_any = { class = {
               "cmus",
               "Audacity",
               "Ardour",
               "Carla2",
               "Carla2-Control"
               }
            },
       properties = { tag = "" }
    }
-- V TAG
    ruled.client.append_rule {
    rule_any = { class = {
               "kdenlive",
               "Blender",
               "Natron",
               "SimpleScreenRecorder",
               "Ghb",
               "obs",
               "mpv"
               }
             },
       properties = { tag = "" }
    }
-- X TAG
    ruled.client.append_rule {
    rule_any = { class = {
               "Qjackctl",
               "lsp-plugins",
               "qpwgraph",
               "Gimp-2.10",
               "krita",
               "Inkscape",
               "Xournalpp",
               "Bitwarden"
               }
             },
       properties = { tag = "" }
    }
-- D TAG
    ruled.client.append_rule {
    rule_any = { class = {
               "DesktopEditors",
               "Joplin"
               }
             },
       properties = { tag = "" }
    }
-- G TAG
    ruled.client.append_rule {
    rule = { class =  "retroarch" },
       properties = { tag = "" }
    }
--}}}
    -- }
end)
