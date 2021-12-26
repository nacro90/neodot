local vimm = {}

function vimm.setup()
   vim.bo.tabstop = 4
   vim.bo.softtabstop = 4
   vim.bo.shiftwidth = 4
   vim.bo.expandtab = true
   vim.wo.foldlevel = 0
   vim.wo.foldmethod = 'marker'
end

return vimm
