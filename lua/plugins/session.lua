return {
  "rmagatti/auto-session",
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
}
