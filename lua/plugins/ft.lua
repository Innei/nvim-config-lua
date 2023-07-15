return {
  {
    "nathom/filetype.nvim",
    config = function(_, opt)
      require("filetype").setup({
        overrides = {
          extensions = {
            -- Set the filetype of *.pn files to potion
            pn = "potion",
            env = "sh",
            mts = "typescript",
            mjs = "javascript",
          },
          complex = {
            -- Set the filetype of any full filename matching the regex to gitconfig
            [".*git/config"] = "gitconfig", -- Included in the plugin
          },

          function_literal = {
            Brewfile = function()
              vim.cmd("syntax off")
            end,
          },
          function_complex = {
            ["*.math_notes/%w+"] = function()
              vim.cmd("iabbrev $ $$")
            end,
          },

          shebang = {
            -- Set the filetype of files with a dash shebang to sh
            dash = "sh",
          },
        },
      })
    end,
  },
}
