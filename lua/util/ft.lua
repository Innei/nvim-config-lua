local M = {}

M.exclude_ft_table = {
  ["neo-tree"] = true,
  ["neo-tree-popup"] = true,
  lazyterm = true,
  aerial = true,
  dashboard = true,
  help = true,
  lspinfo = true,
  lspsagafinder = true,
  packer = true,
  checkhealth = true,
  man = true,
  mason = true,
  NvimTree = true,
  plugin = true,
  lazy = true,
  TelescopePrompt = true,
  terminal = true,
  nofile = true,
  [""] = true, -- because TelescopePrompt will set a empty ft, so add this.
  alpha = true,
  toggleterm = true,

  noice = true,
  text = true,
  dropbar_menu = true,

  DressingInput = true,
  NeogitStatus = true,
  ssr = true,

  NeogitCommitMessage = true,
}

local exclude_ft_list = {}
for ft, _ in pairs(M.exclude_ft_table) do
  table.insert(exclude_ft_list, ft)
end

M.exclude_ft = exclude_ft_list

return M
