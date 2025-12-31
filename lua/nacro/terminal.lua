local terminal = {}

local opt_local = vim.opt_local
local api = vim.api
local keymap = vim.keymap

local function setup_keymaps()
  keymap.set("t", "<Esc>", [[<C-\><C-n>]])
  keymap.set({ "n", "t" }, "<C-Space><C-m>", "<Cmd>tabedit | terminal<CR>")

  -- Window navigation from terminal mode (sacrifices <C-w> word delete)
  keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { desc = "Window command from terminal" })
end

local function on_term_open()
  opt_local.sidescrolloff = 0
  opt_local.scrollback = 50000
  opt_local.number = false
  opt_local.relativenumber = false
  vim.cmd "startinsert"
end

local function setup_autocmds()
  local group = api.nvim_create_augroup("terminal_setup", {})
  api.nvim_create_autocmd("TermOpen", {
    group = group,
    pattern = "term://*",
    callback = on_term_open,
  })
end

function terminal.setup()
  setup_keymaps()
  setup_autocmds()
end

return terminal
