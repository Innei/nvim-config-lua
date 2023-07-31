-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.api.nvim_set_hl(0, "ICursorColor", {
  bg = "#7dd3fc",
  fg = "#000000",
})

-- opt.clipboard = "unnamedplus"
opt.wrap = true
opt.clipboard = ""

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
