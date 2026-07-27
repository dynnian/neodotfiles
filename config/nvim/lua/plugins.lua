return {
  -- Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- High priority to load colorscheme first
    config = function()
      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true,
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons" },

  -- Plenary (shared utilities)
  { "nvim-lua/plenary.nvim" },

  -- Nui (UI Component library)
  { "MunifTanjim/nui.nvim" },

  -- Neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = { width = 30 },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false, 
            hide_gitignored = false,
            custom = function(node)
              -- If the item starts with a dot (e.g., .obsidian, .trash)
              if node.name:match("^%.") then
                -- Check if this specific item lives inside an Obsidian vault
                local is_vault = vim.fs.find({ '.obsidian' }, { upward = true, path = node.path })[1]
                if is_vault then
                  return true -- Hide it!
                end
              end
              return false
            end,
          },
        },
      })
    end,
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = { "", "" },
          indicator = { style = "none" },
          tab_size = 18,
          show_close_icon = false,
          show_buffer_close_icons = true,
          buffer_close_icon = "",
          close_icon = "",
          modified_icon = "",
          left_mouse_command = "buffer %d",
          middle_mouse_command = "lua require('mini.bufremove').delete(%d, false)",
          right_mouse_command = "lua require('mini.bufremove').delete(%d, true)",
          close_command = "lua require('mini.bufremove').delete(%d, false)",
          offsets = {
            {
              filetype = "neo-tree",
              text = "Explorer",
              highlight = "Directory",
              separator = true,
            }
          },
        },
      })
    end,
  },

  -- Statusline (Lualine)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          component_separators = { left = "", right = "" },
          section_separators   = { left = "", right = "" },
          globalstatus = true,
          icons_enabled = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename" },
          lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup({
        theme = "doom",
        change_to_vcs_root = true,
        hide = {
          statusline = true,
          tabline = true,
          winbar = true,
        },
        config = {
          week_header = { enable = false },
          vertical_center = true,
          footer = { "vi veri veniversum vivus vici" },
          header = {
            "                                                  ",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣤⣤⡼⠀⢀⡀⣀⢱⡄⡀⠀⠀⠀⢲⣤⣤⣤⣤⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⡿⠛⠋⠁⣤⣿⣿⣿⣧⣷⠀⠀⠘⠉⠛⢻⣷⣿⣽⣿⣿⣷⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⢀⣴⣞⣽⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠠⣿⣿⡟⢻⣿⣿⣇⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣟⢦⡀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⣠⣿⡾⣿⣿⣿⣿⣿⠿⣻⣿⣿⡀⠀⠀⠀⢻⣿⣷⡀⠻⣧⣿⠆⠀⠀⠀⠀⣿⣿⣿⡻⣿⣿⣿⣿⣿⠿⣽⣦⡀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⣼⠟⣩⣾⣿⣿⣿⢟⣵⣾⣿⣿⣿⣧⠀⠀⠀⠈⠿⣿⣿⣷⣈⠁⠀⠀⠀⠀⣰⣿⣿⣿⣿⣮⣟⢯⣿⣿⣷⣬⡻⣷⡄⠀⠀⠀",
            "⠀⠀⢀⡜⣡⣾⣿⢿⣿⣿⣿⣿⣿⢟⣵⣿⣿⣿⣷⣄⠀⣰⣿⣿⣿⣿⣿⣷⣄⠀⢀⣼⣿⣿⣿⣷⡹⣿⣿⣿⣿⣿⣿⢿⣿⣮⡳⡄⠀⠀",
            "⠀⢠⢟⣿⡿⠋⣠⣾⢿⣿⣿⠟⢃⣾⢟⣿⢿⣿⣿⣿⣾⡿⠟⠻⣿⣻⣿⣏⠻⣿⣾⣿⣿⣿⣿⡛⣿⡌⠻⣿⣿⡿⣿⣦⡙⢿⣿⡝⣆⠀",
            "⠀⢯⣿⠏⣠⠞⠋⠀⣠⡿⠋⢀⣿⠁⢸⡏⣿⠿⣿⣿⠃⢠⣴⣾⣿⣿⣿⡟⠀⠘⢹⣿⠟⣿⣾⣷⠈⣿⡄⠘⢿⣦⠀⠈⠻⣆⠙⣿⣜⠆",
            "⢀⣿⠃⡴⠃⢀⡠⠞⠋⠀⠀⠼⠋⠀⠸⡇⠻⠀⠈⠃⠀⣧⢋⣼⣿⣿⣿⣷⣆⠀⠈⠁⠀⠟⠁⡟⠀⠈⠻⠀⠀⠉⠳⢦⡀⠈⢣⠈⢿⡄",
            "⣸⠇⢠⣷⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⠿⠋⠀⢻⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢾⣆⠈⣷",
            "⡟⠀⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣶⣤⡀⢸⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⢹",
            "⡇⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠈⣿⣼⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠃⢸",
            "⢡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⠶⣶⡟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼",
            "⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡁⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣼⣀⣠⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "                                                  ",
          },
          center = {
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Find files",
              desc_hl = "String",
              key = "f",
              key_hl = "Number",
              action = "Telescope find_files",
            },
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Recent files",
              desc_hl = "String",
              key = "r",
              key_hl = "Number",
              action = "Telescope oldfiles",
            },
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Projects",
              desc_hl = "String",
              key = "p",
              key_hl = "Number",
              action = "Telescope project",
            },
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Quit",
              desc_hl = "String",
              key = "q",
              key_hl = "Number",
              action = "qa",
            },
          },
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Git integration (Gitsigns & Neogit)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim", -- highly recommended for diff view inside Neogit
    },
    config = function()
      require("neogit").setup()
    end,
  },

  -- Toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 14,
        hide_numbers = true,
        shade_terminals = false,
        start_in_insert = true,
        insert_mappings = false,
        direction = "float",
        float_opts = { border = "rounded", winblend = 0 },
      })
    end,
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        delay = 300,
        win = {
          border = "rounded",
        },
        plugins = {
          marks = true,
          registers = true,
          spelling = { enabled = true, suggestions = 20 },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
      })
      pcall(function()
        local wk = require("which-key")
        wk.add({
          { "<leader>b", group = "Buffers" },
          { "<leader>f", group = "Find" },
          { "<leader>g", group = "Git" },
          { "<leader>l", group = "LSP" },
          { "<leader>n", group = "Notes" },
          { "<leader>o", group = "Open" },
          { "<leader>w", group = "Windows" },
        })
      end)
    end,
  },

  -- Mini.bufremove
  {
    "echasnovski/mini.bufremove",
    version = "*",
    config = function()
      require("mini.bufremove").setup({})
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = "❯ ",
          path_display = { "smart" },
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          project = {
            base_dirs = {
              { path = "~/Development", max_depth = 4 },
              { path = "~/src", max_depth = 4 },
              { path = "~/dev", max_depth = 4 },
            },
            hidden_files = true,
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = true,
            theme = "dropdown",
            ignore_missing_dirs = true,
            on_project_selected = function(prompt_bufnr)
              local project_actions = require("telescope._extensions.project.actions")
              project_actions.change_working_directory(prompt_bufnr, false)
            end,
            mappings = {
              n = {
                d = function(...) return require('telescope._extensions.project.actions').delete_project(...) end,
                r = function(...) return require('telescope._extensions.project.actions').rename_project(...) end,
                c = function(...) return require('telescope._extensions.project.actions').add_project(...) end,
                C = function(...) return require('telescope._extensions.project.actions').add_project_cwd(...) end,
                f = function(...) return require('telescope._extensions.project.actions').find_project_files(...) end,
                b = function(...) return require('telescope._extensions.project.actions').browse_project_files(...) end,
                s = function(...) return require('telescope._extensions.project.actions').search_in_project_files(...) end,
                R = function(...) return require('telescope._extensions.project.actions').recent_project_files(...) end,
                w = function(...) return require('telescope._extensions.project.actions').change_working_directory(...) end,
                o = function(...) return require('telescope._extensions.project.actions').next_cd_scope(...) end,
              },
              i = {
                ["<c-d>"] = function(...) return require('telescope._extensions.project.actions').delete_project(...) end,
                ["<c-v>"] = function(...) return require('telescope._extensions.project.actions').rename_project(...) end,
                ["<c-a>"] = function(...) return require('telescope._extensions.project.actions').add_project(...) end,
                ["<c-A>"] = function(...) return require('telescope._extensions.project.actions').add_project_cwd(...) end,
                ["<c-f>"] = function(...) return require('telescope._extensions.project.actions').find_project_files(...) end,
                ["<c-b>"] = function(...) return require('telescope._extensions.project.actions').browse_project_files(...) end,
                ["<c-s>"] = function(...) return require('telescope._extensions.project.actions').search_in_project_files(...) end,
                ["<c-r>"] = function(...) return require('telescope._extensions.project.actions').recent_project_files(...) end,
                ["<c-l>"] = function(...) return require('telescope._extensions.project.actions').change_working_directory(...) end,
                ["<c-o>"] = function(...) return require('telescope._extensions.project.actions').next_cd_scope(...) end,
              },
            },
          },
        },
      })
      telescope.load_extension("project")
      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- Obsidian
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    cmd = { "Obsidian" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function(_, opts)
      -- 1. Define the path to your vault and the JSON config
      local vault_path = vim.fn.expand("~/Nextcloud/Documents/Notes")
      local json_path = vault_path .. "/.obsidian/daily-notes.json"

      -- 2. Set fallbacks in case the file can't be read
      local daily_folder = ""
      local daily_format = "%Y-%m-%d"

      -- 3. Read and parse the JSON file if it exists
      if vim.fn.filereadable(json_path) == 1 then
        local json_str = table.concat(vim.fn.readfile(json_path), "\n")
        local ok, data = pcall(vim.json.decode, json_str)
        
        if ok and data then
          daily_folder = data.folder or daily_folder
          
          if data.format then
            -- 4. Translate Moment.js tokens to Lua strftime tokens
            local fmt = data.format
            fmt = fmt:gsub("YYYY", "%%Y")
            fmt = fmt:gsub("YY", "%%y")
            fmt = fmt:gsub("MM", "%%m")
            fmt = fmt:gsub("DD", "%%d")
            daily_format = fmt
          end
        end
      end

      -- 5. Inject the parsed data into the plugin options
      opts.daily_notes = {
        folder = daily_folder,
        date_format = daily_format,
        alias_format = daily_format,
      }

      -- 6. Finally, initialize the plugin with our modified options
      require("obsidian").setup(opts)
    end,
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = "personal",
          path = "~/Nextcloud/Documents/Notes",
        },
      },
      ui = {
        enable = false, 
      },
      picker = {
        name = "telescope.nvim", 
      },
    },
  },

  -- Syntax and filetypes
  { "lnl7/vim-nix" },
  { "pangloss/vim-javascript" },

  -- LSP and Autocomplete
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = { "bashls", "nixd", "lua_ls", "csharp_ls", "gopls", "rust_analyzer" }

      if vim.lsp.config then
        for _, lsp in ipairs(servers) do
          vim.lsp.config(lsp, {
            capabilities = capabilities,
          })
          vim.lsp.enable(lsp)
        end
      else
        local lspconfig = require("lspconfig")
        for _, lsp in ipairs(servers) do
          lspconfig[lsp].setup({
            capabilities = capabilities,
          })
        end
      end
    end,
  },

  -- nvim-cmp and LuaSnip
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load VSCode-style snippets (friendly-snippets etc.)
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "luasnip" },
        }),
      })
    end,
  },
}
