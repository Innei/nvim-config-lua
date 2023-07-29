return {
  {
    "sidebar-nvim/sidebar.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("sidebar-nvim").setup({
        disable_default_keybindings = 0,
        bindings = nil,
        open = true,
        side = "right",
        initial_width = 35,
        hide_statusline = false,
        update_interval = 1000,
        sections = { "buffers", "git", "symbols", "todo", "files" },
        section_separator = { "", "-----", "" },
        section_title_separator = { "" },
        todos = { ignored_paths = { "~" } },
      })
    end,
  },
}
