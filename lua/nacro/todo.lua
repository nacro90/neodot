---@diagnostic disable: unused-local
local todo = {}

local actions = require "telescope.actions"
local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local Path = require "plenary.path"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local p_window = require "telescope.pickers.window"
local sorters = require "telescope.sorters"
local state = require "telescope.state"
local utils = require "telescope.utils"

local conf = require("telescope.config").values

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

---Add a todo item to the todo file
---@param item_text string @Item text to be add
---@param todo_file string? @Todo file
function todo.add_todo(item_text, todo_file)
  assert(item_text and #item_text > 0, "Todo item text can not be empty")
  todo_file = todo_file or todo.default_todo_file
  local fd = io.open(todo_file, "a")
  local date = os.date "%Y-%m-%d"
  local item = ("\n%s %s"):format(date, item_text)
  fd:write(item)
  fd:close()
end

---Add a todo item to the todo file using vim input
---@param todo_file string @Todo file
function todo.add_todo_interactively(todo_file)
  local item_text = fn.input "Todo: "
  todo.add_todo(item_text, todo_file)
end

function todo.telescope_todo(todo_file)
  local opts = {}
  todo_file = todo_file or todo.default_todo_file

  local items = {}

  local fd = io.open(todo_file)
  for line in fd:lines() do
    table.insert(items, line)
  end

  pickers.new({
    prompt_title = "",
    finder = finders.new_table {
      results = items,
      entry_maker = function(line)
        return {
          ordinal = line,
          display = line,
          filename = todo_file,
        }
      end,
    },
    previewer = previewers.cat.new(opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        if selection == nil then
          print "[telescope] Nothing currently selected"
          return
        end

        actions.close(prompt_bufnr)
        print("Enjoy astronomy! You viewed:", selection.display)
      end)

      return true
    end,
  }):find()
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
