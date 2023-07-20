return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin",
        component_separators = "|",
        section_separators = { left = "", right = "" },
        globalstatus = true,
        ignore_focus = {
          "dapui_watches",
          "dapui_stacks",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dap-repl",
        },
      },
      sections = {
        lualine_a = {
          { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = {
          {
            function()
              local loc = require("lualine.components.location")()
              local sel = require("lualine.components.selectioncount")()
              if sel ~= "" then
                loc = loc .. " (" .. sel .. " sel)"
              end
              return loc
            end,
            separator = { right = "" },
            left_padding = 2,
          },
        },
      },
      extensions = { "neo-tree" },
    },
  },
}
