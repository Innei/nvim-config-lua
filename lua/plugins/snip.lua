return {
  {
    "rafamadriz/friendly-snippets",
    opts = function(_, opts)
      require("luasnip").filetype_extend("typescript", { "javascript" })
      require("luasnip").filetype_extend("javascriptreact", { "javascript" })
      require("luasnip").filetype_extend("typescriptreact", { "javascript" })
    end,
  },
}
