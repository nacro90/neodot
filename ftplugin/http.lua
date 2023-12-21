vim.keymap.set("n", "<CR>", function()
  require("rest-nvim").run()
end, { buffer = true })
