return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bq", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      {
        "Q",
        function()
          require("mini.bufremove").delete(nil, false)
        end,
        desc = "Delete buffer",
      },
      {
        "<C-q>",
        function()
          require("mini.bufremove").delete(nil, false)
        end,
        desc = "Delete buffer",
      },
    },

    -- config = function()
    --   require("bufferline").setup({
    --     options = {
    --       hover = {
    --
    --         delay = 200,
    --         reveal = { "close" },
    --         enabled = true,
    --       },
    --       style_preset = "slant",
    --     },
    --   })
    -- end,
  },
}
