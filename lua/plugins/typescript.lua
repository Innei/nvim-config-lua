if true then
  return {}
end
return {
  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup({
        server = {
          on_attach = function(client, bufnr)
            -- your other on_attach stuff here if you have any
            -- ...
            vim.lsp.buf.inlay_hint(bufnr, true)
          end,
          settings = {
            -- specify some or all of the following settings if you want to adjust the default behavior
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          },
        },
      })
    end,
  },
}
