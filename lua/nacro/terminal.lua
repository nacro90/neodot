local terminal = {}

local opt = vim.opt

function terminal.on_term_open()
  opt.sidescrolloff = 0
  opt.scrollback = 50000
end

function terminal.setup()
  vim.cmd [[
    augroup terminal_setup
      autocmd!
      autocmd TermOpen term://* lua require("nacro.terminal").on_term_open()
    augroup END
  ]]
end

return terminal
