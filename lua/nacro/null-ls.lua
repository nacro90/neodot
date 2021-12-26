local nacro_null_ls = {}

function nacro_null_ls.setup()
  require("null-ls").config {}
  require("lspconfig")["null-ls"].setup {}
end

return nacro_null_ls
