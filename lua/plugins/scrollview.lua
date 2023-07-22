return {
  "dstein64/nvim-scrollview",
  enabled = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  config = function()
    require("scrollview").setup({
      excluded_filetypes = { "nerdtree" },
      -- current_only = true,
      -- base = "buffer",
      -- signs_on_startup = { "all" },
      -- diagnostics_severities = { vim.diagnostic.severity.ERROR },
      winblend = 0,
      signs_on_startup = { "diagnostics", "folds", "marks", "search", "spell" },
      diagnostics_error_symbol = "▎",
      diagnostics_warn_symbol = "▎",
      diagnostics_info_symbol = "▎",

      diagnostics_hint_symbol = "",
    })
  end,
}
