local mode_all = { "n", "v", "i" }
local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local mode_ni = { "n", "i" }

local nmappings = {
  -- page scroll
  -- {
  --
  --   from = "<c-i>",
  --   to = "<c-d>",
  --   mode = mode_nv,
  -- },
  -- { from = "Q", to = ":bd<CR>" },
  {
    from = ";",
    to = ":",
    mode = mode_nv,
  },
  { from = "y", to = '"+y' },
  { from = "y", to = '"+ygv<esc>', mode = mode_v },
  {
    from = "`",
    to = "~",
    mode = mode_nv,
  },

  {
    from = "<C-i>",
    to = "<C-d>",
    mode = mode_nv,
  },
  {
    from = "-",
    to = "<C-x>",
  },
  {
    from = "=",
    to = "<C-a>",
  },
  {
    from = "<C-;>",
    to = "<Right>",
    mode = mode_i,
  },
  -- { from = "jj",
  --   to = "<ESC>",
  --   mode = mode_i,
  -- },
  -- {
  --   from = "jk",
  --   to = "<ESC>",
  --   mode = mode_i,
  -- },
  {
    from = "X",
    to = "r",
  },
  {
    from = "r",
    to = "<c-r>",
  },
  --

  {
    from = "cw",
    to = '"_ciw',
  },
  {
    from = "!",
    to = "%",
    mode = mode_nv,
  },
  {
    from = "0",
    to = "^",
  },
  {
    from = ")",
    to = "g_",
  },
  {
    from = "p",
    to = "P",
    mode = mode_v,
  },
  {
    from = "x",
    to = '"_x',
  },
  {
    from = "x",
    to = '"_x',
    mode = mode_v,
  },
  {
    from = "c",
    to = '"_c',
  },
  {
    from = "c",
    to = '"_c',
    mode = mode_v,
  },

  -- undo
  {
    from = "<C-z>",
    to = "<ESC>ua",
    mode = mode_i,
  },
  {
    from = " ",
    to = " <C-g>u",
    mode = mode_i,
  },
  {
    from = "(",
    to = "(<c-g>u",
    mode = mode_i,
  },
  {
    from = ")",
    to = ")<C-g>u",
    mode = mode_i,
  },
  {
    from = "<",
    to = "<<C-g>u",
    mode = mode_i,
  },
  {
    from = ">",
    to = "><C-g>u",
    mode = mode_i,
  },
  {
    from = "/",
    to = "/<C-g>u",
    mode = mode_i,
  },
  {
    from = "=",
    to = "=<C-g>u",
    mode = mode_i,
  },
  --
  -- { from = "<leader>rc", to = ":e ~/.config/nvim/init.lua<CR>" },

  -- map , .
  {
    from = ",",
    to = "<c-o>",
  },
  {
    from = ".",
    to = "<c-i>",
  },
  {
    from = ",",
    to = "^",
    mode = mode_v,
  },
  {
    from = ".",
    to = "g_",
    mode = mode_v,
  },
  {
    from = "'",
    to = ".",
    mode = mode_nv,
  },
  {
    from = "J",
    to = "<nop>",
  },

  {
    from = "<leader>tc",
    to = function()
      vim.cmd([[tabclose]])
    end,
    desc = "Tab close",
  },

  -- vscode like mapping
  {
    from = "<S-up>",
    to = "Vk",
  },
  {
    from = "<S-down>",
    to = "Vj",
  },
  {
    from = "<S-Left>",
    to = "vh",
  },
  {
    from = "<S-Right>",
    to = "vl",
  },
  {
    from = "<S-up>",
    to = "k",
    mode = mode_v,
  },
  {
    from = "<S-down>",
    to = "j",
    mode = mode_v,
  },
  {
    from = "<S-left>",
    to = "h",
  },
  {
    from = "<S-right>",
    to = "l",
  },
  -- cursor move panel
  {
    from = "<leader><up>",
    to = "<C-w>k",
  },
  {
    from = "<leader><down>",
    to = "<C-w>j",
  },
  {
    from = "<leader><left>",
    to = "<C-w>h",
  },
  {
    from = "<leader><right>",
    to = "<C-w>l",
  },
}

-- vscode like mapping based on kitty keymap mapping
if vim.g.vscode == nil then
  nmappings = vim.list_extend(nmappings, {
    {
      from = "<D-x>",
      to = '"+di',
      mode = mode_v,
    },
    {
      from = "<D-d>",
      to = "viw",
    },
    {
      from = "<D-x>",
      to = '"+dd',
    },
    {

      from = "<D-s>",
      to = function()
        vim.cmd([[w]])
        vim.cmd([[stopinsert]])
      end,
      mode = mode_ni,
    },
    {
      from = "<D-n>",
      to = function()
        vim.cmd([[new]])
      end,
      mode = mode_ni,
    },
    {
      from = "<D-c>",
      to = '"+ygv<esc>',
      mode = mode_v,
    },
    {
      from = "<D-z>",
      to = function()
        vim.cmd([[undo]])
      end,
      mode = mode_ni,
    },

    {
      from = "<D-S-z>",
      to = function()
        vim.cmd([[redo]])
      end,
      mode = mode_ni,
    },
    {
      from = "<M-backspace>",
      to = "<C-w>",
      mode = mode_i,
    },
    { from = "<D-a>", to = "<ESC>gg<s-v>G", mode = mode_ni },
    {
      from = "<M-left>",
      to = "<ESC>bi",
      mode = mode_ni,
    },
    {
      from = "<M-right>",
      to = "<ESC>ea",
      mode = mode_ni,
    },
    {
      from = "<M-up>",
      to = "<ESC>:m .-2<CR>==gi",
      mode = mode_ni,
    },
    {
      from = "<M-down>",
      to = "<ESC>:m .+1<CR>==gi",
      mode = mode_ni,
    },

    {
      from = "<D-.>",
      to = vim.lsp.buf.code_action,
      mode = mode_nv,
    },
    -- {
    --   from = "<D-f>",
    --   to = function()
    --     require("spectre").open_file_search({ select_word = false })
    --   end,
    -- },
    {
      from = "<D-f>",
      to = "<nop>",
      mode = mode_i,
    },
    {
      from = "<D-.>",
      to = function()
        vim.cmd("stopinsert")
        vim.lsp.buf.code_action({
          context = {
            only = {
              "source",
            },
            diagnostics = {},
          },
        })
      end,
      mode = mode_i,
    },
    -- {
    --   from = "<D-,>",
    --   to = function()
    --     require("telescope.builtin").live_grep()
    --   end,
    --   mode = mode_ni,
    -- },

    {
      from = "<D-/>",
      to = function()
        local ok, api = pcall(require, "Comment.api")
        if not ok then
          return
        end

        local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.linewise(vim.fn.visualmode())
      end,
      mode = mode_v,
    },

    {
      from = "<D-/>",
      to = function()
        local ok, api = pcall(require, "Comment.api")
        if not ok then
          return
        end
        api.toggle.linewise.current()
      end,
      mode = mode_ni,
    },
    {
      from = "<F5>",
      to = function()
        -- format code
        vim.lsp.buf.format()
      end,
      mode = mode_ni,
    },

    {
      from = "<S-D-f>",
      to = function()
        -- format code
        vim.lsp.buf.format()
      end,
      mode = mode_ni,
    },
    {
      from = "<M-D-s>",
      to = function()
        vim.cmd([[wa]])
      end,
      mode = mode_ni,
    },
    {
      from = "<D-backspace>",
      to = "<esc>cc",
      mode = mode_i,
    },
  })
end

if vim.g.neovide then
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

  -- Allow clipboard copy paste in neovim
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  nmappings = vim.list_extend(nmappings, {
    {
      -- @see https://github.com/neovide/neovide/issues/1237
      from = "<D-f>",
      to = function()
        -- format code
        vim.lsp.buf.format()
      end,
      mode = mode_ni,
    },
  })
end

for _, mapping in ipairs(nmappings) do
  vim.keymap.set(
    mapping.mode or "n",
    mapping.from,
    mapping.to,
    { noremap = mapping.noremap or true, silent = true, desc = mapping.desc }
  )
end

-- delete lazynvim built-in keymaps
vim.keymap.del({ "n", "x" }, "j")
vim.keymap.del({ "n", "x" }, "k")

vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
