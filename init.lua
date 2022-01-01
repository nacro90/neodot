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


require("nacro.plugins").setup()

command("Lprint", print, { nargs = 1 })
command("Linspect", function(...)
  print(vim.inspect(...))
end, { nargs = 1 })

command("LuaHas", "lua print(vim.inspect(pcall(require, '<args>')))", { nargs = 1 })

command("RemoveTrailingWhitespace", [[%substitute/\s\+$//]], { nargs = 0 })

nnoremap("Q", "<Nop>")

command("W", "w")
command("Q", "q")
command("Wq", "wq")
command("WQ", "wq")

-- Edit filetype configuration
nnoremap("<leader>ef", require("nacro.functions").configure_filetype)

-- Edit main lua init file (this file)
nnoremap("<leader>el", string.format("<Cmd>edit %s/init.lua<CR>", vim.fn.stdpath "config"))

-- Edit packages file

-- Yank with 'Y' should be like 'D' or 'C'
-- nmap("Y", "y$")

-- nnoremap("<C-l>", "<Cmd>nohlsearch<CR><C-l>")
-- inoremap("<C-l>", "<Cmd>nohlsearch<CR><C-l>")

nmap("<leader>", "<Nop>")

inoremap("<A-h>", "<Del>")

nnoremap("<leader>T", "<Cmd>tabedit | terminal<CR>")
nnoremap("<C-Space><C-m>", "<Cmd>tabedit | terminal<CR>")
tnoremap("<C-Space><C-m>", "<Cmd>tabedit | terminal<CR>")

vim.api.nvim_set_keymap(
  "c",
  "%%",
  [[luaeval("require('nacro.functions').expand_percentage_if_in_command()")]],
  { noremap = true, expr = true }
)

xmap("x", "s", "<Esc>lys`<")

-- inoremap("jk", "<Esc>")
-- inoremap("JK", "<Esc>")

-- luasnip#choice_active()
tnoremap("<Esc><Esc>", [[<C-\><C-n>]])

-- (') can be very annoying when it can not do the (`)
nmap("'", "`")

nnoremap("zz", "zzzH")

cmd [[
  augroup vert_split_colorization
    autocmd!
  augroup END
]]
-- autocmd ColorScheme * highlight VertSplit guibg=#20222d guifg=#20222d'

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
    vim.api.nvim_set_keymap(mode, key, "g" .. key, {})
  end
end

for _, mode in pairs { "i", "n", "v" } do
  vim.api.nvim_set_keymap(mode, "<F1>", "<Nop>", { noremap = true })
end

-- cmd('autocmd! BufWritePost plugins.lua execute "Reload" | PackerCompile')

nnoremap("<C-w>n", "<Cmd>vertical new<CR>")
nnoremap("<C-w><C-n>", "<Cmd>vertical new<CR>")

cmd [[autocmd! BufWritePre words.md luado if line:find('^%s*:') then return require('turkishmode.core').deasciify(line) end]]

nnoremap("yon", "<Cmd>setlocal number!<CR>")
nnoremap("yor", "<Cmd>setlocal relativenumber!<CR>")
nnoremap("yow", "<Cmd>setlocal wrap!<CR>")
nnoremap("yoc", "<Cmd>setlocal cursorline!<CR>")

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

nnoremap("<leader>R", function()
  local to = fn.input "Replace with: "
  local subst = ("%%s/%s/%s"):format(fn.expand "<cword>", to)
  cmd(subst)
end)

local find_zettel = require("nacro.telescoper").find_zettel
command("Zet", find_zettel)
nnoremap("<leader>z", find_zettel)

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

command("TimestampToDatetime", function(a)
  print(os.date("%Y-%m-%d %H:%M:%S", a / 1000) .. "." .. a % 1000)
end, {
  nargs = 1,
})

nnoremap("<leader>>", "<Cmd>tabmove +<CR>")
nnoremap("<leader><lt>", "<Cmd>tabmove -<CR>")

local todo_file = os.getenv "HOME" .. "/todo/todo.txt"
require("nacro.todo").setup(todo_file)
