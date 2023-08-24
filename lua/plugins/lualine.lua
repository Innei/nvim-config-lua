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
        lualine_x = {
          "filetype",
          {
            function()
              local icon = require("lazyvim.config").icons.kinds.Copilot
              local status = require("copilot.api").status.data
              return icon .. (status.message or "")
            end,
            cond = function()
              local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
              return ok and #clients > 0
            end,
            color = function()
              if not package.loaded["copilot"] then
                return
              end
              local Util = require("lazyvim.util")
              local colors = {
                [""] = Util.fg("Special"),
                ["Normal"] = Util.fg("Special"),
                ["Warning"] = Util.fg("DiagnosticError"),
                ["InProgress"] = Util.fg("DiagnosticWarn"),
              }

              local status = require("copilot.api").status.data
              return colors[status.status] or colors[""]
            end,
          },
        },
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
