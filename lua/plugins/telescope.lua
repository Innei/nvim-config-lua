return {
  "nvim-telescope/telescope.nvim",

  config = function(_, opts)
    -- vim.api.nvim_set_keymap("n", "<C-r>", "<cmd>Telescope grep_string<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })

    -- local actions = require("telescope.actions")
    -- opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
    --   mappings = {
    --     i = {
    --       ["<C-n>"] = actions.cycle_history_next,
    --       ["<C-p>"] = actions.cycle_history_prev,
    --     },
    --   },
    -- })
  end,
}
