-- Apps selection, see config/keys.lua to see how this is handled in keybindings
local apps = {
    terminal     = "alacritty",                                                                     -- terminal emulator

    -- rofi
    drunner      = "rofi -show drun -show-icons",                                                   -- desktop runner
    runner       = "rofi -show run",                                                                -- normal runner
    brunner      = "rofi -show filebrowser",
    runner_power = string.format("%s/.config/awesome/misc/scripts/rofi_power", os.getenv("HOME")),  -- power manager
    runner_mount = string.format("%s/.config/awesome/misc/scripts/rofi_mount", os.getenv("HOME")),  -- drive mounter
    runner_blue  = string.format("%s/.config/awesome/misc/scripts/rofi_blue",  os.getenv("HOME")),  -- bluetooth manager
    runner_wifi  = string.format("%s/.config/awesome/misc/scripts/rofi_wifi",  os.getenv("HOME")),  -- wifi manager
    runner_scrot = string.format("%s/.config/awesome/misc/scripts/rofi_scrot", os.getenv("HOME")),  -- screenshots manager
    runner_emoji = string.format("%s/.config/awesome/misc/scripts/rofi_emoji", os.getenv("HOME")),  -- emojis manager
    runner_wall  = string.format("%s/.config/awesome/misc/scripts/rofi_wall",  os.getenv("HOME")),  -- wallpapers manager
    runner_clip  = "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}' -p '󱉧  Clipboard'",

    -- terminal scripts
    ytx          = "alacritty --class ytx -e yt-x",              -- youtube
    ani_cli      = "alacritty --class ani-cli -e ani-cli",       -- anime
    flix_cli     = "alacritty --class flix-cli -e flix-cli",     -- movies
    newsboat     = "alacritty --class newsboat -e newsboat",     -- newsboat
    btop         = "alacritty --class btop -e btop",             -- btop
    pulsemixer   = "alacritty --class pulsemixer -e pulsemixer", -- pulsemixer

    -- default apps per tag
    editor       = string.format("alacritty --class lunarvim -e %s/.local/bin/lvim", os.getenv("HOME")),  -- TAG 1
    file         = "alacritty --class yazi -e yazi",                                                      -- TAG 2
    browser      = "flatpak run com.brave.Browser",                                                       -- TAG 3
    browser2     = "flatpak run org.chromium.Chromium",                                                   -- TAG 3
    chat         = "flatpak run org.signal.Signal",                                                       -- TAG 4
    chat2        = "flatpak run com.rtosta.zapzap",                                                       -- TAG 4
    chat3        = "flatpak run com.discordapp.Discord",                                                  -- TAG 4
    music        = "alacritty --class cmus -e cmus",                                                      -- TAG 5
    videoeditor  = "flatpak run org.kde.kdenlive",                                                        -- TAG 6
    imageeditor  = "flatpak run org.kde.krita",                                                           -- TAG 7
    office       = "flatpak run org.onlyoffice.desktopeditors",                                           -- TAG 8
    game         = "flatpak run com.valvesoftware.Steam",                                                 -- TAG 9
    notes        = "flatpak run net.cozic.joplin_desktop"                                                 -- TAG 9
}
return apps
