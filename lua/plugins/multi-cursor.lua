return {
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.cmd([[
  let g:VM_maps                       = {}
  let g:VM_maps['Find Under']         = '<C-d>'
  let g:VM_maps['Find Subword Under'] = '<C-d>'
  let g:VM_maps['Find Next']          = 'n'
  let g:VM_maps['Find Prev']          = 'p'
  let g:VM_maps['Remove Region']      = '<backspace>'
  let g:VM_maps['Skip Region']        = 'q'
  let g:VM_maps["Undo"]               = 'u'
  let g:VM_maps["Redo"]               = 'r'
  ]])
    end,
  },

  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "smoka7/hydra.nvim",
    },
    opts = function()
      local N = require("multicursors.normal_mode")
      local I = require("multicursors.insert_mode")
      return {
        normal_keys = {
          -- to change default lhs of key mapping change the key
          [","] = {
            -- assigning nil to method exits from multi cursor mode
            method = N.clear_others,
            -- you can pass :map-arguments here
            opts = { desc = "Clear others" },
          },
        },
        insert_keys = {
          -- to change default lhs of key mapping change the key
          ["<CR>"] = {
            -- assigning nil to method exits from multi cursor mode
            method = I.Cr_method,
            -- you can pass :map-arguments here
            opts = { desc = "New line" },
          },
        },
      }
    end,
    keys = {
      {
        "<C-d>",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for word under the cursor",
      },
    },
  },
}
