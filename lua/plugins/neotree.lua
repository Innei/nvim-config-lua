return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      { "tt", ":Neotree focus<CR>", desc = "Explorer NeoTree focus (cwd)", remap = true },
      { "<C-b>", ":Neotree toggle<CR>", desc = "Explorer NeoTree toggle (cwd)", remap = true },
    },
    --
    -- opts = {
    --   sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    --   open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    --   -- filesystem = {
    --   --   bind_to_cwd = false,
    --   --   follow_current_file = {
    --   --     enabled = true,
    --   --   },
    --   --   use_libuv_file_watcher = true,
    --   -- },
    --   window = {
    --     mappings = {
    --       ["<space>"] = "none",
    --       ["<leftrelease>"] = "open",
    --     },
    --   },
    --   default_component_configs = {
    --     indent = {
    --       with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
    --       expander_collapsed = "",
    --       expander_expanded = "",
    --       expander_highlight = "NeoTreeExpander",
    --     },
    --     icon = {
    --       folder_empty = "󰜌",
    --       folder_empty_open = "󰜌",
    --     },
    --     git_status = {
    --       symbols = {
    --         renamed = "󰁕",
    --         unstaged = "󰄱",
    --       },
    --     },
    --   },
    -- },
  },
}
