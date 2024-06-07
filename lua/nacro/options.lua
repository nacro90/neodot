local g = vim.g
local opt = vim.opt

vim.cmd "filetype plugin indent on"

opt.termguicolors = true
opt.syntax = "enable"
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.hidden = true
opt.wrap = false
opt.linebreak = true
opt.splitbelow = true
opt.splitright = true
opt.showmode = false
opt.showcmd = true
opt.visualbell = true
opt.signcolumn = "auto:2"
opt.title = true
opt.list = true
opt.pumheight = 12
opt.scrolloff = 1
opt.sidescrolloff = 5
opt.laststatus = 2
opt.clipboard = "unnamedplus"
opt.wildmenu = true
opt.wildmode = { "longest", "full" }
opt.fileformat = "unix"
opt.wildignore = {
  "*.swp",
  "*.bak",
  "*.pyc",
  "*.class",
  "*.hi",
  "*.o",
}
opt.foldlevel = 99
opt.timeout = false
opt.foldcolumn = "0"
opt.mouse = "a"
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.inccommand = "nosplit"
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.undofile = true
opt.nrformats = { "bin", "hex" }
opt.sessionoptions = {
  "blank",
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "winpos",
  "terminal",
  "localoptions",
}
opt.viewoptions = {
  "cursor",
  "folds",
  "slash",
  "unix",
}
opt.switchbuf = "usetab"
-- See https://github.com/hrsh7th/nvim-cmp
opt.completeopt = { "menu", "menuone", "noselect" }
opt.list = true
opt.listchars = {
  tab = "  ",
  trail = "_",
  extends = ">",
  precedes = "<",
  nbsp = "+",
}
opt.formatoptions = "tcqj"
opt.showbreak = "\\"
opt.errorbells = false
opt.cmdheight = 0
opt.swapfile = false
opt.updatetime = 500
opt.virtualedit = "onemore"
opt.shortmess:append "c"
opt.shortmess:append "S"
opt.shortmess:append "W"
opt.lazyredraw = true
opt.fillchars = {
  vert = "┃",
  diff = " ",
  foldsep = "│",
  foldopen = "┍",
  foldclose = "≡",
}
opt.breakindent = true
opt.breakindentopt = {
  "sbr",
  shift = "2",
  min = "20",
}

g.mapleader = " "
g.loaded_netrwPlugin = 1

g.ch_syntax_for_h = 1
g.python_highlight_all = 1
g.python_recommended_style = 0

-- Macos language bugfix
if require("nacro.os").get_name() == "mac" then
  vim.cmd "language en_US.UTF-8"
end
