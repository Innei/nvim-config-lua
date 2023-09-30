return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    enabled = true,
    keys = {
      {
        "<leader>bq",
        function()
          local buffers = vim.fn.getbufinfo({ buflisted = true })
          local changed_buffers = vim.tbl_filter(function(buf)
            return buf.changed == 1
          end, buffers)
          if #changed_buffers == 0 then
            vim.cmd([[BufferLineCloseOthers]])
          else
            vim.notify("There are unsaved buffers", vim.log.levels.WARN)
          end
        end,
        desc = "Delete other buffers",
      },
      {
        "Q",
        function()
          require("mini.bufremove").delete(nil, false)
        end,
        desc = "Delete buffer",
      },
      {
        "<C-q>",
        function()
          require("mini.bufremove").delete(nil, false)
        end,
        desc = "Delete buffer",
      },
      {
        "<D-w>",
        function()
          require("mini.bufremove").delete(nil, false)
        end,
        desc = "Delete buffer",
      },

      {
        "<leader>bs",
        function()
          vim.cmd([[BufferLinePick]])
        end,

        desc = "Pick buffer",
      },

      {
        "<leader>bS",
        function()
          vim.cmd([[BufferLinePickClose]])
        end,
        desc = "Pick buffer and close",
      },
    },

    config = function()
      vim.cmd([[
  nnoremap <silent><A-1> <Cmd>BufferLineGoToBuffer 1<CR>
  nnoremap <silent><A-2> <Cmd>BufferLineGoToBuffer 2<CR>
  nnoremap <silent><A-3> <Cmd>BufferLineGoToBuffer 3<CR>
  nnoremap <silent><A-4> <Cmd>BufferLineGoToBuffer 4<CR>
  nnoremap <silent><A-5> <Cmd>BufferLineGoToBuffer 5<CR>
  nnoremap <silent><A-6> <Cmd>BufferLineGoToBuffer 6<CR>
  nnoremap <silent><A-7> <Cmd>BufferLineGoToBuffer 7<CR>
  nnoremap <silent><A-8> <Cmd>BufferLineGoToBuffer 8<CR>
  nnoremap <silent><A-9> <Cmd>BufferLineGoToBuffer 9<CR>
  ]])

      vim.o.mousemoveevent = true
      require("bufferline").setup({

        options = {

          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              highlight = "Directory",
              text_align = "left",
            },
          },
          always_show_bufferline = true,
          indicator = {
            icon = "▎", -- this should be omitted if indicator style is not 'icon'
            style = "underline",
          },
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            -- only show warning and error
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " " or (e == "warning" and " " or "")
              s = s .. sym .. n
            end
            return s
          end,
          hover = {

            delay = 36,
            reveal = { "close" },
            enabled = true,
          },
          style_preset = "slant",
        },
      })
    end,
  },
  {
    "romgrk/barbar.nvim",
    enabled = false,
    event = "VeryLazy",
    keys = {
      { "<leader>bq", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Delete other buffers" },
      {
        "Q",
        "<cmd>BufferClose<cr>",
        desc = "Delete buffer",
      },
      {
        "<C-q>",
        "<cmd>BufferClose<cr>",

        desc = "Delete buffer",
      },
    },
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
      map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
      map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
      map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
      map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
      map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
      map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
      map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
      map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
      map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

      map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
      map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
      map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
      map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

      vim.g.barbar_auto_setup = false -- disable auto-setup

      require("barbar").setup({
        highlight_alternate = false,

        -- Disable highlighting file icons in inactive buffers
        highlight_inactive_file_icons = false,

        -- Enable highlighting visible buffers
        highlight_visible = true,
        -- animation = false,
        sidebar_filetypes = {
          -- Use the default values: {event = 'BufWinLeave', text = nil}
          NvimTree = true,
          -- Or, specify the text used for the offset:
          undotree = { text = "undotree" },
          -- Or, specify the event which the sidebar executes when leaving:
          -- ["neo-tree"] = { event = "BufWipeout" },
          ["neo-tree"] = true,
          -- Or, specify both
          Outline = { event = "BufWinLeave", text = "symbols-outline" },
        },
        letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

        icons = {
          button = "×",
          separator = { left = "▎", right = "" },
          modified = { button = "●" },
          pinned = { button = "", filename = true },

          highlight_inactive_file_icons = true,
        },
        diagnostic = {
          [vim.diagnostic.severity.ERROR] = { enabled = true },
        },
        -- Enable/disable auto-hiding the tab bar when there is a single buffer
        auto_hide = false,
        -- Enable/disable current/total tabpages indicator (top right corner)

        tabpages = true,
      })
    end,
  },
}
