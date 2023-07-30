return {
  -- {
  --   "echasnovski/mini.animate",
  --   version = "*",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.animate").setup({
  --       scroll = {
  --         enable = true,
  --         timing = function(_, n)
  --           return 150 / n
  --         end,
  --       },
  --       cursor = {
  --         enable = false,
  --       },
  --     })
  --   end,
  -- },
  {
    "gen740/SmoothCursor.nvim",
    config = function()
      require("smoothcursor").setup({
        cursor = "",

        priority = 1, -- set marker priority
        fancy = {
          enable = true,
        },
        disabled_filetypes = require("util.ft").exclude_ft, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
      })
    end,
    event = "BufRead",
  },
}
