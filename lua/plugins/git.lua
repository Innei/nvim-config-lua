return {
  {
    "sindrets/diffview.nvim",
    very_lazy = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = "<leader>gd",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>DiffviewFileHistory %<cr>", { noremap = true, silent = true })
    end,
  },
  {
    "f-person/git-blame.nvim",
  },
}
