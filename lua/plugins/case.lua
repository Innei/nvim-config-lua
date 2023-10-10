return {
  "xlboy/text-case.nvim",

  event = "BufRead",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")
    vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescopeLSPChange<CR>", { desc = "Telescope" })
    vim.api.nvim_set_keymap("v", "ga.", "<cmd>TextCaseOpenTelescopeLSPChange<CR>", { desc = "Telescope" })
    vim.api.nvim_set_keymap(
      "n",
      "gaa",
      "<cmd>TextCaseOpenTelescopeQuickChange<CR>",
      { desc = "Telescope Quick Change" }
    )
  end,
}
