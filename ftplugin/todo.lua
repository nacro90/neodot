local n_todo = require "nacro.todo"

local opt_local = vim.opt_local
local keymap = vim.keymap

opt_local.foldmethod = "expr"
opt_local.foldexpr = "getline(v:lnum)[0]=='x'"
opt_local.foldenable = true
opt_local.foldlevel = 0

local priority_chars = { "a", "b", "c", "d", "e", "f" }

local function line_priority_changer(char)
  return function()
    n_todo.set_line_priority(char and string.upper(char))
  end
end

---@diagnostic disable-next-line: unused-local
local function new_line_starter(offset)
  return function()
    n_todo.start_new_line(offset)
  end
end

for _, key in ipairs(priority_chars) do
  keymap.set("n", "," .. key, line_priority_changer(key), { buffer = true })
end
keymap.set("n", ",,", line_priority_changer(), { buffer = true })

keymap.set(
  "n",
  "<CR>",
  "<Cmd>call todo#txt#mark_as_done()<CR><C-l>",
  { buffer = true, remap = true }
)

local function format()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd [[silent! %substitute/\s\+$//]]
  vim.cmd "silent! sort"
  vim.api.nvim_win_set_cursor(0, cursor)
end

keymap.set("n", "gl", format, { buffer = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("nacro_todo_txt", {}),
  pattern = "todo.txt",
  callback = format,
})
