return {
  "FeiyouG/command_center.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    {
      "<D-S-p>",
      function()
        vim.cmd([[Telescope command_center]])
      end,
      desc = "Command Center",
    },
  },

  lazy = true,
  config = function()
    local telescope = require("telescope")
    local command_center = require("command_center")

    local plugins = require("lazy").plugins()

    for _, plugin in ipairs(plugins) do
      if plugin.command_center then
        -- only add for enabled plugins
        -- copied from require('lazy.core.plugin').Spec:fix_disabled
        local enabled = not (plugin.enabled == false or (type(plugin.enabled) == "function" and not plugin.enabled()))

        if enabled then
          command_center.add(plugin.command_center)
        end
      end
    end

    command_center.add({
      {
        desc = "Advanced git search",
        cmd = "<CMD>AdvancedGitSearch<CR>",
      },
      {
        desc = "Neogit",
        cmd = "<CMD>Neogit<CR>",
      },
      {
        desc = "Restart lsp server",
        cmd = "<CMD>LspRestart<CR>",
      },
      {
        desc = "Refresh TSHighlight",
        cmd = function()
          vim.cmd([[TSDisable highlight]])
          vim.cmd([[TSEnable highlight]])
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
    }, { mode = command_center.mode.ADD })

    telescope.setup({
      extensions = {
        command_center = {
          components = {
            command_center.component.DESC,
            command_center.component.KEYS,
          },
          sort_by = {
            command_center.component.DESC,
            command_center.component.KEYS,
          },
          auto_replace_desc_with_cmd = false,
        },
      },
    })

    telescope.load_extension("command_center")
  end,
}
