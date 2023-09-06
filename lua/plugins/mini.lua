return {
  {
    "echasnovski/mini.bracketed",
    version = "*",
    event = "BufReadPost",
    config = function()
      require("mini.bracketed").setup()
    end,
  },
}
