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
          use_treesitter = true,
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
