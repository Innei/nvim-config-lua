vim.cmd([[
let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript','tsx','jsx','typescriptreact','javascriptreact']
]])

return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
