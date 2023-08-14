return {
  -- vscode like tab navigation
  {

    "ghillb/cybu.nvim",
    branch = "main", -- timely updates
    -- branch = "v1.x", -- won't receive breaking changes
    requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
    config = function()
      local cybu = require("cybu")
      cybu.setup()
      -- vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
      -- vim.keymap.set("n", "J", "<Plug>(CybuNext)")
      vim.keymap.set({ "n", "v" }, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
      vim.keymap.set({ "n", "v" }, "<c-tab>", "<plug>(CybuLastusedNext)")
    end,
  },

  -- e path:row:col
  {
    "wsdjeg/vim-fetch",
    event = "VeryLazy",
  },
}
