local M = {}
local map = vim.api.nvim_set_keymap

local function set_keymap(mode, key, command, description)
  local options = { noremap = true, silent = true, desc = description }
  map(mode, key, command, options)
end

local function set_n_keymap(key, command, description)
  set_keymap("n", key, command, description)
end

M.set_n_keymap = set_n_keymap

return M
