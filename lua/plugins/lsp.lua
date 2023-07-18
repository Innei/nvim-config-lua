return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji", "zbirenbaum/copilot.lua" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.confirm()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
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
          i = cmp.mapping.abort(),
          -- c = cmp.mapping.close(),
          c = cmp.mapping.abort(),
        }),
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),

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
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
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
      table.insert(opts.ensure_installed, "proselint")
      table.insert(opts.ensure_installed, "write-good")
      table.insert(opts.ensure_installed, "alex")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.proselint,
        nls.builtins.diagnostics.write_good,
        nls.builtins.diagnostics.alex,
        nls.builtins.code_actions.proselint,
      })
      -- table.insert(opts.source, nls.builtins.completion.spell)
    end,
  },
}
