return {

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    commit = "2107f7037c775bf0b9bff9015eed68929fcf493e",
    config = function()
      local home = vim.fn.expand("$HOME")
      require("chatgpt").setup({
        api_key_cmd = "cat " .. home .. "/openai.key",
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
