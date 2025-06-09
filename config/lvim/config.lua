-- nvim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.cmd('autocmd FileType markdown setlocal nospell')
vim.opt.wrap = true -- wrap lines
vim.opt.spell = false
vim.o.shell = '/usr/bin/fish'
vim.o.autochdir = true
vim.cmd('autocmd BufEnter * lcd %:p:h')

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
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.project.manual_mode = false

lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "cpp",
    "c_sharp",
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
    -- Colorschemes
    { "lunarvim/colorschemes" },
    { "preservim/vim-markdown" },
    { "ellisonleao/gruvbox.nvim",
        config = function()
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
                transparent_mode = true,
            })
        end

    },

    -- Database UI (vim-dadbod)
    { "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            { 'kristijanhusak/vim-dadbod-completion',
                after = "nvim-cmp",
                ft = { 'sql', 'mysql', 'plsql' },
                lazy = true
            },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },

    -- Snippets
    { "SirVer/ultisnips" },

    -- DAP
    { "mfussenegger/nvim-dap" },

    -- Dotnet Tools
    { "MoaidHathot/dotnet.nvim",
        config = function()
            require("dotnet").setup({})
        end
    }
}

-- Keybindigns
-- vim-dadbod-ui
lvim.keys.normal_mode["<leader>D"] = ":DBUIToggle<CR>"

-- telescope projects
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- dotnet
lvim.builtin.which_key.mappings["N"] = {
    name = "+Dotnet",
    n = { "<cmd>DotnetUI new_item<cr>", "Create a dotnet project" },
    a = { "<cmd>DotnetUI project package add<cr>", "Install a NuGet package" },
    r = { "<cmd>DotnetUI project package remove<cr>", "Remove a NuGet package" },
    A = { "<cmd>DotnetUI project reference add<cr>", "Add a project reference" },
    R = { "<cmd>DotnetUI project reference remove<cr>", "Remove a project reference" },
}

-- Setup auto completion of SQL files with vim-dadbod-completion
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    command = ":lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })",
})

-- Fix weird bug with vim-dadbod under lunarvim 
-- https://github.com/kristijanhusak/vim-dadbod-completion/issues/53
local cmp = require("cmp")
