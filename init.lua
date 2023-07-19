-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local swap_ternary = require("plugin.swap_ternary")
vim.keymap.set("n", "<leader>sX", swap_ternary.swap_ternary, { noremap = true })
