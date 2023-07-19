return {
  {
    "AndrewRadev/switch.vim",
    keys = {
      {
        "<leader>sx",
        function()
          vim.cmd("Switch")
        end,
        desc = "Switch",
      },
    },

    config = function()
      vim.g.switch_mapping = ""
    end,
  },
}
