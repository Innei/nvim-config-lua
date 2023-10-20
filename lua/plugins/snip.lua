return {
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  -- {
  --   "Innei/friendly-snippets-fork",
  --   -- event = "InsertEnter",
  --   config = function()
  --     -- require("luasnip.loaders.from_vscode").lazy_load()
  --     require("luasnip.loaders.from_vscode").lazy_load({
  --       paths = { "~/.config/nvim/snippets" },
  --     })
  --     require("luasnip").filetype_extend("typescript", { "javascript" })
  --     require("luasnip").filetype_extend("javascriptreact", { "javascript" })
  --     require("luasnip").filetype_extend("typescriptreact", { "javascript" })
  --   end,
  -- },
  {
    "L3MON4D3/LuaSnip",
    event = "LazyFile",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "~/.config/nvim/snippets" },
      })
      require("luasnip").filetype_extend("typescript", { "javascript" })
      require("luasnip").filetype_extend("javascriptreact", { "javascript" })
      require("luasnip").filetype_extend("typescriptreact", { "javascript" })
      require("luasnip").setup({
        history = false,
        region_check_events = { "CursorHold" },
      })
    end,
  },
}
