return {
  {
    "vuki656/package-info.nvim",
    event = "BufRead package.json",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("package-info").setup({
        package_manager = "pnpm",
      })

      require("telescope").setup({
        extensions = {
          package_info = {
            -- Optional theme (the extension doesn't set a default theme)
            theme = "ivy",
          },
        },
      })

      require("telescope").load_extension("package_info")

      -- Update dependency on the line
      vim.keymap.set(
        { "n" },
        "<LEADER>nu",
        require("package-info").update,
        { silent = true, noremap = true, desc = "Update dependency on the line" }
      )

      -- Delete dependency on the line
      vim.keymap.set(
        { "n" },
        "<LEADER>nd",
        require("package-info").delete,
        { silent = true, noremap = true, desc = "Delete dependency on the line" }
      )

      -- Install a new dependency
      vim.keymap.set(
        { "n" },
        "<LEADER>ni",
        require("package-info").install,
        { silent = true, noremap = true, desc = "Install a new dependency" }
      )

      -- Install a different dependency version
      vim.keymap.set(
        { "n" },
        "<LEADER>np",
        require("package-info").change_version,
        { silent = true, noremap = true, desc = "Install a different dependency version" }
      )
    end,
  },
}
