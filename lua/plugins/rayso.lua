return {
  "TobinPalmer/rayso.nvim",
  cmd = "Rayso",
  config = function()
    require("rayso").setup({
      open_cmd = "Arc",
    })
  end,
}
