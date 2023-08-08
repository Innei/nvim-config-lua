return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    init = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
