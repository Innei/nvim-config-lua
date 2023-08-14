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

      opts.servers.tsserver = vim.tbl_extend("force", opts.servers.tsserver, {
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern(".git")(fname)
            or util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
        end,
      })

      opts.servers.tsserver.settings = vim.tbl_extend("force", opts.servers.tsserver.settings, {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = false,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = false,
            includeInlayFunctionLikeReturnTypeHints = false,
            includeInlayEnumMemberValueHints = true,
          },
        },
      })

      opts.servers.tailwindcss = vim.tbl_extend("force", opts.servers.tailwindcss, {
        root_dir = function(...)
          return require("lspconfig.util").root_pattern(".git")(...)
        end,
      })
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

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "json-lsp")
      table.insert(opts.ensure_installed, "cspell")
      -- table.insert(opts.ensure_installed, "proselint")
      -- table.insert(opts.ensure_installed, "write-good")
      -- table.insert(opts.ensure_installed, "alex")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")

      opts.root_dir = require("null-ls.utils").root_pattern(".git")

      opts.sources = vim.list_extend(opts.sources, {
        -- nls.builtins.diagnostics.proselint,
        -- nls.builtins.diagnostics.write_good,
        -- nls.builtins.diagnostics.alex,
        -- nls.builtins.code_actions.proselint,
        nls.builtins.code_actions.cspell,
        nls.builtins.diagnostics.cspell.with({
          -- Force the severity to be HINT
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
        }),
      })
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

      set_keymap("gp", "<nop>", "+~Goto preview")
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
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },

  {
    "mhartington/formatter.nvim",
    cmd = "Format",
    config = function()
      require("formatter").setup({
        filetype = {
          zsh = {
            function()
              return {
                exe = "shfmt",
                args = { "-i", "2", "-ci" },
                stdin = true,
              }
            end,
          },
        },
        ["*"] = {
          -- "formatter.filetypes.any" defines default configurations for any
          -- filetype
          require("formatter.filetypes.any").remove_trailing_whitespace,
        },
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    keys = {

      { "<leader>T", "<cmd>SymbolsOutline<CR>", "SymbolsOutline" },
    },
    config = function()
      local opts = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = "right",
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = "Pmenu",
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = { "", "" },
        wrap = false,
        keymaps = { -- These keymaps can be a string or a table for multiple keys
          close = { "<Esc>", "q" },
          goto_location = "<Cr>",
          focus_location = "o",
          hover_symbol = "<C-space>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
          File = { icon = "", hl = "@text.uri" },
          Module = { icon = "", hl = "@namespace" },
          Namespace = { icon = "", hl = "@namespace" },
          Package = { icon = "", hl = "@namespace" },
          Class = { icon = "", hl = "@type" },
          Method = { icon = "ƒ", hl = "@method" },
          Property = { icon = "", hl = "@method" },
          Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "", hl = "@type" },
          Interface = { icon = "", hl = "@type" },
          Function = { icon = "", hl = "@function" },
          Variable = { icon = "", hl = "@constant" },
          Constant = { icon = "", hl = "@constant" },
          String = { icon = "", hl = "@string" },
          Number = { icon = "#", hl = "@number" },
          Boolean = { icon = "", hl = "@boolean" },
          Array = { icon = "", hl = "@constant" },
          Object = { icon = "", hl = "@type" },
          Key = { icon = "", hl = "@type" },
          Null = { icon = "", hl = "@type" },
          EnumMember = { icon = "", hl = "@field" },
          Struct = { icon = "", hl = "@type" },
          Event = { icon = "", hl = "@type" },
          Operator = { icon = "", hl = "@operator" },
          TypeParameter = { icon = "", hl = "@parameter" },
          Component = { icon = "", hl = "@function" },
          Fragment = { icon = "", hl = "@constant" },
        },
      }
      require("symbols-outline").setup(opts)
    end,
  },
}
