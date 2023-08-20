return {
  "rareitems/printer.nvim",
  event = "VeryLazy",
  config = function()
    require("printer").setup({
      keymap = "gl", -- Plugin doesn't have any keymaps by default
      formatters = {
        typescriptreact = function(text_inside, text_var)
          return string.format('console.log("%s = ", %s)', text_inside, text_var)
        end,
        javascriptreact = function(text_inside, text_var)
          return string.format('console.log("%s = ", %s)', text_inside, text_var)
        end,
        vue = function(text_inside, text_var)
          return string.format('console.log("%s = ", %s)', text_inside, text_var)
        end,
      },
    })
  end,
}
