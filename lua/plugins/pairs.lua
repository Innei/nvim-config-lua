return {
  {
    "m4xshen/autoclose.nvim",
    event = "InsertEnter",
    enabled = false,
    config = function()
      require("autoclose").setup({
        keys = {
          ["("] = { escape = false, close = true, pair = "()", disabled_filetypes = {} },
          ["["] = { escape = false, close = true, pair = "[]", disabled_filetypes = {} },
          ["{"] = { escape = false, close = true, pair = "{}", disabled_filetypes = {} },

          [">"] = { escape = true, close = false, pair = "<>", disabled_filetypes = {} },
          [")"] = { escape = true, close = false, pair = "()", disabled_filetypes = {} },
          ["]"] = { escape = true, close = false, pair = "[]", disabled_filetypes = {} },
          ["}"] = { escape = true, close = false, pair = "{}", disabled_filetypes = {} },

          ['"'] = { escape = true, close = true, pair = '""', disabled_filetypes = {} },
          ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = {} },
          ["`"] = { escape = true, close = true, pair = "``", disabled_filetypes = {} },
        },
        options = {
          -- disabled_filetypes = require("util.ft").exclude_ft,
          disable_when_touch = false,
          touch_regex = "[%w(%[{]",
          pair_spaces = false,
          auto_indent = true,
        },
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    -- opts = {},
    enabled = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "LazyFile",
    opts = {}, -- this is equalent to setup({}) function
    enabled = true,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    enabled = true,
    event = "FileType typescriptreact,javascriptreact,vue,html,xml,astro",
    config = function()
      require("nvim-treesitter.configs").setup({
        autotag = {
          enable = true,
          enable_close_on_slash = false,
        },
      })
    end,
  },

  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    enabled = false,
    config = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      require("nvim-treesitter.configs").setup({
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
        },
      })
    end,
  },
}
