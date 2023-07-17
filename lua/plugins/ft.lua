return {
  {
    "nathom/filetype.nvim",
    enabled = false,
    config = function(_, opt)
      require("filetype").setup({
        overrides = {
          extensions = {
            env = "sh",
            mts = "typescript",
            mjs = "javascript",
          },
          complex = {
            -- Set the filetype of any full filename matching the regex to gitconfig
            [".*git/config"] = "gitconfig", -- Included in the plugin
          },
        },
      })
    end,
  },
}
