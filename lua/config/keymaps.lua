-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.g.mapleader = " "

local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local nmappings = {
  { from = "Q", to = ":bd<CR>" },
  {
    from = ";",
    to = ":",
    mode = mode_nv,
  },
  { from = "Y", to = '"+y', mode = mode_v },
  {
    from = "`",
    to = "~",
    mode = mode_nv,
  },
  {
    from = "jj",
    to = "<ESC>",
    mode = mode_i,
  },
  {
    from = "jk",
    to = "<ESC>",
    mode = mode_i,
  },
  {
    from = "X",
    to = "r",
  },
  {
    from = "r",
    to = "<c-r>",
  },
  --
  { from = "<c-a>", to = "<ESC>A", mode = mode_i },
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
    to = "ciw",
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
  --
  --
  { from = "<leader>rc", to = ":e ~/.config/nvim/init.lua<CR>" },
  { from = "<leader>rv", to = ":e .vim.lua<CR>" },
  { from = ",v", to = "v%" },
  { from = "<leader><cr>", to = ":nohlsearch<CR>" },

  -- plugin
  { from = "R", to = ":Joshuto<CR>" },
  {
    from = "<c-p>",
    to = ":Telescope git_files<CR>",
  },
  {
    from = ",",
    to = "<c-o>",
  },
  {
    from = ".",
    to = "<c-i>",
  },
  -- {
  --   from = "tt",
  --   to = ":Neotree focus<cr>",
  -- },
  -- {
  --   from = "<c-b>",
  --   to = ":Neotree toggle<cr>",
  -- },
}

for _, mapping in ipairs(nmappings) do
  vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end
