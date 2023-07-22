-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

local swap_ternary = require("plugin.swap_ternary")
vim.keymap.set("n", "<leader>sX", swap_ternary.swap_ternary, { noremap = true })
--
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })

local spell_group = vim.api.nvim_create_augroup("spell_group", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "python", "go", "typescript", "typescriptreact", "javascript" },
  command = "setlocal spell spelllang=en_us,cjk",
  group = spell_group,
})
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*", -- disable spellchecking in the embeded terminal
  command = "setlocal nospell",
  group = spell_group,
})

vim.api.nvim_create_user_command("Qa", "qa", { bang = true })
