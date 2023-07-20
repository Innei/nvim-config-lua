return {
  -- Switch between single-line and multiline forms of code
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>j", ":TSJToggle<CR>", silent = true },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
      max_join_length = 999,
    },
  },
}
