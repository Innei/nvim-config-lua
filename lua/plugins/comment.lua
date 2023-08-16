return {
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("Comment").setup({
        ---Add a space b/w comment and the line
        padding = true,
        ---Whether the cursor should stay at its position
        sticky = true,
        ---Lines to be ignored while (un)comment
        ignore = nil,
        ---LHS of toggle mappings in NORMAL mode
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
          basic = true,
        },
        ---Function to call before (un)comment
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        ---Function to call after (un)comment
        post_hook = nil,
      })
    end,
  },
  {
    "echasnovski/mini.comment",
    enabled = false,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({ snippet_engine = "luasnip" })
    end,
    cmd = "Neogen",
    keys = {
      {
        "<leader>ng",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen",
      },
    },
  },
}
