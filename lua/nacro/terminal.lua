local terminal = {}

function terminal.setup()
  vim.cmd [[
    augroup terminal_setup
      autocmd!
      autocmd TermOpen term://* setlocal sidescrolloff=0
    augroup END
  ]]
end

return terminal
