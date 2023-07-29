return {
  {
    "Eandrju/cellular-automaton.nvim",
    keys = "<leader>rr",
    config = function()
      vim.keymap.set("n", "<leader>rr", "<cmd>CellularAutomaton make_it_rain<CR>")
    end,
  },
  {
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>dd",
        function()
          require("duck").hatch()
        end,
        desc = "Duck",
      },
      {
        "<leader>dk",
        function()
          require("duck").cook()
        end,
        desc = "Duck",
      },
    },
  },
  {
    "tamton-aquib/zone.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("zone").setup()
    end,
  },
}
