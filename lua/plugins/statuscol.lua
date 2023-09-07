return {
  {
    "luukvbaal/statuscol.nvim",
    lazy = false,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        ft_ignore = require("util.ft").exclude_ft,
        bt_ignore = { "terminal", "nofile" },
        relculright = true,
        segments = {
          {
            sign = {
              name = { "smoothcursor_.*" },
              auto = true,
              wrap = true,
              maxwidth = 1,
              colwidth = 1,
            },
          },
          { text = { " " } },
          { text = { builtin.foldfunc }, click = "v:lua.ScFa", auto = true },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 1, colwidth = 1, auto = true },
            click = "v:lua.ScSa",
          },
          {
            sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, wrap = true, auto = true },
            click = "v:lua.ScSa",
          },

          { text = { builtin.lnumfunc }, click = "v:lua.ScLa", auto = true, wrap = true },

          {
            text = { " " },
          },
          {
            sign = {
              name = { "GitSigns*" },
              auto = true,
            },
            click = "v:lua.ScSa",
          },
        },
      })
    end,
  },
}
