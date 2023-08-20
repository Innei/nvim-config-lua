return {
  {
    "echasnovski/mini.surround",
    enabled = false,
    opts = {
      mappings = {
        replace = "cs",

        -- add = "gsa",
        -- delete = "gsd",
        -- find = "gsf",
        -- find_left = "gsF",
        -- highlight = "gsh",
        -- update_n_lines = "gsn",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    vscode = true,
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      })
    end,
  },
}
