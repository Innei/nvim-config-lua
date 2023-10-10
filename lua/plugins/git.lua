return {
  {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      -- optional: setup telescope before loading the extension
      require("telescope").setup({
        -- move this to the place where you call the telescope setup function
        extensions = {
          advanced_git_search = {
            -- fugitive or diffview
            diff_plugin = "diffview",
            -- customize git in previewer
            -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
            git_flags = {},
            -- customize git diff in previewer
            -- e.g. flags such as { "--raw" }
            git_diff_flags = {},
            -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
            show_builtin_git_pickers = false,
            entry_default_author_or_date = "author", -- one of "author" or "date"

            -- Telescope layout setup
            -- telescope_theme = {
            --   function_name_1 = {
            --     -- Theme options
            --   },
            --   function_name_2 = "dropdown"
            --   -- e.g. realistic example
            --   show_custom_functions = {
            --     layout_config = { width = 0.4, height = 0.4 },
            --   },
            -- }
          },
        },
      })

      require("telescope").load_extension("advanced_git_search")
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    cmd = { "Neogit" },
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opt)
      opt.current_line_blame = true
      opt.current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 200,
        ignore_whitespace = false,
        relative_time = true,
      }
      opt.current_line_blame_formatter_opts = {
        relative_time = true,
      }

      -- opt.current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>"
      opt.sign_priority = 0
    end,
  },
}
