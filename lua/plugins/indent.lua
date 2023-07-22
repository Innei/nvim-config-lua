return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    init = function()
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL" })
      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          style = {
            { fg = "#F596AA" },
          },
        },
        indent = {
          chars = { "│" },
          use_treesitter = false,
          aerial = true,
          dashboard = true,
          help = true,
          lspinfo = true,
          lspsagafinder = true,
          packer = true,
          checkhealth = true,
          man = true,
          mason = true,
          NvimTree = true,
          ["neo-tree"] = true,
          ["neo-tree-popup"] = true,
          plugin = true,
          lazy = true,
          TelescopePrompt = true,
          [""] = true, -- because TelescopePrompt will set a empty ft, so add this.
          alpha = true,
          toggleterm = true,
        },
        blank = {
          enable = false,
        },
        line_num = {
          use_treesitter = true,
          style = "#F596AA",
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  {
    "echasnovski/mini.indentscope",
    enabled = false,
  },
}
