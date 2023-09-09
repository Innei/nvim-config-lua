return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
      {
        "R",
        function()
          vim.cmd([[Telescope file_browser path=%:p:h select_buffer=true]])
        end,
      },
      desc = "Telescope File Browser",
    },
    config = function()
      require("telescope").setup({
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
      })
    end,
  },
  {
    "theniceboy/joshuto.nvim",
    enabled = false,
    cmd = "Joshuto",
    config = function()
      vim.g.joshuto_floating_window_scaling_factor = 1.0
      vim.g.joshuto_use_neovim_remote = 1
      vim.g.joshuto_floating_window_winblend = 0
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    event = "VeryLazy",
    keys = {
      {
        [[\]],
        function()
          vim.cmd([[Neotree reveal]])
        end,
        desc = "Neotree reveal",
      },
    },
    opts = function(_, opts)
      vim.keymap.set({ "n", "i" }, "<D-b>", function()
        vim.cmd([[Neotree toggle]])
      end, { silent = true })
      opts.sync_root_with_cwd = false
      opts.respect_buf_cwd = true
      opts.update_focused_file = {
        enable = true,
        update_root = true,
      }

      opts.window = {
        width = 35,
      }

      opts.filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/directories
          hide_by_name = {
            --"node_modules"
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            ".gitignored",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            ".DS_Store",
            ".git",
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      }

      opts.commands = {
        reveal_in_finder = function(state) -- define a global "hello world" function
          local node = state.tree:get_node()
          if node then
            vim.fn.execute("!open -R " .. node.path)
          end
        end,
      }

      opts.filesystem.window = {}
      opts.filesystem.window.mappings = {
        ["<space>"] = {
          "toggle_preview",
          nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use,
          config = { use_float = true },
        },
        ["R"] = "reveal_in_finder",
        ["<2-LeftMouse>"] = "open",
        ["<leftrelease>"] = { "toggle_preview", config = { use_float = false } },
        ["<cr>"] = "open",
        ["<esc>"] = "cancel", -- close preview or floating neo-tree window
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["l"] = "focus_preview",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        -- ["S"] = "split_with_window_picker",
        -- ["s"] = "vsplit_with_window_picker",
        ["t"] = "open_tabnew",
        -- ["<cr>"] = "open_drop",
        -- ["t"] = "open_tab_drop",
        ["w"] = "open_with_window_picker",
        --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
        ["C"] = "close_node",
        -- ['C'] = 'close_all_subnodes',
        ["z"] = "close_all_nodes",
        --["Z"] = "expand_all_nodes",
        ["a"] = {
          "add",
          -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "none", -- "none", "relative", "absolute"
          },
        },
        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
        -- ["c"] = {
        --  "copy",
        --  config = {
        --    show_path = "none" -- "none", "relative", "absolute"
        --  }
        --}
        ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
        ["q"] = "close_window",
        -- ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
      }
      return opts
    end,
  },
}
