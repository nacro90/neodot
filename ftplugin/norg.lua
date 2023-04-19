vim.opt_local.expandtab = true
vim.opt_local.conceallevel = 1
vim.opt_local.foldlevel = 1
vim.opt_local.foldnestmax = 1
vim.opt_local.wrap = true

local group = vim.api.nvim_create_augroup("FTPluginNorg", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*.norg",
  command = "RemoveTrailingWhitespace",
})
