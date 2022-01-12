local highlight = require "nacro.utils.highlight"

local keymap = vim.keymap
local api = vim.api

local function new_line_starter(offset)
  return function()
    local line, _ = unpack(api.nvim_win_get_cursor(0))
    local date = os.date "%Y-%m-%d"
    local new_line = line - 1 + offset
    api.nvim_buf_set_lines(0, new_line, new_line, true, { date .. " " })
    api.nvim_win_set_cursor(0, { line + offset, 0 })
    vim.cmd "startinsert!"
  end
end

keymap.set("n", "o", new_line_starter(1), { buffer = true })
keymap.set("n", "O", new_line_starter(0), { buffer = true })
keymap.set("i", "<CR>", new_line_starter(1), { buffer = true })
keymap.set(
  "n",
  "<CR>",
  "<Cmd>call todo#txt#mark_as_done()<CR><C-l>",
  { buffer = true, remap = true }
)

highlight("TodoDone", "NonText")

vim.cmd [[
  augroup orcan_todo_txt
      autocmd!
      autocmd BufWritePre <buffer> silent! %substitute/\s\+$//
      autocmd BufWritePre <buffer> silent! sort
  augroup end
]]
