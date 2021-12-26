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
---@param todo_file string @Todo file
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

---Setup module
---@param todo_file string @Path to the todo file
function todo.setup(todo_file)
  todo.default_todo_file = todo_file

  local function edit_todo()
    require("nacro.functions").strict_edit(todo_file)
  end

  nnoremap("<leader>et", edit_todo)

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

return todo
