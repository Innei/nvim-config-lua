return {

  {
    "FeiyouG/command_center.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<D-S-p>",
        function()
          vim.cmd([[Telescope commander]])
        end,
        desc = "Command Center",
      },
    },

    lazy = true,
    config = function()
      local command_center = require("commander")
      command_center.add({
        {
          desc = "Copy current file path (absolute)",
          cmd = function()
            local file_path = vim.api.nvim_buf_get_name(0)
            vim.fn.system("echo -n" .. file_path .. " | pbcopy")
          end,
        },
        {
          desc = "Copy current file path & line (relative to cwd)",
          cmd = function()
            local file_path = vim.api.nvim_buf_get_name(0)
            local relative_path = vim.fn.fnamemodify(file_path, ":~:." .. vim.fn.getcwd() .. ":.")
            local current_line = vim.api.nvim_win_get_cursor(0)[1]
            local file_path_and_line = relative_path .. "#" .. current_line
            vim.fn.system("echo -n " .. file_path_and_line .. " | pbcopy")
          end,
        },
        {
          desc = "Restart LSP server",
          cmd = function()
            vim.cmd([[LspStop]])
            vim.cmd([[LspStart]])
          end,
        },
        {
          desc = "Reload Buffer",
          cmd = "<CMD>bufdo e<CR>zz",
        },
        {
          desc = "Reload Window",
          cmd = "<CMD>windo e<CR>zz",
        },
        {
          desc = "Advanced git search",
          cmd = "<CMD>AdvancedGitSearch<CR>",
        },
        {
          desc = "Neogit",
          cmd = "<CMD>Neogit<CR>",
        },
        {
          desc = "Refresh TSHighlight",
          cmd = function()
            vim.cmd([[TSDisable highlight]])
            vim.cmd([[TSEnable highlight]])
          end,
        },
        {
          desc = "Open the specified file (relative to cwd)",
          cmd = function()
            require("plugin.open-file").open_file()
          end,
        },
        -- {
        --   desc = "Reload plugins host",
        --   cmd = function()
        --     local plugins = require("lazy").plugins()
        --
        --     for _, plugin in ipairs(plugins) do
        --       vim.cmd("Lazy reload " .. plugin.name)
        --     end
        --   end,
        -- },
      })

      command_center.setup({
        components = {
          "DESC",
          "KEYS",
          "CAT",
        },
        sort_by = {
          "DESC",
          "KEYS",
          "CAT",
          "CMD",
        },
        -- Change the separator used to separate each component
        separator = " ",

        -- When set to true,
        -- The desc component will be populated with cmd if desc is empty or missing.
        auto_replace_desc_with_cmd = true,

        -- Default title of the prompt
        prompt_title = "Commander",
        integration = {
          telescope = {
            enable = true,
          },
          lazy = {
            enable = true,
          },
        },
      })
      -- telescope.setup({
      --   extensions = {
      --     command_center = {
      --       components = {
      --         command_center.component.DESC,
      --         command_center.component.KEYS,
      --       },
      --       auto_replace_desc_with_cmd = false,
      --     },
      --   },
      -- })

      -- telescope.load_extension("command_center")
    end,
  },
}
