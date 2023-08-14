return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
      { "folke/which-key.nvim" },
      { "debugloop/telescope-undo.nvim" },
      { "nvim-lua/plenary.nvim" },
      {
        "tomasky/bookmarks.nvim",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")

      wk.register({
        ["<leader>t"] = {
          name = "telescope",
          a = {
            function()
              require("telescope.builtin").find_files({
                no_ignore = true,
                hidden = true,
                prompt_title = "All Files",
              })
            end,
            "All files",
          },
          f = { "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>", "find files" },
          b = { "<cmd>Telescope buffers<cr>", "buffers" },
          h = { "<cmd>Telescope help_tags<cr>", "help tags" },
          m = { "<cmd>Telescope marks<cr>", "marks" },
          r = { "<cmd>Telescope registers<cr>", "registers" },
          t = { "<cmd>Telescope treesitter<cr>", "treesitter" },
          w = { "<cmd>Telescope grep_string<cr>", "grep string" },
          o = { "<cmd>Telescope oldfiles<cr>", "oldfiles" },
          g = {
            name = "git",
            b = { "<cmd>Telescope git_branches<cr>", "branches" },
            c = { "<cmd>Telescope git_commits<cr>", "commits" },
            s = { "<cmd>Telescope git_status<cr>", "status" },
            h = { "<cmd>Telescope git_stash<cr>", "stash" },
            p = { "<cmd>Telescope git_files<cr>", "git files" },
          },
        },

        ["<c-f>"] = {
          "<cmd>Telescope live_grep find_command=rg,--ignore,--hidden,-F<cr>",
          "live grep",
        },
      })

      wk.register({
        -- -F fixed string
        ["<d-p>"] = {
          "<cmd>Telescope smart_open<cr>",
          "find file",
        },

        ["<c-p>"] = {
          "<cmd>Telescope fd find_command=rg,--ignore,--hidden,--files,-F<cr>",
          "find file",
        },

        ["<d-,>"] = {
          "<cmd>Telescope live_grep find_command=rg,--ignore,--hidden,--files,-F<cr>",
          "live grep",
        },
      }, {
        mode = { "n", "i" },
      })

      local actions = require("telescope.actions")
      require("telescope").setup({

        extensions = {
          smart_open = {
            show_scores = false,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
            match_algorithm = "fzf",
            disable_devicons = false,
            cwd_only = true,
          },
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          file_browser = {
            -- theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
          undo = {
            use_delta = true,
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
        },

        defaults = {
          -- dont ignore will cause lsp to not work
          -- file_ignore_patterns = {
          -- ".git",
          -- ".cache",
          -- "%.o",
          -- "%.a",
          -- "%.out",
          -- "%.class",
          -- "%.pdf",
          -- "%.mkv",
          -- "%.mp4",
          -- "%.zip",
          -- },

          -- file_sorter = require("util.sorter").frecency_sorter,
          git_worktrees = vim.g.git_worktrees,
          dynamic_preview_title = true,
          path_display = {
            shorten = {
              len = 3,
              exclude = { 1, -1 },
            },

            truncate = true,
          },
          -- path_display = function(opts, path)
          --   local tail = require("telescope.utils").path_tail(path)
          --   return string.format("%s\n%s", tail, path)
          -- end,
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<esc>"] = actions.close,
            },
            n = { q = actions.close },
          },
        },
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("undo")
      require("telescope").load_extension("bookmarks")
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
      -- { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      require("telescope-all-recent").setup({})
    end,
  },
}
