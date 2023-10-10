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
              name = { "smoothcursor*" },
              auto = false,
              wrap = true,
              maxwidth = 1,
              colwidth = 1,
            },
          },
          { text = { " " } },
          { text = { builtin.foldfunc }, click = "v:lua.ScFa", auto = false },
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
              name = { ".*" },
              namespace = { "gitsigns_extmark_signs_" },
              text = { ".*" },
              auto = false,
            },
            click = "v:lua.ScSa",
          },
          -- {
          --   sign = {
          --     name = { "GitSigns*" },
          --     auto = false,
          --   },
          --   click = "v:lua.ScSa",
          -- },
        },
      })
    end,
  },
}
