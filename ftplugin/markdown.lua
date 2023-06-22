local highlight = require "nacro.utils.highlight"

local opt_local = vim.opt_local
local keymap = vim.keymap

opt_local.autoindent = true
opt_local.shiftwidth = 2
opt_local.tabstop = 2
opt_local.expandtab = true
opt_local.conceallevel = 2
opt_local.textwidth = 100
opt_local.foldenable = true
opt_local.spelllang = { "en", "tr" }
opt_local.wrap = true
opt_local.linebreak = true

keymap.set("n", "<leader>x", "<Cmd>normal! 0f[lrX<CR>", {buffer = true})

highlight("mkdLineBreak", { guibg = "NONE" })

--[[
set iskeyword+=-
set formatoptions=tlnqr

" Mappings
" autocmd! BufWritePre *.md,*.mkd,*.markdown substitute
]]--
