return {
  {
    "rainbowhxch/accelerated-jk.nvim",
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
    end,
    vscode = true,
  },
  -- {
  --   "tpope/vim-sleuth",
  --   event = "InsertEnter",
  -- },

  -- save if not folder exists
  {
    "jghauser/mkdir.nvim",
    event = "VeryLazy",
  },
  -- open in current nvim if open file in float terminal
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },

  {
    "https://git.sr.ht/~reggie/licenses.nvim",
    cmd = {
      "LicenseInsert",
      "LicenseFetch",
      "LicenseUpdate",
      "LicenseWrite",
    },
    config = function()
      require("licenses").setup({
        copyright_holder = "Innei",
        email = "i@innei.in",
        license = "MIT",
      })
    end,
  },
}
