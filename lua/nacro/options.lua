local options = {}

local utils = require "nacro.utils"

local g = vim.g
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local opt = vim.opt
local cmd = vim.cmd

function options.setup()
  o.termguicolors = true
  o.syntax = "enable"
  vim.cmd "filetype plugin indent on"

  local encoding = "utf-8"
  o.encoding = encoding
  o.fileencoding = encoding
  bo.fileencoding = encoding

  g.mapleader = ' '
  g.loaded_netrwPlugin = 1

  g.ch_syntax_for_h = 1
  g.python_highlight_all = 1
  g.python_recommended_style = 0

  wo.cursorline = true
  wo.number = false
  wo.relativenumber = false
  o.hidden = true
  wo.wrap = false
  wo.linebreak = true
  o.splitbelow = true
  o.splitright = true
  o.showmode = false
  o.showcmd = true
  o.visualbell = true
  wo.signcolumn = "auto:2"
  o.title = true
  wo.list = true
  o.pumheight = 8
  o.scrolloff = 1
  o.sidescrolloff = 5
  o.laststatus = 2
  o.clipboard = "unnamedplus"
  o.wildmenu = true
  o.wildmode = "longest,full"

  local fileformat = "unix"
  o.fileformat = fileformat
  bo.fileformat = fileformat

  o.wildignore = [[ *.swp,*.bak,*.pyc,*.class,*.hi,*.o ]]

  wo.foldlevel = 99
  opt.foldcolumn = "0"
  o.mouse = "a"
  o.ignorecase = true
  o.smartcase = true

  local smartindent = true
  o.smartindent = smartindent
  bo.smartindent = smartindent

  o.inccommand = "nosplit"

  local expandtab = true
  o.expandtab = expandtab
  bo.expandtab = expandtab

  o.shiftround = true

  local shiftwidth = 4
  o.shiftwidth = shiftwidth
  bo.shiftwidth = shiftwidth

  local tabstop = 4
  o.tabstop = tabstop
  bo.tabstop = tabstop

  local softtabstop = 4
  o.softtabstop = softtabstop
  bo.softtabstop = softtabstop

  local undofile = true
  o.undofile = undofile
  bo.undofile = undofile

  local nrformats = "bin,hex"
  o.nrformats = nrformats
  bo.nrformats = nrformats

  o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize"

  -- See https://github.com/zhimsel/vim-stay
  o.viewoptions = "cursor,folds,slash,unix"

  o.switchbuf = "usetab"

  -- See https://github.com/hrsh7th/nvim-cmp
  o.completeopt = "menu,menuone,noselect"

  wo.list = true
  o.listchars = [[tab:  ,trail:_,extends:>,precedes:<,nbsp:+]]

  local formatoptions = "tcqj"
  o.formatoptions = formatoptions
  bo.formatoptions = formatoptions

  opt.showbreak = "\\"

  o.errorbells = false
  o.cmdheight = 2
  o.swapfile = false
  bo.swapfile = false
  o.updatetime = 500
  opt.shortmess:append "c"
  wo.signcolumn = "auto:2"
  o.lazyredraw = true
  opt.fillchars = {
    vert = "┃",
    diff = " ",
    foldsep = "│",
    foldopen = "┍",
    foldclose = "≡",
  }
  opt.number = false
  wo.breakindent = true
  wo.breakindentopt = [[shift:2,sbr,min:20]]
  o.guifont = "firacode Nerd Font:h14:w27"

  -- Macos language bugfix
  if utils.get_os() == "mac" then
    cmd "language en_US.UTF-8"
  end
end

return options

-- vim: foldmethod=marker
