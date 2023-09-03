local M = {}

local _temp_buf = vim.api.nvim_create_buf(false, true)
--- @type nil | integer
local _current_opened_win = nil

vim.api.nvim_buf_set_keymap(
  _temp_buf,
  "i",
  "<CR>",
  '<CMD>:lua require("plugin.open-file").jump()<CR>',
  { noremap = true, silent = true }
)

local function create_win(buf)
  local editor_width = vim.api.nvim_get_option("columns")
  local editor_height = vim.api.nvim_get_option("lines")

  local win_width = math.floor(editor_width / 2) -- 宽度是当前窗口宽度的一半
  local win_height = 10 -- 高度是10

  local row = math.floor((editor_height - win_height) / 2) -- 垂直居中
  local col = math.floor((editor_width - win_width) / 2) -- 水平居中

  -- set buffer ft
  vim.api.nvim_buf_set_option(buf, "filetype", "")
  -- hide line number
  vim.api.nvim_buf_set_option(buf, "buflisted", false)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row, -- 置顶
    col = col, -- 从最左侧开始
    width = 80,
    height = 1,
    border = "rounded",
    zindex = 250,
    focusable = true,
  })

  -- hide status columns
  vim.api.nvim_win_set_option(win, "number", false)

  return win
end

function M.open_file()
  vim.api.nvim_buf_set_lines(_temp_buf, 0, -1, false, {}) -- 清空 buffer 的内容
  _current_opened_win = create_win(_temp_buf)
  vim.api.nvim_feedkeys("i", "n", false)
end

function M.jump()
  if not _current_opened_win then
    return
  end

  vim.api.nvim_win_close(_current_opened_win, false)
  local rel_path = vim.api.nvim_buf_get_lines(_temp_buf, 0, -1, false)[1]
  local rel_path_without_pos = string.gsub(rel_path, "[#:]%d+[#:]?%d*$", "")
  local abs_path = vim.fn.getcwd() .. "/" .. rel_path_without_pos
  local is_invalid_path = vim.fn.filereadable(abs_path) == 0
  if is_invalid_path then
    return vim.notify("路径不存在，请重试", vim.log.levels.ERROR)
  end
  vim.api.nvim_command("edit " .. abs_path)

  local target_line, target_col = rel_path:match("[#:](%d+)[#:](%d+)$")
  if not target_line then
    target_line = rel_path:match("[#:](%d+)$")
  end

  local jumped_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_cursor(jumped_win, { tonumber(target_line), tonumber(target_col or 0) })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", false)
  vim.cmd([[normal! zz]])
end

return M
