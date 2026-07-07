-- Set tab width specifically for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "nix" },
  command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2",
})

-- Automatically change working directory to git root or current file directory
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    -- Ignore special or non-file buffers
    if vim.bo.buftype ~= "" or vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 0 then
      return
    end

    -- Find the nearest directory containing a .git folder starting from the current file
    local root = vim.fs.find({ '.git' }, { upward = true, path = vim.api.nvim_buf_get_name(0) })[1]
    if root then
      -- Set Neovim's global path to the folder containing the .git directory
      vim.api.nvim_set_current_dir(vim.fs.dirname(root))
    else
      -- Fallback: If not in a git repo, just change directory to the file's folder
      local current_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
      if vim.fn.isdirectory(current_dir) == 1 then
        vim.api.nvim_set_current_dir(current_dir)
      end
    end
  end,
})


