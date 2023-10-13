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
              if not package.loaded["copilot"] then
                return
              end
              local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
              if not ok then
                return false
              end
              return ok and #clients > 0
            end,
            color = function()
              if not package.loaded["copilot"] then
                return
              end
              local Util = require("lazyvim.util")
              local colors = {
                [""] = Util.ui.fg("Special"),
                ["Normal"] = Util.ui.fg("Special"),
                ["Warning"] = Util.ui.fg("DiagnosticError"),
                ["InProgress"] = Util.ui.fg("DiagnosticWarn"),
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
