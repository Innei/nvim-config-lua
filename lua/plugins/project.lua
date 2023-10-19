return {
  -- {
  --   "airblade/vim-rooter",
  --   init = function()
  --     vim.g.rooter_patterns = { "__vim_project_root", ".git/" }
  --     vim.g.rooter_silent_chdir = true
  --     -- set an autocmd
  --     vim.api.nvim_create_autocmd("VimEnter", {
  --       pattern = "*",
  --       callback = function()
  --         -- source .nvim.lua at project root
  --         vim.cmd([[silent! source .vim.lua]])
  --       end,
  --     })
  --   end,
  -- },
  { import = "lazyvim.plugins.extras.util.project" },
  -- {
  --   "coffebar/neovim-project",
  --   opts = {
  --     projects = {
  --       "~/git/*",
  --       "~/.config/nvim",
  --     },
  --   },
  --   init = function()
  --     -- enable saving the state of plugins in the session
  --     vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  --   end,
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim" },
  --     { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
  --     { "Shatur/neovim-session-manager" },
  --   },
  --   lazy = false,
  --   priority = 100,
  -- },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    -- enabled = false,
    opts = {
      -- Manual mode doesn't automatically change your root directory, so you have
      -- the option to manually do so using `:ProjectRoot` command.
      manual_mode = true,

      -- Methods of detecting the root directory. **"lsp"** uses the native neovim
      -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
      -- order matters: if one is not detected, the other is used as fallback. You
      -- can also delete or rearangne the detection methods.
      detection_methods = { "!>packages", "lsp", "pattern" },

      -- All the patterns used to detect root dir, when **"pattern"** is in
      -- detection_methods
      patterns = { ".git", "Makefile", "pnpm-workspace.yaml", "yarn.lock", "pnpm-lock.yaml" },

      -- Table of lsp clients to ignore by name
      -- eg: { "efm", ... }
      ignore_lsp = {
        "prismals",
      },

      -- Don't calculate root dir on specific directories
      -- Ex: { "~/.cargo/*", ... }
      exclude_dirs = {},

      -- Show hidden files in telescope
      show_hidden = true,

      -- When set to false, you will get a message when project.nvim changes your
      -- directory.
      silent_chdir = false,

      -- What scope to change the directory, valid options are
      -- * global (default)
      -- * tab
      -- * win
      scope_chdir = "global",

      -- Path where project.nvim will store the project history for use in
      -- telescope
      datapath = vim.fn.stdpath("data"),
    },
  },

  {
    "imNel/monorepo.nvim",
    enabled = false,
    config = function()
      require("monorepo").setup({
        -- Your config here!
      })

      require("telescope").load_extension("monorepo")
    end,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
