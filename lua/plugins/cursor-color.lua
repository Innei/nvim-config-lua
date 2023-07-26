return {
  "mvllow/modes.nvim",
  event = "BufEnter",
  enabled = false,
  config = function()
    require("modes").setup({
      colors = {
        insert = "#75C2F6",
        visual = "#FF2171",
      },

      -- Set opacity for cursorline and number background
      line_opacity = 0.3,

      -- Enable cursor highlights
      set_cursor = true,

      -- Enable cursorline initially, and disable cursorline for inactive windows
      -- or ignored filetypes
      set_cursorline = true,

      -- Enable line number highlights to match cursorline
      set_number = true,

      -- Disable modes highlights in specified filetypes
      -- Please PR commonly ignored filetypes
      ignore_filetypes = require("util.ft").exclude_ft,
    })
  end,
}
