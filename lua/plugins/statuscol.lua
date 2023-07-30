return {
  "luukvbaal/statuscol.nvim",
  event = "BufReadPost",
  init = function()
    vim.opt_global.foldcolumn = "1"

    vim.opt.signcolumn = "yes:2"
    vim.opt_global.signcolumn = "yes:2"
  end,
  opts = function()
    local builtin = require("statuscol.builtin")
    return {
      setopt = true,
      relculright = true,
      segments = {
        {
          sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
          click = "v:lua.ScSa",
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
      },
    }
  end,
}
