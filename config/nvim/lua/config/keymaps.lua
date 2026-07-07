local map = vim.keymap.set

-- Doom-style window management
map("n", "<leader>wh", "<C-w>h", { silent = true, desc = "Window left" })
map("n", "<leader>wj", "<C-w>j", { silent = true, desc = "Window down" })
map("n", "<leader>wk", "<C-w>k", { silent = true, desc = "Window up" })
map("n", "<leader>wl", "<C-w>l", { silent = true, desc = "Window right" })

-- Fast ones with just ctrl
map("n", "<C-h>", "<C-w>h", { silent = true, desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { silent = true, desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { silent = true, desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { silent = true, desc = "Window right" })

-- Splits
map("n", "<leader>wv", "<C-w>v", { silent = true, desc = "Vertical split" })
map("n", "<leader>ws", "<C-w>s", { silent = true, desc = "Horizontal split" })

-- Close / maximize
map("n", "<leader>wc", "<C-w>c", { silent = true, desc = "Close window" })
map("n", "<leader>wo", "<C-w>o", { silent = true, desc = "Only window" })

-- LSP (Doom-ish: <leader>l ...)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true, desc = "LSP: go to definition" })
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true, desc = "LSP: go to declaration" })
map("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true, desc = "LSP: go to implementation" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true, desc = "LSP: references" })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true, desc = "LSP: hover" })
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true, desc = "LSP: signature help" })

-- Leader LSP actions
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true, desc = "LSP: code action" })
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true, desc = "LSP: rename" })
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { silent = true, desc = "LSP: format" })
map("n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true, desc = "Diagnostics: line" })
map("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { silent = true, desc = "Diagnostics: loclist" })
map("n", "<leader>lQ", "<cmd>lua vim.diagnostic.setqflist()<CR>", { silent = true, desc = "Diagnostics: quickfix" })

-- Diagnostics navigation
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { silent = true, desc = "Diagnostics: previous" })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { silent = true, desc = "Diagnostics: next" })

-- Symbols
map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", { silent = true, desc = "LSP: document symbols" })
map("n", "<leader>lS", "<cmd>lua vim.lsp.buf.workspace_symbol('')<CR>", { silent = true, desc = "LSP: workspace symbols" })

-- LSP info / restart
map("n", "<leader>li", "<cmd>LspInfo<CR>", { silent = true, desc = "LSP: info" })
map("n", "<leader>lR", "<cmd>LspRestart<CR>", { silent = true, desc = "LSP: restart" })

-- Git (SPC g ...)
map("n", "<leader>gg", ":Neogit<CR>", { silent = true, desc = "Git: status (Neogit)" })
map("n", "<leader>gc", "<cmd>lua require('neogit').open({ kind = 'tab' }); vim.cmd('Neogit commit')<CR>", { silent = true, desc = "Git: commit" })
map("n", "<leader>gp", "<cmd>lua require('neogit').open({ kind = 'tab' }); vim.cmd('Neogit push')<CR>", { silent = true, desc = "Git: push" })

-- Hunks
map("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { silent = true, desc = "Preview hunk" })
map("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "Stage hunk" })
map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { silent = true, desc = "Reset hunk" })

-- File-level
map("n", "<leader>gS", ":Gitsigns stage_buffer<CR>", { silent = true, desc = "Stage buffer" })
map("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { silent = true, desc = "Reset buffer" })

-- Navigation
map("n", "]c", ":Gitsigns next_hunk<CR>", { silent = true, desc = "Next hunk" })
map("n", "[c", ":Gitsigns prev_hunk<CR>", { silent = true, desc = "Previous hunk" })

-- Blame
map("n", "<leader>gb", ":Gitsigns blame_line<CR>", { silent = true, desc = "Blame line" })

-- Neotree
map("n", "<C-b>", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Neo-tree" })
map("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Neo-tree" })

-- Toggleterm
map("n", "<leader>t", ":ToggleTerm direction=float<CR>", { silent = true, desc = "Toggle terminal (float)" })
map("n", "<S-Up>", "5k")
map("n", "<S-Down>", "5j")
map("t", "<Esc>", "<C-\\><C-n>", { silent = true, desc = "Exit terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true })

-- Telescope
map("n", "<leader>of", ":Telescope find_files<CR>", { silent = true, desc = "Open file" })
map("n", "<leader>or", ":Telescope oldfiles<CR>", { silent = true, desc = "Open recent file" })
map("n", "<leader>op", ":Telescope project<CR>", { silent = true, desc = "Open project" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true, desc = "Live grep" })
map("n", "<leader>bi", ":Telescope buffers<CR>", { silent = true, desc = "Buffers interactive" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { silent = true, desc = "Help tags" })
map("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { silent = true, desc = "Document symbols" })
map("n", "<leader>fS", ":Telescope lsp_workspace_symbols<CR>", { silent = true, desc = "Workspace symbols" })
map("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>", { silent = true, desc = "Fuzzy find in buffer" })

-- Buffer mappings
map("n", "<leader>bn", "<cmd>bnext<CR>", { silent = true, desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>bprevious<CR>", { silent = true, desc = "Previous buffer" })
map("n", "<leader>bk", "<cmd>lua require('mini.bufremove').delete(0, false)<CR>", { silent = true, desc = "Kill buffer" })
