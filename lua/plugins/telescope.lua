return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        enabled = vim.fn.executable("make") == 1,
        build = "make",
      },
      { "nvim-lua/plenary.nvim" },
    },
    config = function(_, opts)
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Telescope key mappings for files and system tools
      map("n", "<leader>ta", function()
        require("telescope.builtin").find_files({
          no_ignore = true,
          hidden = true,
          prompt_title = "All Files",
        })
      end, vim.tbl_extend("force", opts, { desc = "All files" }))

      local telescope_cmds = {
        -- ["<leader>tf"] = "Telescope find_files find_command=rg,--ignore,--hidden,--files",
        ["<leader>tb"] = "Telescope buffers",
        ["<leader>th"] = "Telescope help_tags",
        ["<leader>tm"] = "Telescope marks",
        ["<leader>tr"] = "Telescope registers",
        ["<leader>tt"] = "Telescope treesitter",
        ["<leader>tg"] = "Telescope git_status",
        ["<leader>tgp"] = "Telescope git_files",
        ["<leader>tgc"] = "Telescope git_commits",
        ["<leader>tgb"] = "Telescope git_branches",
        ["<leader>tgs"] = "Telescope git_status",
        ["<leader>tgh"] = "Telescope git_stash",
      }

      for k, cmd in pairs(telescope_cmds) do
        map("n", k, "<cmd>" .. cmd .. "<cr>", vim.tbl_extend("force", opts, { desc = cmd }))
      end

      -- Telescope key mappings for general searching
      local modes = { "n", "l" }
      local search_cmds = {
        ["<d-p>"] = "lua require('telescope').extensions.smart_open.smart_open({ cwd_only = true })",
        ["<c-p>"] = "Telescope fd find_command=rg,--ignore,--hidden,--files,-F",
        ["<d-,>"] = "Telescope live_grep find_command=rg,--ignore,--hidden,--files,-F",
      }

      for k, cmd in pairs(search_cmds) do
        for _, mode in ipairs(modes) do
          map(mode, k, "<cmd>" .. cmd .. "<cr>", vim.tbl_extend("force", opts, { desc = cmd }))
        end
      end

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
            shorten = { len = 3, exclude = { 1, -1 } },

            truncate = true,
          },
          -- path_display = function(opts, path)
          --   local tail = require("telescope.utils").path_tail(path)
          --   return string.format("%s\n%s", tail, path)
          -- end,
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
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
    end,
  },
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
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      require("telescope-all-recent").setup({
        database = {
          folder = vim.fn.stdpath("data"),
          file = "telescope-all-recent.sqlite3",
          max_timestamps = 10,
        },
        debug = false,
        scoring = {
          recency_modifier = { -- also see telescope-frecency for these settings
            [1] = { age = 240, value = 100 }, -- past 4 hours
            [2] = { age = 1440, value = 80 }, -- past day
            [3] = { age = 4320, value = 60 }, -- past 3 days
            [4] = { age = 10080, value = 40 }, -- past week
            [5] = { age = 43200, value = 20 }, -- past month
            [6] = { age = 129600, value = 10 }, -- past 90 days
          },
          -- how much the score of a recent item will be improved.
          boost_factor = 0.0001,
        },
        default = {
          disable = true, -- disable any unkown pickers (recommended)
          use_cwd = true, -- differentiate scoring for each picker based on cwd
          sorting = "recent", -- sorting: options: 'recent' and 'frecency'
        },
        pickers = { -- allows you to overwrite the default settings for each picker
          man_pages = { -- enable man_pages picker. Disable cwd and use frecency sorting.
            disable = false,
            use_cwd = false,
            sorting = "frecency",
          },
          ["commander#commander"] = {
            disable = false,
            use_cwd = false,
            sorting = "recent",
          },
        },
      })
    end,
  },
  {
    "eckon/treesitter-current-functions",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>tf", "<CMD>GetCurrentFunctions<CR>", desc = "Get current function" },
    },
  },

  {
    "piersolenski/telescope-import.nvim",
    requires = "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>ti", "<CMD>lua require('telescope').extensions.import.import()<CR>", desc = "Telescope Import" },
    },
    config = function()
      require("telescope").load_extension("import")
    end,
  },
}
