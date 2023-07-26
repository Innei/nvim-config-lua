return {
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        fps = 60,
        render = "compact",
        stages = "fade_in_slide_out",
        timeout = 5000,
        max_width = 80,
        max_height = 20,
      })
    end,
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require("lazyvim.util")
      if not Util.has("noice.nvim") then
        Util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      views = {
        mini = {
          win_options = { winblend = 0 },
        },
      },
      routes = {
        {
          filter = {
            event = "notify",
            any = {
              -- Neo-tree
              { find = "Toggling hidden files: true" },
              { find = "Toggling hidden files: false" },
              { find = "Operation canceled" },

              -- Telescope
              { find = "Nothing currently selected" },
              {
                find = "No information available",
              },
              {
                find = "Highlight group",
              },
              {
                find = "no manual entry for",
              },
              {
                find = "not have parser for",
              },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = { "echo" },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            any = {
              -- Save
              { find = " bytes written" },

              -- Redo/Undo
              { find = " changes; before #" },
              { find = " changes; after #" },
              { find = "1 change; before #" },
              { find = "1 change; after #" },

              -- Yank
              { find = " lines yanked" },

              -- Move lines
              { find = " lines moved" },
              { find = " lines indented" },

              -- Bulk edit
              { find = " fewer lines" },
              { find = " more lines" },
              { find = "1 more line" },
              { find = "1 line less" },

              -- General messages
              { find = "Already at newest change" },
              { find = "Already at oldest change" },
              { find = "E21: Cannot make changes, 'modifiable' is off" },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "lsp",
            any = {
              { find = "formatting" },
              { find = "Diagnosing" },
              { find = "Diagnostics" },
              { find = "diagnostics" },
              { find = "code_action" },
              { find = "Processing full semantic tokens" },
            },
          },
          opts = { skip = true },
        },
      },
    },
    -- opts = function(_, opts)
    --   table.insert(opts.routes, {
    --     filter = {
    --       event = "notify",
    --       find = "No information available",
    --     },
    --     opts = { skip = true },
    --   })
    --   table.insert(opts.routes, {
    --     filter = {
    --       event = "notify",
    --       find = "Highlight group",
    --     },
    --     opts = { skip = true },
    --   })
    --   table.insert(opts.routes, {
    --     filter = {
    --       event = "notify",
    --       find = "no manual entry for",
    --     },
    --     opts = { skip = true },
    --   })
    --   table.insert(opts.routes, {
    --     filter = {
    --       event = "notify",
    --       find = "not have parser for",
    --     },
    --     opts = { skip = true },
    --   })
    -- end,
  },
}
