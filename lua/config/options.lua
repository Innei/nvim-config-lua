-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.api.nvim_set_hl(0, "ICursorColor", {
  bg = "#7dd3fc",
  fg = "#000000",
})

if vim.g.neovide ~= nil then
  opt.clipboard = "unnamedplus"
end

opt.wrap = true
opt.clipboard = ""
opt.laststatus = 0
opt.spelllang = "en,cjk"
-- vim.opt.spell = true
opt.spelloptions = "camel"
opt.scrolloff = 5
opt.indentexpr = ""
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldenable = true
opt.foldlevelstart = 99
opt.guicursor =
  "n:block,i-ci-ve-v-c:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-ICursorColor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

if vim.g.neovide then
  vim.g.neovide_padding_right = 5
  vim.g.neovide_padding_left = 5
  vim.o.guifont = "ComicShannsMono Nerd Font Mono:h14"
  -- vim.g.neovide_transparency = 0.0
  -- vim.g.transparency = 0.8
  -- vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_input_use_logo = 1
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
end
