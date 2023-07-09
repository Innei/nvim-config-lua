return {
  "nvim-telescope/telescope.nvim",

  config = function()
    vim.api.nvim_set_keymap("n", "<C-r>", "<cmd>Telescope grep_string<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
  end
}
