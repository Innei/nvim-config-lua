return {
  "dstein64/nvim-scrollview",
  enabled = false,
  config = function()
    require("scrollview").setup({
      excluded_filetypes = { "nerdtree" },
      current_only = true,
      base = "buffer",
      signs_on_startup = { "all" },
      diagnostics_severities = { vim.diagnostic.severity.ERROR },
    })
  end,
}
