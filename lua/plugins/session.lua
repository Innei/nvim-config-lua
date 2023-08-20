return {
  {
    "rmagatti/auto-session",
    enabled = false,
    config = function()
      -- local function close_neo_tree()
      --   require("neo-tree.sources.manager").close_all()
      -- end
      --
      -- local function open_neo_tree()
      --   vim.cmd([[<esc>:Neotree reveal<cr>]])
      -- end

      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
        -- bypass_session_save_file_types = {
        --   "neo-tree",
        --   "tsplayground",
        --   "query",
        -- },
        -- pre_save_cmds = {
        --   close_neo_tree,
        -- },
        -- post_restore_cmds = {
        --   open_neo_tree,
        -- },
      })
    end,
  },
  -- {
  --   "folke/persistence.nvim",
  --   event = "BufReadPre",
  --   opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
  --   config = function()
  --     require("persistence").setup({
  --       options = {
  --         "globals",
  --       },
  --       pre_save = function()
  --         vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
  --       end,
  --     })
  --   end,
  --   keys = {
  --     {
  --       "<leader>qs",
  --       function()
  --         require("persistence").load()
  --       end,
  --       desc = "Restore Session",
  --     },
  --     {
  --       "<leader>ql",
  --       function()
  --         require("persistence").load({ last = true })
  --       end,
  --       desc = "Restore Last Session",
  --     },
  --     {
  --       "<leader>qd",
  --       function()
  --         require("persistence").stop()
  --       end,
  --       desc = "Don't Save Current Session",
  --     },
  --   },
  -- },
}
