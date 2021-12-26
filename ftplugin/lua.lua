vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.bo.expandtab = true
vim.wo.foldenable = true
vim.bo.autoindent = true
vim.wo.wrap = false
vim.bo.suffixesadd = ".lua"

vim.g.indentLine_enabled = 1

vim.g.completion_trigger_character = { ".", ":" }

vim.api.nvim_buf_set_keymap(0, "n", [[<leader>ml]], [[<Cmd>normal! Ilocal <CR>]], { noremap = true })
vim.bo.formatprg = "lua-format"

vim.opt.foldexpr = vim.fn["nvim_treesitter#foldexpr"]()
