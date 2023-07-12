return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({

        "*",
      }, {
        names = false,
        rgb_fn = true,
        hsl_fn = true,
      })
    end,
  },
}
