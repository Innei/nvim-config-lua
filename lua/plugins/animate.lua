return {
  {
    "echasnovski/mini.animate",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.animate").setup({
        scroll = {
          enable = true,
          timing = function(_, n)
            return 150 / n
          end,
        },
        cursor = {
          enable = false,
        },
      })
    end,
  },
  {
    "gen740/SmoothCursor.nvim",
    config = function()
      require("smoothcursor").setup({
        cursor = "",
        fancy = {
          enable = true,
        },
      })
    end,
    event = "BufRead",
  },
}
