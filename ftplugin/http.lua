vim.keymap.set("n", "<CR>", function()
  require("rest-nvim").run()
end, { buffer = true })

vim.opt_local.foldmethod = "marker"
