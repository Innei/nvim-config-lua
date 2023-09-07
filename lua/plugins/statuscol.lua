return {
  -- "luukvbaal/statuscol.nvim",
  -- event = "BufReadPost",
  -- enabled = false,
  -- init = function()
  --   vim.opt_global.foldcolumn = "1"
  --
  --   vim.opt.signcolumn = "yes:2"
  --   vim.opt_global.signcolumn = "yes:2"
  -- end,
  -- opts = function()
  --   local builtin = require("statuscol.builtin")
  --   return {
  --     setopt = true,
  --     relculright = true,
  --     segments = {
  --       {
  --         sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
  --         click = "v:lua.ScSa",
  --       },
  --       { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
  --       { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
  --     },
  --   }
  -- end,
  {
    "luukvbaal/statuscol.nvim",
    lazy = false,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
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
          { text = { builtin.foldfunc }, click = "v:lua.ScFa", auto = true },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 1, colwidth = 1, auto = true },
            click = "v:lua.ScSa",
          },
          {
            sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, wrap = true, auto = true },
            click = "v:lua.ScSa",
          },

          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },

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
