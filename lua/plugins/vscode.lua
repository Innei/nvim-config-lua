return {
  {
    "elijahmanor/export-to-vscode.nvim",
    event = "BufReadPost",
    config = function()
      vim.api.nvim_create_user_command("Code", function()
        require("export-to-vscode").launch()
      end, {
        bang = true,
      })
    end,
  },
}
