-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

vim.api.nvim_create_user_command("Qa", "qa", { bang = true })
vim.api.nvim_create_user_command("Q", "q", { bang = true })
vim.api.nvim_create_user_command("W", "w", { bang = true })
vim.api.nvim_create_user_command("Wq", "wq", { bang = true })
vim.api.nvim_create_user_command("Wqa", "wqa", { bang = true })
vim.api.nvim_create_user_command("WQ", "wq", { bang = true })
vim.api.nvim_create_user_command("Wq", "wq", { bang = true })

vim.fn.system(string.format("kitty @ set-tab-title %q", vim.fs.basename(vim.fn.getcwd())))
vim.api.nvim_create_autocmd({ "DirChanged" }, {
  pattern = "*",
  callback = function()
    vim.fn.system(string.format("kitty @ set-tab-title %q", vim.fs.basename(vim.fn.getcwd())))
  end,
})

vim.api.nvim_create_user_command("Finder", function()
  local path = vim.api.nvim_buf_get_name(0)
  os.execute("open -R " .. path)
end, {})

vim.cmd([[
if !has('gui_running')
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=300
    augroup END
endif
]])
