# config.py - Standard qutebrowser configuration

# --- Font Fallbacks (Replacing theme.nix) ---
SYSTEM_FONT = "Inter"      # Replace with your system font, e.g., "DejaVu Sans"
SYSTEM_FONT_MONO = "Mononoki Nerd Font"  # Replace with your mono font, e.g., "JetBrains Mono"

# --- Gruvbox Dark Hard Palette ---
bg0_normal = "#282828"
bg0 = bg0_normal
bg1 = "#3c3836"
bg2 = "#504945"
bg3 = "#665c54"
bg4 = "#7c6f64"

fg0 = "#fbf1c7"
fg1 = "#ebdbb2"
fg2 = "#d5c4a1"
fg3 = "#bdae93"
fg4 = "#a89984"

bright_red = "#fb4934"
bright_green = "#b8bb26"
bright_yellow = "#fabd2f"
bright_blue = "#83a598"
bright_purple = "#d3869b"
bright_aqua = "#8ec07c"
bright_orange = "#fe8019"

dark_red = "#cc241d"
dark_blue = "#458588"
dark_purple = "#b16286"
dark_aqua = "#689d6a"

# --- General Configuration ---
config.load_autoconfig(False)

# --- User Agent ---
c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'

# --- Aliases ---
c.aliases = {
    'q': 'quit',
    'w': 'session-save',
    'wq': 'quit --save'
}

# --- Key Bindings ---
config.bind('M', 'hint links spawn mpv {hint-url}', mode='normal')
config.bind('Z', 'hint links spawn st -e youtube-dl {hint-url}', mode='normal')
config.bind('t', 'set-cmd-text -s :open -t', mode='normal')
config.bind('xb', 'config-cycle statusbar.show always never', mode='normal')
config.bind('xt', 'config-cycle tabs.show always never', mode='normal')
config.bind('xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never', mode='normal')

# --- Domain-specific Settings ---
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# --- Search Engines ---
c.url.searchengines = {
    'DEFAULT': 'https://sx.dynn.xyz/search?q={}',
    'w': 'https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1',
    'aw': 'https://wiki.archlinux.org/?search={}',
    'nw': 'https://wiki.nixos.org/index.php?search={}',
    'g': 'https://www.google.com/search?hl=en&q={}',
    'd': 'https://duckduckgo.com/search?q={}',
    'ub': 'https://www.urbandictionary.com/define.php?term={}'
}

# --- Settings ---
c.tabs.show = 'always'
c.downloads.location.directory = '~/Downloads'
c.url.default_page = 'https://sx.dynn.xyz'
c.url.start_pages = ['https://sx.dynn.xyz']

c.colors.webpage.preferred_color_scheme = 'dark'

c.content.notifications.enabled = False
c.content.blocking.method = 'both'
c.content.blocking.enabled = True
c.content.autoplay = False
c.content.register_protocol_handler = False

# --- Fonts ---
c.fonts.default_family = SYSTEM_FONT
c.fonts.default_size = '10pt'
c.fonts.completion.entry = f"10pt '{SYSTEM_FONT_MONO}'"
c.fonts.debug_console = f"10pt '{SYSTEM_FONT_MONO}'"
c.fonts.prompts = f"10pt {SYSTEM_FONT}"
c.fonts.statusbar = f"10pt '{SYSTEM_FONT}'"

# --- Theme Colors ---

# Completion
c.colors.completion.fg = [fg1, bright_aqua, bright_yellow]
c.colors.completion.odd.bg = bg0
c.colors.completion.even.bg = bg0
c.colors.completion.category.fg = bright_blue
c.colors.completion.category.bg = bg1
c.colors.completion.category.border.top = bg1
c.colors.completion.category.border.bottom = bg1
c.colors.completion.item.selected.fg = fg0
c.colors.completion.item.selected.bg = bg4
c.colors.completion.item.selected.border.top = bg2
c.colors.completion.item.selected.border.bottom = bg2
c.colors.completion.item.selected.match.fg = bright_orange
c.colors.completion.match.fg = bright_orange
c.colors.completion.scrollbar.fg = fg0
c.colors.completion.scrollbar.bg = bg1

# Context Menu
c.colors.contextmenu.disabled.bg = bg3
c.colors.contextmenu.disabled.fg = fg3
c.colors.contextmenu.menu.bg = bg0
c.colors.contextmenu.menu.fg = fg2
c.colors.contextmenu.selected.bg = bg2
c.colors.contextmenu.selected.fg = fg2

# Downloads
c.colors.downloads.bar.bg = bg0
c.colors.downloads.start.fg = bg0
c.colors.downloads.start.bg = bright_blue
c.colors.downloads.stop.fg = bg0
c.colors.downloads.stop.bg = bright_aqua
c.colors.downloads.error.fg = bright_red

# Hints
c.colors.hints.fg = bg0
c.colors.hints.bg = 'rgba(250, 191, 47, 200)'  # bright_yellow
c.colors.hints.match.fg = bg4

# Keyhints
c.colors.keyhint.fg = fg4
c.colors.keyhint.suffix.fg = fg0
c.colors.keyhint.bg = bg0

# Messages
c.colors.messages.error.fg = bg0
c.colors.messages.error.bg = bright_red
c.colors.messages.error.border = bright_red
c.colors.messages.warning.fg = bg0
c.colors.messages.warning.bg = bright_purple
c.colors.messages.warning.border = bright_purple
c.colors.messages.info.fg = fg2
c.colors.messages.info.bg = bg0
c.colors.messages.info.border = bg0

# Prompts
c.colors.prompts.fg = fg2
c.colors.prompts.border = f"1px solid {bg1}"
c.colors.prompts.bg = bg3
c.colors.prompts.selected.bg = bg2

# Statusbar
c.colors.statusbar.normal.fg = fg2
c.colors.statusbar.normal.bg = bg0
c.colors.statusbar.insert.fg = bg0
c.colors.statusbar.insert.bg = dark_aqua
c.colors.statusbar.passthrough.fg = bg0
c.colors.statusbar.passthrough.bg = dark_blue
c.colors.statusbar.private.fg = bright_purple
c.colors.statusbar.private.bg = bg0
c.colors.statusbar.command.fg = fg3
c.colors.statusbar.command.bg = bg1
c.colors.statusbar.command.private.fg = bright_purple
c.colors.statusbar.command.private.bg = bg1
c.colors.statusbar.caret.fg = bg0
c.colors.statusbar.caret.bg = dark_purple
c.colors.statusbar.caret.selection.fg = bg0
c.colors.statusbar.caret.selection.bg = bright_purple
c.colors.statusbar.progress.bg = bright_blue
c.colors.statusbar.url.fg = fg4
c.colors.statusbar.url.error.fg = dark_red
c.colors.statusbar.url.hover.fg = bright_orange
c.colors.statusbar.url.success.http.fg = bright_red
c.colors.statusbar.url.success.https.fg = fg0
c.colors.statusbar.url.warn.fg = bright_purple

# Tabs
c.colors.tabs.bar.bg = bg0
c.colors.tabs.indicator.start = bright_blue
c.colors.tabs.indicator.stop = bright_aqua
c.colors.tabs.indicator.error = bright_red
c.colors.tabs.odd.fg = fg2
c.colors.tabs.odd.bg = bg2
c.colors.tabs.even.fg = fg2
c.colors.tabs.even.bg = bg3
c.colors.tabs.selected.odd.fg = fg2
c.colors.tabs.selected.odd.bg = bg0
c.colors.tabs.selected.even.fg = fg2
c.colors.tabs.selected.even.bg = bg0
c.colors.tabs.pinned.even.bg = bright_green
c.colors.tabs.pinned.even.fg = bg2
c.colors.tabs.pinned.odd.bg = bright_green
c.colors.tabs.pinned.odd.fg = bg2
c.colors.tabs.pinned.selected.even.bg = bg0
c.colors.tabs.pinned.selected.even.fg = fg2
c.colors.tabs.pinned.selected.odd.bg = bg0
c.colors.tabs.pinned.selected.odd.fg = fg2
