return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        enabled = vim.fn.executable("make") == 1,
        build = "make",
      }, -- { "folke/which-key.nvim" },
      { "debugloop/telescope-undo.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "tomasky/bookmarks.nvim" },
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
        ["<leader>tf"] = "Telescope find_files find_command=rg,--ignore,--hidden,--files",
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
        ["<d-p>"] = "Telescope smart_open",
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
          undo = {
            use_delta = true,
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = { preview_height = 0.8 },
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
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      require("telescope-all-recent").setup({})
    end,
  },
}
