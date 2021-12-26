-- nacro90
-- Neovim options
--
-- WARNING: see https://github.com/nanotee/nvim-lua-guide#caveats-4
--
local utils = require "nacro.utils"

local vim = vim
local g = vim.g
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local opt = vim.opt
local cmd = vim.cmd

local options = {}

function options.setup()
  -- Gui
  -- Enables 24 bit color support
  o.termguicolors = true

  -- Syntax support
  o.syntax = "enable"

  -- Make use of ftplugins
  cmd [[filetype plugin indent on]]

  -- Encoding
  local encoding = "utf-8"
  o.encoding = encoding
  o.fileencoding = encoding
  bo.fileencoding = encoding

  cmd [[let mapleader = ' ']]

  -- Disable netrw
  cmd [[let loaded_netrwPlugin = 1]]

  -- Indicates the line that cursor is on
  wo.cursorline = true

  -- Line numbers
  wo.number = false

  -- Relative line numbers are very convenient for vim
  wo.relativenumber = false

  -- When off a buffer is unloaded when it is abandoned.  When on a buffer
  -- becomes hidden when it is abandoned.
  o.hidden = true

  -- I want to see original version of a file first
  wo.wrap = false

  -- If on, Vim will wrap long lines at a character in 'breakat' rather
  -- than at the last character that fits on the screen
  wo.linebreak = true

  -- Splits open at the bottom and right, which is non-retarded
  o.splitbelow = true
  o.splitright = true

  -- Dont' display mode (Lightline)
  o.showmode = false

  -- Show (partial) command in the last line of the screen
  o.showcmd = true

  -- Use visual bell instead of beeping
  o.visualbell = true

  -- always show signcolumns
  wo.signcolumn = "auto:2"

  -- Sets the terminal title depending on the context
  o.title = true

  -- See invisible characters like tabs, spaces and EOL
  wo.list = true

  -- Set max height of completion window to human levels
  o.pumheight = 8

  -- Vertical scroll off
  o.scrolloff = 1

  -- Set horizontal scroll off to one if not set
  o.sidescrolloff = 5

  -- When to show status line
  o.laststatus = 2

  -- Clipboard register selection
  o.clipboard = "unnamedplus"

  -- Enables "enhanced mode" of command-line completion
  o.wildmenu = true

  -- Completion mode that is used for the character specified with 'wildchar'
  o.wildmode = "longest,full"

  -- This gives the <EOL> of the current buffer, which is used for
  -- reading/writing the buffer from/to a file
  local fileformat = "unix"
  o.fileformat = fileformat
  bo.fileformat = fileformat

  -- A list of file patterns.  A file that matches with one of these patterns is
  -- ignored when expanding wildcards, completing file or directory names, and
  -- influences the result of expand(), glob() and globpath() unless a flag is
  -- passed to disable this
  o.wildignore = [[ *.swp,*.bak,*.pyc,*.class,*.hi,*.o ]]

  -- Sets the fold level: Folds with a higher level will be closed
  wo.foldlevel = 99

  opt.foldcolumn = "0"

  -- Enables mouse support
  o.mouse = "a"

  -- Ignore case in search patterns.  Also used when searching in the tags file
  o.ignorecase = true

  -- Override the 'ignorecase' option if the search pattern contains upper case
  -- characters.  Only used when the search pattern is typed and 'ignorecase'
  -- option is on
  o.smartcase = true

  local smartindent = true
  o.smartindent = smartindent
  bo.smartindent = smartindent

  -- Preview :substitute command in a split
  o.inccommand = "nosplit"

  -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>
  local expandtab = true
  o.expandtab = expandtab
  bo.expandtab = expandtab

  -- Round indent to multiple of 'shiftwidth'
  o.shiftround = true

  -- Number of spaces to use for each step of (auto)indent
  local shiftwidth = 4
  o.shiftwidth = shiftwidth
  bo.shiftwidth = shiftwidth

  -- Number of spaces that a <Tab> in the file counts for
  local tabstop = 4
  o.tabstop = tabstop
  bo.tabstop = tabstop

  -- Number of spaces that a <Tab> counts for while performing editing
  -- operations, like inserting a <Tab> or using <BS>
  local softtabstop = 4
  o.softtabstop = softtabstop
  bo.softtabstop = softtabstop

  -- Persistent undo file
  local undofile = true
  o.undofile = undofile
  bo.undofile = undofile

  -- This defines what bases Vim will consider for numbers when using the CTRL-A
  -- and CTRL-X commands for adding to and subtracting from a number respectively
  local nrformats = "bin,hex"
  o.nrformats = nrformats
  bo.nrformats = nrformats

  -- Changes the effect of the mksession command
  o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize"

  -- See https://github.com/zhimsel/vim-stay
  o.viewoptions = "cursor,folds,slash,unix"

  -- This option controls the behavior when switching between buffers.
  o.switchbuf = "usetab"

  -- A comma separated list of options for Insert mode completion
  -- see https://github.com/nvim-lua/completion-nvim
  o.completeopt = "menuone,noinsert,noselect"

  -- List mode: Show tabs as CTRL-I is displayed, display $ after end of line.
  -- Useful to see the difference between tabs and spaces and for trailing
  -- blanks.
  wo.list = true

  o.listchars = [[tab:  ,trail:_,extends:>,precedes:<,nbsp:+]]

  -- This is a sequence of letters which describes how automatic formatting is to
  -- be done.
  -- See `:help to-table`
  local formatoptions = "tcqj"
  o.formatoptions = formatoptions
  bo.formatoptions = formatoptions

  opt.showbreak = "\\"

  -- Ring the bell (beep or screen flash) for error messages
  o.errorbells = false

  -- Number of screen lines to use for the command-line
  o.cmdheight = 2

  o.swapfile = false
  bo.swapfile = false

  -- If this many milliseconds nothing is typed the swap file will be written to
  -- disk. Also used for the CursorHold autocommand event
  o.updatetime = 500

  -- This option helps to avoid all the |hit-enter| prompts caused by file
  -- messages
  opt.shortmess:append "c"

  -- When this option is set, the screen will not be redrawn while executing
  -- macros, registers and other commands that have not been typed
  wo.signcolumn = "auto:2"

  -- Don't update screen while running macros
  o.lazyredraw = true

  -- Characters to fill the statuslines and vertical separators
  opt.fillchars = {
    vert = "┃",
    diff = " ",
    foldsep = "│",
    foldopen = "┍",
    foldclose = "≡",
  }

  -- Every wrapped line will continue visually indented (same amount of space as
  -- the beginning of that line), thus preserving horizontal blocks of text
  wo.breakindent = true
  wo.breakindentopt = [[shift:2,sbr,min:20]]

  --- Variable settings

  g.ch_syntax_for_h = 1

  -- Python

  -- If you want all possible Python highlighting (the same as setting the
  -- preceding last option and unsetting all other ones)
  g.python_highlight_all = 1

  -- By default the following options are set, in accordance with PEP8: >
  --     setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
  --     DISABLE THIS
  g.python_recommended_style = 0
  --

  o.guifont = "firacode Nerd Font:h14:w27"

  -- Macos language bugfix
  if utils.get_os() == "mac" then
    cmd "language en_US.UTF-8"
  end
end

return options

-- vim: foldmethod=marker
