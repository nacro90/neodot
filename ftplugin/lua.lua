local opt_local = vim.opt_local
local keymap = vim.keymap
local api = vim.api

opt_local.tabstop = 2
opt_local.softtabstop = 2
opt_local.shiftwidth = 2
opt_local.expandtab = true
opt_local.autoindent = true
opt_local.suffixesadd = ".lua"
opt_local.foldmethod = "expr"
opt_local.foldexpr = "nvim_treesitter#foldexpr()"
opt_local.foldenable = false

local function toggle_local_keyword()
  local line = api.nvim_get_current_line()

  local cursor_correction = -6
  local replacement, n_occurences = line:gsub("^(%s*)local ", "%1")

  if n_occurences == 0 then
    replacement = line:gsub("^(%s*)(.*)", "%1local %2")
    cursor_correction = -cursor_correction
  end

  api.nvim_set_current_line(replacement)

  local cursor = api.nvim_win_get_cursor(0)
  cursor[2] = cursor[2] + cursor_correction
  api.nvim_win_set_cursor(0, cursor)
end

keymap.set("n", "<leader>ml", toggle_local_keyword, { buffer = 0 })
