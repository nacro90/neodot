vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"

local function append_newline_if_not_exists()
  local last_line = unpack(vim.api.nvim_buf_get_lines(0, -2, -1, true))
  if last_line == "" then
    return
  end
  vim.api.nvim_buf_set_lines(0, -1, -1, true, { "" })
end

local augroup = vim.api.nvim_create_augroup("nacro_yaml", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = append_newline_if_not_exists,
  desc = "Append new line to yamls",
  buffer = vim.api.nvim_buf_get_number(0)
})

