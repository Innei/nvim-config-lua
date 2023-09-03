return {
  {
    "ggandor/leap.nvim",
    enabled = false,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      search = {
        -- mode = "fuzzy",
      },
      label = {
        uppercase = false,
      },
      modes = {

        char = {
          enabled = true,
          -- dynamic configuration for ftFT motions
          config = function(opts)
            -- autohide flash when in operator-pending mode
            opts.autohide = vim.fn.mode(true):find("no") and vim.v.operator == "y"

            -- disable jump labels when enabled and when using a count
            opts.jump_labels = opts.jump_labels and vim.v.count == 0

            -- Show jump labels only in operator-pending mode
            -- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
          end,
          -- hide after jump when not using jump labels
          autohide = false,
          -- show jump labels
          jump_labels = false,
          -- set to `false` to use the current line only
          multi_line = true,
          -- When using jump labels, don't use these keys
          -- This allows using those keys directly after the motion
          -- label = { exclude = "hjkliardc" },
          -- by default all keymaps are enabled, but you can disable some of them,
          -- by removing them from the list.
          -- If you rather use another key, you can map them
          -- to something else, e.g., { [";"] = "L", [","] = H }
          keys = { "f", "F", "t", "T" },
          -- The direction for `prev` and `next` is determined by the motion.
          -- `left` and `right` are always left and right.
          search = { wrap = false },
          highlight = { backdrop = true },
          jump = { register = false },
        },
        search = {
          -- when `true`, flash will be activated during regular search by default.
          -- You can always toggle when searching with `require("flash").toggle()`
          enabled = false,
        },
      },
    },
    keys = function()
      return {
        {
          "s",
          -- mode = { "n" },
          function()
            require("flash").jump()
          end,
          desc = "Flash",
        },
        {
          "S",
          -- mode = { "n" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash Treesitter",
        },
      }
    end,
  },
}
