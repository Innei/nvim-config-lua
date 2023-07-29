return {
  "Vonr/align.nvim",
  event = "BufRead",
  config = function()
    local NS = { noremap = true, silent = true }

    vim.keymap.set("x", "aa", function()
      require("align").align_to_char(1, true)
    end, NS) -- Aligns to 1 character, looking le   ft
    vim.keymap.set("x", "as", function()
      require("align").align_to_char(2, true, true)
    end, NS) -- Aligns to 2 characters, looking le  ft and with previews
    vim.keymap.set("x", "aw", function()
      require("align").align_to_string(false, true, true)
    end, NS) -- Aligns to a string, looking le      ft and with previews
    vim.keymap.set("x", "ar", function()
      require("align").align_to_string(true, true, true)
    end, NS) -- Aligns to a Lua pattern, looking le ft and with previews
  end,
}
