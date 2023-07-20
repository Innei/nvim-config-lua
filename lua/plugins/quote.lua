return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    enabled = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        replace = "cs",

        -- add = "gsa",
        -- delete = "gsd",
        -- find = "gsf",
        -- find_left = "gsF",
        -- highlight = "gsh",
        -- update_n_lines = "gsn",
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.cmd([[
let g:VM_maps                       = {} 
let g:VM_maps['Find Under']         = '<C-d>' 
let g:VM_maps['Find Subword Under'] = '<C-d>' 
let g:VM_maps['Find Next']          = '' 
let g:VM_maps['Find Prev']          = '' 
let g:VM_maps['Remove Region']      = '<backspace>' 
let g:VM_maps['Skip Region']        = '<leader>' 
let g:VM_maps["Undo"]               = 'u' 
let g:VM_maps["Redo"]               = 'r' 
noremap <leader>sa <Plug>(VM-Select-All)
]])
    end,
  },
}
