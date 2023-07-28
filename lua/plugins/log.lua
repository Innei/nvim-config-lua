return {
  "rareitems/printer.nvim",
  event = "InsertEnter",
  config = function()
    require("printer").setup({
      keymap = "gl", -- Plugin doesn't have any keymaps by default
    })
  end,
}
