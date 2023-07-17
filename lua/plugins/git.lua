return {
  -- {
  --   "sindrets/diffview.nvim",
  --   very_lazy = true,
  --   cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  --   keys = "<leader>gd",
  --   config = function()
  --     vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>DiffviewFileHistory %<cr>", { noremap = true, silent = true })
  --   end,
  -- },
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.cmd([[
let g:gitblame_message_when_not_committed = 'Oh please, commit this !'
" let g:gitblame_highlight_group = "Question"
" let g:gitblame_virtual_text_column = 120
let g:gitblame_date_format = '%r'

      ]])
    end,
  },
}
