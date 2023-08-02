local icons = {
  Keyword = "󰌋",
  Operator = "󰆕",

  Text = "",
  Value = "󰎠",
  Constant = "󰏿",

  Method = "",
  Function = "󰊕",
  Constructor = "",

  Class = "",
  Interface = "",
  Module = "",

  Variable = "",
  Property = "󰜢",
  Field = "󰜢",

  Struct = "󰙅",
  Enum = "",
  EnumMember = "",

  Snippet = "",

  File = "",
  Folder = "",

  Reference = "󰈇",
  Event = "",
  Color = "",
  Unit = "󰑭",
  TypeParameter = "",
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Function to check if a floating dialog exists and if not
      -- then check for diagnostics under the cursor
      function OpenDiagnosticIfNoFloat()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
          if vim.api.nvim_win_get_config(winid).zindex then
            return
          end
        end
        -- THIS IS FOR BUILTIN LSP
        vim.diagnostic.open_float(0, {
          scope = "cursor",
          focusable = false,
          close_events = {
            "CursorMoved",
            "CursorMovedI",
            "BufHidden",
            "InsertCharPre",
            "WinLeave",
          },
        })
      end
      -- Show diagnostics under the cursor when holding position
      vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold" }, {
        pattern = "*",
        command = "lua OpenDiagnosticIfNoFloat()",
        group = "lsp_diagnostics_hold",
      })

      opts.diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        -- virtual_text = {
        --   spacing = 4,
        --   source = "if_many",
        --   prefix = "●",
        --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        --   -- prefix = "icons",
        -- },
        severity_sort = true,
        signs = false,
      }

      opts.inlay_hints = {
        enabled = true,
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "BufEnter",
    dependencies = { "hrsh7th/cmp-emoji", "zbirenbaum/copilot.lua" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      opts.formatting.format = function(entry, item)
        item.kind = icons[item.kind] or item.kind
        item.menu = nil

        local truncated = vim.fn.strcharpart(item.abbr, 0, 30)
        if truncated ~= item.abbr then
          item.abbr = truncated .. "…"
        end

        return item
      end

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.confirm({
              select = true,
            })
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Esc>"] = cmp.mapping({
          i = function(fallback)
            fallback()
          end,
        }),
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<c-e>"] = cmp.mapping({
          i = function(fallback)
            fallback()
          end,
        }),

        -- disable cr
        -- ["<CR>"] = cmp.mapping(function(fallback)
        --   fallback()
        -- end),
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() then
              cmp.confirm()
            else
              fallback()
            end
          end,
        }),
      })
    end,
  },

  -- https://www.lazyvim.org/configuration/recipes#use-eslint-for-fix-on-save-and-prettier-for-formatting
  -- Add Eslint and use it for formatting
  -- If your project is using eslint with eslint-plugin-prettier, then this will automatically fix eslint errors and format with prettier on save. Important: make sure not to add prettier to null-ls, otherwise this won't work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = { eslint = {} },
  --     setup = {
  --       eslint = function()
  --         require("lazyvim.util").on_attach(function(client)
  --           if client.name == "eslint" then
  --             client.server_capabilities.documentFormattingProvider = true
  --           elseif client.name == "tsserver" then
  --             client.server_capabilities.documentFormattingProvider = false
  --           end
  --         end)
  --       end,
  --     },
  --   },
  -- },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "json-lsp")
      -- table.insert(opts.ensure_installed, "proselint")
      -- table.insert(opts.ensure_installed, "write-good")
      -- table.insert(opts.ensure_installed, "alex")
      -- table.insert(opts.ensure_installed, "cspell")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      -- local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        -- nls.builtins.diagnostics.proselint,
        -- nls.builtins.diagnostics.write_good,
        -- nls.builtins.diagnostics.alex,
        -- nls.builtins.code_actions.proselint,
        -- nls.builtins.code_actions.cspell,
        -- nls.builtins.diagnostics.cspell.with({
        --   -- Force the severity to be HINT
        --   diagnostics_postprocess = function(diagnostic)
        --     diagnostic.severity = vim.diagnostic.severity.HINT
        --   end,
        -- }),
      })
      -- table.insert(opts.source, nls.builtins.completion.spell)
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({
        ui = {
          code_action = "💡",
        },
        lightbulb = {
          sign = false,
          virtual_text = true,
          enable = true,
        },
      })
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc")
      vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action")
      vim.keymap.set("n", "<leader>ol", "<cmd>Lspsaga outline")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },

  -- configure lsp easy
  {
    "tamago324/nlsp-settings.nvim",
    enabled = true,
    cmd = "LspSettings",
    opts = {},
  },
  {
    "dnlhc/glance.nvim",
    event = "BufRead",
    config = function()
      require("glance").setup({
        -- your configuration
      })

      vim.keymap.set("n", "gD", "<CMD>Glance definitions<CR>")
      vim.keymap.set("n", "gR", "<CMD>Glance references<CR>")
      vim.keymap.set("n", "gY", "<CMD>Glance type_definitions<CR>")
      vim.keymap.set("n", "gM", "<CMD>Glance implementations<CR>")
    end,
  },

  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({
        width = 120, -- Width of the floating window
        height = 15, -- Height of the floating window
        border = require("util.opts").float.border, -- Border characters of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false, -- Print debug information
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true, -- Focus the floating window when opening it.
        dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
      })

      local utils = require("util.utils")

      local set_keymap = utils.set_n_keymap

      set_keymap("gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "Go to definition preview")
      set_keymap(
        "gpt",
        "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
        "Go to type definition preview"
      )
      set_keymap(
        "gpi",
        "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
        "Go to implementation preview"
      )
      set_keymap("gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", "Close all preview windows")
      set_keymap("gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "Go to references preview")
    end,
  },
  {
    -- Not needed anymore with nvim-0.10.0
    {
      "lvimuser/lsp-inlayhints.nvim",
      branch = "anticonceal",
      event = "LspAttach",
      opts = {},
      config = function(_, opts)
        require("lsp-inlayhints").setup(opts)
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
          callback = function(args)
            if not (args.data and args.data.client_id) then
              return
            end
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            require("lsp-inlayhints").on_attach(client, args.buf)
          end,
        })
      end,
    },
  },
}
