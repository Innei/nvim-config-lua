return {
  {
    "AndrewRadev/switch.vim",
    vscode = true,
    keys = {
      {
        "<leader>sx",
        function()
          vim.cmd("Switch")
        end,
        desc = "Switch",
      },
    },

    config = function()
      vim.g.switch_mapping = ""
    end,
  },
  {
    "mizlan/iswap.nvim",
    cmd = { "ISwap", "ISwapWith", "ISwapNode", "ISwapNodeWith" },
    config = function()
      require("iswap").setup({
        -- The keys that will be used as a selection, in order
        -- ('asdfghjklqwertyuiopzxcvbnm' by default)
        keys = "asdfghjklqwertyuiop123456",

        -- Grey out the rest of the text when making a selection
        -- (enabled by default)
        -- grey = "enabled",

        -- Highlight group for the sniping value (asdf etc.)
        -- default 'Search'
        hl_snipe = "ErrorMsg",

        -- Highlight group for the visual selection of terms
        -- default 'Visual'
        hl_selection = "WarningMsg",

        -- Highlight group for the greyed background
        -- default 'Comment'
        hl_grey = "LineNr",

        -- Post-operation flashing highlight style,
        -- either 'simultaneous' or 'sequential', or false to disable
        -- default 'sequential'
        flash_style = false,

        -- Highlight group for flashing highlight afterward
        -- default 'IncSearch'
        hl_flash = "ModeMsg",

        -- Move cursor to the other element in ISwap*With commands
        -- default false
        move_cursor = true,

        -- Automatically swap with only two arguments
        -- default nil
        autoswap = true,

        -- Other default options you probably should not change:
        debug = nil,
        hl_grey_priority = "1000",
      })
    end,
  },
  {
    "Wansmer/sibling-swap.nvim",
    dependencies = { "nvim-treesitter" },
    keys = {
      {
        "<leader>s.",
        function()
          require("sibling-swap").swap_with_right_with_opp()
        end,
        desc = "Swap with right with opp",
      },
      {
        "<leader>s,",
        function()
          require("sibling-swap").swap_with_left_with_opp()
        end,
        desc = "Swap with left with opp",
      },
      {
        "<C-.>",
        function()
          require("sibling-swap").swap_with_right()
        end,
        desc = "Swap with right",
      },
      {
        "<C-,>",
        function()
          require("sibling-swap").swap_with_left()
        end,
        desc = "Swap with left",
      },
    },
    config = function()
      require("sibling-swap").setup({
        allowed_separators = {
          ",",
          ";",
          "and",
          "or",
          "&&",
          "&",
          "||",
          "|",
          "==",
          "===",
          "!=",
          "!==",
          "-",
          "+",
          ["<"] = ">",
          ["<="] = ">=",
          [">"] = "<",
          [">="] = "<=",
        },
        use_default_keymaps = true,
        -- Highlight recently swapped node. Can be boolean or table
        -- If table: { ms = 500, hl_opts = { link = 'IncSearch' } }
        -- `hl_opts` is a `val` from `nvim_set_hl()`
        highlight_node_at_cursor = false,
        -- keybinding for movements to right or left (and up or down, if `allow_interline_swaps` is true)
        keymaps = {
          ["<C-.>"] = "swap_with_right",
          ["<C-,>"] = "swap_with_left",
          ["<leader>s."] = "swap_with_right_with_opp",
          ["<leader>s,"] = "swap_with_left_with_opp",
        },
        ignore_injected_langs = false,
        -- allow swaps across lines
        allow_interline_swaps = true,
        -- swaps interline siblings without separators (no recommended, helpful for swaps html-like attributes)
        interline_swaps_witout_separator = false,
      })
    end,
  },
}
