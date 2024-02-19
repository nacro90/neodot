require "nacro.options"
require "nacro.keymaps"

local command = require "nacro.utils.command"

local api = vim.api
local fn = vim.fn

local nlazy = require "nacro.lazy"
nlazy.bootstrap()
nlazy.setup()

command("LuaHas", function(keys)
  vim.notify(vim.inspect(pcall(require, keys.args)))
end, {
  nargs = 1,
})

command("RemoveTrailingWhitespace", [[silent! %substitute/\s\+$//]], { nargs = 0 })

command("W", "w")
command("Q", "q")
command("Wq", "wq")
command("WQ", "wq")

api.nvim_create_autocmd("TextYankPost", {
  group = api.nvim_create_augroup("highlight_yank", {}),
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- Jump to the last known cursor position
api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local pos = vim.fn.line "'\""
    if pos > 0 and pos <= vim.api.nvim_buf_line_count(0) then
      vim.cmd 'normal g`"'
    end
  end,
})

command("RenameBuffer", function(arg)
  local name
  if arg and #arg > 0 then
    name = arg
  else
    name = fn.input "Buffer name: "
    if not name or #name == 0 then
      return
    end
  end
  api.nvim_buf_set_name(0, name)
end, {
  nargs = "?",
})

require("nacro.translate").setup()
require("nacro.matchparen").setup()
require("nacro.terminal").setup()
require("nacro.todo").setup(vim.env.HOME .. "/Organizers/todo.txt")
require("nacro.howdoi").setup()
-- require("nacro.clipboard_image").setup()
require("nacro.neovide").setup_if_neovide()
require("nacro.buffer").setup()

command("TimestampToDatetime", function(a)
  a = a.args
  print(os.date("%Y-%m-%d %H:%M:%S", a / 1000) .. "." .. a % 1000)
end, {
  nargs = 1,
})

vim.diagnostic.config {
  virtual_text = false,
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  }
}

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover)
vim.keymap.set("n", "<C-j>", vim.diagnostic.open_float)
vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next {
    severity = { min = vim.diagnostic.severity.WARN },
  }
end)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_next {
    severity = { min = vim.diagnostic.severity.WARN },
  }
end)
vim.keymap.set("n", "<C-q>", vim.lsp.buf.signature_help)
vim.keymap.set("i", "<C-q>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "gD", vim.lsp.buf.type_definition)
vim.keymap.set({ "n", "v" }, "gl", vim.lsp.buf.format, { desc = "LSP format buffer" })
