-- Apps selection, see config/keys.lua to see how this is handled in keybindings
local apps = {
    terminal     = "kitty",                                                                         -- terminal emulator

    -- rofi
    drunner      = "rofi -show drun -show-icons",                                                   -- desktop runner
    runner       = "rofi -show run",                                                                -- normal runner
    runner_power = string.format("%s/.config/awesome/misc/scripts/rofi_power", os.getenv("HOME")),  -- power manager
    runner_mount = string.format("%s/.config/awesome/misc/scripts/rofi_mount", os.getenv("HOME")),  -- drive mounter
    runner_blue  = string.format("%s/.config/awesome/misc/scripts/rofi_blue",  os.getenv("HOME")),  -- bluetooth manager
    runner_wifi  = string.format("%s/.config/awesome/misc/scripts/rofi_wifi",  os.getenv("HOME")),  -- wifi manager
    runner_scrot = string.format("%s/.config/awesome/misc/scripts/rofi_scrot", os.getenv("HOME")),  -- screenshots manager
    runner_emoji = string.format("%s/.config/awesome/misc/scripts/rofi_emoji", os.getenv("HOME")),  -- emojis manager
    runner_wall  = string.format("%s/.config/awesome/misc/scripts/rofi_wall",  os.getenv("HOME")),  -- wallpapers manager

    -- terminal scripts
    ytfzfv       = "kitty --class vidytfzf ytfzf -flst",                                            -- youtube
    ytfzfm       = "kitty --class musytfzf ytfzf -mlst",                                            -- youtube music
    ani_cli      = "kitty --class ani-cli ani-cli",                                                 -- anime
    flix_cli     = "kitty --class flix-cli flix-cli",                                               -- movies
    newsboat     = "kitty --class newsboat newsboat",                                               -- newsboat
    btop         = "kitty --class btop btop",                                                       -- btop
    pulsemixer   = "kitty --class pulsemixer pulsemixer",                                           -- pulsemixer

    -- default apps per tag
    editor       = string.format("kitty --class neovim %s/.local/bin/lvim", os.getenv("HOME")),             -- TAG 1
    file         = string.format("kitty --class vifm %s/.config/vifm/scripts/vifmrun", os.getenv("HOME")),  -- TAG 2
    browser      = "brave",                                                                                 -- TAG 3
    chat         = "flatpak run org.signal.Signal",                                                         -- TAG 4
    music        = "kitty --class cmus cmus",                                                               -- TAG 5
    videoeditor  = "flatpak run org.kde.kdenlive",                                                          -- TAG 6
    imageeditor  = "flatpak run org.kde.krita",                                                             -- TAG 7
    office       = "flatpak run org.onlyoffice.desktopeditors",                                             -- TAG 8
    game         = "flatpak run com.valvesoftware.Steam"                                                    -- TAG 9
}
return apps
