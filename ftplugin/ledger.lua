local opt_local = vim.opt_local
local keymap = vim.keymap
local fn = vim.fn

opt_local.tabstop = 4
opt_local.softtabstop = 4
opt_local.shiftwidth = 4
opt_local.expandtab = true

local entry_pattern = [[^\d]]

local function search_entry_backwards()
  fn.search(entry_pattern, "b")
end

local function search_entry_forwards()
  fn.search(entry_pattern)
end

local search_entry_keymap_opts = { buffer = true, silent = true }

keymap.set("n", "{", search_entry_backwards, search_entry_keymap_opts)
keymap.set("n", "}", search_entry_forwards, search_entry_keymap_opts)

opt_local.foldmethod = "expr"
opt_local.foldexpr = "nvim_treesitter#foldexpr()"
opt_local.foldlevel = 0
opt_local.foldenable = true

-- nnoremap <buffer> <leader>m <Cmd>silent make\|redraw!\|cwindow<CR>
