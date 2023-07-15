return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({

        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-c>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      })
    end,
  },
  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     vim.g.copilot_enabled = true
  --     vim.g.copilot_no_tab_map = true
  --     vim.api.nvim_set_keymap("n", "<leader>go", ":Copilot<CR>", { silent = true })
  --     vim.api.nvim_set_keymap("i", "<c-p>", "<Plug>(copilot-suggest)", {})
  --     -- vim.api.nvim_set_keymap('i', '<c-n>', '<Plug>(copilot-next)', { silent = true })
  --     -- vim.api.nvim_set_keymap('i', '<c-l>', '<Plug>(copilot-previous)', { silent = true })
  --     vim.cmd('imap <silent><script><expr> <C-C> copilot#Accept("")')
  --     vim.cmd([[
  -- 	let g:copilot_filetypes = {
  --       \ 'TelescopePrompt': v:false,
  --     \ }
  -- 	]])
  --   end,
  -- },
}
