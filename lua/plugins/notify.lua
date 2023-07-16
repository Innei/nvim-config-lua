return {
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "NotifyBackground",
        fps = 60,
        render = "compact",
        stages = "fade_in_slide_out",
        timeout = 5000,
      })
    end,
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require("lazyvim.util")
      if not Util.has("noice.nvim") then
        Util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
  },
}
