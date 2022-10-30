require "nacro.options"

local command = require "nacro.utils.command"
local map = require "nacro.utils.map"

local nnoremap = map.nnoremap
local xmap = map.xmap
local nmap = map.nmap

-- local placeholders to improve performance
local api = vim.api
local fn = vim.fn
local keymap = vim.keymap

require("nacro.plugins").setup()

command("LuaHas", function(keys)
  vim.notify(vim.inspect(pcall(require, keys.args)))
end, { nargs = 1 })

command("RemoveTrailingWhitespace", [[%substitute/\s\+$//]], { nargs = 0 })

nnoremap("Q", "<Nop>")

command("W", "w")
command("Q", "q")
command("Wq", "wq")
command("WQ", "wq")

nnoremap("<leader>ef", require("nacro.functions").configure_filetype)

nmap("<leader>", "<Nop>")
nmap("<CR>", "<Nop>")

keymap.set("i", "<C-l>", "<Del>")

keymap.set("i", "<C-a>", "<Esc>ggvG")

keymap.set("c", "%%", require("nacro.functions").expand_percentage_if_in_command, { expr = true })

xmap("s", "<Esc>lys`<")


-- (') can be very annoying when it can not do the (`)
nmap("'", "`")

nnoremap("zz", "zzzH")

api.nvim_create_autocmd("TextYankPost", {
  group = api.nvim_create_augroup("highlight_yank", {}),
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

for _, key in ipairs { "j", "k", "^" } do
  keymap.set({ "n", "v" }, key, "g" .. key, { remap = true, silent = true })
end

for _, mode in pairs { "i", "n", "v" } do
  keymap.set(mode, "<F1>", "<Nop>")
end

-- cmd('autocmd! BufWritePost plugins.lua execute "Reload" | PackerCompile')

nnoremap("<C-w>n", "<Cmd>vertical new<CR>")
nnoremap("<C-w><C-n>", "<Cmd>vertical new<CR>")

nnoremap("yon", "<Cmd>setlocal number!<CR>")
nnoremap("yor", "<Cmd>setlocal relativenumber!<CR>")
nnoremap("yow", "<Cmd>setlocal wrap!<CR>")
nnoremap("yoc", "<Cmd>setlocal cursorline!<CR>")
keymap.set("n", "yos", "<Cmd>setlocal spell!<CR>")

command("LspAttached", function()
  vim.notify(#vim.lsp.get_active_clients { bufnr = 0 } > 0)
end)

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

vim.keymap.set("x", "il", "g_o^")
vim.keymap.set("o", "il", "<Cmd>normal vil<CR>")
vim.keymap.set("x", "al", "$o^")
vim.keymap.set("o", "al", "<Cmd>normal val<CR>")

nnoremap("-", "<Nop>")

require("nacro.colorscheme").setup "codedark"
require("nacro.telescoper").setup()
require("nacro.nvim_tree").setup()
require("nacro.lsp").setup()
require("nacro.dap").setup()
require("nacro.lualine").setup()
require("nacro.completion").setup()
require("nacro.autopairs").setup()
require("nacro.gitsigns").setup()
require("nacro.omen").setup()
require("nacro.workspaces").setup()
require("nacro.translate").setup()
require("nacro.matchparen").setup()
require("nacro.treesitter").setup()
require("nacro.terminal").setup()
require("nacro.zettelkasten").setup()
require("nacro.todo").setup(vim.env.HOME .. "/Zettels/todo.txt")
require("nacro.ledger").setup()
require("nacro.snippet").setup()
require("nacro.flutter").setup()
require("nacro.howdoi").setup()
require("nacro.indent_blankline").setup()
require("nacro.testing").setup()
require("nacro.clipboard_image").setup()
require("nacro.surround").setup()
require("nacro.neogit").setup()
require("nacro.colorizer").setup()
require("nacro.neotest").setup()
require("nacro.neovide").setup_if_neovide()

command("TimestampToDatetime", function(a)
  a = a.args
  print(os.date("%Y-%m-%d %H:%M:%S", a / 1000) .. "." .. a % 1000)
end, {
  nargs = 1,
})

nnoremap("<leader>>", "<Cmd>tabmove +<CR>")
nnoremap("<leader><lt>", "<Cmd>tabmove -<CR>")

require("hlargs").setup()

vim.keymap.set("n", "<BS>", "<NOP>", {})

vim.g.ultest_deprecation_notice = 0
