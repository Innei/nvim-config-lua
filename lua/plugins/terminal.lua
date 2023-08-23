return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup({
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = true,
        persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
        direction = "horizontal", --   direction = 'vertical' | 'horizontal' | 'tab' | 'float',
        auto_scroll = true, -- automatically scroll to the bottom on terminal output
        open_mapping = [[<c-`>]],
      })
    end,
  },
}
