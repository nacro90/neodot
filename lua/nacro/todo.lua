---@diagnostic disable: unused-local
local todo = {}

local map = require "nacro.utils.map"
local command = require("nacro.utils.command").command
local nnoremap = map.nnoremap

local fn = vim.fn
local api = vim.api
local cmd = vim.cmd

---Check string is empty or nil
---@param str string
---@return boolean
local function is_empty(str)
  return (str and #str > 0) and true or false
end

function todo.edit_todo_popup(size)
  local width = 80
  local height = 20

  local buf = api.nvim_create_buf(false, true)

  local ui = api.nvim_list_uis()[1]

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = (ui.width / 2) - (width / 2),
    row = (ui.height / 2) - (height / 2),
    anchor = "NW",
    style = "minimal",
  }
  local win = api.nvim_open_win(buf, 1, opts)
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(0, true)
  end, { buffer = true })

  vim.cmd("edit " .. todo.default_todo_file)
end

---Setup module
---@param todo_file string @Path to the todo file
function todo.setup(todo_file)
  todo.default_todo_file = todo_file

  local function edit_todo()
    require("nacro.functions").strict_edit(todo_file)
  end

  nnoremap("<leader>et", todo.edit_todo_popup)
  nnoremap("<leader>eT", edit_todo)

  command("Todo", function(arg)
    if is_empty(arg) then
      todo.add_todo(arg)
    else
      edit_todo()
    end
  end, {
    nargs = "?",
  })
end

function todo.set_line_priority(priority)
  local line = api.nvim_get_current_line()
  local priority_str = priority and ("(%s) "):format(priority) or ""
  local replacement, occurence = line:gsub("^%(%w%) ", priority_str)
  if occurence == 0 then
    replacement = priority_str .. line
  end
  api.nvim_set_current_line(replacement)

  local cursor_correction = #replacement - #line
  if cursor_correction == 0 then
    return
  end
  local cursor = api.nvim_win_get_cursor(0)
  cursor[2] = math.max(0, cursor[2] + cursor_correction)
  api.nvim_win_set_cursor(0, cursor)
end

function todo.start_new_line(offset)
  local line, _ = unpack(api.nvim_win_get_cursor(0))
  local date = os.date "%Y-%m-%d"
  local new_line = line - 1 + offset
  api.nvim_buf_set_lines(0, new_line, new_line, true, { date .. " " })
  api.nvim_win_set_cursor(0, { line + offset, 0 })
  vim.cmd "startinsert!"
end

return todo
