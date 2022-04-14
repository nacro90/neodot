local opt = vim.opt

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

vim.keymap.set("n", "<leader>mp", "mlBi_`ll", { buffer = 0 })
