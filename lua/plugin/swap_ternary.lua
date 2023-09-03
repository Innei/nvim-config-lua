local M = {}

--- @return TSNode | nil
local function _find_ternary_node(buf)
  local node_tree = vim.treesitter.get_parser(buf)
  if not node_tree then
    return vim.notify("无节点树", vim.log.levels.ERROR)
  end

  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local current_line = current_cursor[1] - 1
  local current_col = current_cursor[2] - 1

  local node = node_tree:named_node_for_range({ current_line, current_col, current_line, current_col })
  while node do
    if node:type() == "ternary_expression" then
      return node
    end
    node = node:parent()
  end
end

function M.replace()
  local current_buf = vim.api.nvim_get_current_buf()
  local supported_filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
  local can_replace = false

  for _, filetype in ipairs(supported_filetypes) do
    if vim.bo.filetype == filetype then
      can_replace = true
      break
    end
  end

  if not can_replace then
    return vim.notify("当前文件非 typescript 文件", vim.log.levels.ERROR)
  end

  local node_tree = vim.treesitter.get_parser(current_buf)
  if not node_tree then
    return vim.notify("无节点树", vim.log.levels.ERROR)
  end

  local ternary_node = _find_ternary_node(current_buf)
  if not ternary_node then
    return vim.notify("未在当前光标处找到“三元表达式”", vim.log.levels.WARN)
  end

  local cond_node = nil ---@type TSNode | nil
  local cons_node = nil ---@type TSNode | nil
  local alt_node = nil ---@type TSNode | nil
  for child_node, name in ternary_node:iter_children() do
    if name == "condition" then
      cond_node = child_node
    end
    if name == "consequence" then
      cons_node = child_node
    end
    if name == "alternative" then
      alt_node = child_node
    end
  end

  if not cons_node or not alt_node or not cond_node then
    return vim.notify("ast 操作异常，请联系开发者检查", vim.log.levels.ERROR)
  end

  local cond_start_line, cond_start_col, cond_end_line, cond_end_col = cond_node:range()
  local cons_start_line, cons_start_col, cons_end_line, cons_end_col = cons_node:range()
  local alt_start_line, alt_start_col, alt_end_line, alt_end_col = alt_node:range()

  local cond_text =
    vim.api.nvim_buf_get_text(current_buf, cond_start_line, cond_start_col, cond_end_line, cond_end_col, {})[1]
  local cons_text =
    vim.api.nvim_buf_get_text(current_buf, cons_start_line, cons_start_col, cons_end_line, cons_end_col, {})[1]
  local alt_text =
    vim.api.nvim_buf_get_text(current_buf, alt_start_line, alt_start_col, alt_end_line, alt_end_col, {})[1]

  local replaced_text = cond_text .. " ? " .. alt_text .. " : " .. cons_text
  --- `t_n_s` = `ternary_node_start`, `t_n_e` = `ternary_node_end`
  local t_n_s_line, t_n_s_col, t_n_e_line, t_n_e_col = ternary_node:range()
  vim.api.nvim_buf_set_text(current_buf, t_n_s_line, t_n_s_col, t_n_e_line, t_n_e_col, { replaced_text })
end

return M
