require("nacro.options").setup()
require "nacro.globals"

local command = require "nacro.utils.command"
local map = require "nacro.utils.map"

local nnoremap = map.nnoremap
local inoremap = map.inoremap
local tnoremap = map.tnoremap
local cnoremap = map.cnoremap
local xmap = map.xmap
local nmap = map.nmap

-- local placeholders to improve performance
local cmd = vim.cmd
local api = vim.api
local fn = vim.fn
local keymap = vim.keymap

require("nacro.plugins").setup()

command("LuaHas", function(keys)
  print(vim.inspect(pcall(require, keys.args)))
end, { nargs = 1 })

command("RemoveTrailingWhitespace", [[%substitute/\s\+$//]], { nargs = 0 })

nnoremap("Q", "<Nop>")

command("W", "w")
command("Q", "q")
command("Wq", "wq")
command("WQ", "wq")

nnoremap("<leader>ef", require("nacro.functions").configure_filetype)

nmap("<leader>", "<Nop>")

inoremap("<A-h>", "<Del>")

nnoremap("<leader>T", "<Cmd>tabedit | terminal<CR>")
nnoremap("<C-Space><C-m>", "<Cmd>tabedit | terminal<CR>")
tnoremap("<C-Space><C-m>", "<Cmd>tabedit | terminal<CR>")

keymap.set("c", "%%", require("nacro.functions").expand_percentage_if_in_command, { expr = true })

xmap("s", "<Esc>lys`<")

tnoremap("<Esc><Esc>", [[<C-\><C-n>]])

-- (') can be very annoying when it can not do the (`)
nmap("'", "`")

nnoremap("zz", "zzzH")

cmd [[
  augroup nacro_terminal
    autocmd!
    autocmd BufWinEnter,WinEnter term://* setlocal nonumber norelativenumber
  augroup end
]]

cmd [[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Visual", timeout=200}
  augroup END
]]

for _, mode in ipairs { "n", "v" } do
  for _, key in ipairs { "j", "k", "^" } do
    keymap.set(mode, key, "g" .. key, { remap = true })
  end
end

for _, mode in pairs { "i", "n", "v" } do
  keymap.set(mode, "<F1>", "<Nop>")
end

-- cmd('autocmd! BufWritePost plugins.lua execute "Reload" | PackerCompile')

nnoremap("<C-w>n", "<Cmd>vertical new<CR>")
nnoremap("<C-w><C-n>", "<Cmd>vertical new<CR>")

cmd [[autocmd! BufWritePre words.md luado if line:find('^%s*:') then return require('turkishmode.core').deasciify(line) end]]

nnoremap("yon", "<Cmd>setlocal number!<CR>")
nnoremap("yor", "<Cmd>setlocal relativenumber!<CR>")
nnoremap("yow", "<Cmd>setlocal wrap!<CR>")
nnoremap("yoc", "<Cmd>setlocal cursorline!<CR>")
keymap.set("n", "yos", "<Cmd>setlocal spell!<CR>")

command("LspAttached", function()
  print(#vim.lsp.buf_get_clients() > 0)
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
require("nacro.project").setup()
require("nacro.translate").setup()
require("nacro.test").setup()
require("nacro.matchparen").setup()
require("nacro.treesitter").setup()
require("nacro.terminal").setup()
require("nacro.zettelkasten").setup()
require("nacro.todo").setup(vim.env.HOME .. "/Zettels/todo.txt")
require("nacro.ledger").setup()
require("nacro.snippet").setup()

command("TimestampToDatetime", function(a)
  a = a.args
  print(os.date("%Y-%m-%d %H:%M:%S", a / 1000) .. "." .. a % 1000)
end, {
  nargs = 1,
})

nnoremap("<leader>>", "<Cmd>tabmove +<CR>")
nnoremap("<leader><lt>", "<Cmd>tabmove -<CR>")
