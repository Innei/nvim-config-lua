-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.g.mapleader = " "

local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local nmappings = {
  -- page scroll
  {

    from = "<c-i>",
    to = "<c-d>",
    mode = mode_nv,
  },
  -- { from = "Q", to = ":bd<CR>" },
  {
    from = ";",
    to = ":",
    mode = mode_nv,
  },
  { from = "y", to = '"+y', mode = mode_nv },
  {
    from = "`",
    to = "~",
    mode = mode_nv,
  },
  -- {
  --   from = "jj",
  --   to = "<ESC>",
  --   mode = mode_i,
  -- },
  -- {
  --   from = "jk",
  --   to = "<ESC>",
  --   mode = mode_i,
  -- },
  {
    from = "X",
    to = "r",
  },
  {
    from = "r",
    to = "<c-r>",
  },
  --
  {
    from = "<s-up>",
    to = "<ESC>:m .-2<CR>==gi",
    mode = mode_i,
  },
  {
    from = "<s-down>",
    to = "<ESC>:m .+1<CR>==gi",
    mode = mode_i,
  },

  {
    from = "cw",
    to = '"_ciw',
  },
  {
    from = "!",
    to = "%",
  },
  {
    from = "0",
    to = "^",
  },
  {
    from = ")",
    to = "g_",
  },
  {
    from = "p",
    to = "P",
    mode = mode_v,
  },
  {
    from = "x",
    to = '"_x',
  },
  {
    from = "x",
    to = '"_x',
    mode = mode_v,
  },
  {
    from = "c",
    to = '"_c',
  },
  {
    from = "c",
    to = '"_c',
    mode = mode_v,
  },

  {
    from = "<M-left>",
    to = "<ESC>bi",
    mode = mode_i,
  },
  {
    from = "<M-right>",
    to = "<ESC>ea",
    mode = mode_i,
  },

  -- undo
  {
    from = "<C-z>",
    to = "<ESC>ua",
    mode = mode_i,
  },
  {
    from = " ",
    to = " <C-g>u",
    mode = mode_i,
  },
  {
    from = "=",
    to = "=<C-g>u",
    mode = mode_i,
  },
  --
  { from = "<leader>rc", to = ":e ~/.config/nvim/init.lua<CR>" },

  -- map , .
  {
    from = ",",
    to = "<c-o>",
  },
  {
    from = ".",
    to = "<c-i>",
  },
  {
    from = ",",
    to = "^",
    mode = mode_v,
  },
  {
    from = ".",
    to = "g_",
    mode = mode_v,
  },

  -- cursor move panel
  {
    from = "<leader><up>",
    to = "<C-w>k",
  },
  {
    from = "<leader><down>",
    to = "<C-w>j",
  },
  {
    from = "<leader><left>",
    to = "<C-w>h",
  },
  {
    from = "<leader><right>",
    to = "<C-w>l",
  },
  -- for kitty mapping
  -- {
  --   from = "<M-D-f>",
  --   to = "<ESC><Leader>cf",
  --   mode = mode_i,
  --   noremap = false,
  -- },
  {
    from = "<M-x>",
    to = '"+d',
    mode = mode_v,
  },
  {
    from = "<M-x>",
    to = "dd",
  },
  {
    from = "<M-c>",
    to = '"+y',
    mode = mode_v,
  },
  {
    from = "<M-z>",
    to = "<ESC>ui",
    mode = mode_i,
  },
  {
    from = "<M-z>",
    to = "u",
  },
  {
    from = "<M-p>",
    to = "<ESC>:Telescope<CR>",
  },
  {
    from = "<M-backspace>",

    to = "<C-w>",
    mode = mode_i,
  },
  {
    from = "<M-.>",
    to = "<Esc><cmd>lua vim.lsp.buf.code_action()<CR>",
  },
  { from = "<c-a>", to = "gg<s-v>G" },
}

for _, mapping in ipairs(nmappings) do
  vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = mapping.noremap or true })
end

vim.keymap.del({ "n", "x" }, "j")
vim.keymap.del({ "n", "x" }, "k")

vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
