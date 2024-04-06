return {
  {
    "NvChad/nvim-colorizer.lua",
    -- event = "VeryLazy",
    lazy = false,
    priority = 9999,

    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    enabled = false,
    init = function()
      local done = false
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.name == "tailwindcss" and done == false then
            vim.cmd("ColorizerToggle")
            done = true
          end
        end,
      })
    end,
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true,
        sass = { enable = false },
        virtualtext = "■",
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },

  {
    "uga-rosa/ccc.nvim",
    enabled = true,
    cmd = { "CccPick", "CccConvert", "CccHighlighterEnable" },
    event = "FileType typescript,typescriptreact,javascript,javascriptreact,json,yaml",
    keys = {
      { "<leader>zc", "<cmd>CccConvert<cr>", desc = "Convert color" },
      { "<leader>zp", "<cmd>CccPick<cr>", desc = "Pick Color" },
    },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
    config = function(_, opts)
      require("ccc").setup(opts)
      if opts.highlighter and opts.highlighter.auto_enable then
        vim.cmd.CccHighlighterEnable()
        local target_count = 0
        local target_lsp_names = { "tsserver", "tailwindcss" }
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if vim.tbl_contains(target_lsp_names, client.name) then
              target_count = target_count + 1
            end
            if target_count == 2 then
              local refresh_steps = { "<cmd>startinsert<CR>", "<esc><CR>", "<cmd>bufdo e<CR>zz" }
              local refresh_code = vim.api.nvim_replace_termcodes(table.concat(refresh_steps, ""), true, false, true)
              vim.api.nvim_feedkeys(refresh_code, "t", true)
            end
          end,
        })
      end
    end,
  },
}
