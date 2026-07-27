vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.conceallevel = 1

-- Only use fish if it is installed on the system
if vim.fn.executable("fish") == 1 then
  vim.opt.shell = "fish"
  vim.opt.shellcmdflag = "-i -c"
end

vim.opt.fillchars = { eob = " " }
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000
vim.opt.confirm = true

-- Enable filetype detection, plugins, and indenting
vim.cmd("filetype plugin indent on")

-- Persistent undo directory setup
local undodir = vim.fn.stdpath("state") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
