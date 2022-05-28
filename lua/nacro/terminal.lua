local terminal = {}

local opt_local = vim.opt_local
local api = vim.api

local function on_term_open()
  opt_local.sidescrolloff = 0
  opt_local.scrollback = 50000
  opt_local.number = false
  opt_local.relativenumber = false
  vim.cmd "startinsert"
end

local function create_autocmds()
  local group = api.nvim_create_augroup("terminal_setup", {})
  api.nvim_create_autocmd("TermOpen", {
    group = group,
    pattern = "term://*",
    callback = on_term_open,
  })
end

function terminal.setup()
  create_autocmds()
end

return terminal
