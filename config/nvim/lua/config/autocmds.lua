-- Set tab width specifically for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "nix" },
  command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2",
})

-- Automatically change working directory to vault root, git root, or current file directory
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    -- Ignore special buffers (terminals, neo-tree, etc.)
    if vim.bo.buftype ~= "" then return end

    local file_path = vim.api.nvim_buf_get_name(0)
    
    -- Ignore empty buffers
    if file_path == "" then return end

    -- 1. Check if we are inside an Obsidian vault
    local vault_root = vim.fs.find({ '.obsidian' }, { upward = true, path = file_path })[1]
    if vault_root then
      vim.api.nvim_set_current_dir(vim.fs.dirname(vault_root))
      return
    end

    -- 2. Find the nearest directory containing a .git folder
    local git_root = vim.fs.find({ '.git' }, { upward = true, path = file_path })[1]
    if git_root then
      vim.api.nvim_set_current_dir(vim.fs.dirname(git_root))
      return
    end

    -- 3. Fallback: If not in a vault or git repo, just change directory to the file's folder
    local current_dir = vim.fs.dirname(file_path)
    if vim.fn.isdirectory(current_dir) == 1 then
      vim.api.nvim_set_current_dir(current_dir)
    end
  end,
})
