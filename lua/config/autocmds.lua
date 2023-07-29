-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

-- local swap_ternary = require("plugin.swap_ternary")
-- vim.keymap.set("n", "<leader>sX", swap_ternary.swap_ternary, { noremap = true })
--
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })
--
-- local spell_group = vim.api.nvim_create_augroup("spell_group", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "lua", "python", "go", "typescript", "typescriptreact", "javascript" },
--   command = "setlocal spell spelllang=en_us,cjk",
--   group = spell_group,
-- })
-- vim.api.nvim_create_autocmd("TermOpen", {
--   pattern = "*", -- disable spellchecking in the embeded terminal
--   command = "setlocal nospell",
--   group = spell_group,
-- })

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

-- local hasNumber = false
-- -- " toggle number releative or absolute
-- vim.api.nvim_create_autocmd("InsertEnter", {
--   callback = function()
--     hasNumber = vim.opt.number:get()
--     if not hasNumber then
--       return
--     end
--     vim.opt.relativenumber = false
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   callback = function()
--     if not hasNumber then
--       return
--     end
--     vim.opt.relativenumber = true
--   end,
-- })
--

vim.cmd([[
if !has('gui_running')
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=300
    augroup END
endif
]])
