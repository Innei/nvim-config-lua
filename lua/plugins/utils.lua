return {
  {
    "rainbowhxch/accelerated-jk.nvim",
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
    end,
    vscode = true,
  },
  -- {
  --   "tpope/vim-sleuth",
  --   event = "InsertEnter",
  -- },

  -- save if not folder exists
  {
    "jghauser/mkdir.nvim",
    event = "VeryLazy",
  },
}
