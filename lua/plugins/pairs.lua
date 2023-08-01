return {
  {
    "m4xshen/autoclose.nvim",
    event = "BufEnter",
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
          disabled_filetypes = require("util.ft").exclude_ft,
          disable_when_touch = true,
          pair_spaces = true,
          auto_indent = true,
        },
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    enabled = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {}, -- this is equalent to setup({}) function
    enabled = true,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    config = function()
      local filetypes = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "rescript",
        "xml",
        "php",
        "markdown",
        "astro",
        "glimmer",
        "handlebars",
        "hbs",
      }
      require("nvim-ts-autotag").setup({
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = false,
          filetypes = filetypes,
        },
      })
    end,
  },

  {
    "andymass/vim-matchup",
    event = "BufEnter",
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
