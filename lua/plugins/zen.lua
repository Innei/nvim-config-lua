return {
  {
    "koenverburg/peepsight.nvim",
    cmd = { "PeepsightEnable", "PeepsightDisable" },
    keys = { {
      "<leader>Zp",
      "<cmd>PeepsightEnable<cr>",
      desc = "PeepsightEnable",
    } },
    config = function()
      require("peepsight").setup({
        -- Lua
        "local_function_definition_statement",
        "function_definition_statement",

        -- TypeScript
        "class_declaration",
        "method_definition",
        "arrow_function",
        "function_declaration",
        "generator_function_declaration",
      })
      require("peepsight").enable()
    end,
  },
}
