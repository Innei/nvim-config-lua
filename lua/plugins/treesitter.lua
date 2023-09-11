return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- use wildfire.nvim
      opts.incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<Tab>",
          node_decremental = "<BS>",
        },
      }

      opts.context_commentstring = {
        enable_autocmd = false,
      }

      vim.list_extend(opts.ensure_installed, {
        "prisma",
        "dockerfile",
        "svelte",
        "swift",
        "vue",
      })
    end,
  },
  {
    "xlboy/swap-ternary.nvim",
    keys = {
      {
        "<leader>sX",
        function()
          require("swap-ternary.controller").swap()
        end,
        desc = "Swap Ternary",
      },
    },
    config = function() end,
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    config = function()
      require("nvim-treesitter.configs").setup({
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local tscontext = require("treesitter-context")
      tscontext.setup({
        enable = true,
        max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit
        min_window_height = 5, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          html = "rainbow-tags",
          javascript = "rainbow-delimiters-react",
          javascriptreact = "rainbow-delimiters-react",
          typescriptreact = "rainbow-delimiters-react",
        },
        strategy = {
          [""] = rainbow.strategy["global"],
          vim = rainbow.strategy["local"],
        },
      }
    end,
  },
  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    vscode = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup({
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
        },
      })
    end,
  },
}
