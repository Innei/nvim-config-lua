return {

  {
    "nvim-treesitter/nvim-treesitter-context",

    config = function()
      require("nvim-ts-autotag").setup()

      local tscontext = require("treesitter-context")
      tscontext.setup({
        enable = true,
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
      vim.keymap.set("n", "[c", function()
        tscontext.go_to_context()
      end, { silent = true })
      -- vim.api.nvim_set_option_value("foldmethod", "expr", {})
      -- vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})
      -- vim.cmd("set nofoldenable")
      --
      vim.o.indentexpr = ""
      vim.o.foldmethod = "indent"
      vim.o.foldlevel = 99
      vim.o.foldenable = true
      vim.o.foldlevelstart = 99
    end,
  },
}
