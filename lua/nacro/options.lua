local g = vim.g
local opt = vim.opt

-- Leader key (must be set before lazy.nvim)
g.mapleader = " "

-- UI
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.linebreak = true
opt.splitbelow = true
opt.splitright = true
opt.showmode = false
opt.visualbell = true
opt.signcolumn = "auto:2"
opt.title = true
opt.pumheight = 12
opt.scrolloff = 1
opt.sidescrolloff = 5
opt.cmdheight = 0
opt.showbreak = "\\"
opt.breakindent = true
opt.breakindentopt = {
  "sbr",
  shift = "2",
  min = "20",
}
opt.fillchars = {
  vert = "┃",
  diff = " ",
  foldsep = "│",
  foldopen = "┍",
  foldclose = "≡",
}

-- List characters
opt.list = true
opt.listchars = {
  tab = "  ",
  trail = "_",
  extends = ">",
  precedes = "<",
  nbsp = "+",
}

-- Editing
opt.clipboard = "unnamedplus"
opt.fileformat = "unix"
opt.smartindent = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.virtualedit = "onemore"
opt.formatoptions = "tcqj"
opt.nrformats = { "bin", "hex" }

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"

-- Completion
opt.wildmode = { "longest", "full" }
opt.wildignore = {
  "*.swp",
  "*.bak",
  "*.pyc",
  "*.class",
  "*.hi",
  "*.o",
}
opt.completeopt = { "menu", "menuone", "noselect" }

-- Folding
opt.foldlevel = 99
opt.foldcolumn = "0"

-- Session & View
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

-- Performance & Behavior
opt.timeoutlen = 500
opt.updatetime = 500
opt.undofile = true
opt.swapfile = false
opt.errorbells = false
opt.mouse = "a"
opt.shortmess:append "c"
opt.shortmess:append "S"
opt.shortmess:append "W"

-- Filetype specific globals
g.ch_syntax_for_h = 1
g.python_highlight_all = 1
g.python_recommended_style = 0

-- macOS language bugfix
if require("nacro.os").get_name() == "mac" then
  vim.cmd "language en_US.UTF-8"
end
