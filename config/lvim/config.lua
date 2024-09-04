-- neovide options
vim.o.guifont = "mononoki Nerd Font:h14"
vim.g.neovide_no_idle = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_input_use_logo = true

vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_particle_speed = 20.0

vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0

-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.98)))
end
vim.g.neovide_transparency = 0.98
vim.g.transparency = 0.98
vim.g.neovide_background_color = "#1d2021" .. alpha()

-- nvim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.cmd('autocmd FileType markdown setlocal nospell')
vim.opt.wrap = true -- wrap lines
vim.opt.spell = false
vim.o.shell = '/usr/bin/fish'
vim.o.autochdir = true
--vim.cmd('autocmd BufEnter * lcd %:p:h')

-- general
lvim.use_icons = true
lvim.log.level = "info"

-- change theme settings
lvim.colorscheme = "gruvbox"
lvim.transparent_window = false
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.project.manual_mode = true

lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "dart",
    "java",
    "yaml",
    "toml",
    "sql",
}

-- additional Plugins
lvim.plugins = {
    { "lunarvim/colorschemes" },
    { "ellisonleao/gruvbox.nvim" },
    { "tpope/vim-dadbod" },
    { "kristijanhusak/vim-dadbod-ui" },
    { "kristijanhusak/vim-dadbod-completion", after = "nvim-cmp" },
    { "SirVer/ultisnips" },
    { "mfussenegger/nvim-dap" },
    { "akinsho/flutter-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
  },
}

-- configuring colorscheme
require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = false,
    italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,    -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})

require('flutter-tools').setup {
    decorations = {
        statusline = {
            app_version = false,
            device = true,
            project_config = false,
        }
    },
    dev_log = {
        enabled = true,
        notify_errors = true,
        open_cmd = "tabedit",
    },
    lsp = {
        color = {
            enabled = true,
            background = false,
            foreground = false,
            virtual_text = true,
            virtual_text_str = "■",
        },
        settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            enableSdkFormatter = true,
        },
    },
}

-- Flutter .arb files should be concidered as json files
vim.filetype.add {
    extension = {
        arb = 'json',
    }
}

lvim.keys.normal_mode["<leader>D"] = ":DBUIToggle<CR>"
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["F"] = {
    name = "+Flutter",
    c = { "<cmd>Telescope flutter commands<cr>", "Open Flutter Commans" },
    d = { "<cmd>FlutterDevices<cr>", "Flutter Devices" },
    e = { "<cmd>FlutterEmulators<cr>", "Flutter Emulators" },
    r = { "<cmd>FlutterReload<cr>", "Hot Reload App" },
    R = { "<cmd>FlutterRestart<cr>", "Hot Restart app" },
    q = { "<cmd>FlutterQuit<cr>", "Quit running application" },
    v = { "<cmd>Telescope flutter fvm<cr>", "Flutter version" },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  command = ":lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dart",
  callback = function()
    vim.bo.tabstop = 2 -- Set tabstop to 2 spaces for Dart
    vim.bo.shiftwidth = 2 -- Set shiftwidth to 2 spaces for Dart
    vim.bo.expandtab = true -- Use spaces instead of tabs
  end,
})

local cmp = require("cmp")
