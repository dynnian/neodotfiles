-- Set mapleader before lazy.nvim
vim.g.mapleader = " "

-- Load options, keymaps, autocmds
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit...", "MoreMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim
require("lazy").setup("plugins", {
  defaults = {
    lazy = false, -- Load plugins by default
  },
  change_detection = {
    notify = false, -- Don't notify on file changes
  },
})

-- Apply transparent background highlights after all plugins are loaded
vim.cmd([[
  hi Normal      guibg=NONE ctermbg=NONE
  hi LineNr      guibg=NONE ctermbg=NONE
  hi SignColumn  guibg=NONE ctermbg=NONE
  hi EndOfBuffer guibg=NONE ctermbg=NONE
  hi Visual      cterm=none ctermbg=darkgrey ctermfg=white
]])

